From: Tom Grennan <tom.grennan@ericsson.com>
Subject: [RFC/PATCH] verify-tag: check sig of all tags to given object
Date: Fri, 3 Feb 2012 17:25:51 -0800
Message-ID: <1328318751-4470-1-git-send-email-tom.grennan@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 02:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtUOK-0007xl-JB
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 02:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab2BDBZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 20:25:59 -0500
Received: from imr3.ericy.com ([198.24.6.13]:53204 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2BDBZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 20:25:54 -0500
Received: from eusaamw0706.eamcs.ericsson.se ([147.117.20.31])
	by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id q141Pqa6004761
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 3 Feb 2012 19:25:52 -0600
Received: from prattle.redback.com (147.117.20.214) by
 eusaamw0706.eamcs.ericsson.se (147.117.20.91) with Microsoft SMTP Server id
 8.3.137.0; Fri, 3 Feb 2012 20:25:51 -0500
Received: from localhost (localhost [127.0.0.1])	by prattle.redback.com
 (Postfix) with ESMTP id 5F8B2BF9F05;	Fri,  3 Feb 2012 17:25:51 -0800 (PST)
Received: from prattle.redback.com ([127.0.0.1]) by localhost (prattle
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 24863-03; Fri,  3 Feb
 2012 17:25:51 -0800 (PST)
Received: from rbos-pc-8.lab.redback.com (rbos-pc-8.lab.redback.com
 [10.12.11.128])	by prattle.redback.com (Postfix) with ESMTP id 3A575BF9F04;
	Fri,  3 Feb 2012 17:25:51 -0800 (PST)
X-Mailer: git-send-email 1.7.9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189834>

If the command argument is a non-tag object, scan and verify all tags to
the given object; for example:

john$ git tag -s -m "I approve" john-README master:README
...
john$ git tag -s -m "I recommend" john-HEAD HEAD
...
john$ git push <url> tag john-README
john$ git push <url> tag john-HEAD

jane$ git fetch --tags <url>
jane$ git tag -s -m "I also approve" jane-README master:README
...
jane$ git push <url> tag jane-README

jeff$ git fetch --tags <url>
jeff$ git verify-tag master:README
tag john-README: OK
tag jane-README: OK
jeff$ git verify-tag HEAD
tag john-HEAD: OK

Signed-off-by: Tom Grennan <tom.grennan@ericsson.com>
---
 Documentation/git-verify-tag.txt |    6 +++-
 builtin/verify-tag.c             |   53 +++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 5ff76e8..ce47f95 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -8,7 +8,7 @@ git-verify-tag - Check the GPG signature of tags
 SYNOPSIS
 --------
 [verse]
-'git verify-tag' <tag>...
+'git verify-tag' <object>...
 
 DESCRIPTION
 -----------
@@ -20,8 +20,10 @@ OPTIONS
 --verbose::
 	Print the contents of the tag object before validating it.
 
-<tag>...::
+<object>...::
 	SHA1 identifiers of git tag objects.
+	For non-tag objects, scan and verify all tags to the given
+	object.
 
 GIT
 ---
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 28c2174..df9e93c 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "refs.h"
 #include "tag.h"
 #include "run-command.h"
 #include <signal.h>
@@ -14,7 +15,7 @@
 #include "gpg-interface.h"
 
 static const char * const verify_tag_usage[] = {
-		"git verify-tag [-v|--verbose] <tag>...",
+		"git verify-tag [-v|--verbose] <object>...",
 		NULL
 };
 
@@ -32,6 +33,46 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	return verify_signed_buffer(buf, len, buf + len, size - len, NULL);
 }
 
+struct obj_filter {
+	const unsigned char *sha1;
+	int verbose;
+	struct strbuf sb;
+};
+
+static int verify_tag_of_obj(const char *refname, const unsigned char *sha1,
+			     int flag, void *cb_data)
+{
+	struct obj_filter *obj = cb_data;
+	enum object_type type;
+	unsigned long size;
+	int len, ret;
+	char *buf = NULL;
+	unsigned char tagged_sha1[20];
+
+	if ((type = sha1_object_info(sha1, NULL), type == OBJ_TAG) \
+	    && (buf = read_sha1_file(sha1, &type, &size), buf) \
+	    && !memcmp("object ", buf, 7) \
+	    && !get_sha1_hex(buf + 7, tagged_sha1) \
+	    && buf[47] == '\n' \
+	    && !memcmp(obj->sha1, tagged_sha1, 20) \
+	    && (len = parse_signature(buf, size), len != size)) {
+		strbuf_reset(&obj->sb);
+		ret = verify_signed_buffer(buf, len, buf + len, size - len,
+					   &obj->sb);
+		if (obj->verbose) {
+			write_in_full(1, buf, len);
+			write_in_full(1, obj->sb.buf, obj->sb.len);
+		} else if (ret) {
+			printf("tag %s: FAILED\n", refname);
+			write_in_full(1, obj->sb.buf, obj->sb.len);
+		} else
+			printf("tag %s: OK\n", refname);
+	}
+	if (buf)
+		free(buf);
+	return 0;
+}
+
 static int verify_tag(const char *name, int verbose)
 {
 	enum object_type type;
@@ -44,9 +85,13 @@ static int verify_tag(const char *name, int verbose)
 		return error("tag '%s' not found.", name);
 
 	type = sha1_object_info(sha1, NULL);
-	if (type != OBJ_TAG)
-		return error("%s: cannot verify a non-tag object of type %s.",
-				name, typename(type));
+	if (type != OBJ_TAG) {
+		struct obj_filter obj = { sha1, verbose };
+		strbuf_init(&obj.sb, 4096);
+		for_each_tag_ref(verify_tag_of_obj, (void *) &obj);
+		strbuf_release(&obj.sb);
+		return 0;
+	}
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-- 
1.7.9.dirty

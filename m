From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/6] fsck: check tag objects' headers
Date: Thu, 28 Aug 2014 16:46:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 16:47:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN0yh-0007Gp-Ic
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaH1Oq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:46:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:58152 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaH1Oq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 10:46:58 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0M85r3-1WRd5q2NAP-00ve3N;
 Thu, 28 Aug 2014 16:46:55 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ZXAkHxuyINBhnK0Nx/3X2oKaSC0e1ap715ykq8Y4sN4L3xKReqq
 CAd9PCnPBH+J2xHpKoNabBescIg/PRb+AakZA6eVM+Jka7w/CeJswH5Hz8hDTFi8MxPpMpE
 X8OFhm7EHiF4GVwZ8dpEkly1vLs0tSUo/nNEN9SXa6H+UTUNC6/977hDekgdmrHH0E9SCmT
 bGBS86EKk4B7oiqIwEO0A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256088>

We inspect commit objects pretty much in detail in git-fsck, but we just
glanced over the tag objects. Let's be stricter.

This work was sponsored by GitHub Inc.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index db6aaa4..d30946b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "refs.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -355,6 +356,90 @@ static int fsck_commit(struct commit *commit, const char *data,
 	return ret;
 }
 
+static int fsck_tag_buffer(struct tag *tag, const char *data,
+	unsigned long size, fsck_error error_func)
+{
+	unsigned char commit_sha1[20];
+	int ret = 0;
+	const char *buffer;
+	char *tmp = NULL, *eol;
+
+	if (data)
+		buffer = data;
+	else {
+		enum object_type type;
+
+		buffer = tmp = read_sha1_file(tag->object.sha1, &type, &size);
+		if (!buffer)
+			return error_func(&tag->object, FSCK_ERROR,
+				"cannot read tag object");
+
+		if (type != OBJ_TAG) {
+			ret = error_func(&tag->object, FSCK_ERROR,
+				"expected tag got %s",
+			    typename(type));
+			goto done;
+		}
+	}
+
+	if (must_have_empty_line(buffer, size, &tag->object, error_func))
+		goto done;
+
+	if (!skip_prefix(buffer, "object ", &buffer)) {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
+		goto done;
+	}
+	if (get_sha1_hex(buffer, commit_sha1) || buffer[40] != '\n') {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'object' line format - bad sha1");
+		goto done;
+	}
+	buffer += 41;
+
+	if (!skip_prefix(buffer, "type ", &buffer)) {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'type' line");
+		goto done;
+	}
+	eol = strchr(buffer, '\n');
+	if (!eol) {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
+		goto done;
+	}
+	*eol = '\0';
+	if (type_from_string_gently(buffer) < 0)
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'type' value");
+	*eol = '\n';
+	if (ret)
+		goto done;
+	buffer = eol + 1;
+
+	if (!skip_prefix(buffer, "tag ", &buffer)) {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
+		goto done;
+	}
+	eol = strchr(buffer, '\n');
+	if (!eol) {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
+		goto done;
+	}
+	*eol = '\0';
+	if (check_refname_format(buffer, REFNAME_ALLOW_ONELEVEL))
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'tag' name: %s", buffer);
+	*eol = '\n';
+	if (ret)
+		goto done;
+	buffer = eol + 1;
+
+	if (!skip_prefix(buffer, "tagger ", &buffer)) {
+		/* early tags do not contain 'tagger' lines; warn only */
+		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
+	}
+	ret = fsck_ident(&buffer, &tag->object, error_func);
+
+done:
+	free(tmp);
+	return ret;
+}
+
 static int fsck_tag(struct tag *tag, const char *data,
 	unsigned long size, fsck_error error_func)
 {
@@ -362,7 +447,8 @@ static int fsck_tag(struct tag *tag, const char *data,
 
 	if (!tagged)
 		return error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
-	return 0;
+
+	return fsck_tag_buffer(tag, data, size, error_func);
 }
 
 int fsck_object(struct object *obj, void *data, unsigned long size,
-- 
2.0.0.rc3.9669.g840d1f9

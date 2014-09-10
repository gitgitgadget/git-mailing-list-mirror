From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 4/6] fsck: check tag objects' headers
Date: Wed, 10 Sep 2014 15:53:04 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409101553020.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info> <cover.1410356761.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 10 15:53:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRiKm-0000Aw-7G
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbaIJNxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:53:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:54856 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaIJNxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:53:14 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0Le64S-1Y8lnZ1WgO-00psKB;
 Wed, 10 Sep 2014 15:53:05 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410356761.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:heS3u0qrjm93DxpZXgF37WTHfE5kKfws0ITrdtScTxD7fnhW0uB
 Cg8NX1vxj70ruRxuPz8urL7LDT7ByNdURglGA51EXoYtDDdf0ujJsVgShc04MjvnlrU6oG7
 /P5tJzL8l5mtsOrJO9TrmU79HYZlK2yTlmPynGAbLJZ6om49JxxzJu/yoVrkXk7ogzlWpuj
 1Iym4q1+DTH13BIqdOYtg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256745>

We inspect commit objects pretty much in detail in git-fsck, but we just
glanced over the tag objects. Let's be stricter.

Since we do not want to limit 'tag' lines unduly, values that would fail
the refname check only result in warnings, not errors.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 9dd7d12..8341a30 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "refs.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -355,6 +356,87 @@ static int fsck_commit(struct commit *commit, const char *data,
 	return ret;
 }
 
+static int fsck_tag_buffer(struct tag *tag, const char *data,
+	unsigned long size, fsck_error error_func)
+{
+	unsigned char sha1[20];
+	int ret = 0;
+	const char *buffer;
+	char *to_free = NULL, *eol;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (data)
+		buffer = data;
+	else {
+		enum object_type type;
+
+		buffer = to_free =
+			read_sha1_file(tag->object.sha1, &type, &size);
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
+	if (require_end_of_header(buffer, size, &tag->object, error_func))
+		goto done;
+
+	if (!skip_prefix(buffer, "object ", &buffer)) {
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
+		goto done;
+	}
+	if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
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
+	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
+		ret = error_func(&tag->object, FSCK_ERROR, "invalid 'type' value");
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
+	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
+	if (check_refname_format(sb.buf, 0))
+		error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %s", buffer);
+	buffer = eol + 1;
+
+	if (!skip_prefix(buffer, "tagger ", &buffer)) {
+		/* early tags do not contain 'tagger' lines; warn only */
+		error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
+	}
+	ret = fsck_ident(&buffer, &tag->object, error_func);
+
+done:
+	free(to_free);
+	return ret;
+}
+
 static int fsck_tag(struct tag *tag, const char *data,
 	unsigned long size, fsck_error error_func)
 {
@@ -362,7 +444,8 @@ static int fsck_tag(struct tag *tag, const char *data,
 
 	if (!tagged)
 		return error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
-	return 0;
+
+	return fsck_tag_buffer(tag, data, size, error_func);
 }
 
 int fsck_object(struct object *obj, void *data, unsigned long size,
-- 
2.0.0.rc3.9669.g840d1f9

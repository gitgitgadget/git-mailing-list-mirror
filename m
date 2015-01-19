From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 14/18] fsck: Allow upgrading fsck warnings to errors
Date: Mon, 19 Jan 2015 16:51:37 +0100
Organization: gmx
Message-ID: <2a520e8d2b9f332f61edd7f8e45eab01b46bd508.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 17:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEkS-0006a5-QB
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 17:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbbASQAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 11:00:10 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689AbbASP7g (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:36 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFpb9Y026436;
	Mon, 19 Jan 2015 16:51:37 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFpb4Y026435;
	Mon, 19 Jan 2015 16:51:37 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262634>

The 'invalid tag name' and 'missing tagger entry' warnings can now be
upgraded to errors by specifying `invalid-tag-name` and
`missing-tagger-entry` to the receive.fsck.error config setting.

Incidentally, the missing tagger warning is now really shown as a warning
(as opposed to being reported with the "error:" prefix, as it used to be
the case before this commit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                | 24 +++++++++++++++++-------
 t/t5302-pack-index.sh |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 649c8fe..480cd87 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,6 +10,7 @@
 #include "utf8.h"
 
 #define FSCK_FATAL -1
+#define FSCK_INFO -2
 
 #define FOREACH_MSG_ID(FUNC) \
 	/* fatal errors */ \
@@ -55,10 +56,11 @@
 	FUNC(HAS_DOT, WARN) \
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
-	FUNC(INVALID_TAG_NAME, WARN) \
-	FUNC(MISSING_TAGGER_ENTRY, WARN) \
 	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN)
+	FUNC(ZERO_PADDED_FILEMODE, WARN) \
+	/* infos (reported as warnings, but ignored by default) */ \
+	FUNC(INVALID_TAG_NAME, INFO) \
+	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
 #define MSG_ID(id, severity) FSCK_MSG_##id,
 enum fsck_msg_id {
@@ -200,6 +202,8 @@ static int report(struct fsck_options *options, struct object *object,
 
 	if (msg_severity == FSCK_FATAL)
 		msg_severity = FSCK_ERROR;
+	else if (msg_severity == FSCK_INFO)
+		msg_severity = FSCK_WARN;
 
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
@@ -658,15 +662,21 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
-	if (check_refname_format(sb.buf, 0))
-		report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME,
+	if (check_refname_format(sb.buf, 0)) {
+		ret = report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME,
 			   "invalid 'tag' name: %.*s",
 			   (int)(eol - buffer), buffer);
+		if (ret)
+			goto done;
+	}
 	buffer = eol + 1;
 
-	if (!skip_prefix(buffer, "tagger ", &buffer))
+	if (!skip_prefix(buffer, "tagger ", &buffer)) {
 		/* early tags do not contain 'tagger' lines; warn only */
-		report(options, &tag->object, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
+		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
+		if (ret)
+			goto done;
+	}
 	else
 		ret = fsck_ident(&buffer, &tag->object, options);
 
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 61bc8da..3dc5ec4 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -259,7 +259,7 @@ EOF
     thirtyeight=${tag#??} &&
     rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
     git index-pack --strict tag-test-${pack1}.pack 2>err &&
-    grep "^error:.* expected .tagger. line" err
+    grep "^warning:.* expected .tagger. line" err
 '
 
 test_done
-- 
2.0.0.rc3.9669.g840d1f9

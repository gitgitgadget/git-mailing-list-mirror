From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 14/18] fsck: allow upgrading fsck warnings to errors
Date: Mon, 8 Dec 2014 17:15:25 +0100 (CET)
Message-ID: <c70409e8e6a42bdc7cacd19cbd49d5d1adbedd1a.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yG-0006Mx-Ty
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbaLHQPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:50950 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755908AbaLHQPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:30 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lck9X-1XWgNF1IUZ-00k9uG;
 Mon, 08 Dec 2014 17:15:26 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:uUNWGSjbctkXuiANmffLtBNOcbTBtnkme7ArS1VSJGg68tySXNX
 SWCPbEI0VMZyfrx6SP+piRKsM2hS+7sZMc3rJzJ8zxWrYmWKLkzN8uKXQ04dhugs+zXmlvh
 kmUkmW+T+O0MzwIDSBYHaTVRRbGms7+qcOLI9MtRsontTInhQiFG/luBYexTAP0mo8D2+U0
 XtVVUP6WzLax0GJxz4+yQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261066>

The 'invalid tag name' and 'missing tagger entry' warnings can now be
upgraded to errors by setting receive.fsck.invalid-tag-name and
receive.fsck.missing-tagger-entry to 'error'.

Incidentally, the missing tagger warning is now really shown as a warning
(as opposed to being reported with the "error:" prefix, as it used to be
the case before this commit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                | 24 ++++++++++++++++--------
 t/t5302-pack-index.sh |  2 +-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fsck.c b/fsck.c
index abfd3af..154f361 100644
--- a/fsck.c
+++ b/fsck.c
@@ -52,13 +52,15 @@
 	FUNC(HAS_DOT) \
 	FUNC(HAS_DOTDOT) \
 	FUNC(HAS_DOTGIT) \
-	FUNC(INVALID_TAG_NAME) \
-	FUNC(MISSING_TAGGER_ENTRY) \
 	FUNC(NULL_SHA1) \
-	FUNC(ZERO_PADDED_FILEMODE)
+	FUNC(ZERO_PADDED_FILEMODE) \
+	/* infos (reported as warnings, but ignored by default) */ \
+	FUNC(INVALID_TAG_NAME) \
+	FUNC(MISSING_TAGGER_ENTRY)
 
 #define FIRST_NON_FATAL_ERROR FSCK_MSG_BAD_DATE
 #define FIRST_WARNING FSCK_MSG_BAD_FILEMODE
+#define FIRST_INFO FSCK_MSG_INVALID_TAG_NAME
 
 #define MSG_ID(x) FSCK_MSG_##x,
 enum fsck_msg_id {
@@ -103,7 +105,7 @@ int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
 	if (options->strict_mode && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
 		return options->strict_mode[msg_id];
 	if (options->strict)
-		return FSCK_ERROR;
+		return msg_id < FIRST_INFO ? FSCK_ERROR : FSCK_WARN;
 	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
 }
 
@@ -643,13 +645,19 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
-	if (check_refname_format(sb.buf, 0))
-		report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME, "invalid 'tag' name: %s", buffer);
+	if (check_refname_format(sb.buf, 0)) {
+		ret = report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME, "invalid 'tag' name: %s", buffer);
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

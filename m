From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 14/19] fsck: Allow upgrading fsck warnings to errors
Date: Mon, 22 Jun 2015 17:26:54 +0200
Organization: gmx
Message-ID: <3bbee0090b9ed0f6fc893facd815fdfaf0fa1619.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73cp-0007Js-Sj
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbbFVP1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:27:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:57009 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbbFVP1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:27:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LpcBS-1Ye4SG47RG-00fP4o; Mon, 22 Jun 2015 17:26:55
 +0200
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:LE8l34JONKrPImAB3nrDF5aXOh9UE+juSD/6C28LN4De9wblx4G
 AutfoXmKAazQ89Yh7wC26oTt8alkfKuYYNGOyChU9wxnznXG4Cq2b0z047WFUSLNH82yNIN
 xz1M4L9Zf9MAvY+QGjC1fw6sBGCmENscc3RvEkJpM+PlB9yQw0CPUxOla51bo+BL/mTc9T6
 hy85UnOHKE5XoCReMy6Eg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272385>

The 'invalid tag name' and 'missing tagger entry' warnings can now be
upgraded to errors by specifying `invalidTagName` and
`missingTaggerEntry` in the receive.fsck.<msg-id> config setting.

Incidentally, the missing tagger warning is now really shown as a warning
(as opposed to being reported with the "error:" prefix, as it used to be
the case before this commit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                | 24 +++++++++++++++++-------
 t/t5302-pack-index.sh |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index cbfff1f..f6fc384 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,6 +10,7 @@
 #include "utf8.h"
 
 #define FSCK_FATAL -1
+#define FSCK_INFO -2
 
 #define FOREACH_MSG_ID(FUNC) \
 	/* fatal errors */ \
@@ -50,15 +51,16 @@
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE, WARN) \
-	FUNC(BAD_TAG_NAME, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
-	FUNC(MISSING_TAGGER_ENTRY, WARN) \
 	FUNC(NULL_SHA1, WARN) \
-	FUNC(ZERO_PADDED_FILEMODE, WARN)
+	FUNC(ZERO_PADDED_FILEMODE, WARN) \
+	/* infos (reported as warnings, but ignored by default) */ \
+	FUNC(BAD_TAG_NAME, INFO) \
+	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
@@ -228,6 +230,8 @@ static int report(struct fsck_options *options, struct object *object,
 
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
+	else if (msg_type == FSCK_INFO)
+		msg_type = FSCK_WARN;
 
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
@@ -686,15 +690,21 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
-	if (check_refname_format(sb.buf, 0))
-		report(options, &tag->object, FSCK_MSG_BAD_TAG_NAME,
+	if (check_refname_format(sb.buf, 0)) {
+		ret = report(options, &tag->object, FSCK_MSG_BAD_TAG_NAME,
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
2.3.1.windows.1.9.g8c01ab4

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 14/19] fsck: Allow upgrading fsck warnings to errors
Date: Wed, 21 Jan 2015 20:26:54 +0100
Organization: gmx
Message-ID: <00dc8446a9c89b5093ccbe17667743caf09c4e79.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0ve-0003Ml-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbbAUT07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:26:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:55940 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbbAUT05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:26:57 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Luxaj-1Xn6Ct2YE5-01025V; Wed, 21 Jan 2015 20:26:54
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:rP86JOfEuZlL1DX8kuMis74gFHBR7/zQ+j/8yE6pXJ6mxyXTVER
 iG9GNZWzTI6v0+LpQOC9nZYFQQeXVJhwxlVexxbt4ST5ea3Qg2Vz4tWp6beayXyckfqGlJ0
 ZDqoeNl4d9KdX/GV+/9PwOWwaFZLRrh7m4nbMnPcqfqzndTN+VX0nJ3gDzFbaSCoSX/YwYV
 fowtNCa+SFGfkSh9B2Adg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262759>

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
index 028a7ca..1334941 100644
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
2.2.0.33.gc18b867

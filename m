From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 14/19] fsck: Allow upgrading fsck warnings to errors
Date: Thu, 18 Jun 2015 22:09:34 +0200
Organization: gmx
Message-ID: <6c5ac208f58d995fa07d64aa4b0ef4ae634e85d4.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g8K-0003xm-Ln
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbbFRUJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:09:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:63313 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbbFRUJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:09:38 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MBExR-1ZFGMl4C0L-00AFFI; Thu, 18 Jun 2015 22:09:35
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:yswCJPwI/9etTbpDi7nYIIDYxOhgBjaS887QlCaG20GNF9/oT7Y
 kBVkOmcoMA/2HN5ju3VSbtVVVzVL7J7QywZCHea5WPQWd2dcuKL64yoyiARcI8cJ3/KIO/+
 RfvLZdvy4DM+x1RvjnHatoYjOt4Dc+6Z/igYJTN5cQLNYt1hQqoFDjUOCCqFcPlJofD5xBK
 6U57luGXVsK6Pq81c4YfQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C9wpbMTdqa0=:Ckd8nDHW/wqXUr/4qBOYWb
 nIpr7GWXIs4ZfiGsxLGmiCv7gvcfbQ2KYT2WEoa0nj5/tPBaghKVF0N+iky0a2fTWoUaEcVIr
 BtsyDE37kOd3d9zY2nT+0Cy7UHYLEeZhEbWjKQ5XBANT7R5vD7tWAAKByIf2jQY6Vr7HILjvO
 LEj5rRDbU7s04YSmja4OttuK0z3JxHI7AM0VL4zPpYqbMfc1xc1pJSwg+eJ/y2G0f9QUVL7xx
 CnkLDOb7QIaP4jUjLcJZRshPboaLMvc2rHF8UIJjPjOTncoFcBnm6VmjD2bgVLb23wyWGXH85
 r2Hb80spEDL1/Sw+gQk3Y5KknmTHRJJbXt+57pVE9S30DtLk15O7fMyaTEjoOb0CXHQgIZZGZ
 gpxhS4W7lAYO1nmaFkN00mhEQfK0TBdOFwCJjNRvDhzgbRb4wmiFt48oml3nOW4hvIHhe0L9v
 DtoGU6XFz6WP0sJgo+z6okhHT1ROKN6Vip2i4f6tGPA1QfOxLaRopq+R+8lM3Hode3q4gdalB
 Odo70ZQA/xmyRJJSfRo9z0BFM5xvyAAQbzxXB3SMuNPa6Ua7GbinwX7XclcBT6DC5p9q/Q98o
 7aTztHwMViy2Y2zPdloq8Yd4yBmLc9sYLwGsUgQiH9Cx0FakMiEBwxo84EZ0shmdOjFNoAYK0
 dDiefBu7ClVVO26kNwJi/cJQ5PUtGzzrRDiUht56Tmk7Ryx/e+tzm4bvsb8DFz+kH2b8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272056>

The 'invalid tag name' and 'missing tagger entry' warnings can now be
upgraded to errors by specifying `invalidtagname` and
`missingtaggerentry` in the receive.fsck.<msg-id> config setting.

Incidentally, the missing tagger warning is now really shown as a warning
(as opposed to being reported with the "error:" prefix, as it used to be
the case before this commit).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                | 24 +++++++++++++++++-------
 t/t5302-pack-index.sh |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fsck.c b/fsck.c
index 0f7eb22..a5e7dfb 100644
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
 
 #define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
@@ -227,6 +229,8 @@ static int report(struct fsck_options *options, struct object *object,
 
 	if (msg_type == FSCK_FATAL)
 		msg_type = FSCK_ERROR;
+	else if (msg_type == FSCK_INFO)
+		msg_type = FSCK_WARN;
 
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
@@ -685,15 +689,21 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
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
2.3.1.windows.1.9.g8c01ab4

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 12/18] fsck: Disallow demoting grave fsck errors to  warnings
Date: Mon, 19 Jan 2015 16:51:22 +0100
Organization: gmx
Message-ID: <ed901ae6a0bcd8e2d0d45b55a105e0f2b1aa916f.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 16:59:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEju-0006J3-RY
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 16:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbbASP7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:33 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751633AbbASP7b (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:31 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFpMkN026402;
	Mon, 19 Jan 2015 16:51:22 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFpM2m026401;
	Mon, 19 Jan 2015 16:51:22 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <cover.1421682369.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262621>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 13 +++++++++++--
 t/t5504-fetch-receive-strict.sh |  9 +++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index b8cbbfb..f2c8044 100644
--- a/fsck.c
+++ b/fsck.c
@@ -9,7 +9,12 @@
 #include "refs.h"
 #include "utf8.h"
 
+#define FSCK_FATAL -1
+
 #define FOREACH_MSG_ID(FUNC) \
+	/* fatal errors */ \
+	FUNC(NUL_IN_HEADER, FATAL) \
+	FUNC(UNTERMINATED_HEADER, FATAL) \
 	/* errors */ \
 	FUNC(BAD_DATE, ERROR) \
 	FUNC(BAD_EMAIL, ERROR) \
@@ -40,10 +45,8 @@
 	FUNC(MISSING_TYPE_ENTRY, ERROR) \
 	FUNC(MULTIPLE_AUTHORS, ERROR) \
 	FUNC(NOT_SORTED, ERROR) \
-	FUNC(NUL_IN_HEADER, ERROR) \
 	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
 	FUNC(UNKNOWN_TYPE, ERROR) \
-	FUNC(UNTERMINATED_HEADER, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE, WARN) \
@@ -157,6 +160,9 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 		}
 
 		msg_id = parse_msg_id(mode, len);
+		if (severity != FSCK_ERROR &&
+				msg_id_info[msg_id].severity == FSCK_FATAL)
+			die("Cannot demote %.*s", len, mode);
 		options->msg_severity[msg_id] = severity;
 		mode += len;
 	}
@@ -187,6 +193,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_severity = fsck_msg_severity(id, options), result;
 
+	if (msg_severity == FSCK_FATAL)
+		msg_severity = FSCK_ERROR;
+
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
 	va_start(ap, fmt);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index d491172..2757c3a 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -135,4 +135,13 @@ test_expect_success 'push with receive.fsck.warn = missing-email' '
 	grep "missing-email" act
 '
 
+test_expect_success 'receive.fsck.warn = unterminated-header triggers error' '
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	git --git-dir=dst/.git config receive.fsck.warn unterminated-header &&
+	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
+	grep "Cannot demote unterminated-header" act
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 12/19] fsck: Disallow demoting grave fsck errors to
 warnings
Date: Wed, 21 Jan 2015 20:26:12 +0100
Organization: gmx
Message-ID: <ac323d099490f533a926d55adb64187c6f012b6c.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:26:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0ux-0002xA-SM
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbbAUT0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:26:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:54189 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbbAUT0P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:26:15 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MgXCF-1YPCN92EkB-00NzeD; Wed, 21 Jan 2015 20:26:12
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:m3p9YBmH6C3m7KLNugvkoSk5mtV3fLIyqM2tSaq+SmXT1L098M+
 tGfG1yekSYCIC6/7n4U/5+/S++/v+wvdnzahW/P/7SM1upLNJasXGv/6M9V7La9fhzLDwlM
 v5tVbdhLMRcYzO5srDoMIxZ48/x/ETj6Uhs/8KZ0TzKFHVw1/Fv+cZz87bJrrdsftl3anEW
 XwGRWzOHapzvFmsm/L+1g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262757>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 13 +++++++++++--
 t/t5504-fetch-receive-strict.sh |  9 +++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4adf9ce..27a381b 100644
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
index 40c7557..75d718f 100755
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
2.2.0.33.gc18b867

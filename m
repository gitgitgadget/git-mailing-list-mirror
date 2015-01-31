From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 12/19] fsck: Disallow demoting grave fsck errors to
 warnings
Date: Sat, 31 Jan 2015 22:05:34 +0100
Organization: gmx
Message-ID: <1a5759c5882313ce5f39da089f9d1728abd85b77.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfEh-0004Oc-Co
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059AbbAaVFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:05:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:60054 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777AbbAaVFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:05:42 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LmJsk-1Xj9Qa3PoQ-00Zszj; Sat, 31 Jan 2015 22:05:34
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:HxLKrEN33eJUewv9M6m3ScN1UXpekjeji8egm7OinlZMCMlEZyQ
 P4zNoQ6lFvkJpzBgjk1BlWFp300jqVqcbI/woFivUvtjBoXnwZVs9qcxOVq6Kd3Q2OxYtd5
 +BE3tluAhDSO2omhshvSv51DpVGGqH/b7REI9U3nnpGyJ4CaLSTxa2cmT1r0Yiz6m+AmuCt
 PDGWukFN/F5M9NrECrZ0g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263217>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 13 +++++++++++--
 t/t5504-fetch-receive-strict.sh | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index f72e404..e126320 100644
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
@@ -163,6 +166,9 @@ void fsck_set_severity(struct fsck_options *options, const char *mode)
 					len2, p);
 		}
 
+		if (severity != FSCK_ERROR &&
+				msg_id_info[msg_id].severity == FSCK_FATAL)
+			die("Cannot demote %.*s", len, mode);
 		options->msg_severity[msg_id] = severity;
 		mode += len;
 	}
@@ -193,6 +199,9 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_severity = fsck_msg_severity(id, options), result;
 
+	if (msg_severity == FSCK_FATAL)
+		msg_severity = FSCK_ERROR;
+
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
 	va_start(ap, fmt);
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 9d49cb7..0b6af82 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -136,4 +136,15 @@ test_expect_success 'push with receive.fsck.severity = missing-email=warn' '
 	grep "missing-email" act
 '
 
+test_expect_success \
+	'receive.fsck.severity = unterminated-header=warn triggers error' '
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	git --git-dir=dst/.git config \
+		receive.fsck.severity unterminated-header=warn &&
+	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
+	grep "Cannot demote unterminated-header" act
+'
+
 test_done
-- 
2.2.0.33.gc18b867

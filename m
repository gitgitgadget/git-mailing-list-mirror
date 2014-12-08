From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 12/18] Disallow demoting grave fsck errors to warnings
Date: Mon, 8 Dec 2014 17:15:16 +0100 (CET)
Message-ID: <fcf343ed359ca47d6154f0d1e1850738eb7768ac.1418055173.git.johannes.schindelin@gmx.de>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 08 17:15:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy0yA-0006Hi-Hd
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 17:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903AbaLHQPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 11:15:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:56117 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755885AbaLHQPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 11:15:19 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0LiDnn-1XcCgA0uBf-00nR75;
 Mon, 08 Dec 2014 17:15:17 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1418055173.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:GOd6vdsmTxfxzJWNp39UYErO2ss1afI3BxnZT1rdSN7MHcJvpIw
 hmgkNkDjfxA6rWyKNpXtjIHIcREr+Uw8Oof0kiH02b+q3DCBcSZxdJMe1WO65mxGsMB7ZIT
 YOnhjaDtPlFQaDDvLDYRhsVcZOWNanOs8Y/L2lnf3c5BXgMjW92VYlhV/KmBH4Iy1aWNDO8
 yXC+1pjf2e19JGBVS6pPQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261063>

Some kinds of errors are intrinsically unrecoverable (e.g. errors while
uncompressing objects). It does not make sense to allow demoting them to
mere warnings.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c                          | 8 ++++++--
 t/t5504-fetch-receive-strict.sh | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index c1e7a85..f8339af 100644
--- a/fsck.c
+++ b/fsck.c
@@ -9,6 +9,9 @@
 #include "refs.h"
 
 #define FOREACH_MSG_ID(FUNC) \
+	/* fatal errors */ \
+	FUNC(NUL_IN_HEADER) \
+	FUNC(UNTERMINATED_HEADER) \
 	/* errors */ \
 	FUNC(BAD_DATE) \
 	FUNC(BAD_EMAIL) \
@@ -39,10 +42,8 @@
 	FUNC(MISSING_TYPE_ENTRY) \
 	FUNC(MULTIPLE_AUTHORS) \
 	FUNC(NOT_SORTED) \
-	FUNC(NUL_IN_HEADER) \
 	FUNC(TAG_OBJECT_NOT_TAG) \
 	FUNC(UNKNOWN_TYPE) \
-	FUNC(UNTERMINATED_HEADER) \
 	FUNC(ZERO_PADDED_DATE) \
 	/* warnings */ \
 	FUNC(BAD_FILEMODE) \
@@ -56,6 +57,7 @@
 	FUNC(NULL_SHA1) \
 	FUNC(ZERO_PADDED_FILEMODE)
 
+#define FIRST_NON_FATAL_ERROR FSCK_MSG_BAD_DATE
 #define FIRST_WARNING FSCK_MSG_BAD_FILEMODE
 
 #define MSG_ID(x) FSCK_MSG_##x,
@@ -150,6 +152,8 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
 		}
 
 		msg_id = parse_msg_id(mode, equal);
+		if (type != FSCK_ERROR && msg_id < FIRST_NON_FATAL_ERROR)
+			die("Cannot demote %.*s", len, mode);
 		options->strict_mode[msg_id] = type;
 		mode += len;
 	}
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index db79e56..8a47db2 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -135,4 +135,13 @@ test_expect_success 'push with receive.fsck.missing-mail = warn' '
 	grep "missing-email" act
 '
 
+test_expect_success 'receive.fsck.unterminated-header = warn triggers error' '
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	git --git-dir=dst/.git config receive.fsck.unterminated-header warn &&
+	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
+	grep "Cannot demote unterminated-header=warn" act
+'
+
 test_done
-- 
2.0.0.rc3.9669.g840d1f9

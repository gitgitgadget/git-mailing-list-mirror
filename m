From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] fixup! refs: make rev-parse --quiet actually quiet
Date: Tue, 16 Sep 2014 21:35:29 -0700
Message-ID: <1410928530-21595-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 06:35:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU6xq-0008Ns-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 06:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbaIQEfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 00:35:30 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38480 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaIQEf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 00:35:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so1281926pab.5
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 21:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=OZmajBFYcGTDbufagAStxEdpm1/r2eLqPs4IQ77dJfI=;
        b=093f5LEfMIeFxUE2KgYrqV+AbIDoZ262GZtihyoq2gAOkgYfWI7RUTNxJ2U74JsX7E
         z4YDLeKTapi/ZMLUXiBs4dVV9+gm+A4dhWt+/Gs9L8B0AiYTxH2QtLXLd/1BI45F4zcP
         Ed93TPxYosGB/jhGY5FCzQCnCtwGWWAukA1s8FEglnL42kryUiPGSPRhe184jf8YD640
         ypJMTEdSMFGwgY8Qr7o3Z7Ty59kRjEc2mVDUouZK+YO6GEVV4Ggo/kWZ6kIlGJEqvmoe
         yNArkfMpJElPwyUvuDNYP9mujDSvgNYEomGEBxmiM93o+Pl1/xE+pxiv7ckMfl8lZTAl
         l+rA==
X-Received: by 10.68.135.70 with SMTP id pq6mr56974424pbb.10.1410928528824;
        Tue, 16 Sep 2014 21:35:28 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ou6sm15467009pbb.88.2014.09.16.21.35.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 21:35:27 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.248.g6401287.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257211>

---
This is a fixup for da/rev-parse-verify-quiet in pu
We now exit(128) and handle the "Log for XXX only has DDD entries" case.

 refs.c                      |  2 +-
 sha1_name.c                 |  3 +++
 t/t1503-rev-parse-verify.sh | 10 +++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 447e339..9e405f9 100644
--- a/refs.c
+++ b/refs.c
@@ -3128,7 +3128,7 @@ int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time,
 
 	if (!cb.reccnt) {
 		if (flags & GET_SHA1_QUIETLY)
-			exit(1);
+			exit(128);
 		else
 			die("Log for %s is empty.", refname);
 	}
diff --git a/sha1_name.c b/sha1_name.c
index d292e31..be9a9de 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -563,6 +563,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 					"back to %s.", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
 			else {
+				if (flags & GET_SHA1_QUIETLY) {
+					exit(128);
+				}
 				die("Log for '%.*s' only has %d entries.",
 				    len, str, co_cnt);
 			}
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 4fe9f0e..7c3d830 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -86,12 +86,20 @@ test_expect_success 'fails silently when using -q' '
 test_expect_success 'fails silently when using -q with deleted reflogs' '
 	ref=$(git rev-parse HEAD) &&
 	: >.git/logs/refs/test &&
-	git update-ref -m "reflog message for refs/test" refs/test "$ref" &&
+	git update-ref -m "message for refs/test" refs/test "$ref" &&
 	git reflog delete --updateref --rewrite refs/test@{0} &&
 	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
 	test_must_be_empty error
 '
 
+test_expect_success 'fails silently when using -q with not enough reflogs' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test2 &&
+	git update-ref -m "message for refs/test2" refs/test2 "$ref" &&
+	test_must_fail git rev-parse -q --verify refs/test2@{999} >error 2>&1 &&
+	test_must_be_empty error
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.248.g6401287.dirty

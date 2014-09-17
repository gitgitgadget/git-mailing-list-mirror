From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/2] rev-parse: honor --quiet when asking for reflog dates that do not exist
Date: Tue, 16 Sep 2014 21:35:30 -0700
Message-ID: <1410928530-21595-2-git-send-email-davvid@gmail.com>
References: <1410928530-21595-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 06:35:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU6xr-0008Ns-5q
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 06:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbaIQEfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2014 00:35:32 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:42261 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbaIQEfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2014 00:35:31 -0400
Received: by mail-pd0-f172.google.com with SMTP id v10so1313798pde.3
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 21:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WI7xO9QeN/FvkZxjadxlFJNoogoCZqh15O1gKnT0Mz8=;
        b=ZZhTe2Toaqnn7UX8kfwVuBz6XjaAi/KFxQdrHazllDRANW8Eqv+FNZWMEROajGJtjS
         /gEknhoonKWfijM3PkE00RQlXlq4rGhY4QLY0xhFGAINMfA23g9OqHeyOn1hmmJCyj8I
         MULpQDYBWu09Mw74Gk9ixTvTB6CSFgO+bWKsJtckBn3M41PIL8qBvb0T/N7bZAAef7wG
         XXOUsCrJWkbFuf9YR1RCo63xhtrNg4xbQO7H9bZEk1CkP9JmTOsZwfhn9v9t9ylJEaWm
         GwCmhiYOixr6nPnvksv09BGA9HJvzDeVRbq3lf6Y+9YL1CckKoHLAbCqZ4mjZ8foo2tP
         Wrog==
X-Received: by 10.66.121.65 with SMTP id li1mr21537093pab.128.1410928530594;
        Tue, 16 Sep 2014 21:35:30 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ou6sm15467009pbb.88.2014.09.16.21.35.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 21:35:29 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.248.g6401287.dirty
In-Reply-To: <1410928530-21595-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257212>

Make rev-parse --verify --quiet ref@{1.year.ago} when the reflog
does not go back that far succeed silently with --quiet.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 sha1_name.c                 | 19 ++++++++++++-------
 t/t1503-rev-parse-verify.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index be9a9de..5836f94 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -514,8 +514,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (warn_ambiguous_refs &&
 	    (refs_found > 1 ||
-	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
-		warning(warn_msg, len, str);
+	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY))) {
+		if (!(flags & GET_SHA1_QUIETLY)) {
+			warning(warn_msg, len, str);
+		}
+	}
 
 	if (reflog_len) {
 		int nth, i;
@@ -558,11 +561,13 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 					len = 4;
 				}
 			}
-			if (at_time)
-				warning("Log for '%.*s' only goes "
-					"back to %s.", len, str,
-					show_date(co_time, co_tz, DATE_RFC2822));
-			else {
+			if (at_time) {
+				if (!(flags & GET_SHA1_QUIETLY)) {
+					warning("Log for '%.*s' only goes "
+						"back to %s.", len, str,
+						show_date(co_time, co_tz, DATE_RFC2822));
+				}
+			} else {
 				if (flags & GET_SHA1_QUIETLY) {
 					exit(128);
 				}
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 7c3d830..e7dece0 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -100,6 +100,16 @@ test_expect_success 'fails silently when using -q with not enough reflogs' '
 	test_must_be_empty error
 '
 
+test_expect_success 'succeeds silently when using -q with invalid dates' '
+	ref=$(git rev-parse HEAD) &&
+	: >.git/logs/refs/test3 &&
+	git update-ref -m "message for refs/test3" refs/test3 "$ref" &&
+	git rev-parse -q --verify refs/test3@{1.year.ago} >actual 2>error &&
+	test_must_be_empty error &&
+	echo "$ref" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no stdout output on error' '
 	test -z "$(git rev-parse --verify)" &&
 	test -z "$(git rev-parse --verify foo)" &&
-- 
2.1.0.248.g6401287.dirty

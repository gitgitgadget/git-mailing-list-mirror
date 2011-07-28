From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 3/5] fast-import: check committer name more strictly
Date: Thu, 28 Jul 2011 11:44:02 +0600
Message-ID: <1311831844-13123-4-git-send-email-divanorama@gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 07:41:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmJLi-0004L5-AP
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 07:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab1G1Fl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 01:41:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56514 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab1G1FlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 01:41:19 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so916357fxh.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 22:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pNMG6ycjzdq/2/sOj0REjJkaecv69Bzsqi00WoP9ucQ=;
        b=qD3XONc8TagseqMtmPf5yLLCKa49JEAB2jKj3M3Zu0XOuUUdxptS+ioCuHy3X50ut/
         5myiS8rPuGHLki+dde8uh/aTZk2taoQ3ht9ZSB9oF23pYinVqBRWSNzO+1DlcP6l6Sd2
         1xnepdeSRaUQlHuD9HU/7o8IFOgVv6Mb4ez3M=
Received: by 10.204.145.10 with SMTP id b10mr205570bkv.175.1311831678538;
        Wed, 27 Jul 2011 22:41:18 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id g11sm154133bku.49.2011.07.27.22.41.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 22:41:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178039>

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 fast-import.c          |   29 +++++++++++++++++------------
 t/t9300-fast-import.sh |   10 +++++-----
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 3194f4e..419744f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1968,7 +1968,7 @@ static int validate_raw_date(const char *src, char *result, int maxlen)
 
 static char *parse_ident(const char *buf)
 {
-	const char *gt;
+	const char *ltgt;
 	size_t name_len;
 	char *ident;
 
@@ -1976,28 +1976,33 @@ static char *parse_ident(const char *buf)
 	if (*buf == '<')
 		--buf;
 
-	gt = strrchr(buf, '>');
-	if (!gt)
+	ltgt = buf + strcspn(buf, "<>");
+	if (*ltgt != '<')
+		die("Missing < in ident string: %s", buf);
+	if (ltgt != buf && ltgt[-1] != ' ')
+		die("Missing space before < in ident string: %s", buf);
+	ltgt = ltgt + 1 + strcspn(ltgt + 1, "<>");
+	if (*ltgt != '>')
 		die("Missing > in ident string: %s", buf);
-	gt++;
-	if (*gt != ' ')
+	ltgt++;
+	if (*ltgt != ' ')
 		die("Missing space after > in ident string: %s", buf);
-	gt++;
-	name_len = gt - buf;
+	ltgt++;
+	name_len = ltgt - buf;
 	ident = xmalloc(name_len + 24);
 	strncpy(ident, buf, name_len);
 
 	switch (whenspec) {
 	case WHENSPEC_RAW:
-		if (validate_raw_date(gt, ident + name_len, 24) < 0)
-			die("Invalid raw date \"%s\" in ident: %s", gt, buf);
+		if (validate_raw_date(ltgt, ident + name_len, 24) < 0)
+			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
 		break;
 	case WHENSPEC_RFC2822:
-		if (parse_date(gt, ident + name_len, 24) < 0)
-			die("Invalid rfc2822 date \"%s\" in ident: %s", gt, buf);
+		if (parse_date(ltgt, ident + name_len, 24) < 0)
+			die("Invalid rfc2822 date \"%s\" in ident: %s", ltgt, buf);
 		break;
 	case WHENSPEC_NOW:
-		if (strcmp("now", gt))
+		if (strcmp("now", ltgt))
 			die("Date in ident must be 'now': %s", buf);
 		datestamp(ident + name_len, 24);
 		break;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 09ef6ba..18441f8 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -370,7 +370,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: fail on invalid committer (1)' '
+test_expect_success 'B: fail on invalid committer (1)' '
 	test_must_fail git fast-import <input
 '
 git update-ref -d refs/heads/invalid-committer || true
@@ -382,7 +382,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: fail on invalid committer (2)' '
+test_expect_success 'B: fail on invalid committer (2)' '
 	test_must_fail git fast-import <input
 '
 git update-ref -d refs/heads/invalid-committer || true
@@ -394,7 +394,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: fail on invalid committer (3)' '
+test_expect_success 'B: fail on invalid committer (3)' '
 	test_must_fail git fast-import <input
 '
 git update-ref -d refs/heads/invalid-committer || true
@@ -406,7 +406,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: fail on invalid committer (4)' '
+test_expect_success 'B: fail on invalid committer (4)' '
 	test_must_fail git fast-import <input
 '
 git update-ref -d refs/heads/invalid-committer || true
@@ -418,7 +418,7 @@ data <<COMMIT
 empty commit
 COMMIT
 INPUT_END
-test_expect_failure 'B: fail on invalid committer (5)' '
+test_expect_success 'B: fail on invalid committer (5)' '
 	test_must_fail git fast-import <input
 '
 git update-ref -d refs/heads/invalid-committer || true
-- 
1.7.3.4

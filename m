From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v2 3/5] fast-import: check committer name more strictly
Date: Thu, 11 Aug 2011 16:21:08 +0600
Message-ID: <1313058070-4774-4-git-send-email-divanorama@gmail.com>
References: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Cc: SASAKI Suguru <sss.sonik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 12:21:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrSO4-0004S2-J6
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 12:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755262Ab1HKKVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 06:21:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56320 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab1HKKVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 06:21:02 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so867233bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XU0YPcHW0xqmTad8EminqX9AkkNTUAJwGIM35bZrxW4=;
        b=I2cLx7Uam0onzJzpqWcIR+PjscNFgG24CK7lNaEVV9CAH+Uq8vgjaqx/oAYD9gzBFS
         qtTWE799v0ciz2G4MacqfIAQR3a3wtx/jJ3vtisd9pb6ml+RRi2Oh+PeKEGIvqAF4mSg
         q1sVkMUytYdXmVwHhhb1v7RIkVvSHXmz0x6MY=
Received: by 10.204.5.83 with SMTP id 19mr1825000bku.361.1313058061271;
        Thu, 11 Aug 2011 03:21:01 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id p15sm476918bkd.62.2011.08.11.03.20.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 03:21:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1313058070-4774-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179106>

The documentation declares following identity format:
(<name> SP)? LT <email> GT
where name is any string without LF and LT characters.
But fast-import just accepts any string up to first GT
instead of checking the whole format, and moreover just
writes it as is to the commit object.

git-fsck checks for [^<\n]* <[^<>\n]*> format. Note that the
space is mandatory. And the space quirk is already handled via
extending the string to the left when needed.

Modify fast-import input identity format to a slightly stricter
one - deny LF, LT and GT in both <name> and <email>. And check
for it.

This is stricter then git-fsck as fsck accepts "Name> <email>"
currently, but soon fsck check will be adjusted likewise.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 Documentation/git-fast-import.txt |    4 ++--
 fast-import.c                     |   29 +++++++++++++++++------------
 t/t9300-fast-import.sh            |   10 +++++-----
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2969388..ba16889 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -425,8 +425,8 @@ Here `<name>` is the person's display name (for example
 (``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
-`<name>` is free-form and may contain any sequence of bytes, except
-`LT` and `LF`.  It is typically UTF-8 encoded.
+`<name>` and `<email>` are free-form and may contain any sequence
+of bytes, except `LT`, `GT` and `LF`.  `<name>` is typically UTF-8 encoded.
 
 The time of the change is specified by `<when>` using the date format
 that was selected by the \--date-format=<fmt> command line option.
diff --git a/fast-import.c b/fast-import.c
index ed1f7c9..6d491b9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1969,7 +1969,7 @@ static int validate_raw_date(const char *src, char *result, int maxlen)
 
 static char *parse_ident(const char *buf)
 {
-	const char *gt;
+	const char *ltgt;
 	size_t name_len;
 	char *ident;
 
@@ -1977,28 +1977,33 @@ static char *parse_ident(const char *buf)
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
index 8f3938c..e53ca90 100755
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

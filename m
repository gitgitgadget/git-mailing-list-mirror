From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: [PATCH alt-v3] Improve function dir.c:trim_trailing_spaces()
Date: Mon,  2 Jun 2014 15:36:56 -0700
Message-ID: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Pasha Bolokhov <pasha.bolokhov@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 00:37:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wraqr-00023J-Nh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 00:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaFBWhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 18:37:03 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:60225 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319AbaFBWhC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 18:37:02 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so3856989pde.14
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GDX1nWNyQ5eUfknNV0+TCH0tF2/Ki+bCwjPq28Tj2b8=;
        b=QSVHq7+c4MRwAYt75YjcvhNa7VszCnpks96zIYa9jKRb8WrNBtlHokedwrmOF1OAgC
         f4btF4zEE9QxBS9+2i8y7ZZR2mBKTUXqJydUKDfdfeH6Qzqbgwa2/n31/EqvzxbTMqXv
         9IQicpSZCqMeb/6u4j1YcUf79i1ZEoR3h12Pi85N0UknG2o+BduMMrDKrfnTrGuHbFxq
         5fM0xzIME4I4RhCx7Mm9walpV8UBgWqaZ8eLMUuvjqEXNlxSNJg/dFKKtadwjDIme+WW
         Sk2aNh45GQyDP8EkSmoX86GzFTV0Z9gx3e0YMfupPIMItls4DUnA+JQTJ8dOd6QKqG7L
         Yfkw==
X-Received: by 10.66.228.37 with SMTP id sf5mr44130702pac.19.1401748621568;
        Mon, 02 Jun 2014 15:37:01 -0700 (PDT)
Received: from ani.gv.shawcable.net (S0106586d8f8ca92a.gv.shawcable.net. [96.54.196.148])
        by mx.google.com with ESMTPSA id wt6sm19572207pac.29.2014.06.02.15.37.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jun 2014 15:37:00 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250605>

Discard the unnecessary 'nr_spaces' variable, remove 'strlen()' and
improve the 'if' structure. Switch to pointers instead of integers

Slightly more rare occurrences of 'text  \    ' with a backslash
in between spaces are handled correctly. Namely, the code in
8ba87adad6 does not reset 'last_space' when a backslash is
encountered and the above line stays intact as a result.
Add a test at the end of t/t0008-ignores.sh to exhibit this behavior

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
---
Add /* fallthrough */ comment to switch(), remove TABs in test,
and remove ":" command in file truncation in the test

 dir.c              | 36 +++++++++++++++++++++---------------
 t/t0008-ignores.sh | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..c7dc846 100644
--- a/dir.c
+++ b/dir.c
@@ -508,21 +508,27 @@ void clear_exclude_list(struct exclude_list *el)
 
 static void trim_trailing_spaces(char *buf)
 {
-	int i, last_space = -1, nr_spaces, len = strlen(buf);
-	for (i = 0; i < len; i++)
-		if (buf[i] == '\\')
-			i++;
-		else if (buf[i] == ' ') {
-			if (last_space == -1) {
-				last_space = i;
-				nr_spaces = 1;
-			} else
-				nr_spaces++;
-		} else
-			last_space = -1;
-
-	if (last_space != -1 && last_space + nr_spaces == len)
-		buf[last_space] = '\0';
+	char *p, *last_space = NULL;
+
+	for (p = buf; *p; p++)
+		switch (*p) {
+		case ' ':
+			if (!last_space)
+				last_space = p;
+			break;
+
+		case '\\':
+			p++;
+			if (!*p)
+				return;
+			/* fallthrough */
+
+		default:
+			last_space = NULL;
+		}
+
+	if (last_space)
+		*last_space = '\0';
 }
 
 int add_excludes_from_file_to_list(const char *fname,
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 63beb99..5ef5ad3 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -806,4 +806,27 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	test_cmp err.expect err
 '
 
+test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
+	rm -rf whitespace &&
+	mkdir whitespace &&
+	>"whitespace/trailing 1  " &&
+	>"whitespace/trailing 2 \\\\" &&
+	>"whitespace/trailing 3 \\\\" &&
+	>"whitespace/trailing 4   \\ " &&
+	>"whitespace/trailing 5 \\ \\ " &&
+	>"whitespace/trailing 6 \\a\\" &&
+	>whitespace/untracked &&
+	echo "whitespace/trailing 1 \\    " >ignore  &&
+	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\" >>ignore &&
+	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ " >>ignore &&
+	echo "whitespace/trailing 4   \\\\\\\\\\\\    " >>ignore &&
+	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   " >>ignore &&
+	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\" >>ignore &&
+	echo whitespace/untracked >expect &&
+	>err.expect &&
+	git ls-files -o -X ignore whitespace >actual 2>err &&
+	test_cmp expect actual &&
+	test_cmp err.expect err
+'
+
 test_done
-- 
1.9.1

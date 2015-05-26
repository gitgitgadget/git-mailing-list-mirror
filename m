From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] t4015: separate common setup and per-test expectation
Date: Tue, 26 May 2015 12:46:22 -0700
Message-ID: <1432669584-342-3-git-send-email-gitster@pobox.com>
References: <xmqq1ti3kz5v.fsf@gitster.dls.corp.google.com>
 <1432669584-342-1-git-send-email-gitster@pobox.com>
Cc: Christian Brabandt <cblists@256bit.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 21:46:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxKoE-0001ob-6B
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 21:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbEZTqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 15:46:34 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33528 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbEZTq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 15:46:29 -0400
Received: by igbpi8 with SMTP id pi8so68822611igb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgERGHJDlQqvp5M6oTHALsm5HXJeIuysU//qYXknLvE=;
        b=0bNrFpvCAKjMepHZzlq3OJ4PY5WuP6VcxWxmCs28HY8P2u4FZ3oJwsuKa0EOGqO21+
         Btr0qzbLWtEerVjNJr98jygufXfDD/KNe1TYDEPdJFAJr1797KrODp6dhF7FbUeN6vJP
         44c5L6sYfcQSjWuimBK4IxOVjKtyTHlKjwjonh94Tzd8Z1FHhX90g8476wi+92VIrBaH
         5dtEyz30U5VOu6nI5uGnePRyvsUVaR5Ii/EJD7Np2o5rHsoM/Xwz3sBmUTP8RU/pm2MQ
         VRXtMFQxBiaOeVCZDRnnSZtIvOl8aGL3WHWxOJ5e3T/iAsE8V+SbhTI6LAW/dm6clQwc
         4DBQ==
X-Received: by 10.107.47.4 with SMTP id j4mr256174ioo.17.1432669589257;
        Tue, 26 May 2015 12:46:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id av6sm17402igc.17.2015.05.26.12.46.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 12:46:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.1-511-gc1146d5
In-Reply-To: <1432669584-342-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269970>

The last two tests in the script were to

 - set up color.diff.* slots
 - set up an expectation for a single test
 - run that test and check the result

but split in a wrong way.  It did the first two in the first test
and the third one in the second test.  The latter two belong to each
other.  This matters when you plan to add more of these tests that
share the common coloring.

While at it, make sure we use a color different from old, which is
also red.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4015-diff-whitespace.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 0bfc7ff..4da30e5 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -810,11 +810,20 @@ test_expect_success 'setup diff colors' '
 	git config color.diff.old red &&
 	git config color.diff.new green &&
 	git config color.diff.commit yellow &&
-	git config color.diff.whitespace "normal red" &&
+	git config color.diff.whitespace blue &&
 
-	git config core.autocrlf false &&
+	git config core.autocrlf false
+'
+
+test_expect_success 'diff that introduces a line with only tabs' '
+	git config core.whitespace blank-at-eol &&
+	git reset --hard &&
+	echo "test" >x &&
+	git commit -m "initial" x &&
+	echo "{NTN}" | tr "NT" "\n\t" >>x &&
+	git -c color.diff=always diff | test_decode_color >current &&
 
-	cat >expected <<-\EOF
+	cat >expected <<-\EOF &&
 	<BOLD>diff --git a/x b/x<RESET>
 	<BOLD>index 9daeafb..2874b91 100644<RESET>
 	<BOLD>--- a/x<RESET>
@@ -822,18 +831,10 @@ test_expect_success 'setup diff colors' '
 	<CYAN>@@ -1 +1,4 @@<RESET>
 	 test<RESET>
 	<GREEN>+<RESET><GREEN>{<RESET>
-	<GREEN>+<RESET><BRED>	<RESET>
+	<GREEN>+<RESET><BLUE>	<RESET>
 	<GREEN>+<RESET><GREEN>}<RESET>
 	EOF
-'
 
-test_expect_success 'diff that introduces a line with only tabs' '
-	git config core.whitespace blank-at-eol &&
-	git reset --hard &&
-	echo "test" >x &&
-	git commit -m "initial" x &&
-	echo "{NTN}" | tr "NT" "\n\t" >>x &&
-	git -c color.diff=always diff | test_decode_color >current &&
 	test_cmp expected current
 '
 
-- 
2.4.1-511-gc1146d5

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] t4015: separate common setup and per-test expectation
Date: Tue, 26 May 2015 23:30:30 -0700
Message-ID: <1432708232-29892-3-git-send-email-gitster@pobox.com>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
 <1432708232-29892-1-git-send-email-gitster@pobox.com>
Cc: Christian Brabandt <cblists@256bit.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 08:30:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxUrY-0001bm-Ki
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 08:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbbE0Gam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 02:30:42 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35006 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbbE0Gah (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 02:30:37 -0400
Received: by iesa3 with SMTP id a3so6414759ies.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 23:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PJsUO4h8yKOo55yC8l2Jum78ek1svQ2s4/bptOU1e4A=;
        b=fGEXHmZTSWg362Jd4t9zjvAIjt+LlQ9fTqaJdyj17Yhtaf9/REdqT3fSXMirXzPWwV
         ztuPCDgsjr4xq7VoCjalbze7j/b1FlmAGOImLvIW0fUxjaSuheAmIgflA14c9pwvA8yx
         K9aZHPzt0NIotgGYWWNItcOQBssubMfd1dIq6XlaNfOorDY9exnFsHaQ3KZD6q88+2YU
         VZLwkSrKsta1JrUvoGLCPSc/XRnihLvomAXaCH8NNEaTZe9/vhd7Dw82CoQ/xvXwyPb7
         iN9+CcmNk8RaUvsQxVqxpkO3SOtNrPi5dVE7SVpA9XzxAxy6HfaVXsHWRXLmBrRySd3C
         xzCA==
X-Received: by 10.107.133.9 with SMTP id h9mr35804200iod.47.1432708237021;
        Tue, 26 May 2015 23:30:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4485:3520:962f:d5a5])
        by mx.google.com with ESMTPSA id v3sm1176168igk.1.2015.05.26.23.30.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 23:30:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2-503-g2442661
In-Reply-To: <1432708232-29892-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270018>

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
2.4.2-503-g3e4528a

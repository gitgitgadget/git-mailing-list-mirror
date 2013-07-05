From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v10 5/5] t4205 (log-pretty-formats): avoid using `sed`
Date: Fri,  5 Jul 2013 16:01:50 +0400
Message-ID: <3f54479bde07c3b1ca93ef1175a8ed2879179bd2.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 05 14:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4iZ-0004To-2i
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214Ab3GEMCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:02:15 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:34340 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327Ab3GEMCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:02:09 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so1970661lab.6
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=nCrYmytyHmiQMcFpW3R952zSmfc019hmsgvl68Vkzvc=;
        b=DPG0gD1apMc40GVpZir64PFbAbxtJstcp0z94jpGTMHghYag1qFTR6a6QH1/7aKQbq
         QWuu2uKtDcQcmXD0+8GtiqEhDgDaoCXPgbKbTXQA0vCJsWbGFKxT71FkqG8J6T1qME+R
         OJn53mCW1VK0yr3DLAt+QPNJzRaEHCgfwMGpVaVoOaob8yXVehBTZKl3HeGzcOYDg26z
         LbZEAQ8TAhCNiR1jOml1qQDzvKJJ5CTk6YNU6iTi3PCPtRgn/vzt/bn0q0ZnuRlaMjhc
         ogBFelSeZYRJ1mDft6MP2VgPwz5GLYjo8NdmTLBOh+rFT9GL6ToovMI8ElJKuwQMqUCc
         k18w==
X-Received: by 10.112.150.68 with SMTP id ug4mr5328631lbb.81.1373025728038;
        Fri, 05 Jul 2013 05:02:08 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id n17sm2842143lbv.2.2013.07.05.05.02.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:02:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.16.gb1f0d63
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1373024281.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com> <cover.1373024281.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229654>

For testing truncated log messages 'commit_msg' function uses `sed` to
cut a message. On various platforms `sed` behaves differently and
results of its work depend on locales installed. So, avoid using `sed`.
Use predefined expected outputs instead of calculated ones.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4205-log-pretty-formats.sh | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 2933c63..73fd236 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -7,25 +7,19 @@
 test_description='Test pretty formats'
 . ./test-lib.sh
 
+sample_utf8_part=$(printf "f\303\244ng")
+
 commit_msg () {
 	# String "initial. initial" partly in German
 	# (translated with Google Translate),
 	# encoded in UTF-8, used as a commit log message below.
-	msg=$(printf "initial. anf\303\244nglich")
+	msg="initial. an${sample_utf8_part}lich"
 	if test -n "$1"
 	then
-		msg=$(echo $msg | iconv -f utf-8 -t $1)
-	fi
-	if test -n "$2" -a -n "$3"
-	then
-		# cut string, replace cut part with two dots
-		# $2 - chars count from the beginning of the string
-		# $3 - "trailing" chars
-		# LC_ALL is set to make `sed` interpret "." as a UTF-8 char not a byte
-		# as it does with C locale
-		msg=$(echo $msg | LC_ALL=en_US.UTF-8 sed -e "s/^\(.\{$2\}\)$3/\1../")
+		print $msg | iconv -f utf-8 -t "$1"
+	else
+		print $msg
 	fi
-	echo $msg
 }
 
 test_expect_success 'set up basic repos' '
@@ -193,7 +187,7 @@ test_expect_success 'left alignment formatting with trunc' '
 message ..
 message ..
 add bar  Z
-$(commit_msg "" "8" "..*$")
+initial...
 EOF
 	test_cmp expected actual
 '
@@ -206,7 +200,7 @@ test_expect_success 'left alignment formatting with ltrunc' '
 ..sage two
 ..sage one
 add bar  Z
-$(commit_msg "" "0" ".\{11\}")
+..${sample_utf8_part}lich
 EOF
 	test_cmp expected actual
 '
@@ -219,7 +213,7 @@ test_expect_success 'left alignment formatting with mtrunc' '
 mess.. two
 mess.. one
 add bar  Z
-$(commit_msg "" "4" ".\{11\}")
+init..lich
 EOF
 	test_cmp expected actual
 '
@@ -311,7 +305,7 @@ test_expect_success 'left/right alignment formatting with stealing' '
 short long  long long
 message ..   A U Thor
 add bar      A U Thor
-$(commit_msg "" "8" "..*$")   A U Thor
+initial...   A U Thor
 EOF
 	test_cmp expected actual
 '
-- 
1.8.3.2.16.gb1f0d63

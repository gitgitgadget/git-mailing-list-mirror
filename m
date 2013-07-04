From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v9 5/5] t4205: avoid using `sed`
Date: Thu,  4 Jul 2013 16:45:50 +0400
Message-ID: <3c39c11346a5233c910ef15c2484915cdedde753.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372939482.git.Alex.Crezoff@gmail.com>
Cc: John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 14:46:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uuivd-0001SI-IR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 14:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977Ab3GDMqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 08:46:10 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34443 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964901Ab3GDMqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 08:46:05 -0400
Received: by mail-lb0-f173.google.com with SMTP id v1so1194198lbd.4
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=BMZ44qkhH8VpyLQsOi2WY9R60MdPfLll62CStcdxo2A=;
        b=abZ5x6Acmb4umbZcDluQNhZthheKCj6aFE7+tizlknDn/n3E/igRiRFZnWzKzewTl8
         so8654J6MBaF10QR+zhz6EZoFVJu3mbSpE02LIYJKPAbIHpDrbBOF3nzcugdTh3WlK1I
         V8/TLDl2inXMyEBdElyCdQuG9UtOd3WyPMXDzJLY+eK5bjo9t0wYvQDVUGGelyEZg0Dp
         Q3WGTcoLC/T02wAmEQA5kJN7DfNuE3Mqe7x2v/ylbnc9yzI3nL1IFDD3VrLEXrUjOUv4
         bYP+9u944/lcd7vwUd+UtAfc4HG5QNE1ey9rsq0hO3GLKCD7TGOfzToZw+KIbRrJf1Gx
         p26Q==
X-Received: by 10.112.157.137 with SMTP id wm9mr3494584lbb.14.1372941963430;
        Thu, 04 Jul 2013 05:46:03 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id b8sm1092704lah.0.2013.07.04.05.46.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jul 2013 05:46:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.15.g5c23c1e
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1372939482.git.Alex.Crezoff@gmail.com>
References: <cover.1372719264.git.Alex.Crezoff@gmail.com> <cover.1372939482.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229578>

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
index bb87f02..8504b13 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -7,25 +7,19 @@
 test_description='Test pretty formats'
 . ./test-lib.sh
 
+sample_utf8_part=$(printf "f\303\244ng")
+
 commit_msg() {
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
+		echo $msg | iconv -f utf-8 -t $1
+	else
+		echo $msg
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
1.8.3.1.15.g5c23c1e

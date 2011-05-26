From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] git-grep: Fix problems with recently added tests
Date: Fri, 27 May 2011 00:43:59 +0200
Message-ID: <1306449839-7491-1-git-send-email-michal.kiedrowicz@gmail.com>
References: <7vvcwxunbt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 00:44:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPjI6-0007me-4h
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758610Ab1EZWoZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2011 18:44:25 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41112 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758210Ab1EZWoY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:44:24 -0400
Received: by wya21 with SMTP id 21so861940wya.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=tNWIcGf+RGDEJAa2kE50Zq+vZG+c/1tftZmev9VioNk=;
        b=vOTMaM4HIOgYGkJn1dsl+FKAKx9CtP/RURZ+suWsYdy3SxkreaXcU2mLIWvh/+kGa5
         NE5+mL8hBuAIoT/k7VOcpJZf6RLUdzVeywEEmFY+NBVzTVDe1wq/qjVj71ok9zrp14ok
         0oVok0grjrKCecsUohqnwssOVCUMQn0VvkIkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Ulfj0pArozHp/XI3v7oLjV2zrvOFvSoT8mbHo8gV0euQHPEtxB1dO2GrTtHb2HVAWJ
         hVOrpB1pWBrA+EqjOd7MIQnpWwzlpSofKcrFlEobxi8gcNua1xidEhHHMx/4KmI+26JA
         qjQaK7DLMKgXtp2WPxgO78chl3hKoD7rVsEQ4=
Received: by 10.227.91.81 with SMTP id l17mr1417879wbm.29.1306449863008;
        Thu, 26 May 2011 15:44:23 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id ex2sm785505wbb.48.2011.05.26.15.44.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 May 2011 15:44:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <7vvcwxunbt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174589>

Brian Gernhardt reported that test 'git grep -E -F -G a\\+b' fails on
OS X 10.6.7. This is because I assumed \+ is part of BRE, which isn't
true on all platforms.

The easiest way to make this test pass is to just update expected
output, but that would make the test pointless. Its real purpose is to
check whether 'git grep -E -F -G' is different from 'git grep -E -G -F'=
=2E
To check that, let's change pattern to "a+b*c". This should return
different match for -G, -F and -E.

I also made two small tweaks to the tests. First, I added path "ab" to
all calls to future-proof tests. Second, I updated last two tests to
better show that 'git grep -P -E' is different from 'git grep -E -P'.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 t/t7810-grep.sh |   56 ++++++++++++++++++++++++-----------------------=
-------
 1 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index e061108..e1d8c40 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -33,9 +33,9 @@ test_expect_success setup '
 		echo HeLLo_world
 	} >hello_world &&
 	{
-		echo aab
-		echo a+b
-		echo a\\+b
+		echo "a+b*c"
+		echo "a+bc"
+		echo "abc"
 	} >ab &&
 	echo vvv >v &&
 	echo ww w >w &&
@@ -233,14 +233,14 @@ do
 		test_cmp expected actual
 	'
 	test_expect_success "grep $L with grep.extendedRegexp=3Dfalse" '
-		echo "ab:a+b" >expected &&
-		git -c grep.extendedRegexp=3Dfalse grep "a+b" >actual &&
+		echo "ab:a+bc" >expected &&
+		git -c grep.extendedRegexp=3Dfalse grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'
=20
 	test_expect_success "grep $L with grep.extendedRegexp=3Dtrue" '
-		echo "ab:aab" >expected &&
-		git -c grep.extendedRegexp=3Dtrue grep "a+b" >actual &&
+		echo "ab:abc" >expected &&
+		git -c grep.extendedRegexp=3Dtrue grep "a+b*c" ab >actual &&
 		test_cmp expected actual
 	'
 done
@@ -650,10 +650,10 @@ test_expect_success LIBPCRE 'grep -P pattern with=
 grep.extendedRegexp=3Dtrue' '
=20
 test_expect_success LIBPCRE 'grep -P -v pattern' '
 	{
-		echo ab:a+b
-		echo ab:a\\+b
+		echo "ab:a+b*c"
+		echo "ab:a+bc"
 	} >expected &&
-	git grep -P -v "aab" ab >actual &&
+	git grep -P -v "abc" ab >actual &&
 	test_cmp expected actual
 '
=20
@@ -686,39 +686,33 @@ test_expect_success LIBPCRE 'grep -P invalidpatte=
rn properly dies ' '
 	test_must_fail git grep -P "a["
 '
=20
-test_expect_success 'grep -F -E -G pattern' '
-	echo ab:a+b >expected &&
-	git grep -F -E -G a+b >actual &&
-	test_cmp expected actual
-'
-
-test_expect_success 'grep -F -G -E pattern' '
-	echo ab:aab >expected &&
-	git grep -F -G -E a+b >actual &&
+test_expect_success 'grep -G -E -F pattern' '
+	echo "ab:a+b*c" >expected &&
+	git grep -G -E -F "a+b*c" ab >actual &&
 	test_cmp expected actual
 '
=20
 test_expect_success 'grep -E -F -G pattern' '
-	echo ab:aab >expected &&
-	git grep -E -F -G a\\+b >actual &&
+	echo "ab:a+bc" >expected &&
+	git grep -E -F -G "a+b*c" ab >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'grep -E -G -F pattern' '
-	echo ab:a\\+b >expected &&
-	git grep -E -G -F a\\+b >actual &&
+test_expect_success 'grep -F -G -E pattern' '
+	echo "ab:abc" >expected &&
+	git grep -F -G -E "a+b*c" ab >actual &&
 	test_cmp expected actual
 '
=20
-test_expect_success 'grep -G -F -E pattern' '
-	echo ab:a+b >expected &&
-	git grep -G -F -E a\\+b >actual &&
-	test_cmp expected actual
+test_expect_success 'grep -G -F -P -E pattern' '
+	:>empty &&
+	test_must_fail git grep -G -F -P -E "a\x{2b}b\x{2a}c" ab >actual &&
+	test_cmp empty actual
 '
=20
-test_expect_success LIBPCRE 'grep -E -G -F -P pattern' '
-	echo ab:a+b >expected &&
-	git grep -E -G -F -P a\\+b >actual &&
+test_expect_success LIBPCRE 'grep -G -F -E -P pattern' '
+	echo "ab:a+b*c" >expected &&
+	git grep -G -F -E -P "a\x{2b}b\x{2a}c" ab >actual &&
 	test_cmp expected actual
 '
=20
--=20
1.7.3.4

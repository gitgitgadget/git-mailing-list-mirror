From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] git-grep: Update tests (mainly for -P)
Date: Sun, 22 May 2011 13:37:28 +0200
Message-ID: <1306064248-23092-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 13:37:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QO6ym-0008Pp-5i
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 13:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671Ab1EVLhr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2011 07:37:47 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51188 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab1EVLhq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 07:37:46 -0400
Received: by wya21 with SMTP id 21so3612932wya.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 04:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=D+GRZUHYS1gLeNiRSs12/9+oGhudPOVa2xszuUYogUs=;
        b=Ck8s6DYtK+d2UXI14Br278AcwTJohHU/AdnVCr02LW8HYDYJPacIsJAckGs5A1PtYz
         WRe/h0l/OIez3HULZCDH22e9Uvfvk0GZatbm+wb8Svk4TAjEnZUO4BwN3gS2Mw9XB5F7
         M+eUGp1dCBBPBPJrlhQVh1VK4k2axAtA7DtDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=O6rgYUXDU4Rc3udBMBUbYgSdPHkR+Un0+QbySM6FFQ4orbp1spPYBd0GAqZCkR4rXB
         JroiGDb4mq+KETpgExhUiov2QKRKbJ0FCOPD0QvT82H2FrfutRuW3JetRa7mTOr4upSj
         3dG3/LW8uToKW9nLxEEHXu5th9210wj8dtl78=
Received: by 10.216.68.18 with SMTP id k18mr1235545wed.109.1306064265133;
        Sun, 22 May 2011 04:37:45 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id o1sm2718449wej.32.2011.05.22.04.37.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 May 2011 04:37:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174189>

This patch adds few more tests to git-grep concerning the
-P/--perl-regexp option.

While at it, add some generic tests for grep.extendedRegexp config
option, for detecting invalid regexep and check if "last one wins" rule
works for selecting regexp type.

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
This is the promised update to tests and is meant to be applied on top =
of
mk/grep-pcre.

 t/t7810-grep.sh |   85 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index e845218..e061108 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -32,6 +32,11 @@ test_expect_success setup '
 		echo Hello_world
 		echo HeLLo_world
 	} >hello_world &&
+	{
+		echo aab
+		echo a+b
+		echo a\\+b
+	} >ab &&
 	echo vvv >v &&
 	echo ww w >w &&
 	echo x x xx x >x &&
@@ -227,7 +232,17 @@ do
 		git grep --max-depth 0 -n -e vvv $H -- t . >actual &&
 		test_cmp expected actual
 	'
+	test_expect_success "grep $L with grep.extendedRegexp=3Dfalse" '
+		echo "ab:a+b" >expected &&
+		git -c grep.extendedRegexp=3Dfalse grep "a+b" >actual &&
+		test_cmp expected actual
+	'
=20
+	test_expect_success "grep $L with grep.extendedRegexp=3Dtrue" '
+		echo "ab:aab" >expected &&
+		git -c grep.extendedRegexp=3Dtrue grep "a+b" >actual &&
+		test_cmp expected actual
+	'
 done
=20
 cat >expected <<EOF
@@ -620,6 +635,28 @@ test_expect_success LIBPCRE 'grep -P pattern' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'grep pattern with grep.extendedRegexp=3Dtrue' '
+	:>empty &&
+	test_must_fail git -c grep.extendedregexp=3Dtrue \
+		grep "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success LIBPCRE 'grep -P pattern with grep.extendedRegexp=3D=
true' '
+	git -c grep.extendedregexp=3Dtrue \
+		grep -P "\p{Ps}.*?\p{Pe}" hello.c >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -P -v pattern' '
+	{
+		echo ab:a+b
+		echo ab:a\\+b
+	} >expected &&
+	git grep -P -v "aab" ab >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success LIBPCRE 'grep -P -i pattern' '
 	{
 		echo "hello.c:	printf(\"Hello world.\n\");"
@@ -637,4 +674,52 @@ test_expect_success LIBPCRE 'grep -P -w pattern' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'grep -G invalidpattern properly dies ' '
+	test_must_fail git grep -G "a["
+'
+
+test_expect_success 'grep -E invalidpattern properly dies ' '
+	test_must_fail git grep -E "a["
+'
+
+test_expect_success LIBPCRE 'grep -P invalidpattern properly dies ' '
+	test_must_fail git grep -P "a["
+'
+
+test_expect_success 'grep -F -E -G pattern' '
+	echo ab:a+b >expected &&
+	git grep -F -E -G a+b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -F -G -E pattern' '
+	echo ab:aab >expected &&
+	git grep -F -G -E a+b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -E -F -G pattern' '
+	echo ab:aab >expected &&
+	git grep -E -F -G a\\+b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -E -G -F pattern' '
+	echo ab:a\\+b >expected &&
+	git grep -E -G -F a\\+b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'grep -G -F -E pattern' '
+	echo ab:a+b >expected &&
+	git grep -G -F -E a\\+b >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success LIBPCRE 'grep -E -G -F -P pattern' '
+	echo ab:a+b >expected &&
+	git grep -E -G -F -P a\\+b >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.3.4

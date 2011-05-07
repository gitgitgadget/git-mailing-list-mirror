From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t3703: add test cases for pathspec magic
Date: Sat,  7 May 2011 17:35:07 +0700
Message-ID: <1304764507-27547-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 07 12:38:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIeto-0005ej-NO
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 12:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222Ab1EGKiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 06:38:08 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:52105 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab1EGKiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 06:38:06 -0400
Received: by pvg12 with SMTP id 12so1758235pvg.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=cOvJ7cGdCUn57GQR8ZM8IZA+OXMrZkD3Fn59H/0glNg=;
        b=OIoW9e0EwzJY7PjADGFSbTcXCoIyoz4zY/pazRTuGEfaC7ttVmROPxktAmo5FFhGi5
         QEnCkg37/ef5jvfzeGuD+Vbe2H0Zfh79vyPu7wOKL63OniDbIn1UTTNf56dXsipje/Yc
         FcZAQZRHxhBiEsydAwDoDFBWnxuPcA4Y0mDXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=FrjfuFSxTHpiicygZuDmoP5Hudy8dOPxdq2cp2l5o/M4rQOcMDQgmVDbG0AzxJ+ihG
         UGoxem6UvIK73K3zAGm4PrCg8vQ2iizCeyobv0IGXR9uTsFtSvpiI4CLLffq+x0GMq25
         XrxEYEFiew+CyWJjjoyMbMGOvJHuqX1fH0O90=
Received: by 10.68.38.100 with SMTP id f4mr927642pbk.126.1304764686094;
        Sat, 07 May 2011 03:38:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.248.91])
        by mx.google.com with ESMTPS id f1sm2754150pbn.22.2011.05.07.03.38.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 03:38:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 07 May 2011 17:35:08 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173046>

That was the intention, but it raises a question: what do we do if a
file happens to have the same name with the given magic pathspec, as
in the last two tests? People can fall into these cases with
"git add *" or something like that.

I'm tempted to reuse "--" the second time to say "no more magic from
here". But there may be better way to deal with it.

Also, long magic must be quoted or at least bash will complain. Is
there any other syntax option that can be used directly without quoting?
---
 t/t3703-add-magic-pathspec.sh |   68 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100755 t/t3703-add-magic-pathspec.sh

diff --git a/t/t3703-add-magic-pathspec.sh b/t/t3703-add-magic-pathspec.sh
new file mode 100755
index 0000000..76108ae
--- /dev/null
+++ b/t/t3703-add-magic-pathspec.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description='magic pathspec tests using git-add'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir sub anothersub &&
+	: >sub/foo &&
+	: >anothersub/foo
+'
+
+test_expect_success 'colon alone magic can only used alone' '
+	test_must_fail git add -n sub/foo : &&
+	test_must_fail git add -n : sub/foo
+'
+
+cat >expected <<EOF
+add 'anothersub/foo'
+add 'expected'
+add 'sub/actual'
+add 'sub/foo'
+EOF
+
+test_expect_success 'add :' '
+	(cd sub && git add -n : >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'add :/' '
+	(cd sub && git add -n :/ >actual) &&
+	test_cmp expected sub/actual
+'
+
+cat >expected <<EOF
+add 'anothersub/foo'
+EOF
+
+test_expect_success 'add :/anothersub' '
+	(cd sub && git add -n :/anothersub >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'add :/non-existent' '
+	(cd sub && test_must_fail git add -n :/non-existent)
+'
+
+cat >expected <<EOF
+add 'sub/foo'
+EOF
+
+test_expect_success 'add :(icase)foo' '
+	(cd sub && git add -n ":(icase)FoO" >actual) &&
+	test_cmp expected sub/actual
+'
+
+test_expect_success 'a file with the same (long) magic name exists' '
+	: >":(case)ha" &&
+	git add -n ":(icase)ha"
+'
+
+test_expect_success 'a file with the same (short) magic name exists' '
+	mkdir ":" &&
+	: >":/bar" &&
+	git add -n :/bar
+'
+
+test_done
-- 
1.7.4.74.g639db

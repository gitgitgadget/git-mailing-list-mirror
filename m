From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] blame: Add tests for -L/start/,/end/
Date: Fri, 16 Jul 2010 15:35:07 +0000
Message-ID: <1279294507-9238-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 16 17:35:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZmwq-00038W-Dm
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 17:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965862Ab0GPPfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 11:35:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53708 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965820Ab0GPPfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 11:35:18 -0400
Received: by eya25 with SMTP id 25so539940eya.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 08:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=WD1cDpk2C9nli0SAdjmmY6wfhsXnXuKRKZjCQ49R/fw=;
        b=I2VtYkpgD1vhHT/vMaYyJUdpCDQvPcvnlPeapKzCHCHh3p9FebrhiG3mRuiAN9BNCL
         vH5qKwtgix7EK5+/2nGYFVQs5G+917kKYv+BP27GvZ1jbypjLXlOPFKLiAzhY26ZqksZ
         9LHCDRmkBeLR00OR5HaMe4YPAev4El8T89DyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=QepDDbHa9Rge+JVO+Luza5bZF6TN8Xssov4kgISb8MorW9g8GiSZS5t1qLtXeOgW1O
         oKfWw24OgnQEINrFndATpB5lrMO69lyWpjmgd3H2hibIm+SD0uyP5QXsT0LihgpIKX7K
         dO7St1+0u3TkjtxxLmQuwn/2dlS50Ya/C9OsU=
Received: by 10.213.28.194 with SMTP id n2mr4444603ebc.10.1279294517109;
        Fri, 16 Jul 2010 08:35:17 -0700 (PDT)
Received: from localhost.localdomain (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v8sm19028412eeh.2.2010.07.16.08.35.15
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 16 Jul 2010 08:35:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151155>

git-pickaxe (later git-blame) gained support for the -L/start/,/end/
form in 2006 (931233bc66 by Junio C Hamano), but nothing was added to
test this functionality. Change that by adding more -L tests to
t8003-blame.sh.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t8003-blame.sh |   53 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 230143c..2a3e169 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -175,6 +175,59 @@ test_expect_success 'blame -L with invalid end' '
 	grep "has only 2 lines" errors
 '
=20
+for comma in '' ','
+do
+	# The comma in -L/regex/, is optional
+	test_expect_success "blame -L/start/$comma" "
+		git blame -L'/[E]F/$comma' cow >current 2>errors &&
+		! test -s errors &&
+		head -n 1 current | grep DEF &&
+		tail -n 1 current | grep GHIJK
+	"
+done
+
+test_expect_success 'blame -L/start/,/end/' '
+	git blame -L"/[E]F/,/^X/" cow >current 2>errors &&
+	! test -s errors &&
+	head -n 1 current | grep DEF &&
+	tail -n 1 current | grep XXXX
+'
+
+test_expect_success 'blame -L/start/,INT' '
+	git blame -L"/[C]/,2" cow >current 2>errors &&
+	! test -s errors &&
+	head -n 1 current | grep ABC &&
+	tail -n 1 current | grep DEF
+'
+
+test_expect_success 'blame -LINT,/end/' '
+	git blame -L3,/GH/ cow  >current 2>errors &&
+	! test -s errors &&
+	head -n 1 current | grep XXXX &&
+	tail -n 1 current | grep GHIJK
+'
+
+test_expect_success 'blame -L,/end/' '
+	git blame -L",/^X/" cow >current 2>errors &&
+	! test -s errors &&
+	head -n 1 current | grep ABC &&
+	tail -n 1 current | grep XXXX
+'
+
+test_expect_success 'blame -L/no match/' '
+	! git blame -L/hlagh/ cow >current 2>errors &&
+	grep hlagh errors &&
+	! test -s current
+'
+
+test_expect_success 'blame -L/invalid regex/' '
+	# At least GNU, Solaris and FreeBSD (and by extension, Mac OS X)
+	# complain about this
+	! git blame -L/[b-a]/ cow >current 2>errors &&
+	grep b-a errors &&
+	! test -s current
+'
+
 test_expect_success 'indent of line numbers, nine lines' '
 	git blame nine_lines >actual &&
 	test $(grep -c "  " actual) =3D 0
--=20
1.7.0.4

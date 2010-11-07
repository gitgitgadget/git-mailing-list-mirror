From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] dir.c: fix EXC_FLAG_MUSTBEDIR match in sparse checkout
Date: Mon,  8 Nov 2010 01:04:58 +0700
Message-ID: <1289153098-15684-1-git-send-email-pclouds@gmail.com>
References: <loom.20101107T172926-284@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	thomasr@sailguy.org
X-From: git-owner@vger.kernel.org Sun Nov 07 19:06:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF9d9-0004hN-C3
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 19:06:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917Ab0KGSGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 13:06:08 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48296 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab0KGSGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 13:06:07 -0500
Received: by pvb32 with SMTP id 32so1100256pvb.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DEmnKSeNwmbCQDbRTYdYTkCJtia02QPWzT8VIqwQ3pE=;
        b=qjsf3BuYyLYWUTZxDo8n62+JlBCXXUm0HLUT/qILfA5NIwtgdJ1355Gn4aPnLUqGXm
         nGM91ZTTuJI/ewYEAKv9yNxKyPVIE2xUpkn9oT5vlRr+JszB6H8ht5Fb+EX2HNO/BmaB
         zS5Dwk1DI+J70dzJsQ4dntlsqRTEa7LNAmmm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GaTe8rzSFUDFwaokCSRTXyexeWic0gAes5G5wss7h8TvN8J86ree4/Wsbw5fRUvDgZ
         xwn/9bV5AxgKV9WJL5yOU6XlfLx5YXq35Bto2Dfit1ZeAoob9W/SokrjkN060wSr+o97
         31kxSHJd7sApNgPLG57kUAZbQe+vGBArn+Rnc=
Received: by 10.142.237.4 with SMTP id k4mr3953438wfh.171.1289153167081;
        Sun, 07 Nov 2010 10:06:07 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.233.195])
        by mx.google.com with ESMTPS id p8sm6536923wff.4.2010.11.07.10.06.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 10:06:06 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 08 Nov 2010 01:05:00 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <loom.20101107T172926-284@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160892>

Commit c84de70 (excluded_1(): support exclude files in index -
2009-08-20) tries to work around the fact that there is no
directory/file information in index entries, therefore
EXC_FLAG_MUSTBEDIR match would fail.

Unfortunately the workaround is flawed. This fixes it.

Reported-by: Thomas Rinderknecht <thomasr@sailguy.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c                                |    3 ++-
 t/t1011-read-tree-sparse-checkout.sh |   10 +++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index d1e5e5e..b2dfb69 100644
--- a/dir.c
+++ b/dir.c
@@ -360,7 +360,8 @@ int excluded_from_list(const char *pathname,
=20
 			if (x->flags & EXC_FLAG_MUSTBEDIR) {
 				if (!dtype) {
-					if (!prefixcmp(pathname, exclude))
+					if (!prefixcmp(pathname, exclude) &&
+					    pathname[x->patternlen] =3D=3D '/')
 						return to_exclude;
 					else
 						continue;
diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-s=
parse-checkout.sh
index 9a07de1..8008fa2 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -17,17 +17,19 @@ test_expect_success 'setup' '
 	cat >expected <<-\EOF &&
 	100644 77f0ba1734ed79d12881f81b36ee134de6a3327b 0	init.t
 	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	sub/added
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	subsub/added
 	EOF
 	cat >expected.swt <<-\EOF &&
 	H init.t
 	H sub/added
+	H subsub/added
 	EOF
=20
 	test_commit init &&
 	echo modified >>init.t &&
-	mkdir sub &&
-	touch sub/added &&
-	git add init.t sub/added &&
+	mkdir sub subsub &&
+	touch sub/added subsub/added &&
+	git add init.t sub/added subsub/added &&
 	git commit -m "modified and added" &&
 	git tag top &&
 	git rm sub/added &&
@@ -81,6 +83,7 @@ test_expect_success 'match directories with trailing =
slash' '
 	cat >expected.swt-noinit <<-\EOF &&
 	S init.t
 	H sub/added
+	S subsub/added
 	EOF
=20
 	echo sub/ > .git/info/sparse-checkout &&
@@ -105,6 +108,7 @@ test_expect_success 'checkout area changes' '
 	cat >expected.swt-nosub <<-\EOF &&
 	H init.t
 	S sub/added
+	S subsub/added
 	EOF
=20
 	echo init.t >.git/info/sparse-checkout &&
--=20
1.7.3.2.210.g045198

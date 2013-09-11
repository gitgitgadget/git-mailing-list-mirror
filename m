From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/21] t1050, t5500: replace the use of "show-index|wc -l" with verify-pack
Date: Wed, 11 Sep 2013 13:06:22 +0700
Message-ID: <1378879582-15372-22-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdcS-00085T-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab3IKGJg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:09:36 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36415 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861Ab3IKGJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:09:35 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so8722223pdj.35
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=H/yhF7whrk3zgqIjpm7zo8Qz+2Z5RHFqrLLWU6aZEQ4=;
        b=YMSTFK6b7iNfAPwtUkmcI6L5NxxTyVQZN7vzTiwXofqzaeIsRgTkahvPiLceMHFazM
         8FQS+kZc8Idv2FVcrctiVuDjowefuplWPxdok6QTzInx1b9PSU/XcqA6FBorQ6R0D6Hd
         xw7WP6n+zv4toIGx2dlao6H4ADR+nZnsBCJ4741KvE+5y2QkqGXM2YJlZEhMCyxFu6yN
         b1qgmHIYUKoyskWt25ZH/HbXEcONHFsrI1TunHkDxXcKR4LzYu/4E+jcs+FtINpwhu/p
         aXwUAax6/eqkXVr5+nVFoqASnkuOmrlU/QmYAMmfMxOQzX7+nfRvga61dPdAnq69nub+
         AURQ==
X-Received: by 10.68.217.196 with SMTP id pa4mr18996265pbc.117.1378879775228;
        Tue, 10 Sep 2013 23:09:35 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ye1sm1082647pab.19.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:09:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:09:28 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234545>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1050-large.sh      | 9 +++++----
 t/t5500-fetch-pack.sh | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index fd10528..829030b 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -32,7 +32,7 @@ test_expect_success 'add a large file or two' '
 	done &&
 	test -z "$bad" &&
 	test $count =3D 1 &&
-	cnt=3D$(git show-index <"$idx" | wc -l) &&
+	cnt=3D$(git verify-pack -v "${idx/idx/pack}" | grep "^[0-9a-f]\{40\}"=
 | wc -l) &&
 	test $cnt =3D 2 &&
 	for l in .git/objects/??/??????????????????????????????????????
 	do
@@ -93,11 +93,12 @@ test_expect_success 'packsize limit' '
 		) |
 		sort >expect &&
=20
-		for pi in .git/objects/pack/pack-*.idx
+		for pi in .git/objects/pack/pack-*.pack
 		do
-			git show-index <"$pi"
+			git verify-pack -v "$pi"
 		done |
-		sed -e "s/^[0-9]* \([0-9a-f]*\) .*/\1/" |
+		grep "^[0-9a-f]\{40\}" |
+		sed -e "s/^\([0-9a-f]\{40\}\) .*/\1/" |
 		sort >actual &&
=20
 		test_cmp expect actual
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index fd2598e..f99cd14 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -60,8 +60,8 @@ pull_to_client () {
 			git unpack-objects <$p &&
 			git fsck --full &&
=20
-			idx=3D`echo pack-*.idx` &&
-			pack_count=3D`git show-index <$idx | wc -l` &&
+			pack=3D`echo pack-*.pack` &&
+			pack_count=3D`git verify-pack -v $pack | grep "^[0-9a-f]\{40\}" | w=
c -l` &&
 			test $pack_count =3D $count &&
 			rm -f pack-*
 		)
--=20
1.8.2.82.gc24b958

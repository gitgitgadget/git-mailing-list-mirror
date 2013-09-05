From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] add--interactive: fix external command invocation on Windows
Date: Thu,  5 Sep 2013 10:40:40 +0700
Message-ID: <1378352440-25410-3-git-send-email-pclouds@gmail.com>
References: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 05:37:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHQOG-0007hC-73
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 05:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181Ab3IEDhs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Sep 2013 23:37:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:45903 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab3IEDhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 23:37:47 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1323799pab.29
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 20:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SU5Es7LwIRrm80/l7d71S2CwTI2/MFHYdP7KQI6rZeg=;
        b=pKIGZgMwMhggVITY5JLIJcCnAILabAt0Axua3Y212ke3fQnOrFraWk6YEBoGGkFg9H
         W8pqvkrI//0sc/nwlOOqU85vTG/XDSwZtgv0y+5WZsrfE9ycjIF+9yiI2vr/y6yZzYDh
         nHNV1dZcj4sHJ+6cj+D36z5lg4maUQuvTH77oc0KaWfKnsQZaXPYMqHLgwdJA1sgkGIi
         fSxciSQsDRYYpNAAemD/ADQ/+bcferKnZy1/AjsbYcTwokVXL3Re2UknzzEiJ0ijaTNZ
         nM+7qcuat6vF2vWHN1VD0YxWSkZazKv1k7DVnJAjGYWu1vjNjUgRKfhItIWuggVs3D4W
         X/AA==
X-Received: by 10.66.171.204 with SMTP id aw12mr6889113pac.7.1378352267159;
        Wed, 04 Sep 2013 20:37:47 -0700 (PDT)
Received: from lanh ([115.73.237.243])
        by mx.google.com with ESMTPSA id qp10sm34555015pab.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 04 Sep 2013 20:37:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Sep 2013 10:40:53 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378352440-25410-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233887>

=46rom: Johannes Sixt <j6t@kdbg.org>

Back in 21e9757e (Hack git-add--interactive to make it work with
ActiveState Perl, 2007-08-01), the invocation of external commands was
changed to use qx{} on Windows. The rationale was that the command
interpreter on Windows is not a POSIX shell, but rather Windows's CMD.
That patch was wrong to include 'msys' in the check whether to use qx{}
or not: 'msys' identifies MSYS perl as shipped with Git for Windows,
which does not need the special treatment; qx{} should be used only wit=
h
ActiveState perl, which is identified by 'MSWin32'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-add--interactive.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 75a991f..5156384 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -169,7 +169,7 @@ my %patch_modes =3D (
 my %patch_mode_flavour =3D %{$patch_modes{stage}};
=20
 sub run_cmd_pipe {
-	if ($^O eq 'MSWin32' || $^O eq 'msys') {
+	if ($^O eq 'MSWin32') {
 		my @invalid =3D grep {m/[":*]/} @_;
 		die "$^O does not support: @invalid\n" if @invalid;
 		my @args =3D map { m/ /o ? "\"$_\"": $_ } @_;
--=20
1.8.2.83.gc99314b

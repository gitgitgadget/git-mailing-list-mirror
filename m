From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 06/19] Avoid writing to buffer in add_excludes_from_file_1()
Date: Thu, 20 Aug 2009 20:47:00 +0700
Message-ID: <1250776033-12395-7-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81F-0007ZS-BL
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbZHTNry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbZHTNry
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:47:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbZHTNrx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:47:53 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3VzNXE7M3UBekqPE3GHDpEauMB1vtvF+OtcOKQHkNr8=;
        b=VYR+r0/XMId7NaFAI2ftykuFnmIL4IE6Ui4RJhyoqTrndy9esoQ91opR+xuVDYzncM
         IHyJApO5Q41SkT5e3QQ0Fs0JFg4YLQhfob9QrYlK2CG3Uwb64vXwAdhwdV2xijEshSnI
         5IKR10d1MzZz/4KYKIbR2jVsvbh5s8oIif8zg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=QwVU2PahKte6tYfZbkdM4pHSObWYW4+60pn2w+vHbfcpdIrPHWQUa2DADpKI/jncY9
         hGXOH9vuqkjaIgv2H6uwuKbxXJ4osIAzhg82rCHUG3mPnqq9UehIs92ZkUcwUQzYNsnJ
         yzsZuQ3NP0pya8d+0TlPCPlbURXKgcNshqEIk=
Received: by 10.140.131.5 with SMTP id e5mr4709035rvd.205.1250776075278;
        Thu, 20 Aug 2009 06:47:55 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id l31sm4779193rvb.24.2009.08.20.06.47.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:47:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:49 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126628>

In the next patch, the buffer that is being used within
add_excludes_from_file_1() comes from another function and does not
have extra space to put \n at the end.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index d0999ba..e9254d6 100644
--- a/dir.c
+++ b/dir.c
@@ -229,10 +229,9 @@ static int add_excludes_from_file_1(const char *fn=
ame,
=20
 	if (buf_p)
 		*buf_p =3D buf;
-	buf[size++] =3D '\n';
 	entry =3D buf;
-	for (i =3D 0; i < size; i++) {
-		if (buf[i] =3D=3D '\n') {
+	for (i =3D 0; i <=3D size; i++) {
+		if (i =3D=3D size || buf[i] =3D=3D '\n') {
 			if (entry !=3D buf + i && entry[0] !=3D '#') {
 				buf[i - (i && buf[i-1] =3D=3D '\r')] =3D 0;
 				add_exclude(entry, base, baselen, which);
--=20
1.6.3.GIT

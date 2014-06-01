From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 4/9] write_or_die.c: replace signal() with sigaction()
Date: Sun,  1 Jun 2014 11:10:13 -0700
Message-ID: <b2dc32a2f9f42b9be5cf7aba47170f204ce43d90.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrADm-0007OM-EN
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 20:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636AbaFASK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2014 14:10:58 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:57862 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbaFASK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 14:10:57 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so3435443pbc.23
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 11:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=qX54+Z2dy51sMbqYy478cyeHkJGQWxxzeIprhJ1KwHY=;
        b=aEGDYCce3PwxFTJGFaev7TYHTm9q9a8C0OgMa7Sui+fwb2SDFmYP/S5KcfEvXQ4lxK
         1aBTKkex29O7y7f5VTamCXLTzdlyi1/5jOCd1sW504csLesTjvMIpzwOcj+ONBnntdAp
         XhdkOZVhAa5uFPBeJe7My6iojCI8i7S58PH6Fesg9NTm6g7UbahPmJv0jH9ZN3rdTEex
         u3IfpleUyAN9pa7x+8Mfp+TOIFlXM/V6CSLVcFVhOcR0AGXTqjYcHXmfduXub6t610sC
         9rkkPKHm3Bd09yLFZLN8tBq1pDd/gF7k1D+u4NDLUAqxMU5FIVsomGBZssg+pnIsH/Qu
         +FlQ==
X-Received: by 10.66.65.169 with SMTP id y9mr34204753pas.145.1401646257468;
        Sun, 01 Jun 2014 11:10:57 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wi14sm20248055pac.22.2014.06.01.11.10.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Jun 2014 11:10:56 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 01 Jun 2014 11:10:52 -0700
X-Mailer: git-send-email 2.0.0.8.g7bf6e1f.dirty
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
In-Reply-To: <cover.1401645403.git.jmmahler@gmail.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250536>

=46rom the signal(2) man page:

  The behavior of signal() varies across UNIX versions, and has also va=
r=E2=80=90
  ied historically across different versions of Linux.   Avoid  its  us=
e:
  use sigaction(2) instead.

Replaced signal() with sigaction() in write_or_die.c

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 write_or_die.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/write_or_die.c b/write_or_die.c
index b50f99a..f5fdec8 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -2,8 +2,12 @@
=20
 static void check_pipe(int err)
 {
+	struct sigaction sa;
+
 	if (err =3D=3D EPIPE) {
-		signal(SIGPIPE, SIG_DFL);
+		memset(&sa, 0, sizeof(sa));
+		sa.sa_handler =3D SIG_DFL;
+		sigaction(SIGPIPE, &sa, NULL);
 		raise(SIGPIPE);
 		/* Should never happen, but just in case... */
 		exit(141);
--=20
2.0.0.8.g7bf6e1f.dirty

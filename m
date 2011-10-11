From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Recognize magic pathspec as filenames
Date: Wed, 12 Oct 2011 09:44:38 +1100
Message-ID: <1318373083-13840-2-git-send-email-pclouds@gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl4Q-0006m9-UA
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1JKWpD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:45:03 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52824 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab1JKWpC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:45:02 -0400
Received: by vws1 with SMTP id 1so89134vws.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CTgU0YiAlH5cl1cdpNGxVKRLE6l6UKA/myEVc6C4x8g=;
        b=BesCgAUrgarYyyP7NXez8fKYj/AKkpeySF2Zalqchi4MlluvDpjCuiwKr1PTNEhHut
         NzayvSn/Z+aA/CeiCXACYektU/1VbE0ZAEDjuwG+bCGcowA9xStdn2TcKIIsEc/pcZBj
         CuBDrz8WxdgWfQgVfbbzWuet99FyZwkZTFH5I=
Received: by 10.52.174.107 with SMTP id br11mr20751125vdc.12.1318373101085;
        Tue, 11 Oct 2011 15:45:01 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id be17sm166450vdc.15.2011.10.11.15.44.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:45:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:44:53 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183335>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .. so that "git log :/" works, not so sure this is correct though

 setup.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index 27c1d47..08f605b 100644
--- a/setup.c
+++ b/setup.c
@@ -58,15 +58,8 @@ static void NORETURN die_verify_filename(const char =
*prefix, const char *arg)
 	unsigned char sha1[20];
 	unsigned mode;
=20
-	/*
-	 * Saying "'(icase)foo' does not exist in the index" when the
-	 * user gave us ":(icase)foo" is just stupid.  A magic pathspec
-	 * begins with a colon and is followed by a non-alnum; do not
-	 * let get_sha1_with_mode_1(only_to_die=3D1) to even trigger.
-	 */
-	if (!(arg[0] =3D=3D ':' && !isalnum(arg[1])))
-		/* try a detailed diagnostic ... */
-		get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
+	/* try a detailed diagnostic ... */
+	get_sha1_with_mode_1(arg, sha1, &mode, 1, prefix);
=20
 	/* ... or fall back the most general message. */
 	die("ambiguous argument '%s': unknown revision or path not in the wor=
king tree.\n"
@@ -85,6 +78,11 @@ void verify_filename(const char *prefix, const char =
*arg)
 {
 	if (*arg =3D=3D '-')
 		die("bad flag '%s' used after filename", arg);
+
+	/* If it's magic pathspec, just assume it's file name */
+	if (arg[0] =3D=3D ':' && is_pathspec_magic(arg[1]))
+		return;
+
 	if (check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg);
--=20
1.7.3.1.256.g2539c.dirty

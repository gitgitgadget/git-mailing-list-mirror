From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 39/43] alias: keep repository found while collecting aliases as long as possible
Date: Mon,  5 Apr 2010 20:41:24 +0200
Message-ID: <1270492888-26589-40-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrI4-0003NW-KS
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756146Ab0DESoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:44:01 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab0DESoA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:44:00 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=OErU3mzcrdQSZ3uS2rGATX0yBIfwWRTLSZG79CYWWXs=;
        b=HxqbTqI1fxWZc4aJ+BTy68eUuN6VEAQsEH39go0CGqXxPjXPQrt1taV0Cc2pgItLh9
         kCt2G+k06y/oWGPIQ5b5zdluc7oR3m91jY5O1DEIT0231tsZZcPkZcnQOkMJmCVvJn5J
         ovYCv44TDJHNU9MTl8rzr9NAw1LbaOZlnfd08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kBmtpYvvIDkNrGa9Y7yns6hz8Jm9Mi8k0UP4lIokUUNmohDLh5XtdCYoQwSqNuVMaA
         NGGV0xnSWh4QwopsiwkzblR7CeBzf+yGltCXzm6vr0ulSbFRuEX8jEBfR7jMgm4OyHiF
         8DPfkawhg5tVD6kN9TW85hWIW3/KFrXnz4tIc=
Received: by 10.223.16.207 with SMTP id p15mr6019174faa.99.1270493039204;
        Mon, 05 Apr 2010 11:43:59 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 13sm2837908fks.30.2010.04.05.11.43.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:58 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:56 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144037>

Given that about 80% builtin commands will need to search for a
repository, we should keep the repository found in alias handling
code. Until we are clear there's no need for a repository, then we can
undo the setup with unset_git_directory().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 17482dd..d6513f1 100644
--- a/git.c
+++ b/git.c
@@ -152,7 +152,8 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 	char *alias_string;
 	int unused_nongit;
=20
-	setup_git_directory_gently(&unused_nongit);
+	if (!startup_info->have_repository)
+		setup_git_directory_gently(&unused_nongit);
=20
 	alias_command =3D (*argv)[0];
 	alias_string =3D alias_lookup(alias_command);
@@ -209,8 +210,6 @@ static int handle_alias(int *argcp, const char ***a=
rgv)
 		ret =3D 1;
 	}
=20
-	unset_git_directory(startup_info->prefix);
-
 	errno =3D saved_errno;
=20
 	return ret;
@@ -240,12 +239,18 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
=20
 	startup_info->help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!startup_info->help) {
-		if (p->option & RUN_SETUP)
+		if ((p->option & RUN_SETUP) && !startup_info->have_repository)
 			setup_git_directory();
-		if (p->option & RUN_SETUP_GENTLY) {
+		else if ((p->option & RUN_SETUP_GENTLY) && !startup_info->have_repos=
itory) {
 			int nongit_ok;
 			setup_git_directory_gently(&nongit_ok);
 		}
+		else if (startup_info->have_repository) {
+			if (p->option & (RUN_SETUP_GENTLY | RUN_SETUP))
+				; /* done already */
+			else
+				unset_git_directory(startup_info->prefix);
+		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
 			use_pager =3D check_pager_config(p->cmd);
--=20
1.7.0.rc1.541.g2da82.dirty

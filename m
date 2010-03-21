From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 18/19] alias: keep repository found while collecting aliases as long as possible
Date: Sun, 21 Mar 2010 17:30:45 +0700
Message-ID: <1269167446-7799-19-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIWE-0003rh-IE
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269Ab0CUKgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:36:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33481 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108Ab0CUKgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:36:18 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so510222gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xwR32CweJBkXzK4b+mpYUkkIJ9HPlIx5GDy1QYS+nXo=;
        b=J3eGDiecGBMqUOHCjlzRih7C94aRFw7uLaWWeeKM0bpUfEuZ2B+GWJ4j18QzPLt0ug
         lOkNA5pJD7YWKsvIjfs1NnfAoZCmUNmlTHI+9gf4YPmncRXMwTMU/rd7tkCypj/yqX5A
         5GImLPWQJ7uBadKvP3bmz2AlUFMoZu+tZti6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ow/c3G3JqQpc2Kh5xDlbCiUP9D3fpfkANK04sFCd/2GcOA18b6h5g0G7Piyap0Uzf9
         BcWda6Jo24O8nH4Qko7BYoTlrleYhk5364hHXKHm8LdnZfnO5bOkf+DeFPYJb2qMfBI2
         KakPSSULyjoQ821f2dElrOCRlIwHWT9g1K7gE=
Received: by 10.101.126.3 with SMTP id d3mr12835706ann.92.1269167778364;
        Sun, 21 Mar 2010 03:36:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 23sm3325636iwn.10.2010.03.21.03.36.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:36:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:32:38 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142813>

Given that about 80% builtin commands will need to search for a
repository, we should keep the repository found in alias handling
code. Until we are clear there's no need for a repository, then we can
undo the setup with unset_git_directory().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index db5bd95..88aaf13 100644
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
1.7.0.2.425.gb99f1

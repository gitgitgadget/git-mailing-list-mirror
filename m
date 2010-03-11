From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/16] alias: keep repository found while collecting aliases as long as possible
Date: Thu, 11 Mar 2010 20:22:33 +0700
Message-ID: <1268313754-28179-16-git-send-email-pclouds@gmail.com>
References: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 14:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpiNg-0001wN-0M
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 14:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754Ab0CKNYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 08:24:06 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48003 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0CKNYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 08:24:01 -0500
Received: by mail-pv0-f174.google.com with SMTP id 32so5769pvb.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=G5XhaDIUy05Ja53c1BrJux81A7ReOwvGiM3op7D3i7k=;
        b=eXv7i+uQBBT5PIO8TU9KB6YNqQm8VPnXmQud91IrktQdfXw8d/us4psmB5AnAT7hJK
         Cy3IpdBv1anI+F2kev3OAGGNVCDVT2EA2QOheWuwk2B6vaNi4RqJac6qvOWuLqxplqNa
         GVTJKTXZcnf2bm7k3YYwTVRc39NwGZd/fIR6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UIhKpOxdKw4z/5J0REEowpw6ZHE2sebdHlFDkTR/QMwPd7gmFM6mrwcpA7So5U/zu3
         Ao9wi376jG2pFMcTL/Y5vROpR091TndQmng3KV9ctDhnYVGnGDFoXqYmZ1ptDYcMGw1Z
         QTJas+j1dCb1h5Y2QGLiw6Joo+y6JskQ9tiWc=
Received: by 10.143.27.35 with SMTP id e35mr1340979wfj.283.1268313840777;
        Thu, 11 Mar 2010 05:24:00 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.130])
        by mx.google.com with ESMTPS id 23sm8863872pzk.14.2010.03.11.05.23.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Mar 2010 05:24:00 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 11 Mar 2010 20:23:56 +0700
X-Mailer: git-send-email 1.7.0.1.384.g6abcaa
In-Reply-To: <1268313754-28179-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141977>

In order to read aliases, $GIT_CONFIG/config must be read (if found).
Currently, after alias handling is done, we chdir() back to original
cwd, pretending no repository setup is done.

Given plain chdir() is not a proper way to undo
setup_git_directory_gently(), and 80% builtin commands will need to
search for a repository, we could keep the repository found in alias
handling code. Until we are clear, there's no need for a repository,
then we can undo the setup with unset_git_directory().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index 6a40304..aa6d029 100644
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
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
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
1.7.0.1.384.g6abcaa

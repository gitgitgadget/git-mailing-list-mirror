From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [WIP PATCH 07/26] Support running setup_git_dir_gently() from the beginning for builtin commands
Date: Tue, 16 Feb 2010 23:04:58 +0700
Message-ID: <1266336317-607-8-git-send-email-pclouds@gmail.com>
References: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 17:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhPz2-0007Hq-02
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684Ab0BPQIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 11:08:47 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:56134 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105Ab0BPQIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:08:45 -0500
Received: by mail-yx0-f200.google.com with SMTP id 38so4317189yxe.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 08:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ULranmOy6stWWQCinptESbnasj4Lz925+NzUatAvsIU=;
        b=McOM7lF12E+rJ3PFq7yBJBTVogYByP3kEOmeMCKuPdrzyoTuPo9wpHoVmYX5y+/DMj
         dRgMB7D43G4JLXjwp3MV85R8rqV1cdLA3ktXTQicGrE3zdaxNR3HYgnO9bD+aQSnq/jG
         1Yw+WuwzgwLbvuoUjWybTYA9+7n6BeQMmIzpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XgBUs71XhtNKuolYBQH+aYK8YjPjp5RrdcKEySz1rT1ka+F1nKQ3O0+V0Dq7twTC+3
         CgFGiRAMYhpfvhoDwB4h5/BFb6Y6i1mqurExe5A2OcjDMpwi1ZND9ETL5AWk0gx3FHyu
         HeZ2yXiZaXuo4M7T5VYQWUmRiC5SLzvEKdNZM=
Received: by 10.101.117.14 with SMTP id u14mr1452674anm.108.1266336525375;
        Tue, 16 Feb 2010 08:08:45 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.207.162])
        by mx.google.com with ESMTPS id 23sm2879641ywh.3.2010.02.16.08.08.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Feb 2010 08:08:44 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 16 Feb 2010 23:06:02 +0700
X-Mailer: git-send-email 1.7.0.195.g637a2
In-Reply-To: <1266336317-607-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140108>

Attempt to access gitdir is everywhere, even before cmd_*() is called.
The sooner we setup gitdir, the less trouble we may have to deal with.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index ea29cca..5391292 100644
--- a/git.c
+++ b/git.c
@@ -215,13 +215,14 @@ static int handle_alias(int *argcp, const char **=
*argv)
=20
 const char git_version_string[] =3D GIT_VERSION;
=20
-#define RUN_SETUP	(1<<0)
-#define USE_PAGER	(1<<1)
+#define RUN_SETUP		(1<<0)
+#define USE_PAGER		(1<<1)
 /*
  * require working tree to be present -- anything uses this needs
  * RUN_SETUP for reading from the configuration file.
  */
-#define NEED_WORK_TREE	(1<<2)
+#define NEED_WORK_TREE		(1<<2)
+#define RUN_SETUP_GENTLY	(1<<3)
=20
 struct cmd_struct {
 	const char *cmd;
@@ -236,12 +237,17 @@ static int run_builtin(struct cmd_struct *p, int =
argc, const char **argv)
=20
 	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
 	if (!help) {
+		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) =3D=3D (RUN_SETUP |=
 RUN_SETUP_GENTLY))
+			die("Internal error: RUN_SETUP and RUN_SETUP_GENTLY are mutually ex=
clusive");
+
 		/* handle_alias() may have set up gitdir for alias lookup */
 		if (startup_info->have_set_gitdir) {
 			if (p->option & RUN_SETUP) {
 				if (!startup_info->have_repository)
 					die("No repository found");
 			}
+			if (p->option & RUN_SETUP_GENTLY)
+				; /* all done */
 			else {
 				/* This is WRONG, but we can't get rid of it now */
 				startup_info->have_set_gitdir =3D 0;
@@ -252,6 +258,10 @@ static int run_builtin(struct cmd_struct *p, int a=
rgc, const char **argv)
 		else {
 			if (p->option & RUN_SETUP)
 				setup_git_directory();
+			if (p->option & RUN_SETUP_GENTLY) {
+				int nongit_ok;
+				setup_git_directory_gently(&nongit_ok);
+			}
 		}
=20
 		if (use_pager =3D=3D -1 && p->option & RUN_SETUP)
--=20
1.7.0.195.g637a2

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/19] run_builtin(): save "-h" detection result for later use
Date: Sun, 21 Mar 2010 17:30:41 +0700
Message-ID: <1269167446-7799-15-git-send-email-pclouds@gmail.com>
References: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:35:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIVi-0003fg-Sm
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243Ab0CUKfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 06:35:53 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:55586 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0CUKfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:35:52 -0400
Received: by mail-yw0-f172.google.com with SMTP id 2so1334601ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 03:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=R++uKfNBthMtXZCco+yqUf4i+JioAc4YrlSSQo8xy8o=;
        b=beXlFCC+biYw+kiBcUkIRFVFluy4RWAmISBmTpwlvVAAUyQmP+Chg90XaPmDMjfTj1
         uNZV7TCWwm6HNNSnZa0AEUbe1ns40E6nG/xaBrGyTy3cn9cFZEcaji+BL2vtdABx3Rbp
         HiBf8uSLKYPDaOUSDQX2NqfuLf9APGpG7kWWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=O94iUsc8yjfzkBNTEFyg1FaoYawYf12iCXmxknGSJ4SPSJgazrp8NWu0rSBTlBGdqp
         yF99wpuvuKZDrLBx6xcc98APynzzu2phecorJWcNUfdGRDk8xRPNWuwow4zeyBQL3WJm
         nIXdzTYfNIBkduSJ1uuibWn4Fuf9C1E1L3GMQ=
Received: by 10.150.208.12 with SMTP id f12mr5290009ybg.36.1269167752115;
        Sun, 21 Mar 2010 03:35:52 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.230.17])
        by mx.google.com with ESMTPS id 22sm1874234iwn.0.2010.03.21.03.35.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 03:35:51 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 21 Mar 2010 17:32:11 +0700
X-Mailer: git-send-email 1.7.0.2.425.gb99f1
In-Reply-To: <1269167446-7799-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142810>

When run_builtin() sees "-h" as the first argument, it assumes that:
 - it's the call for help usage
 - the real git command will only print help usage then exit

So it skips all setup in this case. Unfortunately some commands may do
more things before calling parse_options(), which is where help usage
is printed. Some of those things may touch repository, which has yet
to be set up.

Until now, the only safe thing that can be called before
parse_options() is git_config(). This function is aware of repository
findind status, and will skip reading $GIT_DIR/config if no repository
is found.

Make real commands aware of this fast path so that they can handle it
properly (i.e. print help usage then exist immediately) if they do
more initialization than git_config().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h |    1 +
 git.c   |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index dd27e11..e397e1d 100644
--- a/cache.h
+++ b/cache.h
@@ -1060,6 +1060,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
 struct startup_info {
 	const char *prefix;
 	int have_repository;
+	int help;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/git.c b/git.c
index 746470f..7e30498 100644
--- a/git.c
+++ b/git.c
@@ -237,13 +237,13 @@ struct cmd_struct {
=20
 static int run_builtin(struct cmd_struct *p, int argc, const char **ar=
gv)
 {
-	int status, help;
+	int status;
 	struct stat st;
=20
 	memset(&git_startup_info, 0, sizeof(git_startup_info));
 	startup_info =3D &git_startup_info;
-	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
-	if (!help) {
+	startup_info->help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
+	if (!startup_info->help) {
 		if (p->option & RUN_SETUP)
 			setup_git_directory();
 		if (p->option & RUN_SETUP_GENTLY) {
@@ -261,7 +261,7 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 	}
 	commit_pager_choice();
=20
-	if (!help && p->option & NEED_WORK_TREE)
+	if (!startup_info->help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
=20
 	trace_argv_printf(argv, "trace: built-in: git");
--=20
1.7.0.2.425.gb99f1

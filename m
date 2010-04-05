From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 35/43] run_builtin(): save "-h" detection result for later use
Date: Mon,  5 Apr 2010 20:41:20 +0200
Message-ID: <1270492888-26589-36-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrHB-0000ps-Tb
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab0DESns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:43:48 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:62876 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab0DESnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:43:45 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1250782fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=n+EDN/jPTW0hYoYttWzc8ySo04HLh322LynsCPaTeYw=;
        b=BlGW5cqoInQncFwQKh2j37vTtxShpBQ/kk9q46bR2r0y8JaGYdq9g9vmX7pPC90Lej
         5nNVt9FPXRNyGcYBRu5pqJVvUJDJhQTHplMzii3eO8rmq6mtpYGwZ/UyBrMPDYetcQ8b
         +oJfuN/8jk6T1WCLUldDnganUzlt/5Otwrbo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ejknJsHHlsiIbKhofDyixcWXzuXejCB0/eHlGqWs+6QsB48+DuoMSOfv6TEFHDWL6Y
         C71K5CQ5vQSt67PCaPq3nnxiQNsCi60wdQXoYZOhPjuln3wimwPTb48GInGgYeRN6ukd
         x4+lAmNlFRKZ3/qsvaon0HZlVpiKTYgRckEpo=
Received: by 10.223.75.15 with SMTP id w15mr6093633faj.70.1270493025068;
        Mon, 05 Apr 2010 11:43:45 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id 21sm27022413fks.53.2010.04.05.11.43.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:43:44 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:43:42 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144032>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h |    1 +
 git.c   |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 2980741..bdcd1ec 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,6 +1067,7 @@ int checkout_fast_forward(const unsigned char *fr=
om, const unsigned char *to);
 struct startup_info {
 	const char *prefix;
 	int have_repository;
+	int help;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/git.c b/git.c
index fac3d1c..d60f792 100644
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
1.7.0.rc1.541.g2da82.dirty

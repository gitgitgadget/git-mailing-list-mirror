From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] run_builtin(): save "-h" detection result for later use
Date: Tue, 19 Oct 2010 20:35:18 +0700
Message-ID: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 15:35:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8CM2-0000Tq-St
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 15:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758595Ab0JSNfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 09:35:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55600 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab0JSNff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 09:35:35 -0400
Received: by pzk3 with SMTP id 3so252126pzk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=YTr4lFrvHGidNkTwZDK7j5Z/Z0I1KyO+e/aGnV95Znw=;
        b=X2LRi13W0OZB+CpYu5m4fKeWvoTuJ9xJEzH8/ScwxSfDLxUqb1qibKLgPU0j4QBLU2
         9wtXzHze40uwAQR0FZJAp/n7F2+NTUL3GQc8tFXu6vRpnBf1rBoiMLwcUGo4HVZG1+zO
         EvlWGGIoK0/BzLS5aEiWIkG/hcj6Ajn4kW5nY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=amheJD8SHzsqnCghm/WdIKGjNNVJdEFJH/U2k84DSAp7wkkaj5n91sV6spwjhlCx1J
         3SsPGPln/bYq0MhntOfqsYJMP5IQm+qI9umDoLO0qTrUOcVTQL2NvfaCG14HvUg95vcf
         GzstUzMzM20wH6UcCpwFeYUId/W4D3ajHXVWg=
Received: by 10.142.224.8 with SMTP id w8mr4633864wfg.123.1287495334490;
        Tue, 19 Oct 2010 06:35:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id p8sm25151323wff.4.2010.10.19.06.35.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 06:35:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 19 Oct 2010 20:35:22 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159327>

When run_builtin() sees "-h" as the first argument, it assumes:

 - this is the call for help usage
 - the real git command will only print help usage then exit

So it skips all setup in this case.  Unfortunately, some commands do
other things before calling parse_options(), which is often where the
help usage is printed.  Some of those things may try to access the
repository, which has yet to be set up.

Make real commands aware of this fast path so that they can handle it
properly (i.e., print help usage then exit immediately) if they need
to do more initialization than git_config().

git_config() is a bit of a special case: it is perfectly legitimate to
use it without access to a valid repository. In the future, we should
make git_config() aware of the repository search status so that it can
skip reading $GIT_DIR/config if no repository is found.
---
 cache.h |    1 +
 git.c   |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..43763c1 100644
--- a/cache.h
+++ b/cache.h
@@ -1117,6 +1117,7 @@ const char *split_cmdline_strerror(int cmdline_errno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	int help; /* print help and exit, except git_config(), repo must not be touched */
 };
 extern struct startup_info *startup_info;
 
diff --git a/git.c b/git.c
index 50a1401..5962cdd 100644
--- a/git.c
+++ b/git.c
@@ -246,13 +246,13 @@ struct cmd_struct {
 
 static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 {
-	int status, help;
+	int status;
 	struct stat st;
 	const char *prefix;
 
 	prefix = NULL;
-	help = argc == 2 && !strcmp(argv[1], "-h");
-	if (!help) {
+	startup_info->help = argc == 2 && !strcmp(argv[1], "-h");
+	if (!startup_info->help) {
 		if (p->option & RUN_SETUP)
 			prefix = setup_git_directory();
 		if (p->option & RUN_SETUP_GENTLY) {
@@ -267,7 +267,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	}
 	commit_pager_choice();
 
-	if (!help && p->option & NEED_WORK_TREE)
+	if (!startup_info->help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
 
 	trace_argv_printf(argv, "trace: built-in: git");
-- 
1.7.0.2.445.gcbdb3

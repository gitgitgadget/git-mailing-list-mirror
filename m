From: Deskin Miller <deskinm@umich.edu>
Subject: [PATCH] git init: --bare/--shared overrides system/global config
Date: Sun, 5 Oct 2008 15:44:12 -0400
Message-ID: <20081005194412.GE3052@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 21:47:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZZk-0006jr-K7
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbYJETqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755946AbYJETqW
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:46:22 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:15484 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755819AbYJETqV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:46:21 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1111824wri.5
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent
         :sender;
        bh=/hDAaOop9rqDhbf3TMRvDELyyGZbPHUZyY5az+HoKBc=;
        b=cYxQXGxCSJZHlA1R8q1dIGQyA/PQVL3Lzs+Ba4/qlBnKJuFoNgekp1e2w4Qw6Fbrrp
         ELs5MmDLmVI6A/Q18X3zaPmlqy9rOkPuyLXys3moZpzIyokLOMT7cWRQIqfXYpJv23zh
         bkFFx1GP4MIW9SqY9PKelhHPFq/vmQxhsXtnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent:sender;
        b=yFUAB2YmzKHb9jgBTkWuXf9kuLp6CIgNgI19HURdMSnFVsvXMjtmS1OyzipFJmeOOh
         LOASvNt+ZFmMZHlIF3ln3E7eTmfDNw5Vbn/nDKS3EsNPyez4mq2IkH2BdY8ssaPtg1PY
         xCqUn/x+oJbvWsxoFLcSL8/RAgVG0fQ/BbYrU=
Received: by 10.64.195.20 with SMTP id s20mr6548055qbf.20.1223235977344;
        Sun, 05 Oct 2008 12:46:17 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id k8sm9652222qba.5.2008.10.05.12.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Oct 2008 12:46:16 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97530>

>From b6144562983703079a1eba8cdac3506c18d751a3 Mon Sep 17 00:00:00 2001
From: Deskin Miller <deskinm@umich.edu>
Date: Sat, 4 Oct 2008 20:07:44 -0400

If core.bare or core.sharedRepository are set in /etc/gitconfig or
~/.gitconfig, then 'git init' will read the values when constructing a
new config file; reading them, however, will override the values
specified on the command line.  In the case of --bare, this ends up
causing a segfault, without the repository being properly initialised;
in the case of --shared, the permissions are set according to the
existing config settings, not what was specified on the command line.

This fix saves any specified values for --bare and --shared prior to
reading existing config settings, and restores them after reading but
before writing the new config file.

Also includes a testcase which has a specified global config file
override, demonstrating the former failure scenario.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
I'm not a great fan of the method I took to save and restore the values
specified to init, but it works.  Also, I think the testcase is nice (but I'm
biased, seeing how I wrote it): in general I'd argue for more testcases which
deal with issues caused by the user's complete installation.

I based this off of maint, because I think it should be applied there, but it
applies cleanly to master if you feel that's better.
 builtin-init-db.c |    8 ++++++++
 t/t0001-init.sh   |   17 +++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 8140c12..38e282c 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -17,6 +17,9 @@
 #define TEST_FILEMODE 1
 #endif
 
+static int init_is_bare_repository = 0;
+static int init_shared_repository = PERM_UMASK;
+
 static void safe_create_dir(const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
@@ -191,6 +194,8 @@ static int create_default_files(const char *template_path)
 	copy_templates(template_path);
 
 	git_config(git_default_config, NULL);
+	is_bare_repository_cfg = init_is_bare_repository;
+	shared_repository = init_shared_repository;
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -277,6 +282,9 @@ int init_db(const char *template_dir, unsigned int flags)
 
 	safe_create_dir(get_git_dir(), 0);
 
+	init_is_bare_repository = is_bare_repository();
+	init_shared_repository = shared_repository;
+
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 620da5b..6a6bca0 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -167,4 +167,21 @@ test_expect_success 'init with --template (blank)' '
 	! test -f template-blank/.git/info/exclude
 '
 
+test_expect_success 'init --bare/--shared overrides system/global config' '
+	(
+		HOME="`pwd`" &&
+		export HOME &&
+		test_config="$HOME"/.gitconfig &&
+		unset GIT_CONFIG_NOGLOBAL &&
+		git config -f "$test_config" core.bare false &&
+		git config -f "$test_config" core.sharedRepository 0640 &&
+		mkdir init-bare-shared-override &&
+		cd init-bare-shared-override &&
+		git init --bare --shared=0666
+	) &&
+	check_config init-bare-shared-override true unset &&
+	test 0666 = \
+	`git config -f init-bare-shared-override/config core.sharedRepository`
+'
+
 test_done
-- 
1.6.0.2.307.gc427

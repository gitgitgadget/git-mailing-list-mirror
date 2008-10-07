From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH v2] git init: --bare/--shared overrides system/global
	config
Date: Tue, 7 Oct 2008 01:37:48 -0400
Message-ID: <20081007053748.GF3052@riemann.deskinm.fdns.net>
References: <20081005194412.GE3052@riemann.deskinm.fdns.net> <20081006141452.GA7684@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 07:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn5Jz-0000Zg-Fl
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 07:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbYJGFkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 01:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYJGFkE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 01:40:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:16617 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbYJGFkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 01:40:03 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1437059wri.5
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 22:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=Lw7Z8MpKoNH1ZGl0h6NyHMFf+md2nsLqnTCE4BK7iq0=;
        b=Bx35iR+QtLgh3XIpK1nwO6BAHDZdkjHH5MaAITm5UucfFwrRrqPlSaCqhN2lIah2+L
         dmkMamnTVmBM1iOvUsp1fo0SxXzYBQF5dmeU8f24XPAE8CEajTKa20aJIW/t1NpiY/FY
         nUV1Bk/vesOvgfu1Cp9WMmAncqUqTR1Gw2BBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=c/VGCH3pRElncwksQXZmk8NtMwXzh4HOgY8pHNdeuL0l2U63ZQMKB/B4bSyqszP0yk
         FnZTbkQL9JrztbJuBpBLFYEAZOQ4NIOWKPl85Pgb4EBKuWtO9EPy9MsSwFmN17L4TGBN
         qF0olYVc7akM6W8G9SaeYpxYuSgXzFoyr+/Mw=
Received: by 10.65.83.1 with SMTP id k1mr11273892qbl.93.1223358001148;
        Mon, 06 Oct 2008 22:40:01 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id k30sm12783427qba.4.2008.10.06.22.39.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Oct 2008 22:40:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081006141452.GA7684@spearce.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97665>

If core.bare or core.sharedRepository are set in /etc/gitconfig or
~/.gitconfig, then 'git init' will read the values when constructing a
new config file; reading them, however, will override the values
specified on the command line.  In the case of --bare, this ends up
causing a segfault, without the repository being properly initialised;
in the case of --shared, the permissions are set according to the
existing config settings, not what was specified on the command line.

This fix saves any specified values for --bare and --shared prior to
reading existing config settings, and restores them after reading but
before writing the new config file.  core.bare is ignored in all
situations, while core.sharedRepository will only be used if --shared
is not specified to git init.

Also includes testcases which use a specified global config file
override, demonstrating the former failure scenario.

Signed-off-by: Deskin Miller <deskinm@umich.edu>
---
On Mon, Oct 06, 2008 at 07:14:52AM -0700, Shawn O. Pearce wrote:
> Deskin Miller <deskinm@umich.edu> wrote:
> > From b6144562983703079a1eba8cdac3506c18d751a3 Mon Sep 17 00:00:00 2001
> > From: Deskin Miller <deskinm@umich.edu>
> > Date: Sat, 4 Oct 2008 20:07:44 -0400
> 
> FWIW please don't include these lines in the commit message part
> of the patch email. [...]

Alright, sorry for the messiness; I guess I thought preserving the original
commit date was important?  Won't happen again.

> > diff --git a/builtin-init-db.c b/builtin-init-db.c
> > index 8140c12..38e282c 100644
> > --- a/builtin-init-db.c
> > +++ b/builtin-init-db.c
> > @@ -191,6 +194,8 @@ static int create_default_files(const char *template_path)
> >  	copy_templates(template_path);
> >  
> >  	git_config(git_default_config, NULL);
> > +	is_bare_repository_cfg = init_is_bare_repository;
> > +	shared_repository = init_shared_repository;
> 
> Is this really the right thing to do?  It seems like it would prevent
> a user from setting core.sharedRepository = group in their template
> and thus always have a shared repository on their system.
 
You're right.  Fixed in this version: core.bare ignores any config, while
--shared will override config settings, but init will use the config settings
if --shared is not specified.
 
> A second related test would be a ~/.gitconfig which sets
> core.sharedRepository = 0666 and then does "git init".  I think
> the right outcome is a repository which has that set.

Good suggestion, I added such a case in this version.  My first version fails
this new testcase, while maint fails the original testcase I wrote.

 builtin-init-db.c |   12 ++++++++++--
 t/t0001-init.sh   |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 8140c12..d30c3fe 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -17,6 +17,9 @@
 #define TEST_FILEMODE 1
 #endif
 
+static int init_is_bare_repository = 0;
+static int init_shared_repository = -1;
+
 static void safe_create_dir(const char *dir, int share)
 {
 	if (mkdir(dir, 0777) < 0) {
@@ -191,6 +194,9 @@ static int create_default_files(const char *template_path)
 	copy_templates(template_path);
 
 	git_config(git_default_config, NULL);
+	is_bare_repository_cfg = init_is_bare_repository;
+	if (init_shared_repository != -1)
+		shared_repository = init_shared_repository;
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -277,6 +283,8 @@ int init_db(const char *template_dir, unsigned int flags)
 
 	safe_create_dir(get_git_dir(), 0);
 
+	init_is_bare_repository = is_bare_repository();
+
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
@@ -381,9 +389,9 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir,
 						sizeof(git_dir)), 0);
 		} else if (!strcmp(arg, "--shared"))
-			shared_repository = PERM_GROUP;
+			init_shared_repository = PERM_GROUP;
 		else if (!prefixcmp(arg, "--shared="))
-			shared_repository = git_config_perm("arg", arg+9);
+			init_shared_repository = git_config_perm("arg", arg+9);
 		else if (!strcmp(arg, "-q") || !strcmp(arg, "--quiet"))
 			flags |= INIT_DB_QUIET;
 		else
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 620da5b..5ac0a27 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -167,4 +167,36 @@ test_expect_success 'init with --template (blank)' '
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
+	test x0666 = \
+	x`git config -f init-bare-shared-override/config core.sharedRepository`
+'
+
+test_expect_success 'init honors global core.sharedRepository' '
+	(
+		HOME="`pwd`" &&
+		export HOME &&
+		test_config="$HOME"/.gitconfig &&
+		unset GIT_CONFIG_NOGLOBAL &&
+		git config -f "$test_config" core.sharedRepository 0666 &&
+		mkdir shared-honor-global &&
+		cd shared-honor-global &&
+		git init
+	) &&
+	test x0666 = \
+	x`git config -f shared-honor-global/.git/config core.sharedRepository`
+'
+
 test_done
-- 
1.6.0.2.307.gc427

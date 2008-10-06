From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git init: --bare/--shared overrides system/global
	config
Date: Mon, 6 Oct 2008 07:14:52 -0700
Message-ID: <20081006141452.GA7684@spearce.org>
References: <20081005194412.GE3052@riemann.deskinm.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Mon Oct 06 16:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmqsX-0002EJ-TB
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYJFOOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbYJFOOx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:14:53 -0400
Received: from george.spearce.org ([209.20.77.23]:50160 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbYJFOOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:14:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 312EC3835F; Mon,  6 Oct 2008 14:14:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081005194412.GE3052@riemann.deskinm.fdns.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97583>

Deskin Miller <deskinm@umich.edu> wrote:
> From b6144562983703079a1eba8cdac3506c18d751a3 Mon Sep 17 00:00:00 2001
> From: Deskin Miller <deskinm@umich.edu>
> Date: Sat, 4 Oct 2008 20:07:44 -0400

FWIW please don't include these lines in the commit message part
of the patch email.  The only reason to include a "From: blah" line
(the 2nd one above) is when the name and/or email address that you
want to attribute the change to differs from the name/email that
the message is sent from.  (E.g. sent from gmail.com but you want
to attribute to umich.edu.)
 
> If core.bare or core.sharedRepository are set in /etc/gitconfig or
> ~/.gitconfig, then 'git init' will read the values when constructing a
> new config file; [...]
> ---

Yikes.

> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index 8140c12..38e282c 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -191,6 +194,8 @@ static int create_default_files(const char *template_path)
>  	copy_templates(template_path);
>  
>  	git_config(git_default_config, NULL);
> +	is_bare_repository_cfg = init_is_bare_repository;
> +	shared_repository = init_shared_repository;

Is this really the right thing to do?  It seems like it would prevent
a user from setting core.sharedRepository = group in their template
and thus always have a shared repository on their system.

I think we should only be using the command line shared option if
it was supplied, but if it was not we should be honoring what we
recieved from git_config().

However I agree that is_bare shouldn't be inherited from the config.
Its a per-repository attribute and no matter what the user asked
for in their /etc/gitconfig or ~/.gitconfig we should correctly
set it for this current repository.
  
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 620da5b..6a6bca0 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -167,4 +167,21 @@ test_expect_success 'init with --template (blank)' '
>  	! test -f template-blank/.git/info/exclude
>  '
>  
> +test_expect_success 'init --bare/--shared overrides system/global config' '
> +	(
> +		HOME="`pwd`" &&
> +		export HOME &&
> +		test_config="$HOME"/.gitconfig &&
> +		unset GIT_CONFIG_NOGLOBAL &&
> +		git config -f "$test_config" core.bare false &&
> +		git config -f "$test_config" core.sharedRepository 0640 &&
> +		mkdir init-bare-shared-override &&
> +		cd init-bare-shared-override &&
> +		git init --bare --shared=0666
> +	) &&
> +	check_config init-bare-shared-override true unset &&
> +	test 0666 = \
> +	`git config -f init-bare-shared-override/config core.sharedRepository`
> +'

A second related test would be a ~/.gitconfig which sets
core.sharedRepository = 0666 and then does "git init".  I think
the right outcome is a repository which has that set.

-- 
Shawn.

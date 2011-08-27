From: Pete Wyckoff <pw@padd.com>
Subject: Re: Re* git clean --exclude broken?
Date: Sat, 27 Aug 2011 19:54:58 -0400
Message-ID: <20110827235458.GA8124@arf.padd.com>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
 <7vliuio65w.fsf@alter.siamese.dyndns.org>
 <7vfwkqmfsh.fsf@alter.siamese.dyndns.org>
 <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Todd Rinaldo <toddr@cpanel.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 01:57:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxSkL-0007nd-Uw
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 01:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab1H0X47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 19:56:59 -0400
Received: from honk.padd.com ([74.3.171.149]:59620 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab1H0X46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 19:56:58 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 7F3082D;
	Sat, 27 Aug 2011 16:56:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E0FD0314D1; Sat, 27 Aug 2011 19:54:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180252>

gitster@pobox.com wrote on Thu, 25 Aug 2011 11:29 -0700:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > The documentation and the implementation of "git clean" is quite confused.
> > ...
> 
> So here is a patch to fix the confusion.
> 
> It does not add a new "--except=C" I alluded to, but at least it should
> be the right first step to make the document clearly describe what the
> existing option does.
> 
> -- >8 --
> Subject: [PATCH] Documentation: clarify "git clean -e <pattern>"
> 
> The current explanation of -e can be misread as allowing the user to say
> 
>     I know 'git clean -XYZ' (substitute -XYZ with any option and/or
>     parameter) will remove paths A, B, and C, and I want them all removed
>     except for paths matching this pattern by adding '-e C' to the same
>     command line, i.e. 'git clean -e C -XYZ'.
> 
> But that is not what this option does. It augments the set of ignore rules
> from the command line, just like the same "-e <pattern>" argument does
> with the "ls-files" command (the user could probably pass "-e \!C" to tell
> the command to clean everything the command would normally remove, except
> for C).
> 
> It also fixes small style nit in the parameter to add_exclude() call. The
> current code only works because EXC_CMDL happens to be defined as 0.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-clean.txt |    6 +++---
>  builtin/clean.c             |    5 ++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 974e04e..a7a18e3 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -47,9 +47,9 @@ OPTIONS
>  
>  -e <pattern>::
>  --exclude=<pattern>::
> -	Specify special exceptions to not be cleaned.  Each <pattern> is
> -	the same form as in $GIT_DIR/info/excludes and this option can be
> -	given multiple times.
> +	In addition to what are found in .gitignore (per directory) and
> +	$GIT_DIR/info/exclude, also consider these patterns to be in the
> +	set of the ignore rules in effect.
>  
>  -x::
>  	Don't use the ignore rules.  This allows removing all untracked
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 75697f7..3782718 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -76,6 +76,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	if (ignored && ignored_only)
>  		die(_("-x and -X cannot be used together"));
> +	if (ignored && exclude_list.nr)
> +		die(_("adding exclude with -e and ignoring it with -x is crazy"));

This breaks one of my use cases for git clean.

We have "precious" files that are listed in .gitignore so that
they don't show up in "git status" output.  They're not part of
the repository, but special per-user per-workspace configuration
settings that are required to build the code.

There's plenty of other stuff in .gitignore that should be
deleted.  So we invoke:

    git clean -dqfx -e .magic_file -e "Magic*"

It's been discussed on the list a couple of times that a separate
category for files that I want to ignore, but do not want to
have cleaned, would fill this gap.

		-- Pete

>  	if (!show_only && !force) {
>  		if (config_set)
> @@ -98,7 +100,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		setup_standard_excludes(&dir);
>  
>  	for (i = 0; i < exclude_list.nr; i++)
> -		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);
> +		add_exclude(exclude_list.items[i].string, "", 0,
> +			    &dir.exclude_list[EXC_CMDL]);
>  
>  	pathspec = get_pathspec(prefix, argv);
>  
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

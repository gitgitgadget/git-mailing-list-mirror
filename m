From: Pete Wyckoff <pw@padd.com>
Subject: Re: Re* git clean --exclude broken?
Date: Sun, 28 Aug 2011 08:31:22 -0400
Message-ID: <20110828123122.GA10940@arf.padd.com>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
 <7vliuio65w.fsf@alter.siamese.dyndns.org>
 <7vfwkqmfsh.fsf@alter.siamese.dyndns.org>
 <7vpqjtl4yi.fsf_-_@alter.siamese.dyndns.org>
 <20110827235458.GA8124@arf.padd.com>
 <7v62li9hk5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Todd Rinaldo <toddr@cpanel.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 14:35:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxeZk-0008Ld-VA
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 14:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866Ab1H1Mbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 08:31:33 -0400
Received: from honk.padd.com ([74.3.171.149]:60642 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab1H1Mbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2011 08:31:32 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 65F912D;
	Sun, 28 Aug 2011 05:31:30 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id AA5B6314D1; Sun, 28 Aug 2011 08:31:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v62li9hk5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180266>

gitster@pobox.com wrote on Sat, 27 Aug 2011 23:27 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> >> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> >> index 974e04e..a7a18e3 100644
> >> --- a/Documentation/git-clean.txt
> >> +++ b/Documentation/git-clean.txt
> >> @@ -47,9 +47,9 @@ OPTIONS
> >>  
> >>  -e <pattern>::
> >>  --exclude=<pattern>::
> >> -	Specify special exceptions to not be cleaned.  Each <pattern> is
> >> -	the same form as in $GIT_DIR/info/excludes and this option can be
> >> -	given multiple times.
> >> +	In addition to what are found in .gitignore (per directory) and
> >> +	$GIT_DIR/info/exclude, also consider these patterns to be in the
> >> +	set of the ignore rules in effect.
> >>  
> >>  -x::
> >>  	Don't use the ignore rules.  This allows removing all untracked
> >> diff --git a/builtin/clean.c b/builtin/clean.c
> >> index 75697f7..3782718 100644
> >> --- a/builtin/clean.c
> >> +++ b/builtin/clean.c
> >> @@ -76,6 +76,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
> >>  
> >>  	if (ignored && ignored_only)
> >>  		die(_("-x and -X cannot be used together"));
> >> +	if (ignored && exclude_list.nr)
> >> +		die(_("adding exclude with -e and ignoring it with -x is crazy"));
> >
> > This breaks one of my use cases for git clean.
> 
> The description of '-x' needs to be also updated to reflect what it does.
> 
> How about this on top?
> 
>  Documentation/git-clean.txt |    4 +++-
>  builtin/clean.c             |    2 --
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index b49674f..79fb984 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -52,7 +52,9 @@ OPTIONS
>  	set of the ignore rules in effect.
>  
>  -x::
> -	Don't use the ignore rules.  This allows removing all untracked
> +	Don't use the standard ignore rules read from .gitignore (per
> +	directory) and $GIT_DIR/info/exclude, but do still use the ignore
> +	rules given with `-e` options.  This allows removing all untracked
>  	files, including build products.  This can be used (possibly in
>  	conjunction with 'git reset') to create a pristine
>  	working directory to test a clean build.
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 7fcbf87..0c7b3d0 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -76,8 +76,6 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	if (ignored && ignored_only)
>  		die(_("-x and -X cannot be used together"));
> -	if (ignored && exclude_list.nr)
> -		die(_("adding exclude with -e and ignoring it with -x is crazy"));
>  
>  	if (!show_only && !force) {
>  		if (config_set)
> 

This works, thanks.  It is a confusing set of options, but we
need them all.  I couldn't think of a better way to describe
how they interact.

		-- Pete

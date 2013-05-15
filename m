From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: introduce --parents parameter for commands
 branch and tag
Date: Wed, 15 May 2013 02:35:47 +0000
Message-ID: <20130515023547.GA21987@dcvr.yhbt.net>
References: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tobias Schulte <tobias.schulte@gliderpilot.de>
X-From: git-owner@vger.kernel.org Wed May 15 04:36:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcRZU-00079H-17
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 04:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3EOCft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 22:35:49 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46463 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803Ab3EOCfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 22:35:48 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4742F1F432;
	Wed, 15 May 2013 02:35:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1368476549-17886-1-git-send-email-tobias.schulte@gliderpilot.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224377>

Tobias Schulte <tobias.schulte@gliderpilot.de> wrote:
> This parameter is equivalent to the parameter --parents on svn cp commands
> and is useful for non-standard repository layouts.

This looks useful.  A few minor cosmetic issues.

> +++ b/Documentation/git-svn.txt
> @@ -298,6 +298,11 @@ where <name> is the name of the SVN repository as specified by the -R option to
>  	git config --get-all svn-remote.<name>.commiturl
>  +
>  
> +--parents;;
> +	Create parent folders. This parameter is equivalent to the parameter 
> +	--parents on svn cp commands and is useful for non-standard repository 
> +	layouts.

Trailing whitespace.

> +sub mk_parent_dirs {
> +	my $ctx = shift;
> +	my $parent = shift;

I prefer declaring multiple variables from arguments as:

	my ($ctx, $parent) = @_;

> +	$parent =~ s/\/[^\/]*$//;

You can avoid leaning toothpick syndrome (escaping '/') by specifying
alternate delimiters:

	$parent =~ s{/[^/]*$}{};

ref: perlop(1)

> +	if (!eval{$ctx->ls($parent, 'HEAD', 0)}) {
> +		mk_parent_dirs($ctx, $parent);
> +		print "Creating parent folder ${parent} ...\n";
> +		$ctx->mkdir($parent)
> +			unless $_dry_run;

The newline is confusing, I prefer:

		$ctx->mkdir($parent) unless $_dry_run;

Howeve :

	if (!$_dry_run) {
		$ctx->mkdir($parent);
	}

May be preferred, too (especially for the non-Perl-fluent)

> +++ b/t/t9167-git-svn-cmd-branch-subproject.sh

> +test_expect_success 'initialize svnrepo' '
> +    mkdir import &&
> +    (
> +        (cd import &&
> +        mkdir -p trunk/project branches tags &&
> +        (cd trunk/project &&
> +        echo foo > foo
> +        ) &&

Tabs for all indentation, and indent consistently for subshells:

	mkdir import &&
	(
		cd import &&
		mkdir .. &&
		(
			cd .. &&
			..
		)
	)

We use subshells + cd like this so it's easier to read/maintain.

Thanks again, looking forward to applying v2.

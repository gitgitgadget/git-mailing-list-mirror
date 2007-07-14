From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn init/clone --stdlayout option to default-init trunk/tags/branches
Date: Sat, 14 Jul 2007 03:50:10 -0700
Message-ID: <20070714105010.GA14842@muzzle>
References: <1184405128718-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sat Jul 14 12:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9fCr-0001dQ-M1
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 12:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487AbXGNKuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 06:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbXGNKuO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 06:50:14 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41648 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756419AbXGNKuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 06:50:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 308762DC032;
	Sat, 14 Jul 2007 03:50:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1184405128718-git-send-email-madduck@madduck.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52469>

"martin f. krafft" <madduck@madduck.net> wrote:
> The --stdlayout option to git-svn init/clone initialises the default
> Subversion values of trunk,tags,branches: -T trunk -b branches -t tags.
> If any of the -T/-t/-b options are given in addition, they are given
> preference.
> 
> Signed-off-by: martin f. krafft <madduck@madduck.net>

Thanks.  I've been meaning to do this myself, but keep on putting it
off...

This looks good and useful, but can I also have a  shorthand "-s" for
this, too?  I'm lazy, thanks :)

Also, nitpicking, there's been some whitespace damage:

I use tab characters for indentation, and (should be using) spaces for
alignment.

> ---
>  Documentation/git-svn.txt |    6 +++++-
>  git-svn.perl              |   11 +++++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 0a210e4..9e74b27 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -44,10 +44,14 @@ COMMANDS
>  --tags=<tags_subdir>;;
>  -b<branches_subdir>;;
>  --branches=<branches_subdir>;;
> +--stdlayout;;
>  	These are optional command-line options for init.  Each of
>  	these flags can point to a relative repository path
>  	(--tags=project/tags') or a full url
> -	(--tags=https://foo.org/project/tags)
> +	(--tags=https://foo.org/project/tags). The option --stdlayout is
> +	a shorthand way of setting trunk,tags,branches as the relative paths,
> +	which is the Subversion default. If any of the other options are given
> +	as well, they take precedence.
>  --no-metadata;;
>  	Set the 'noMetadata' option in the [svn-remote] config.
>  --use-svm-props;;
> diff --git a/git-svn.perl b/git-svn.perl
> index b3dffcc..affba8e 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -77,11 +77,12 @@ my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
>  		   \$Git::SVN::_repack_flags,
>  		%remote_opts );
>  
> -my ($_trunk, $_tags, $_branches);
> +my ($_trunk, $_tags, $_branches, $_stdlayout);
>  my %icv;
>  my %init_opts = ( 'template=s' => \$_template, 'shared:s' => \$_shared,
>                    'trunk|T=s' => \$_trunk, 'tags|t=s' => \$_tags,
>                    'branches|b=s' => \$_branches, 'prefix=s' => \$_prefix,
> +                  'stdlayout' => \$_stdlayout,
>                    'minimize-url|m' => \$Git::SVN::_minimize_url,
>  		  'no-metadata' => sub { $icv{noMetadata} = 1 },
>  		  'use-svm-props' => sub { $icv{useSvmProps} = 1 },

Yes, I'm not consistent myself with using spaces for alignment :(
Thanks for using spaces here.

> @@ -292,7 +293,8 @@ sub init_subdir {
>  sub cmd_clone {
>  	my ($url, $path) = @_;
>  	if (!defined $path &&
> -	    (defined $_trunk || defined $_branches || defined $_tags) &&
> +	    (defined $_trunk || defined $_branches || defined $_tags ||
> +		defined $_stdlayout) &&

The lines above and below use spaces for alignment, so this one should,
definitely be using spaces after the initial tab too.

>  	    $url !~ m#^[a-z\+]+://#) {
>  		$path = $url;
>  	}
> @@ -302,6 +304,11 @@ sub cmd_clone {
>  }
>  
>  sub cmd_init {
> +        if (defined $_stdlayout) {
> +          $_trunk = 'trunk' if (!defined $_trunk);
> +          $_tags = 'tags' if (!defined $_tags);
> +          $_branches = 'branches' if (!defined $_branches);
> +        }

Indentation is always done in tabs in git-svn.  I *should* be using
spaces for alignment but I myself have been sloppy :x

>  	if (defined $_trunk || defined $_branches || defined $_tags) {
>  		return cmd_multi_init(@_);
>  	}

-- 
Eric Wong

From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: respect Subversion's [auth] section configuration values
Date: Sat, 6 Oct 2007 20:22:41 -0700
Message-ID: <20071007032241.GG14972@hand.yhbt.net>
References: <20071006185719.GA3943@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:38:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeMjK-0001jo-Mj
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 05:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXJGDWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 23:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbXJGDWn
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 23:22:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38911 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbXJGDWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 23:22:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 152067DC093;
	Sat,  6 Oct 2007 20:22:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20071006185719.GA3943@void.codelabs.ru>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60163>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Parameters 'store-passwords' and 'store-auth-creds' from Subversion's
> configuration (~/.subversion/config) were not respected.  This was
> fixed: the default values for these parameters are set to 'yes' to
> follow Subversion behaviour.

Thanks.

> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-svn.perl |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 484b057..f7ef421 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3051,6 +3051,29 @@ sub new {
>  	  ]);
>  	my $config = SVN::Core::config_get_config($config_dir);
>  	$RA = undef;
> +	my $dont_store_passwords = 1;
> +	my $conf_t = ${$config}{'config'};
> +	{
> +		# The usage of $SVN::_Core::SVN_CONFIG_* variables
> +		# produces warnings that variables are used only once.
> +		# I had not found the better way to shut them up, so
> +		# warnings are disabled in this block.
> +		no warnings;
> +		if (SVN::_Core::svn_config_get_bool($conf_t,
> +		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
> +		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_PASSWORDS,
> +		    1) == 0) {
> +			SVN::_Core::svn_auth_set_parameter($baton,
> +			    $SVN::_Core::SVN_AUTH_PARAM_DONT_STORE_PASSWORDS,
> +			    bless (\$dont_store_passwords, "_p_void"));
> +		}
> +		if (SVN::_Core::svn_config_get_bool($conf_t,
> +		    $SVN::_Core::SVN_CONFIG_SECTION_AUTH,
> +		    $SVN::_Core::SVN_CONFIG_OPTION_STORE_AUTH_CREDS,
> +		    1) == 0) {
> +			$Git::SVN::Prompt::_no_auth_cache = 1;
> +		}
> +	}
>  	my $self = SVN::Ra->new(url => $url, auth => $baton,
>  	                      config => $config,
>  			      pool => SVN::Pool->new,

-- 
Eric Wong

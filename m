From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-svn: respect Subversion's [auth] section configuration
 values
Date: Sun, 07 Oct 2007 14:24:43 +1300
Message-ID: <4708355B.4090403@vilain.net>
References: <20071006185719.GA3943@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:53:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeKtB-0000iX-4R
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 03:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbXJGBYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 21:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbXJGBYw
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 21:24:52 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:47807 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbXJGBYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 21:24:51 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 6293B21CFEF; Sun,  7 Oct 2007 14:24:49 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 53A6A21CFC7;
	Sun,  7 Oct 2007 14:24:43 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20071006185719.GA3943@void.codelabs.ru>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60166>

Eygene Ryabinkin wrote:
> Parameters 'store-passwords' and 'store-auth-creds' from Subversion's
> configuration (~/.subversion/config) were not respected.  This was
> fixed: the default values for these parameters are set to 'yes' to
> follow Subversion behaviour.
>   

I saw this in the svn api before.  It really is a strange API, requiring
the user to get things like this right.

> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
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
>   

You can use no warnings 'once';

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
>   

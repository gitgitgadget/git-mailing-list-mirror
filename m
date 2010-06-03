From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 17:20:30 +0200
Message-ID: <20100603152030.GD20775@machine.or.cz>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 17:20:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKCDn-0000Au-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 17:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab0FCPUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 11:20:34 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53067 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756142Ab0FCPUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 11:20:34 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4EF06862094; Thu,  3 Jun 2010 17:20:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148333>

  Hi!

  I think this is a good start!

  I have couple of concerns; maybe they were addressed in the previous
discussion which I admit I did not read completely, but in that case
they ought to be addressed in the commit message as well.

On Thu, Jun 03, 2010 at 07:25:54PM +0530, Pavan Kumar Sunkara wrote:
> -our $t0;
> -if (eval { require Time::HiRes; 1; }) {
> -	$t0 = [Time::HiRes::gettimeofday()];

Why is this moved to Gitweb::Config? Shouldn't this be rather part of
Gitweb::Request?

> +# __DIR__ is taken from Dir::Self __DIR__ fragment
> +sub __DIR__ () {
> +	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
>  }
> -our $number_of_git_cmds = 0;
> +use lib __DIR__ . "/lib";

Wouldn't it be more elegant to use FindBin? I'm just not sure how long
is it part of core Perl.

> +
> +use Gitweb::Config;
>  
>  BEGIN {
>  	CGI->compile() if $ENV{'MOD_PERL'};
>  }
>  
> -our $version = "++GIT_VERSION++";
> +$version = "++GIT_VERSION++";
>  
>  our ($my_url, $my_uri, $base_url, $path_info, $home_link);
>  sub evaluate_uri {
> @@ -68,402 +71,58 @@ sub evaluate_uri {
>  
>  # core git executable to use
>  # this can just be "git" if your webserver has a sensible PATH
> -our $GIT = "++GIT_BINDIR++/git";
> +$GIT = "++GIT_BINDIR++/git";

I dislike the new schema in one aspect - the list of configuration
variables together with their description is not at a single place
anymore: the build-time overridable variables have their descriptions
still in gitweb.pl and only very brief mentions in Gitweb::Config, while
the rest has moved fully to Gitweb::Config. I think it would be best to
move all descriptions to Gitweb::Config and keep only the override
assignments in gitweb.pl. So, Gitweb::Config would have

	# core git executable to use
	# this can just be "git" if your webserver has a sensible PATH
	our $GIT;

and gitweb.pl would have _just_

	$GIT = "++GIT_BINDIR++/git";

How does that sound?


I think you ought to add a comment in front of this section explaining
that not all configuration variables are listed here anymore. Something
like

	# Only configuration variables with build-time overridable
	# defaults are listed below. The complete set of variables
	# with their descriptions is listed in Gitweb::Config.

>  # name of your site or organization to appear in page titles
>  # replace this with something more descriptive for clearer bookmarks
> -our $site_name = "++GITWEB_SITENAME++"
> +$site_name = "++GITWEB_SITENAME++"
>                   || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";

This looks like some new feature; please do that in a separate patch.
(BTW, I assume that there are no other changes like this in the rest of
the moved code blocks!)

-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.

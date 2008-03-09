From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Don't try and percent-escape existing percent escapes in git-svn URIs
Date: Sun, 9 Mar 2008 01:12:40 -0800
Message-ID: <20080309091240.GA17484@mayonaise>
References: <1205018447-18344-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 10:13:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYHbH-0000lq-Pg
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 10:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbYCIJMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 05:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYCIJMo
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 05:12:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59022 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYCIJMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 05:12:43 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 8E8C47F4153;
	Sun,  9 Mar 2008 01:12:41 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 09 Mar 2008 01:12:40 -0800
Content-Disposition: inline
In-Reply-To: <1205018447-18344-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76640>

Kevin Ballard <kevin@sb.org> wrote:
> git-svn: project names are percent-escaped ever since f5530b.
> Unfortunately this breaks the scenario where the user hands git-svn
> an already-escaped URI. Fix the regexp to skip over what looks like
> existing percent escapes, and test this scenario.

What happens when something that _looks_ like a percent escape is
actually a part of the URL and not really an escape?

> Signed-off-by: Kevin Ballard <kevin@sb.org>
> ---
>  git-svn.perl                                  |    2 +-
>  t/t9120-git-svn-clone-with-percent-escapes.sh |   31 +++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 1 deletions(-)
>  create mode 100755 t/t9120-git-svn-clone-with-percent-escapes.sh
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 9e2faf9..cec664f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -3658,7 +3658,7 @@ sub escape_uri_only {
>  	my ($uri) = @_;
>  	my @tmp;
>  	foreach (split m{/}, $uri) {
> -		s/([^\w.-])/sprintf("%%%02X",ord($1))/eg;
> +		s/([^\w.%-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
>  		push @tmp, $_;
>  	}
>  	join('/', @tmp);
> diff --git a/t/t9120-git-svn-clone-with-percent-escapes.sh b/t/t9120-git-svn-clone-with-percent-escapes.sh
> new file mode 100755
> index 0000000..9a4eabe
> --- /dev/null
> +++ b/t/t9120-git-svn-clone-with-percent-escapes.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2008 Kevin Ballard
> +#
> +
> +test_description='git-svn clone with percent escapes'
> +. ./lib-git-svn.sh
> +
> +test_expect_success 'setup svnrepo' "
> +	mkdir project project/trunk project/branches project/tags &&
> +	echo foo > project/trunk/foo &&
> +	svn import -m '$test_description' project '$svnrepo/pr ject' &&
> +	rm -rf project &&
> +	start_httpd
> +"
> +
> +if test "$SVN_HTTPD_PORT" = ""
> +then
> +	test_expect_failure 'test clone with percent escapes - needs SVN_HTTPD_PORT set' 'false'
> +else
> +	test_expect_success 'test clone with percent escapes' '
> +		git svn clone "$svnrepo/pr%20ject" clone &&
> +		cd clone &&
> +			git rev-parse refs/remotes/git-svn &&
> +		cd ..
> +	'
> +fi
> +
> +stop_httpd
> +
> +test_done
> -- 
> 1.5.4.3.487.g1eab2.dirty
> 

-- 
Eric Wong

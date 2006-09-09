From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitweb: reset input record separator in parse_commit even on error
Date: Sat, 9 Sep 2006 16:51:59 -0400
Message-ID: <20060909205159.GC16906@coredump.intra.peff.net>
References: <20060909151236.GA25518@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 22:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM9oK-0006ar-93
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 22:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWIIUwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 16:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWIIUwE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 16:52:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:58526 "HELO
	peff.net") by vger.kernel.org with SMTP id S964857AbWIIUwB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 16:52:01 -0400
Received: (qmail 14537 invoked from network); 9 Sep 2006 16:51:26 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Sep 2006 16:51:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat,  9 Sep 2006 16:51:59 -0400
To: Sven Verdoolaege <skimo@liacs.nl>
Content-Disposition: inline
In-Reply-To: <20060909151236.GA25518@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26765>

On Sat, Sep 09, 2006 at 05:12:36PM +0200, Sven Verdoolaege wrote:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7afdf33..60dd598 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -897,8 +897,8 @@ sub parse_commit {
>  		my $fd = git_pipe("rev-list", "--header", "--parents", "--max-count=1", $commit_id)
>  			or return;
>  		@commit_lines = split '\n', <$fd>;
> -		close $fd or return;
>  		$/ = "\n";
> +		close $fd or return;
>  		pop @commit_lines;
>  	}
>  	my $header = shift @commit_lines;

You missed the other early return from git_pipe. However, I think the
approach is wrong; this is a great opportunity to use the dynamic
scoping offered by 'local':

  else {
    local $/ = "\0";
    # do stuff with $/ as "\0"
  }
  # $/ has automatically been reset at the end of the block

Looking further at this bit of code, it seems even more confusing,
though. We split the output of rev-list on NUL, grab presumably the
entire thing (since there shouldn't be any NULs in the output, right?)
and then split it on newline into a list. Why aren't we doing this:
  else {
    open my $fd, ...;
    @commit_lines = map { chomp; $_ } <$fd>;
    ...

-Peff

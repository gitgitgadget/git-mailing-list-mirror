From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 3/7] Extract, test and enhance the logic to collapse
 ../foo paths.
Date: Mon, 30 Jul 2012 19:51:08 +0000
Message-ID: <20120730195108.GA20137@dcvr.yhbt.net>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-4-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: "Michael G. Schwern" <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:51:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svvzo-0007v3-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 21:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136Ab2G3TvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 15:51:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56301 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754986Ab2G3TvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 15:51:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271211F449;
	Mon, 30 Jul 2012 19:51:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343468312-72024-4-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202607>

"Michael G. Schwern" <schwern@pobox.com> wrote:
> From: "Michael G. Schwern" <schwern@pobox.com>
> 
> The SVN API functions will not accept ../foo but their canonicalization
> functions will not collapse it.  So we'll have to do it ourselves.
> 
> _collapse_dotdot() works better than the existing regex did.

I don't dispute it's better, but it's worth explaining in the commit
message to reviewers why something is "better".

> This will be used shortly when canonicalize_path() starts using the
> SVN API.
> ---

> +# Turn foo/../bar into bar
> +sub _collapse_dotdot {
> +	my $path = shift;
> +
> +	1 while $path =~ s{/[^/]+/+\.\.}{};
> +	1 while $path =~ s{[^/]+/+\.\./}{};
> +	1 while $path =~ s{[^/]+/+\.\.}{};

This is a bug that's gone unnoticed[1] for over 5 years now,
but I've just noticed this doesn' handle "foo/..bar"  or "foo/...bar"
cases correctly.

>  sub canonicalize_path {
>  	my ($path) = @_;
>  	my $dot_slash_added = 0;
> @@ -83,7 +95,7 @@ sub canonicalize_path {
>  	# good reason), so let's do this manually.
>  	$path =~ s#/+#/#g;
>  	$path =~ s#/\.(?:/|$)#/#g;
> -	$path =~ s#/[^/]+/\.\.##g;
> +	$path = _collapse_dotdot($path);

[1] - I doubt anybody uses paths like these, though...

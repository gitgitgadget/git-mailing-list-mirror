From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] remote: use remote_is_configured() for add and rename
Date: Mon, 15 Feb 2016 13:33:34 -0500
Message-ID: <20160215183334.GH26443@sigill.intra.peff.net>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 19:33:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVNxt-0007cp-E3
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 19:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbcBOSdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 13:33:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:42300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751944AbcBOSdh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 13:33:37 -0500
Received: (qmail 26085 invoked by uid 102); 15 Feb 2016 18:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:33:36 -0500
Received: (qmail 10109 invoked by uid 107); 15 Feb 2016 18:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Feb 2016 13:33:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2016 13:33:34 -0500
Content-Disposition: inline
In-Reply-To: <1455558150-30267-5-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286226>

On Mon, Feb 15, 2016 at 06:42:30PM +0100, Thomas Gummerer wrote:

> Both remote add and remote rename use a slightly different hand-rolled
> check if the remote exits.  The hand-rolled check may have some subtle
> cases in which it might fail to detect when a remote already exists.
> One such case was fixed in fb86e32 ("git remote: allow adding remotes
> agreeing with url.<...>.insteadOf").  Another case is when a remote is
> configured as follows:
> 
>   [remote "foo"]
>     vcs = bar
> 
> If we try to run `git remote add foo bar` with the above remote
> configuration, git segfaults.  This change fixes it.
> 
> In addition, git remote rename $existing foo with the configuration for
> foo as above silently succeeds, even though foo already exists,
> modifying its configuration.  With this patch it fails with "remote foo
> already exists".

Checking is_configured() certainly sounds like a better test, but...

> diff --git a/builtin/remote.c b/builtin/remote.c
> index 981c487..bd57f1b 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -186,10 +186,7 @@ static int add(int argc, const char **argv)
>  	url = argv[1];
>  
>  	remote = remote_get(name);
> -	if (remote && (remote->url_nr > 1 ||
> -			(strcmp(name, remote->url[0]) &&
> -				strcmp(url, remote->url[0])) ||
> -			remote->fetch_refspec_nr))
> +	if (remote_is_configured(remote))
>  		die(_("remote %s already exists."), name);

This original is quite confusing. I thought at first that there was
perhaps something going on with allowing repeated re-configuration of
the same remote, as long as some parameters matched. I.e., I am
wondering if there is a case here that does _not_ segfault, that we
would be breaking.

But reading over fb86e32dcc, I think I have convinced myself that it was
merely an ad-hoc check for "is_configured", and using that function is a
better replacement.

-Peff

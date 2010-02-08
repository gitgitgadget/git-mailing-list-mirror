From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 8 Feb 2010 16:32:57 -0500
Message-ID: <20100208213256.GA470@coredump.intra.peff.net>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:33:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NebE4-0005Xk-Nu
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 22:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864Ab0BHVc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 16:32:56 -0500
Received: from peff.net ([208.65.91.99]:40757 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701Ab0BHVcz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 16:32:55 -0500
Received: (qmail 9656 invoked by uid 107); 8 Feb 2010 21:33:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 08 Feb 2010 16:33:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2010 16:32:57 -0500
Content-Disposition: inline
In-Reply-To: <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139322>

On Mon, Feb 08, 2010 at 01:13:36PM -0800, Junio C Hamano wrote:

> diff --git a/builtin-push.c b/builtin-push.c
> index 5633f0a..f5082d8 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -226,6 +226,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
>  
> +	if (flags & TRANSPORT_PUSH_PORCELAIN) {
> +		/* Do not give advice messages to Porcelain scripts */
> +		advice_push_nonfastforward = 0;
> +	}

I think this is sane.

>  {
>  	if (!count)
> -		fprintf(stderr, "To %s\n", dest);
> +		fprintf(porcelain ? stdout : stderr, "To %s\n", dest);

But note here that you are changing the --porcelain format, as callers
which were keeping only the stdout (and letting stderr go to /dev/null,
or spew to the user) saw only the ref lines. So this may be breaking
such callers.

I think you argued elsewhere (and I agree) that with multiple push urls,
this information is useful. Which means that the original porcelain
format was perhaps not very well thought-out. :( So we have to choose
now whether to fix it and break compatibility, or leave it broken. If
the former, then we should make sure there are not other design issues
in need of fixing, so we can just break compatibility _once_.

> @@ -1071,7 +1071,8 @@ int transport_push(struct transport *transport,
>  		}
>  
>  		if (!quiet && !ret && !refs_pushed(remote_refs))
> -			fprintf(stderr, "Everything up-to-date\n");
> +			fprintf(porcelain ? stdout : stderr,
> +				"Everything up-to-date\n");
>  		return ret;
>  	}

This one, on the other hand, seems to me to be just noise. What does a
--porcelain caller learn by seeing "Everything up-to-date" that it did
not already know from seeing the list of refs?

-Peff

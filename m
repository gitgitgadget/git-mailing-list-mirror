From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: allow --follow-tags to be set by config
 push.followTags
Date: Mon, 16 Feb 2015 00:20:49 -0500
Message-ID: <20150216052049.GA5031@peff.net>
References: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:20:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNE76-0007y1-O2
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbbBPFUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:20:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:49357 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751018AbbBPFUw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:20:52 -0500
Received: (qmail 6877 invoked by uid 102); 16 Feb 2015 05:20:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Feb 2015 23:20:52 -0600
Received: (qmail 12006 invoked by uid 107); 16 Feb 2015 05:20:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:20:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 00:20:49 -0500
Content-Disposition: inline
In-Reply-To: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263869>

On Sun, Feb 15, 2015 at 07:01:30PM -0800, Dave Olszewski wrote:

> +push.followTags::
> +	If set to true enable '--follow-tags' option by default.  You
> +	may override this configuration at time of push by specifying
> +	'--no-follow-tags'.

Thanks, this is something I've considered implementing myself, as I have
one repo that is frequently migrating tags from one remote to another,
and I often forget to specify the option.

> diff --git a/builtin/push.c b/builtin/push.c
> index fc771a9..47f0119 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -525,6 +525,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  
>  	packet_trace_identity("push");
>  	git_config(git_push_config, NULL);
> +
> +	/* set TRANSPORT_PUSH_FOLLOW_TAGS in flags so that --no-follow-tags may unset it */
> +	if (push_follow_tags)
> +		flags |= TRANSPORT_PUSH_FOLLOW_TAGS;

You can see above that we use git_push_config to load our config...

> --- a/config.c
> +++ b/config.c
> @@ -977,6 +977,11 @@ static int git_default_push_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "push.followtags")) {
> +		push_follow_tags = git_config_bool(var, value);
> +		return 0;
> +	}

But here you are adding to git_default_push_config, which is in another
file.

I'm trying to figure out why git_default_push_config exists at all. The
major difference from git_push_config is that the "default" variant will
get loaded for _all_ commands, not just "push". So if it affected
variables that were used by other commands, it would be needed. But all
it sets is push_default, which seems to be specific to builtin/push.c.

So I suspect it can be removed entirely, and folded into
git_config_push. But that's outside the scope of your patch.

What _is_ in the scope of your patch is that I think the new option you
are adding could go into git_push_config; it is definitely only about
the push command itself. And then you could declare it as:

  static int push_follow_tags;

without having to worry about making it an extern that is available
everywhere.

> diff --git a/transport.c b/transport.c
> index 0694a7c..ff5f63d 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1148,7 +1148,7 @@ int transport_push(struct transport *transport,
>  			match_flags |= MATCH_REFS_MIRROR;
>  		if (flags & TRANSPORT_PUSH_PRUNE)
>  			match_flags |= MATCH_REFS_PRUNE;
> -		if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
> +		if ((flags & TRANSPORT_PUSH_FOLLOW_TAGS))
>  			match_flags |= MATCH_REFS_FOLLOW_TAGS;

This looks like just noise in the diff (I guess leftover from some
debugging you were doing). Is that correct?

-Peff

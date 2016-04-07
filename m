From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: --amend -m '' silently fails to wipe message
Date: Thu, 7 Apr 2016 00:48:37 -0400
Message-ID: <20160407044837.GA28859@sigill.intra.peff.net>
References: <20160406171503.GA2345@dinwoodie.org>
 <20160407044219.GA29710@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Webb <chris@arachsys.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Thu Apr 07 06:49:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao1sr-0002Z0-TN
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 06:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbcDGEsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 00:48:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:45652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbcDGEsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 00:48:41 -0400
Received: (qmail 6348 invoked by uid 102); 7 Apr 2016 04:48:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 00:48:40 -0400
Received: (qmail 23643 invoked by uid 107); 7 Apr 2016 04:48:43 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 07 Apr 2016 00:48:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Apr 2016 00:48:37 -0400
Content-Disposition: inline
In-Reply-To: <20160407044219.GA29710@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290906>

On Thu, Apr 07, 2016 at 12:42:19AM -0400, Jeff King wrote:

> On Wed, Apr 06, 2016 at 06:15:03PM +0100, Adam Dinwoodie wrote:
> 
> > `git commit --amend -m ''` seems to be an unambiguous request to blank a
> > commit message, but it actually leaves the commit message as-is.  That's
> > the case regardless of whether `--allow-empty-message` is specified, and
> > doesn't so much as drop a non-zero return code.
> > 
> > Add failing tests to show this behaviour.
> 
> Hmm. Is it just that we check "message.len", which cannot tell the
> difference between "-m was not given" and "-m was given the empty
> string"?
> 
> IOW, would this fix it?
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 109742e..3cdc44e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -695,7 +695,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		}
>  	}
>  
> -	if (message.len) {
> +	if (have_option_m) {
>  		strbuf_addbuf(&sb, &message);
>  		hook_arg1 = "message";
>  	} else if (logfile && !strcmp(logfile, "-")) {

I guessed that this might have come from the conversion of "message"
form a pointer (which could be NULL) into a strbuf. And indeed, it looks
like f956853 (builtin-commit: resurrect behavior for multiple -m
options, 2007-11-11) did that.

There are a few other checks for "message.len" which probably should be
using "have_option_m". E.g.:

 $ git commit -F /dev/null -m foo
 fatal: Option -m cannot be combined with -c/-C/-F/--fixup.

 $ git commit -F /dev/null -m ''
 On branch master
 nothing to commit, working directory clean

-Peff

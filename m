From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Thu, 4 Feb 2016 06:13:07 -0500
Message-ID: <20160204111307.GA30495@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, szeder@ira.uka.de,
	Junio C Hamano <gitster@pobox.com>, tr@thomasrast.ch
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:13:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRHqf-0004KS-TR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 12:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933559AbcBDLNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 06:13:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:37409 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932869AbcBDLNK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 06:13:10 -0500
Received: (qmail 26685 invoked by uid 102); 4 Feb 2016 11:13:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 06:13:10 -0500
Received: (qmail 2001 invoked by uid 107); 4 Feb 2016 11:13:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 06:13:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 06:13:07 -0500
Content-Disposition: inline
In-Reply-To: <56B32953.2010908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2016 at 11:34:59AM +0100, Sebastian Schuberth wrote:

> This avoids output like
> 
>     warning: ignoring broken ref refs/remotes/origin/HEAD
> 
> while completing branch names.

Hmm. I feel like this case (HEAD points to a branch, then `fetch
--prune` deletes it) came up recently and we discussed quieting that
warning. But now I cannot seem to find it.

Anyway, I this is a reasonable workaround. Errors from bash completion
scripts are almost always going to be useless and get in the way of
reading your own prompt.

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 15ebba5..7c0549d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -317,7 +317,7 @@ __git_heads ()
>  	local dir="$(__gitdir)"
>  	if [ -d "$dir" ]; then
>  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
> -			refs/heads
> +			refs/heads 2>/dev/null
>  		return

Not really related to your topic, but digging into it caused me to read
b7dd2d2 (for-each-ref: Do not lookup objects when they will not be used,
2009-05-27), which is about making sure for-each-ref is very fast in
completion.

It looks like %(refname:short) is actually kind of expensive:

$ time git for-each-ref --format='%(refname)' refs/tags  >/dev/null

real    0m0.004s
user    0m0.000s
sys     0m0.004s

$ time git for-each-ref --format='%(refname:short)' refs/tags >/dev/null

real    0m0.009s
user    0m0.004s
sys     0m0.004s

The upcoming refname:strip does much better:

$ time git for-each-ref --format='%(refname:strip=2)' refs/tags >/dev/null

real    0m0.004s
user    0m0.000s
sys     0m0.004s

Obviously these are pretty small timings from my git.git with ~600 tags,
but you can see that refname:short really does cost more.  On a more
ridiculous example repository I have with about 10 million refs, the
timings are more like 5s, 66s, 5.5s.

Just thought I'd throw that our there in case any completion people feel
like poking around with it.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] only warn about ambiguous refs if stderr is a tty
Date: Mon, 9 May 2011 04:03:15 -0400
Message-ID: <20110509080315.GA6205@sigill.intra.peff.net>
References: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
 <1304927478-3112-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, steveire@gmail.com,
	felipe.contreras@gmail.com, gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 10:03:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLR8-0004f4-DF
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab1EIIDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 04:03:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41704
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab1EIIDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 04:03:18 -0400
Received: (qmail 6032 invoked by uid 107); 9 May 2011 08:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 04:05:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 04:03:15 -0400
Content-Disposition: inline
In-Reply-To: <1304927478-3112-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173205>

On Mon, May 09, 2011 at 09:51:18AM +0200, Erik Faye-Lund wrote:

> If there's a branch (either local or remote) called 'HEAD'
> commands that take a ref currently emits a warning, no matter
> if the output is going to a TTY or not.
> 
> Fix this by making sure we only output this warning when stderr
> is a TTY. Other git commands or scripts should not care about
> this ambiguity.
> 
> This fix prevents gitk from barfing when given no arguments and
> there's a branch called 'HEAD'.

This feels wrong. Gitk should not care about messages on stderr, for
exactly the reason that they may be harmless warnings (if anything, it
should show them to the user in a dialog).

My understanding is that this is a tcl thing, but I just think it's
insane.

> In 2f8acdb ('core.warnambiguousrefs: warns when "name" is used
> and both "name" branch and tag exists.'), a check for collisions
> of refs was introduced. It does not seem to me like the intention
> was to check HEAD for ambiguty (because the commit talks about
> branches and tags), but it does.
> 
> Because HEAD cannot be disambiguated like branches and tags can,
> this can lead to an annoying warning, or even an error in the case
> of gitk.

This is a separate issue, isn't it? Gitk should probably handle
ambiguous ref warnings better, no matter what the name.  And if
ambiguous HEAD warnings are considered too annoying, they should be
squelched for everyone. I don't personally have an opinion on the
latter, though.

> A branch called HEAD can be 'injected' into another user's repo
> through remotes, and this can cause annoyance (and in the case of
> gitk, brokenness) just by pulling the wrong remote. Yuck.

Can you give an example? If I am fetching your refs into
refs/remotes/$remote/*, how does that create an ambiguity?

> The particular problem of gitk can be fixed by making gitk able
> to parse the warning, and probably forwarding it to the user.
> This strikes me as The Right Thing To Do(tm), but is outside of my
> gitk and TCL/TK skills.

Agreed. And also outside my tcl skills. :)

> One question is if ANY warnings should be output to stderr if it's
> not a TTY. My guess is that there probably are some classes of
> warnings that should, but the vast majority should probably not.

I disagree. If I do:

  git foo 2>errors

I would certainly expect any relevant errors to end up in that file. As
for why I would do that, two cases I can think of offhand are:

  1. Test scripts, which use this extensively.

  2. Sometimes cron jobs will capture chatty output in a file and show
     it only in the case of some error condition.

> Another question is if we should come up with a way of
> disambiguating HEAD. Perhaps having something like 'refs/HEAD'
> will do?

Yeah, if we disambiguate, I would be tempted to say that "HEAD" always
unambiguously refers to "HEAD". And "refs/HEAD" should already
work, no?

> So, to recap: The way I see it, these are our options:
> 
>  1) Discard this specific warning when stderr isn't a TTY (i.e
>     what this patch does)
>  2) Discard all warnings when stderr isn't a TTY
>  3) Make gitk understand and forward warnings to the user
>  4) Have gitk explicitly ignore ambiuous refs
>  5) Come up with a way to disambiguate HEAD, and use that instead
>     by default
>  6) Force HEAD to never be ambiguous
>  7) Leave things as they are

> 
> I think 3) + 5) might be the most sane solution.

Agreed.

> diff --git a/sha1_name.c b/sha1_name.c
> index faea58d..c7e855e 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -391,7 +391,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  	if (!refs_found)
>  		return -1;
>  
> -	if (warn_ambiguous_refs && refs_found > 1)
> +	if (warn_ambiguous_refs && refs_found > 1 && isatty(2))
>  		warning(warn_msg, len, str);
>  

I think I have made it clear that I am not in favor of this approach,
but if we were to do it, it is too late to be calling isatty(2) here.
You need to also check pager_in_use(), as we may have redirected stderr
into the pager's pipe.

-Peff

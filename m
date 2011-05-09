From: Jeff King <peff@peff.net>
Subject: Re: 'git checkout -p' is a bit confusing...
Date: Mon, 9 May 2011 06:57:00 -0400
Message-ID: <20110509105700.GC9060@sigill.intra.peff.net>
References: <BANLkTik+VbJZKc1Xwb-3p3HPW-zxanc7HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git mailing list <git@vger.kernel.org>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Mon May 09 12:57:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJO9G-0003i5-Cy
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 12:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1EIK5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 06:57:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36916
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393Ab1EIK5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 06:57:03 -0400
Received: (qmail 7541 invoked by uid 107); 9 May 2011 10:58:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 06:58:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 06:57:00 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTik+VbJZKc1Xwb-3p3HPW-zxanc7HQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173218>

On Mon, May 09, 2011 at 06:05:49AM -0400, John Szakmeister wrote:

> I noticed this a little while back, but thought it may have been my
> own misunderstanding.  I wanted to selectively revert part of a file,
> so I used 'git checkout -p filename'.  Then I needed to edit the hunk,
> and got something like this:
> 
>     # Manual hunk edit mode -- see bottom for a quick guide
>     @@ -236,6 +236,12 @@ int run_add_interactive(const char *revision,
> const char *patch_mode,
>             }
>             args[ac] = NULL;
> 
>     +        for (i=0; i < ac; i++)
>     +          {
>     +            fprintf(stderr, "%s ", args[i]);
>     +          }
>     +        fprintf(stderr, "\n");
>     +
>     # ---
>     # To remove '+' lines, make them ' ' lines (context).
>     # To remove '-' lines, delete them.
>     # Lines starting with # will be removed.
>     #
>     # If the patch applies cleanly, the edited hunk will immediately be
>     # marked for discarding. If it does not apply cleanly, you will be given
>     # an opportunity to edit again. If all lines of the hunk are removed,
>     # then the edit is aborted and the hunk is left unchanged.
> 
> Since the diff was showing me the forward direction (from the base to
> modified working tree), I expected that when I left the +'s in there,
> that it was going to leave my hunk.  Unfortunately, it discarded my
> hunk.  I can see the text at the bottom, and now it makes sense, but I
> wonder if there's a way to make it so that you can edit the patch to
> look the way you want, and keep those bits (in much the same way as
> 'git add -p' works)?
> 
> I hope that makes sense. :-)

Your mail does make sense. There are basically two ways of looking at a
diff like this:

  1. Is it a patch you want to apply to the working tree, and you want
     to select the parts you like?

or

  2. Is it a change that is in the working tree versus the index, and
     you want to discard or keep the change?

The interactive patch viewer is capable of doing both directions. In
fact, if you do:

  git checkout -p

then it will show you the diff from the index to the working tree and
say "did you want to discard this hunk?" It does a similar thing for
"git checkout -p HEAD". But if you do:

  git checkout -p some-other-commit

then it will say "did you want to apply this hunk?".

Which seems somewhat inconsistent, but mostly does what people mean. But
as you noticed, when you stop saying "take this hunk" versus "discard
this hunk" and move into "edit this hunk", the "discard" direction seems
more counter-intuitive.

In theory I guess we could flip between the two directions, which is,
after all, more or less what "apply -R" does. So we could be in
"discard" mode, but when somebody wants to "e"dit the patch, it would
always be in "take the parts you _like_" mode. I have a nagging feeling
that there may be some corner case that doesn't reverse properly, but I
haven't thought too long about it.

-Peff

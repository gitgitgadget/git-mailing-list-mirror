From: Jeff King <peff@peff.net>
Subject: Re: git apply: git diff header lacks filename information for git
	diff --no-index patch
Date: Sun, 5 Oct 2008 15:17:28 -0400
Message-ID: <20081005191728.GA6173@coredump.intra.peff.net>
References: <500f3d130810021127j570bb540p901f6a73f58a6cb1@mail.gmail.com> <20081004041714.GA12413@coredump.intra.peff.net> <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:18:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZ7v-0004gU-7v
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbYJETRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755801AbYJETRd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:17:33 -0400
Received: from peff.net ([208.65.91.99]:2011 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315AbYJETRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:17:32 -0400
Received: (qmail 17031 invoked by uid 111); 5 Oct 2008 19:17:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 15:17:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 15:17:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810040918290.3208@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97523>

On Sat, Oct 04, 2008 at 09:54:36AM -0700, Linus Torvalds wrote:

> Exactly. In order to avoid all the ambiguities, we want the filename to 
> match on the 'diff -' line to even be able to guess, and if it doesn't, we 
> should pick it up from the "rename from" lines (for a git diff), or from 
> the '--- a/filename'/'+++ b/filename' otherwise (if it's not a rename, or 
> not a git diff).
> 
> And being a binary diff, and a creation event, all of this fails.

I wonder if it might have been better for binary diffs, like text diffs,
to contain the "from" and "to" filenames in a similar format. But at
this point I don't think a format change is really worthwhile.

> To make things worse, git has also screwed up the "/dev/null" and 
> prepended the prefix to it, making it even harder to see any patterns to 
> the names. Gaah.

Yes, I noticed that, as well. And obviously it looks bogus, but I
thought I managed to get "git diff" to produce "a/dev/null" on some
otherwise valid input, and so assumed that was something we were able to
work around in applying the patch. But testing again today, I can't seem
to get anything except this broken diff to say "a/dev/null". So probably
I was just mistaken yesterday.

> So I think "git apply" is correct, and "git diff --no-index" is broken.

OK, your reasoning is sound.

> That said, I think git-apply being "correct" is not a great excuse, and we 
> should do the "be liberal in what you accept, conservative in what you 
> generate", and think about how to make git-apply be more willing to handle 
> this case too. 

I think for now we might as well just fix the broken "diff" output. The
only thing generating these broken diffs will be older versions of git,
and such diffs are presumably rare (given that this is the first report
we've seen).

So the only advantage would be to accept rare patches from people with
older git, versus asking them to upgrade to a non-broken git.

> Quite frankly, I should have doen the explicit headers as
> 
> 	"new file " <mode> SP <name>
> 
> instead of
> 
> 	"new file mode " <mode>
> 
> (and same for "deleted file", obviously) and the patch would have been 
> more readable _and_ we'd have avoided this issue. But when I did all that, 
> I didn't even think of binary diffs (they weren't an issue originally). 

Agreed (and I think this is just another form of what I mentioned
above; in my suggestion, we would include the filename on _all_ binary
diffs. In practice, it wouldn't matter in non-creation cases, since we
actually get the "diff --git" line _right_ in those cases :) ).

But again, I don't think it is worth trying to change the format now.

-Peff

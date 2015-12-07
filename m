From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/3] ls-files/dir: use is_git_repo to detect
 submodules
Date: Mon, 7 Dec 2015 16:10:52 -0500
Message-ID: <20151207211052.GG30203@sigill.intra.peff.net>
References: <1449252917-3877-1-git-send-email-a.krey@gmx.de>
 <1449252917-3877-3-git-send-email-a.krey@gmx.de>
 <20151205073744.GC21639@sigill.intra.peff.net>
 <20151206165926.GI22288@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a633j-0001Oa-BT
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbbLGVKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:10:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:38520 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752986AbbLGVKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:10:54 -0500
Received: (qmail 17803 invoked by uid 102); 7 Dec 2015 21:10:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 15:10:54 -0600
Received: (qmail 23486 invoked by uid 107); 7 Dec 2015 21:10:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Dec 2015 16:10:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2015 16:10:52 -0500
Content-Disposition: inline
In-Reply-To: <20151206165926.GI22288@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282126>

On Sun, Dec 06, 2015 at 05:59:26PM +0100, Andreas Krey wrote:

> On Sat, 05 Dec 2015 02:37:44 +0000, Jeff King wrote:
> ...
> > Hrm. Weird. You'd think it would break with the existing code if I do
> > this, then:
> > 
> ...
> > -		(cd a/b/c; git init) &&
> > +		(cd a/b/c; git init && git commit --allow-empty -m foo) &&
> >  		git config remote.origin.url ../foo/bar.git &&
> >  		git submodule add ../bar/a/b/c ./a/b/c &&
> 
> I tried a -f here instead; did not work either.
> 
> I guess I will first wade through the other failures my 'fix'
> causes to see the total damage.

The only other one I saw was in the completion tests. And it looked like
`git add` failing in a way similar to what I dug into here. So I think
it's "just" the one bug.

> > We know it is a git dir, but there is no sha1 for us to actually add as
> > the gitlink entry.
> > 
> > If that is the case, then there is either some very tricky refactoring
> > required,
> 
> Yes, it looks like the return code delivered need to be slightly different
> dependent on the user.

Maybe. From your patch it looks like the "git-add" code will return it
as "untracked". Which makes sense if we then want to add it. But if it
has no HEAD commit we _cannot_ add it, as we have no sha1 to stick in
the index. It should probably be ignored totally in that case.

But that means you have to actually find out if HEAD is valid or not.
Which is what the current code is doing. :-/

> > or what we are trying to do here is simply wrong. Maybe it
> > would be simpler to just speed up resolve_gitlink_ref with a better data
> > structure.
> 
> Which is what I did on square one, but now we already have a real fix
> for git clean, and now it's even less advantageous the fix the consequence
> (the submodule cache blowing up) instead of the cause (asking for it
> in the first place).

I think "clean" is a much simpler case. It only wants to know "can I
skip this entry as an untracked sub-repo?". And that is similar to what
"git status" or "git ls-files" wants to know. But "git add" wants to
know "can I _add_ this entry to the index", and that is a different
question (but I think answered by the same code that powers ls-files).

> PS: I seem to not quite have send-email under control, the envelope from
>     seems to made the patches not reach the mailing list (nor me in the CC).

Hmm, yeah. Obviously they made it to me directly, but the list is a
little bit picky.

-Peff

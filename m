From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc3
Date: Thu, 29 Mar 2012 18:11:54 -0400
Message-ID: <20120329221154.GA1413@sigill.intra.peff.net>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDNZc-0005Ox-9d
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 00:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760034Ab2C2WL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 18:11:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39744
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab2C2WL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 18:11:58 -0400
Received: (qmail 7148 invoked by uid 107); 29 Mar 2012 22:11:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Mar 2012 18:11:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2012 18:11:54 -0400
Content-Disposition: inline
In-Reply-To: <7vbonfqezs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194299>

On Thu, Mar 29, 2012 at 02:22:31PM -0700, Junio C Hamano wrote:

> > Did we decide that "upstream" will be the new rule in future versions? I
> > still have some misgivings about that (versus "current"), but I thought
> > the only decision we were settling now was whether to change at all.
> 
> I counted the AOL me-too on "upstream" vs "current" ;-)

I did, too, but as you are so fond of reminding us, this is not a
democracy. :)

> Seriously speaking, I think we have enough time to make sure that
> "upstream" errors out with an appropriate advice when:
> 
>  - The user says "git push" (no remote, no refspec) on a branch without
>    any tracking set; or
> 
>  - The user says "git push $remote" (either remote nick or url, no
>    refspec) when there is no "remote.$remote.push" and the current branch
>    does not have tracking set to that remote (includes the cases where it
>    does not have any tracking set, and where it has tracking set to
>    different remote).

Right. This was one of my two concerns: many upstream corner cases do not
currently make sense, and before we switch to it as a default, those
bugs need to be dealt with. And I think that refusing to push in those
cases is the right thing.

But I would withhold a decision on "upstream" versus "current" until
those bugs are ironed out, because what people think of as "upstream"
(today's current behavior)  may not be exactly what it ends up as.
In particular, the common beginner workflow of:

  $ git clone ...
  $ git checkout -b topic
  $ hack hack hack
  $ git push

would error out (whereas with "current", it would do something
reasonably sane and predictable). The "upstream" push default relies on
the upstream config being set up in a sane way, but in my experience,
that does not always happen in every workflow.

> The "easy to understand for beginners" explanation for "upstream" becomes:
> 
>   Nothing is pushed until you explicitly say what is pushed where, and you
>   can say that by either:
> 
>    - setting remote.$remote.push;
>    - setting branch.$current.merge; or
>    - saying it on the command line.

Or "git has set up branch.$current.merge for you already". The second of
my two concerns is that this:

  $ git clone ...
  $ git checkout -b topic origin/master
  $ hack hack hack
  $ git push

will try to implicitly fast-forward merge your commits onto master. Some
people have said they really like that behavior, but I think it can be a
bit surprising for beginners.

Anyway, I didn't exactly want to re-open the upstream versus current
debate at this point (and actually, I think a hybrid "do nothing unless
upstream and current would agree on the behavior, and give copious
advice" approach might be the best thing). I just wanted to make sure
things were still open for consideration, and was concerned that we are
creating false expectations by putting "upstream" into the release
notes.

-Peff

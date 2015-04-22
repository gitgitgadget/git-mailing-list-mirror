From: Jeff King <peff@peff.net>
Subject: Re: How do I resolve conflict after popping stash without adding the
 file to index?
Date: Wed, 22 Apr 2015 15:55:13 -0400
Message-ID: <20150422195513.GC27656@peff.net>
References: <5535697E.2030204@yandex.ru>
 <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
 <553583C0.6090404@yandex.ru>
 <20150421212922.GC13230@peff.net>
 <5536D099.1000103@yandex.ru>
 <20150421225228.GB26322@peff.net>
 <xmqqa8y0f4cv.fsf@gitster.dls.corp.google.com>
 <20150422183540.GC3535@peff.net>
 <xmqq8udkdk1a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0jz-0006Yp-LP
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbbDVTzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:55:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:48803 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750747AbbDVTzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:55:16 -0400
Received: (qmail 13272 invoked by uid 102); 22 Apr 2015 19:55:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:55:15 -0500
Received: (qmail 13501 invoked by uid 107); 22 Apr 2015 19:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:55:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 15:55:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8udkdk1a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267628>

On Wed, Apr 22, 2015 at 12:45:21PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Ironically, the message before e0e2a9c actually recommends staging
> > changes before applying the stash, which would lead to this exact
> > situation!
> 
> The ancient history is hazy to me, but did we fall back to three-way
> merge in old days (or did anything to the index for that matter), I
> wonder?  In a world "git stash apply" only applied the change to the
> working tree via "git apply", that old recommendation would make
> perfect sense.

Hmm, that advice came in 2a79d2f (Clarify how the user can satisfy
stash's 'dirty state' check., 2008-09-29), at which point it looks like
we were already running merge-recursive. So I think it was simply bad
advice. ;)

> But obviously we do not live in such a world right now.  And because
> we are doing "merge-recursive", we should insist on a clean index;
> otherwise there is no way to "undo" its effect without losing the
> changes by the end-user.

Yeah, agreed.

> > but it makes me wonder if somebody would find it annoying that they
> > cannot apply a stash into their work-in-progress (i.e., it _might_ cause
> > annoyance, but most of the time it will be convenient to do so).
> 
> They can always do "git stash show -p stash@{n} | git apply" if they
> want to build changes incrementally X-<, but it would be annoying.

I think the best thing to do is introduce this safety, let it cook for a
while, and see what comes up. Perhaps we could add a "--force" or
similar, but I'd rather see if anybody ever actually runs into the
situation first.

> > So probably we'd want to refactor that into two separate functions, and
> > only call the require_clean_index part.
> 
> Hmph, but what would that helper do, other than a single "diff-index
> --quiet --cached HEAD" call?

I was wanting to keep the error message and the flags we feed to
diff-index consistent. But yeah, there is little enough duplicate
material and enough added boilerplate that I do not think it is worth it
(see the series I just posted).

-Peff

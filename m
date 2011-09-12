From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: avoid quadratic loop checking for updated
 submodules
Date: Mon, 12 Sep 2011 18:49:34 -0400
Message-ID: <20110912224934.GA28994@sigill.intra.peff.net>
References: <20110912195652.GA27850@sigill.intra.peff.net>
 <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3FK1-0002CR-18
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 00:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab1ILWtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 18:49:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55622
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753689Ab1ILWtg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 18:49:36 -0400
Received: (qmail 19169 invoked by uid 107); 12 Sep 2011 22:50:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Sep 2011 18:50:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2011 18:49:34 -0400
Content-Disposition: inline
In-Reply-To: <7vr53l5u7h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181242>

On Mon, Sep 12, 2011 at 02:25:38PM -0700, Junio C Hamano wrote:

> > +static void calculate_changed_submodule_paths() {
> 
> Locally fixed while queueing; no need to resend:
> 
>         static void calculate_changed_submodule_paths(void)
>         {

Oops, thanks. Old habits die hard, I guess. :)

> I initially thought "eh, what if we have very many refs that may not fit
> on the command line", but this is running the internal rev-list, so there
> is no such issue.
> 
> I however have to wonder if the use of object flags done by this revision
> walking need to be cleared to prevent them from interfering with the
> ancestry walking done in find_common(). Shouldn't this be done in a
> subprocess "rev-list" that is fed these positive and negative refs from
> its standard input?

Maybe. I haven't noticed any such breakage. I don't know if it's because
it's not there, or we don't have sufficient test cases. But if it were a
problem, it would be pretty severe, wouldn't it? The traversal is done
whether you actually have submodules or not, so lots of people should be
seeing it.

I tried to keep the patch as minimal as possible.  If I were writing
from scratch, I think my strategy would be to actually start a
traversal, and mark the commit objects themselves as we find them. I.e.,
the two steps would be:

  - start a traversal
  - for each existing ref
    - lookup_commit_reference, mark as SEEN
  - for each new commit we fetched
    - walk commits from $new_sha1 until we hit SEEN, marking each as
      SEEN as we go.

IOW, instead of keeping "before" and "after" lists, just mark the
commits. But that perhaps exacerbates the protential problem you
mentioned (though we could maybe just use a different flag than SEEN).

To be honest, the whole submodule recursion thing seems a bit confusing
to me. We walk every commit we just fetched looking for it to introduce
a change in a submodule. But we don't actually remember the sha1 it
changed to. And even if we did, we can't just ask a remote for a sha1,
anyway. So with a set of changes like:

  [assume submodule at commit A, superproject at commit B]

  1. Make commit C in submodule repo.

  2. Make commit D in superproject repo.

  3. Make commit E in submodule repo.

  4. Make commit F in superproject repo.

what does it buy us to find out that the submodule changed from "A" to
"C"? We can't actually fetch it. We can only fetch the tips of the
submodule and hope that they include everything we wanted (i.e., both C
and E; which might not be the case of E rewound and is not a descendant
of C).

So since we must accept that we can't necessarily get every intermediate
step, I wonder if we are simply better off diffing the "before" and
"after" state of a particular ref, rather than traversing. It's way
cheaper, and is just as likely to give us the same information (i.e.,
which submodule paths had changed commits). It can be fooled by rewinds,
too, of course:

  1. Make commit C in submodule repo.

  2. Make commit D in superproject repo.

  3. Rewind submodule repo back to A.

  4. Make commit E in superproject repo.

But in that case, you probably can't get commit "C" from the submodule
anyway, so knowing about it is unlikely to help.

I dunno. Maybe there is more going on. This is the first time I've
looked at the problem.

Also also. I was a little turned off by the fact that every fetch is
going to do the equivalent of "git log --raw -m $new --not $old",
whether you have submodules or not. If you fetch a lot of history, this
is a non-trivial price to pay. Is there some way we can detect whether
submodules are being used at all, and not even bother with this
traversal otherwise? Like checking whether .gitmodules exists? I know
virtually nothing about how submodules work.

-Peff

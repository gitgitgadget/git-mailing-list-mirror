From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] check-ref-format --print: Normalize refnames that
 start with slashes
Date: Mon, 29 Aug 2011 17:27:46 -0400
Message-ID: <20110829212746.GA14299@sigill.intra.peff.net>
References: <1314418364-2532-1-git-send-email-mhagger@alum.mit.edu>
 <1314418364-2532-2-git-send-email-mhagger@alum.mit.edu>
 <4E58710B.60507@alum.mit.edu>
 <7vty92adv0.fsf@alter.siamese.dyndns.org>
 <20110829185011.GC756@sigill.intra.peff.net>
 <20110829190118.GE756@sigill.intra.peff.net>
 <7vhb50543g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9N4-0005bd-Od
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab1H2V1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:27:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53995
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754974Ab1H2V1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:27:49 -0400
Received: (qmail 20901 invoked by uid 107); 29 Aug 2011 21:28:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 17:28:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 17:27:46 -0400
Content-Disposition: inline
In-Reply-To: <7vhb50543g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180356>

On Mon, Aug 29, 2011 at 01:56:35PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Aug 29, 2011 at 02:50:12PM -0400, Jeff King wrote:
> >
> >>   3. Having better tool support for comparing two sets of commits. The
> >>      ideal interface (to me) for this workflow would be something like:
> >
> > BTW, this discussion is obviously about comparing what was applied
> > upstream with what was submitted, but I think such a tool could have
> > other purposes, too. It should be able to provide a much nicer interdiff
> > between two versions of the same series (e.g., for reviewers looking at
> > a re-roll).
> 
> I agree with it in principle, but I am not going to write one any time
> soon.

Heh. I didn't expect you to. :) I may make an attempt at something, but
I'd be happy if somebody else has ideas, too.

> I think the most difficult case is when the submitter based a fix on
> 'next' or 'pu' and I fixed it up so that it applies to 'maint'. It is not
> trivial to express conflict resolution in such a case, as what your tool
> has to do its work are (1) the original patch that may apply to
> "somewhere" (the tool could ask "am -3" to help it out), and (2) the patch
> that is queued somewhere in 'pu'.

The nastiest part of such a thing is not necessarily comparing the
patches afterwards, but the actual conflicts you have to resolve to
convince "am -3" to apply the patch on "master" in the first place.

Consider this toy example, which accidentally bases a topic off of
"next" instead of "master":

  git init repo &&
  cd repo &&
  perl -le 'print "line $_" for (1..20)' >file &&
  git add file &&
  git commit -m base &&
  git checkout -b next &&
  perl -pi -e 's/10/$& unrelated topic on next/' file &&
  git commit -a -m 'unrelated topic' &&
  git checkout -b our-topic next && # oops!
  perl -pi -e 's/11/$& our topic/' file &&
  git commit -a -m 'our topic' &&
  git format-patch --stdout -1 >patch &&
  git checkout master

Obviously "git am" will fail to apply the patch. You can do it with "am
-3", but get a conflict like:

  ++<<<<<<< HEAD
   +line 10
   +line 11
  ++=======
  + line 10 unrelated topic on next
  + line 11 our topic
  ++>>>>>>> our topic

which is obviously easy to resolve in this toy example, but harder in
the real world (I assume in really hard cases, you just complain to the
submitter to rebase it properly).

But assuming you resolve that properly to:

  line 10
  line 11 our topic

what does the original submitter see? If they try to rebase their topic
onto master, they'll get this pretty sane conflict:

  ++<<<<<<< HEAD
   +line 10
  ++=======
  + line 10 unrelated topic on next
  ++>>>>>>> our topic

I think the tool behavior I outlined in the previous message would
yield:

  diff --git a/file b/file
  --- a/file
  +++ b/file
   line 8
   line 9
  -line 10 unrelated topic on next
  +line 10
   line 11 our topic
   line 12
  Accept this change [y,n,q]?

That is, it would look at the final versions of what each patch
produces, and try to apply the differences from one to the other, and
then use the result to apply on top of our rebase-in-progress.

So really, I think the ugliness of what the submitter would see is no
uglier than what you had to do during "git am". If you make trivial
changes, they'll see trivial changes. If you had to pick apart large
chunks of code into their constituent topics, then that's what the
submitter will see when reviewing the differences.

But note that I didn't actually run the above "this is what my tool
should do" through an actual script. I haven't written anything yet, so
I am just guessing, and there may be more complex cases where it breaks
down.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: jk/tag-contains: stalled
Date: Thu, 5 Aug 2010 15:06:54 -0400
Message-ID: <20100805190653.GA2942@sigill>
References: <7v62zqf23s.fsf@alter.siamese.dyndns.org>
 <20100805001629.GC2901@thunk.org>
 <7vsk2tdnv5.fsf@alter.siamese.dyndns.org>
 <7vhbj9dm6h.fsf@alter.siamese.dyndns.org>
 <20100805173635.GA15760@sigill>
 <7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ted Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 21:07:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh5mg-0008HY-MR
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 21:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759302Ab0HETHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 15:07:05 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59021 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759180Ab0HETG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 15:06:57 -0400
Received: (qmail 30126 invoked by uid 111); 5 Aug 2010 19:06:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.116)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 05 Aug 2010 19:06:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Aug 2010 15:06:54 -0400
Content-Disposition: inline
In-Reply-To: <7vy6ckdhhu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152703>

On Thu, Aug 05, 2010 at 11:47:09AM -0700, Junio C Hamano wrote:

> > The only bad log message should be the final one, which should be
> > dropped anyway. I would recommend just merging the first two for now,
> > and Ted can tweak his core.clockskew manually.
> 
> After re-reviewing the one that is queued, the use of TMP_MARK smelled
> somewhat bad to me.  It is named TMP_ exactly because it is meant to be
> used in a closed callpath---you can use it but you are supposed to clean
> it before you return the control to the caller, so that the caller can
> rely on TMP_MARK absent from any objects.
> 
> Use of UNINTERESTING is similarly not kosher if this were to be used in
> larger context outside of "do 'tags --contains' and exit".  You noted
> these two points in your original RFC patch.

Oops, thanks, I had forgotten that the marks needed to be addressed.
Should I be introducing new flags? We have 27 flag bits, but I would
hate to waste 2 of them.

> Besides, "contains()" is too generic a name to live in commit.h.

I agree it's a pretty generic name. I was trying to make this as generic
as possible, at least within the domain of commits, so it could be a
faster replacement for calls to is_descendant_of. Maybe commit_contains?

> My gut feeling is that it is probably Ok if contains() and its
> recursive helper are moved to builtin/tag.c and are made static, to
> make it clear that this should not be reused outside the current
> context as a generic "contains" function.  It would probably help to
> have a comment at the end of list_tags() to say that TMP_MARK _ought_
> to be cleaned before leaving the function but we don't do that because
> we know it is the last function in the callchain before we exit.

But my intent was to have a generic contains function. I was planning on
applying this to "git branch --contains", as well, but my initial
approach wasn't really any faster than the current code (probably
because the number of branches tends to be small compared to the number
of tags).

In an ideal object-oriented world, the interface would be:

  void contains_init(struct contains_context *c,
                     struct commit_list *needles);
  void contains_check(struct contains_context *c, struct commit *haystack);
  void contains_free(struct contains_context *c);

But for memory use reasons, we don't get our own private copy of each
commit. We can drop the "init" and have a "free" or "clear" which clears
marks on the global commit objects. But you also _must_ use the same
needle list for each contains check, or you will get bogus results
(since the marks are essentially partial cached answers).

I guess we could do:

  static struct commit_list *contains_needles;

  void contains_init(struct commit_list *needles)
  {
          if (contains_needles)
                  die("BUG: somebody else is already checking contains!");
          copy_commit_list(&contains_needles, needles);
  }

  void contains_check(struct commit *haystack)
  {
     /* like contains, but check against our static contains_needles */
  }

  void contains_clear(struct contains_context *c)
  {
          /* free contains_needles list, set it to NULL */
          /* clear commit marks */
  }

> By the way, I wonder why pop_most_recent_commit() with a commit_list,
> which is the usual revision traversal ingredient for doing something like
> this, was not used in the patch, though.  Is it because depth-first was
> necessary?

Yes, it is because of the depth-first nature. The intent is to mark
whole sections of the subgraph as "does not contain". If you can think
of a clever way around that, I would be interested to hear it. The fact
that it is a DFS is why we can possibly perform worse than the current
code (we might follow the wrong branch of a merge all the way down to
the root before realizing the commit in question is on the other side).

-Peff

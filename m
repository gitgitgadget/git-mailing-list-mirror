From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] remote.c: avoid O(m*n) behavior in match_push_refs
Date: Mon, 8 Jul 2013 03:50:09 -0400
Message-ID: <20130708075007.GB25072@sigill.intra.peff.net>
References: <7v7gh7e6mh.fsf@alter.siamese.dyndns.org>
 <1373266931-30391-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, mfick@codeaurora.org,
	bcasey@nvidia.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 09:50:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw6DF-000450-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 09:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483Ab3GHHuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 03:50:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:55323 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000Ab3GHHuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 03:50:11 -0400
Received: (qmail 7647 invoked by uid 102); 8 Jul 2013 07:51:25 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Jul 2013 02:51:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jul 2013 03:50:09 -0400
Content-Disposition: inline
In-Reply-To: <1373266931-30391-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229827>

On Mon, Jul 08, 2013 at 12:02:11AM -0700, Brandon Casey wrote:

> Here is the reroll with an updated commit message that hopefully
> provides a little more detail to justify this change.  I removed
> the use of the search index in the send_prune block since I think
> that pruning many refs is an uncommon operation and the overhead
> of creating the index will more commonly exceed the benefit of
> using it.

I don't know. I'd think that if you are using pruning, you might delete
a large chunk at one time (e.g., rearranging your ref hierarchy,
followed by "git push --mirror"). But that is just my gut feeling. I
haven't actually run into this slow-down in the real world (we typically
fetch from our giant repositories rather than push into them).

> This version now lazily builds the search index in the first loop,
> so there should be no impact when pushing using explicit refspecs.
> 
> e.g. pushing a change for review to Gerrit
> 
>    $ git push origin HEAD:refs/for/master
> 
> I suspect that this is the most common form of pushing and furthermore
> will become the default once push.default defaults to 'current'.

Nice.

> The remaining push cases can be distilled into the following:
> 
>   ref-count    impact
>   m >= log n   improved with this patch
>   m < log n    regressed with this patch roughly ~6-7%
> 
> So, I think what we have to consider is whether the improvement to
> something like 'git push --mirror' is worth the impact to an asymmetric
> push where the number of local refs is much smaller than the number of
> remote refs.  I'm not sure how common the latter really is though.
> Gerrit does produce repositories with many refs on the remote end in
> the refs/changes/ namespace, but do people commonly push to Gerrit
> using matching or pattern refspecs?  Not sure, but I'd tend to think
> that they don't.

To me it is not about what happens sometimes or not, but about having
runaway worst-case behavior that is unusable. The 6-7% increase (which
is the absolute worst-case measurement we could come up with; in the
real world you would usually transfer actual objects, and connect over
an actual network) is worth it, IMHO.

So I'd be in favor of applying this (possibly covering the send_prune
case, too). If somebody really wants to care about the 6-7%, they can
build on top of your patch with heuristics to avoid indexing in the
small cases.

-Peff

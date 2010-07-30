From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2010, #05; Wed, 28)
Date: Fri, 30 Jul 2010 14:37:09 -0400
Message-ID: <20100730183709.GC18544@coredump.intra.peff.net>
References: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 20:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuSh-0006Zf-Mc
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274Ab0G3ShU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:37:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47968 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933270Ab0G3ShQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:37:16 -0400
Received: (qmail 3658 invoked by uid 111); 30 Jul 2010 18:37:14 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Fri, 30 Jul 2010 18:37:14 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jul 2010 14:37:09 -0400
Content-Disposition: inline
In-Reply-To: <7vvd7zuecv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152257>

On Wed, Jul 28, 2010 at 09:00:16PM -0700, Junio C Hamano wrote:

> --------------------------------------------------
> [Stalled -- would discard unless there are some movements soon]
> [...]
> * jk/tag-contains (2010-07-05) 4 commits
>  - Why is "git tag --contains" so slow?
>  - default core.clockskew variable to one day
>  - limit "contains" traversals based on commit timestamp
>  - tag: speed up --contains calculation

What do we want to do with this?

The first patch by itself produces a pretty big speedup for Ted's case,
and does not impact correctness.  However, it does do a mindless
depth-first search, so there are cases where it can be slower than the
current code (basically, if you never have to go to the roots for your
tagset, then my code will be slower, as it will almost certainly go to
the roots, but it will do so only one time for the whole set, instead of
potentially once per tag).

The second patch by itself is harmless, as the user has to turn it
on explicitly. And the amount of code is quite small, so even if most
people don't use it, I don't think it is a problem.

The third one is where we start defaulting things to "assume no more
than 1 day of clock skew by default", which can cause incorrect answers
in the face of skew.

The fourth is just an illustrative patch for per-repo skew detection.

So if the tradeoff for patch 1 is acceptable, we can merge the first
two. If the tradeoff in patch 3 is acceptable, then we can merge up to
patch 3. The fourth one should be thrown out either way. I can work up a
"detect clock skew on clone and gc" patch based on it if we want to go
that way.

-Peff

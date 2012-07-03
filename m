From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 3 Jul 2012 14:38:40 -0400
Message-ID: <20120703183839.GA5765@sigill.intra.peff.net>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <20120703071940.GB16679@sigill.intra.peff.net>
 <7v3958wvtx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm7zs-0004a6-TP
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756219Ab2GCSin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:38:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52456
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab2GCSin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:38:43 -0400
Received: (qmail 24399 invoked by uid 107); 3 Jul 2012 18:38:50 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jul 2012 14:38:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2012 14:38:40 -0400
Content-Disposition: inline
In-Reply-To: <7v3958wvtx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200929>

On Tue, Jul 03, 2012 at 11:20:10AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, if you feed a partial sha1 for which there are
> > multiple matches, none of which satisfy the disambiguation hint, then we
> > used to say "short SHA1 is ambiguous", and now we don't.
> 
> In finish_object_disambiguation(), if the candidate hasn't been
> checked, there are two cases:
> 
>  - It is the first and only object that match the prefix; or
>  - It replaced another object that matched the prefix but that
>    object did not satisfy ds->fn() callback.
> 
> And the former case we set ds->candidate_ok to true without doing
> anything else, while for the latter we check the candidate, which
> may set ds->candidate_ok to false.

Yeah, I think this is right.

> At this point in the code, ds->candidate_ok can be false only if
> this last-round check found that the candidate does not pass the
> check, because the state after update_candidates() returns cannot
> satisfy
> 
>     !ds->ambiguous && ds->candidate_exists && ds->candidate_checked
> 
> and !ds->canidate_ok at the same time.
> 
> Hence, when we execute this "return", we know we have seen more than
> one object that match the prefix (and none of them satisfied ds->fn),
> meaning that we should say "the short name is ambiguous", not "there
> is no object that matches the prefix".

Right. Per the comment just above your change, we are explicitly "ok"
whether or not we meet the criteria in the hint function if we have seen
only one. Which means the function is entirely about _disambiguating_.
It is never about filtering. Which is a good thing, because it leaves
the semantics of get_sha1 otherwise intact.

> Please sanity check; I think it is just this one-liner, but I am
> having hard time convincing myself that it can be that simple.

It looks right to me (and certainly fixes the behavior I mentioned).

-Peff

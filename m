From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Fri, 10 Jan 2014 04:15:46 -0500
Message-ID: <20140110091546.GA17443@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
 <20140107235850.GC10657@sigill.intra.peff.net>
 <20140108034733.GA17198@sigill.intra.peff.net>
 <52CD36AF.2080705@alum.mit.edu>
 <20140109214926.GA32069@sigill.intra.peff.net>
 <52CFB66D.5070800@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Brodie Rao <brodie@sf.io>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 10 10:16:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1YCO-0004cO-3z
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 10:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbaAJJPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 04:15:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:58294 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751152AbaAJJPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 04:15:48 -0500
Received: (qmail 9592 invoked by uid 102); 10 Jan 2014 09:15:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Jan 2014 03:15:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jan 2014 04:15:46 -0500
Content-Disposition: inline
In-Reply-To: <52CFB66D.5070800@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240298>

On Fri, Jan 10, 2014 at 09:59:25AM +0100, Michael Haggerty wrote:

> > However, is it safe to prime only part of the loose ref namespace?
> [...]
> 
> prime_ref_dir() is called by do_for_each_entry(), which all the
> iteration functions pass through.  It is always called before the
> iteration starts, and it primes only the subtree of the refs hierarchy
> that is being iterated over.  For example, if iterating over
> "refs/heads" then it only primes references with that prefix.
> 
> This is OK, because if later somebody iterates over a broader part of
> the refs hierarchy (say, "refs"), then priming is done again, including
> re-checking the packed refs.

Ah, right. This is the part I was forgetting: the next for_each_ref will
re-prime with the expanded view. Thanks for a dose of sanity.

I'll fix that in my re-roll.

> It would also be possible to swing in the other direction.  I don't
> remember a particular reason why I left the DO_FOR_EACH_INCLUDE_BROKEN
> handling at the do_for_each_ref() level rather than handling it at the
> do_for_each_entry() level.  But now that you are passing the flags
> parameter all the way down the call stack, it wouldn't cost anything to
> support both of the DO_FOR_EACH flags everywhere and just document it
> that way.

I think it was simply that it was an option that the traversal did not
need to know about (just like the "trim" option), so you kept it as
encapsulated as possible. I think I'll introduce it as a separate flag
namespace, as discussed in the previous email. It is the same amount of
refactoring work to merge them later as it is now, if we so choose.

-Peff

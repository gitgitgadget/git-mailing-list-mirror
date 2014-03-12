From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2014, #02; Tue, 11)
Date: Wed, 12 Mar 2014 15:35:09 -0400
Message-ID: <20140312193509.GA1816@sigill.intra.peff.net>
References: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:35:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNovu-0005IV-KG
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008AbaCLTfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:35:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:38267 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752935AbaCLTfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:35:11 -0400
Received: (qmail 29461 invoked by uid 102); 12 Mar 2014 19:35:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 14:35:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 15:35:09 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g80o05g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243970>

On Tue, Mar 11, 2014 at 03:12:11PM -0700, Junio C Hamano wrote:

> * jk/warn-on-object-refname-ambiguity (2014-01-09) 6 commits
>  - get_sha1: drop object/refname ambiguity flag
>  - get_sha1: speed up ambiguous 40-hex test
>  - FIXUP: teach DO_FOR_EACH_NO_RECURSE to prime_ref_dir()
>  - refs: teach for_each_ref a flag to avoid recursion
>  - cat-file: fix a minor memory leak in batch_objects
>  - cat-file: refactor error handling of batch_objects
> 
>  Expecting a reroll.

I finally got a chance to return to this one. Michael had some good
comments on the refactoring that was going on in the middle patches. He
ended with:

  Yes.  Still, the code is really piling up for this one warning for the
  contrived eventuality that somebody wants to pass SHA-1s and branch
  names together in a single cat-file invocation *and* wants to pass
  lots of inputs at once and so is worried about performance *and* has
  reference names that look like SHA-1s.  Otherwise we could just leave
  the warning disabled in this case, as now.  Or we could add a new
  "--hashes-only" option that tells cat-file to treat all of its
  arguments/inputs as SHA-1s; such an option would permit an even faster
  code path for bulk callers.

Having looked at it again, I really think it is not worth pursuing. The
end goal is not that interesting, there is a lot of code introduced, and
a reasonable chance of accidentally introducing regressions and/or
making the code less maintainable.  Keeping the existing code (which
just disables the check for cat-file) is probably the sanest course of
action. We can do a similar thing for "rev-list --stdin" if we want, or
we can wait until somebody complains.

The bottom two patches are reasonable cleanups we should keep, though
(and the rest can just be discarded).

-Peff

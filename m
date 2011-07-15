From: Jeff King <peff@peff.net>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Fri, 15 Jul 2011 17:20:59 -0400
Message-ID: <20110715212059.GA2117@sigill.intra.peff.net>
References: <4E1E97C3.3030306@alum.mit.edu>
 <4E1EB5E9.1070902@alum.mit.edu>
 <4E200611.9010005@alum.mit.edu>
 <7vlivz1inu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 23:21:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qhpor-00071Y-Kn
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 23:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786Ab1GOVVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 17:21:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50262
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752441Ab1GOVVD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 17:21:03 -0400
Received: (qmail 27286 invoked by uid 107); 15 Jul 2011 21:21:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Jul 2011 17:21:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jul 2011 17:20:59 -0400
Content-Disposition: inline
In-Reply-To: <7vlivz1inu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177236>

On Fri, Jul 15, 2011 at 11:51:49AM -0700, Junio C Hamano wrote:

> But I think the replace-object codepath should be optimized to realize
> there is no funky replacement (which _is_ a rare configuration) going on
> much early so that it does not incur that much overhead you observed. IOW,
> I tend to agree with your 3. below.
> [...]
> > 3. Optimize the specific case where there is no refs/replace
> > directory--if this directory is missing, then defer populating the loose
> > refs cache in the hope that it will never be needed.

It already tries to do so. It looks like it calls:

  for_each_replace_ref(...)

which calls:

  do_for_each_ref("refs/replace", ...)

which reads _every_ loose ref, regardless of the prefix we have given
it. So the optimization should go into the for_each_ref code, which
should avoid looking at parts of the hierarchy that are just going to be
culled, no?

And then we would see immediately that there is no refs/replace at all,
and quit early. And as a bonus, things like "for_each_tag_ref" would get
faster in a repository with many branches, too.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/5] refs: teach for_each_ref a flag to avoid recursion
Date: Thu, 9 Jan 2014 16:55:36 -0500
Message-ID: <20140109215536.GB32069@sigill.intra.peff.net>
References: <20140107235631.GA10503@sigill.intra.peff.net>
 <20140107235850.GC10657@sigill.intra.peff.net>
 <20140108034733.GA17198@sigill.intra.peff.net>
 <xmqqa9f5avs3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 22:55:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1NZr-0008E4-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 22:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600AbaAIVzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 16:55:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:58023 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757500AbaAIVzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 16:55:38 -0500
Received: (qmail 8922 invoked by uid 102); 9 Jan 2014 21:55:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jan 2014 15:55:38 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jan 2014 16:55:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa9f5avs3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240276>

On Thu, Jan 09, 2014 at 09:51:24AM -0800, Junio C Hamano wrote:

> > On Tue, Jan 07, 2014 at 06:58:50PM -0500, Jeff King wrote:
> >
> >> +			if (flags & DO_FOR_EACH_NO_RECURSE) {
> >> +				struct ref_dir *subdir = get_ref_dir(entry);
> >> +				sort_ref_dir(subdir);
> >> +				retval = do_for_each_entry_in_dir(subdir, 0,
> >
> > Obviously this is totally wrong and inverts the point of the flag. And
> > causes something like half of the test suite to fail.
> >
> > Michael was nice enough to point it out to me off-list, but well, I have
> > to face the brown paper bag at some point. :) In my defense, it was a
> > last minute refactor before going to dinner. That is what I get for
> > rushing out the series.
> 
> And perhaps a bad naming that calls for double-negation in the
> normal cases, which might have been less likely to happen it the new
> flag were called "onelevel only" or something, perhaps?

That may be a nicer name, but it was not the problem here. The problem
here is that I wrote:

  if (flags & DO_FOR_EACH_NO_RECURSE == 0)

to avoid the extra layer of parentheses, but of course that doesn't
work. And then when I switched it back, I screwed up the reversion.

I think the nicest way to write it would be to avoid negation at all,
as:

  if (flags & DO_FOR_EACH_RECURSE) {
     ... do the recursion ...

but that means flipping the default, requiring us to set the flag
explicitly in the existing callers (though there really aren't that
many).

-Peff

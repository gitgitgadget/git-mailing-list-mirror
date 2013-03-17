From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-refs: add fully-peeled trait
Date: Sun, 17 Mar 2013 02:04:08 -0400
Message-ID: <20130317060408.GE16070@sigill.intra.peff.net>
References: <20130316090018.GA26708@sigill.intra.peff.net>
 <20130316090116.GB26855@sigill.intra.peff.net>
 <51447C5E.3050808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Mar 17 07:04:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6hy-0004yo-0z
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 07:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3CQGEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 02:04:11 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54054 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab3CQGEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 02:04:11 -0400
Received: (qmail 7091 invoked by uid 107); 17 Mar 2013 06:05:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 02:05:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 02:04:08 -0400
Content-Disposition: inline
In-Reply-To: <51447C5E.3050808@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218338>

On Sat, Mar 16, 2013 at 03:06:22PM +0100, Michael Haggerty wrote:

> >  		refname = parse_ref_line(refline, sha1);
> >  		if (refname) {
> > -			last = create_ref_entry(refname, sha1, flag, 1);
> > +			/*
> > +			 * Older git did not write peel lines for anything
> > +			 * outside of refs/tags/; if the fully-peeled trait
> > +			 * is not set, we are dealing with such an older
> > +			 * git and cannot assume an omitted peel value
> > +			 * means the ref is not a tag object.
> > +			 */
> > +			int this_flag = flag;
> > +			if (!fully_peeled && prefixcmp(refname, "refs/tags/"))
> > +				this_flag &= ~REF_KNOWS_PEELED;
> > +
> > +			last = create_ref_entry(refname, sha1, this_flag, 1);
> >  			add_ref(dir, last);
> >  			continue;
> >  		}
> 
> I have to admit that I am partial to my variant of this code [1] because
> the logic makes it clearer when the affirmative decision can be made to
> set the REF_KNOWS_PEELED flag.  But this version also looks correct to
> me and equivalent (aside from the idea that a few lines later if a
> peeled value is found then the REF_KNOWS_PEELED bit could also be set).

Yeah, I think they are equivalent, but I agree yours is a little more
readable. I'll switch it in my re-roll, and I will go ahead and set the
REF_KNOWS_PEELED bit when we see a peel line. That code should not be
triggered in general, but it is the sane thing for the reader to do, so
it makes the code more obvious and readable.

-Peff

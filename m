From: Jeff King <peff@peff.net>
Subject: Re: regression in multi-threaded git-pack-index
Date: Tue, 19 Mar 2013 06:33:06 -0400
Message-ID: <20130319103306.GA9490@sigill.intra.peff.net>
References: <20130315224240.50AA340839@wince.sfo.corp.google.com>
 <20130316114118.GA1940@sigill.intra.peff.net>
 <87fvzrajmr.fsf@pctrast.inf.ethz.ch>
 <20130319093034.GA29997@sigill.intra.peff.net>
 <20130319095943.GA6031@sigill.intra.peff.net>
 <20130319100800.GA6341@sigill.intra.peff.net>
 <20130319102422.GB6341@sigill.intra.peff.net>
 <87obef8yy7.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHtrQ-0001Pa-57
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab3CSKdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:33:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58174 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532Ab3CSKdL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:33:11 -0400
Received: (qmail 27477 invoked by uid 107); 19 Mar 2013 10:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Mar 2013 06:34:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Mar 2013 06:33:06 -0400
Content-Disposition: inline
In-Reply-To: <87obef8yy7.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218497>

On Tue, Mar 19, 2013 at 11:29:36AM +0100, Thomas Rast wrote:

> > Ah, indeed. Putting:
> >
> >   fprintf(stderr, "%lu\n", base->obj->delta_depth);
> >
> > before the conditional reveals that base->obj->delta_depth is
> > uninitialized, which is the real problem. I'm sure there is some
> > perfectly logical explanation for why valgrind can't detect its use
> > during the assignment, but I'm not sure what it is.
> 
> That's simply because you would get far too much noise.  It only reports
> an uninitialized value when it actually gets used in a conditional or
> for output (syscalls), which is when they matter.

Would it? I would think any computation you start with an undefined
value would be suspect (and you would want to know about it as soon as
possible, before the tainted value gets output). I was assuming it was a
performance issue or something.

> You can use --track-origins=yes to see where the undefined value came
> from, but it's veeeery slow.

It's pretty slow either way. :) I do have --track-origins on, but the
origin is this:

  objects = xrealloc(objects,
                     (nr_objects + nr_unresolved + 1)
                     * sizeof(*objects));

which is not very helpful. It's _somewhere_ in the list of objects...:)

-Peff

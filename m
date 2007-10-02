From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 01:08:21 -0400
Message-ID: <20071002050820.GA4261@coredump.intra.peff.net>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org> <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org> <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net> <7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 07:08:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcZzj-00053b-Q4
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 07:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbXJBFIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 01:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbXJBFIX
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 01:08:23 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4618 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbXJBFIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 01:08:23 -0400
Received: (qmail 22077 invoked by uid 111); 2 Oct 2007 05:08:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Oct 2007 01:08:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2007 01:08:21 -0400
Content-Disposition: inline
In-Reply-To: <7vsl4up0tf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59657>

On Mon, Oct 01, 2007 at 10:01:16PM -0700, Junio C Hamano wrote:

> > Just to update, I tried using a non-colliding hash for this (at the
> > expense of much memory), and I wasn't able to get things much faster
> > (and certainly not worth the explosion in memory), short of reducing the
> > size of the hash (which is going to reduce the quality of the output).
> > So I am giving up for the time being, but if others are interested in
> > trying to speed things up, I would be happy to discuss ideas.
> 
> Bummer.  You are giving up at the same place I gave up the last
> time.  I was somehow hoping that other people are more clever
> and determined than I was ;-).
> 
> Thanks for trying.

What was so discouraging is that I literally simplified the process to

  for(i = 0; i < HASH_SIZE; i++)
      if(src[i] < dst[i])
        ...

and it spent all of the time on that one conditional.

One approach which I haven't tried but might be promising is to actually
keep each list sorted, and then do a "merge" of the two lists, comparing
as you go. We don't really need to do arbitrary lookups in the hash; we
just need to compare two hash tables at a time. My approach was to be
simple, but have O(HASH_SIZE) comparisons (where HASH_SIZE is on the
order of 2^17), and that's clearly just too big. But with a list merge,
it should be O(n), where n is the actual number of lines in the files
(or binary chunks for the binary case).

-Peff

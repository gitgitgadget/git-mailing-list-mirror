From: Jeff King <peff@peff.net>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 02:55:15 -0500
Message-ID: <20090128075515.GA1133@coredump.intra.peff.net>
References: <7vvds0z1c1.fsf@gitster.siamese.dyndns.org> <7vk58gz04l.fsf@gitster.siamese.dyndns.org> <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org> <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com> <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:56:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5Hv-0003WE-BK
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbZA1HzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbZA1HzT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:55:19 -0500
Received: from peff.net ([208.65.91.99]:47143 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbZA1HzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:55:17 -0500
Received: (qmail 19855 invoked by uid 107); 28 Jan 2009 07:55:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:55:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:55:15 -0500
Content-Disposition: inline
In-Reply-To: <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107502>

On Tue, Jan 27, 2009 at 11:14:56PM -0800, Junio C Hamano wrote:

> I've been toying with an idea for an alternative solution, and need
> somebody competent to bounce it around with.

Well, unfortunately for you, you are stuck with me. ;P

> Here is my work in progress.  It introduces "ignore-missing-negative"
> option to the revision traversal machinery, and squelches the places we
> currently complain loudly and die when we expect an object to be
> available, when the color we are going to paint the object with is
> UNINTERESTING.
> 
> I have a mild suspicion that it may even be the right thing to ignore them
> unconditionally, and it might even match the intention of Linus's original
> code.  That would make many hunks in this patch much simpler.

I'm not sure it is a good idea to do so unconditionally. In the case of
negatives for transferring files, a missed negative is simply a missed
opportunity for optimizing the resulting pack.

But in other cases, it silently gives you the wrong answer.  For
example, consider a history like:

       C--D
      /
  A--B
      \
       E--F

now let's suppose I have everything except 'E'. If I ask for

  git rev-list F..D

then it will not realize that A and B are uninteresting, and I will get
A-B-C-D. I think it is much better for git to complain loudly that it
could not compute the correct answer.

Am I understanding the issue correctly?

-Peff

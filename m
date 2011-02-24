From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] format-patch: rfc2047-encode newlines in headers
Date: Thu, 24 Feb 2011 02:15:35 -0500
Message-ID: <20110224071534.GC16550@sigill.intra.peff.net>
References: <20110223094844.GA9205@sigill.intra.peff.net>
 <20110223095917.GC9222@sigill.intra.peff.net>
 <7vhbbu7792.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: xzer <xiaozhu@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 08:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsVQL-0000jz-D0
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 08:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713Ab1BXHPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 02:15:35 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932508Ab1BXHPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 02:15:34 -0500
Received: (qmail 19694 invoked by uid 111); 24 Feb 2011 07:15:33 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 07:15:33 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 02:15:35 -0500
Content-Disposition: inline
In-Reply-To: <7vhbbu7792.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167776>

On Wed, Feb 23, 2011 at 01:47:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > These should generally never happen, as we already
> > concatenate multiples in subjects into a single line. But
> > let's be defensive, since not encoding them means we will
> > output malformed headers.
> 
> In this particular case, wouldn't it be more conservative and defensive to
> produce malformed headers so that the patch won't leave the
> originator?

No. If you go back to xzer's original mail, the malformed headers didn't
cause messages not to be sent. They just resulted in corrupted and
missing data on the receiver side. I don't think we can rely on any MUA
or MTA having a particular behavior for malformed mail. Some of them may
complain, but many won't.

> I have a suspicion that mailinfo would choke on the output of this
> one, even though I didn't try.

Actually, it does quite well. Without "-k", mailinfo turns it into a
single line, which is what I would expect. With "-k", the info file
contains:

  Author: Jeff King
  Email: peff@peff.net
  Subject: this is a long
  Subject: subject line with
  Subject: many lines in it
  Date: Wed, 23 Feb 2011 11:30:43 -0500

which "git am" turns back into the original multi-line subject.

So I think it's definitely the right thing to do. Not only does it avoid
us generating malformed mail, but because existing mailinfo handles it
sanely, it makes it easy to do a "preserve-newlines" patch on top (which
I'm still not sure is a great idea, but I can see the use in certain
circumstances).

-Peff

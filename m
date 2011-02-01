From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 20:57:36 -0500
Message-ID: <20110201015736.GC2722@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
 <20110131210045.GB14419@sigill.intra.peff.net>
 <alpine.LFD.2.00.1101311621150.8580@xanadu.home>
 <20110131231210.GD14419@sigill.intra.peff.net>
 <AANLkTi=boNXZbryTGFth5igZ771BbTmEKmh7LOxko+T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 02:57:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk5V2-0007RG-7X
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 02:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754283Ab1BAB5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 20:57:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49772 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab1BAB5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 20:57:38 -0500
Received: (qmail 15849 invoked by uid 111); 1 Feb 2011 01:57:38 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 01 Feb 2011 01:57:38 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 20:57:36 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=boNXZbryTGFth5igZ771BbTmEKmh7LOxko+T-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165789>

On Tue, Feb 01, 2011 at 02:00:05AM +0100, Sverre Rabbelier wrote:

> Heya,
> 
> On Tue, Feb 1, 2011 at 00:12, Jeff King <peff@peff.net> wrote:
> > [1] I'd be interested to see how much we can get around that slowness
> > using a notes-cache.
> 
> Do you mean something like a refs/notes/renames namespace in which we
> stick notes on commits indicating that a rename indicated at that
> commit, with an option of the user, after-the-fact, adding this
> information manually?

Yes, without the "option of the user..." bit. Basically just cache the
list of renames for a given commit against its parent (which should be
immutable[1]), under the assumption that it is cheaper to look up the
note than it is to calculate the renames.

But I would make it purely a cache, not some place for users to stick
their own generated rename information (if people really want to do
that, I would much rather see it go into the commit itself as a
pseudo-header).

-Peff

[1] It's technically not immutable if you limit the pathspec, or if you
have non-standard rename options. But you could define some "canonical"
rename set, like all of the pairs found doing rename detection with -M90
when considering the whole set of removed files as sources and added
files as destinations. That would cover the common case of people
running "git log", and then more specialized detection would not use the
cache.

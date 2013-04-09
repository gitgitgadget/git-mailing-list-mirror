From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Using a bit more decoration
Date: Tue, 9 Apr 2013 00:39:39 -0400
Message-ID: <20130409043938.GA31447@sigill.intra.peff.net>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <20130409035126.GA17319@sigill.intra.peff.net>
 <7vsj30tk0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 06:39:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPQLU-0003Gw-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 06:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762574Ab3DIEjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 00:39:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34714 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997Ab3DIEjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 00:39:43 -0400
Received: (qmail 19643 invoked by uid 107); 9 Apr 2013 04:41:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 09 Apr 2013 00:41:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Apr 2013 00:39:39 -0400
Content-Disposition: inline
In-Reply-To: <7vsj30tk0p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220549>

On Mon, Apr 08, 2013 at 09:17:42PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [1] The thing that made me think about this was making a version of
> >     paint_down_to_common that could keep a separate color for each
> >     source, rather than only PARENT1 and PARENT2. That would let us do
> >     the "--contains" traversal in a breadth-first way, but calculate the
> >     answer simultaneously for all sources (i.e., avoid the depth-first
> >     "go to roots" problem that the current "tag --contains" has if you
> >     do not use timestamp cutoffs).
> 
> Yes, show-branch operates independently of rev-list machinery, hence
> can use full set of bits, but the full set of bits in a word is not
> always sufficient and it can be helped greatly with such an unbound
> set of bits machinery.

The tricky part is how to store the index for each commit (or object). I
don't see a way around adding a new field to "struct commit" to do so.
It _might_ be worth it, because that index would be reusable for many
different operations.

I had hoped to do something clever and implicit with the commit pointer,
since we allocate from a pool. For example, if you have pointer X and
know that the pool starts at Y, you can get an index with simple
subtraction. But of course we don't know what the pool is for any given
allocator without searching the pools, which grow linearly with the
number of objects. So it ends up with the same algorithmic complexity as
just searching for the commit in a data structure (albeit with a smaller
constant, since we allocate big chunks of objects).

-Peff

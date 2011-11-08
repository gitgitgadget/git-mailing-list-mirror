From: Jeff King <peff@peff.net>
Subject: Re: Find the size of git push in pre-receive hook
Date: Tue, 8 Nov 2011 00:41:14 -0500
Message-ID: <20111108054114.GB29643@sigill.intra.peff.net>
References: <1320398420796-6962141.post@n2.nabble.com>
 <7vaa8bdax2.fsf@alter.siamese.dyndns.org>
 <CAFx4vfb-ssFXFEy9We7U+5+Fi+QsbcckNOEh1eXbMiqNfkU7jQ@mail.gmail.com>
 <7vboso4hf6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Manigandan S <etc.mani@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeQz-0001Or-3D
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1KHFlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:41:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36076
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab1KHFlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:41:16 -0500
Received: (qmail 1079 invoked by uid 107); 8 Nov 2011 05:41:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 00:41:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 00:41:14 -0500
Content-Disposition: inline
In-Reply-To: <7vboso4hf6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185072>

On Sun, Nov 06, 2011 at 09:42:37PM -0800, Junio C Hamano wrote:

> Manigandan S <etc.mani@gmail.com> writes:
> 
> > Let me explain it in detail, if I was not clear.
> 
> Do not top-post on this list.
> 
> You said you wanted to restrict the size of a push, but what you are
> trying is to restrict the size of a repository after a push. If accepting
> this push will result in your repository go over the quota, the push will
> be denied. Otherwise the push will be accepted.
> 
> If that is the case, how much the resulting repository weighs is what you
> are trying to measure, not the size of _this_ push, i.e. the amount of
> additional data this push will introduce, and "du -s" for the repository
> inside pre-receive-hook is the way to do so.

I'm not sure even "du -s" is a good method. That will tell you how big
this push is right _now_, which is at least a maximum. But most commits,
when packed with other commits, will take up a fraction of that space
due to deltas.

So you might receive a 100K thin pack on the network that git will
explode to a 5 megabyte full pack on disk. Next time you repack, it will
only increase the size of your existing packed data by 100K or so.

If receive-pack actually measured the incoming pack bytes in the thin
pack, that would probably be a more accurate guess (but again, it's
still just a guess).

-Peff

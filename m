From: Jeff King <peff@peff.net>
Subject: Re: Local clone checks out wrong branch based on remote HEAD
Date: Tue, 17 Mar 2009 21:51:58 -0400
Message-ID: <20090318015158.GA32119@coredump.intra.peff.net>
References: <b97024a40903171219k8841508p774d9dc4295a09bc@mail.gmail.com> <alpine.LNX.1.00.0903171530160.19665@iabervon.org> <7viqm7pvkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Tom Preston-Werner <tom@github.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkzG-0007BF-92
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbZCRBwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbZCRBwH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:52:07 -0400
Received: from peff.net ([208.65.91.99]:39870 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754305AbZCRBwG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:52:06 -0400
Received: (qmail 10061 invoked by uid 107); 18 Mar 2009 01:52:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Mar 2009 21:52:12 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2009 21:51:58 -0400
Content-Disposition: inline
In-Reply-To: <7viqm7pvkl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113567>

On Tue, Mar 17, 2009 at 04:40:26PM -0700, Junio C Hamano wrote:

> The first round's protocol extension was not quite backward compatible
> but in a benign way, in that it did not break anything but induced a
> harmless warning from older ls-remote.  The second round did not have such
> flaw but it got a "Yuck". 
> 
>     From: Jeff King <peff@peff.net>
>     Date: Mon, 1 Dec 2008 12:44:15 -0500
>     Message-ID: <20081201174414.GA22185@coredump.intra.peff.net>
>     Subject: Re: [PATCH 5/6 (v2)] upload-pack: send the HEAD information
> 
> I somehow feel that the "Yuck" was addressed not to the patches but to the
> problem the patch needs to address.

Actually, you addressed my original "yuck" as it was a misunderstanding
on my part of how the protocol worked. I did lay out a few further
complaints in:

  http://thread.gmane.org/gmane.comp.version-control.git/102039/focus=102070

To summarize, they were:

  1. sending the server capabilities repeatedly

  2. extensibility of this technique

  3. handling empty clone

I think (1) is something we can just live with. It's a few dozen extra
bytes per symref line. But just look at all the crap a normal HTTP
request sends. ;)

For (2), I think it would work to simply define each NUL-separated field
after the first as an "extra info" slot, and put a header in that slot.
So send something like:

  [0-9a-f]{40} HEAD\0<server capabilities>\0symref refs/heads/master\n

And as we add new "here is something extra about this ref" fields, they
get assigned new headers. Sadly it is too late to do such a thing for
the server capabilities slot, so slot 1 must remain there. But at least
we can keep it open for the future.

For (3), we would have to investigate how badly a 0{40} sha-1 break
current clients (which understand empty clone, but maybe not this new
"branch to be born" syntax). Or maybe it is OK to say "this is the new
way to do empty clone, and everything less than v1.6.3 will not be able
to handle your empty clone" (which is true for everything less than
v1.6.2 or so, anyway).

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] upload-pack: implement protocol extension
	"symbolic-ref"
Date: Sun, 30 Nov 2008 13:02:14 -0500
Message-ID: <20081130180214.GA10375@coredump.intra.peff.net>
References: <1228039053-31099-1-git-send-email-gitster@pobox.com> <1228039053-31099-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 19:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6qdx-0001Ht-8C
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 19:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYK3SCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYK3SCR
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 13:02:17 -0500
Received: from peff.net ([208.65.91.99]:4664 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471AbYK3SCR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 13:02:17 -0500
Received: (qmail 9193 invoked by uid 111); 30 Nov 2008 18:02:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Nov 2008 13:02:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Nov 2008 13:02:14 -0500
Content-Disposition: inline
In-Reply-To: <1228039053-31099-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101980>

On Sun, Nov 30, 2008 at 01:57:29AM -0800, Junio C Hamano wrote:

> Although the new capability is advertised on the first available ref in
> the same way as the other extensions, the way to trigger this extension
> from the receiving end is not by adding it in the first "want" line as
> usual.  Instead, the receiving end sends a "symbolic-ref" request packet
> before the usual sequence of "want" lines.
> 
> This is unfortunate because it forces an extra round trip (receiving end
> sends a "please tell me symbolic-ref" packet, and then upload side sends
> "here are the requested information" packet), but it has to be implemented
> this way because (1) ls-remote may need to ask for this information, in
> which case there is no "want" to be sent; and (2) the transport API
> insists that transport_get_remote_refs() returns the final list, and does
> not allow augmenting what was initially obtained from the call to it by
> later calls to transport_fetch_refs() easily.

Hrm. For (1), could we allow either interaction method? IOW, allow
requesting a symref on the first want line, _or_ by separate "symbolic
ref" packet? That would allow clients who are using "want" to
piggy-back the symref request as an optimization, but not restrict those
that just want to ask for it?

Not being too familiar with the transport code, I can't speak to (2).
But it would be sad to see an internal API shortcoming that we have
_now_ stick us with a crappy protocol _forever_. We can fix the API, but
once the protocol is in the wild, it becomes much harder to change.

> It also is unfortunate that with this change on the server side, older
> clients running "ls-remote" without actually downloading anything will
> trigger "The remote end hung up unexpectedly" error on the uploading side,
> which is annoying even though it is benign.  You can observe it by applying
> only this patch but not the patch to the receiving end and running t5601
> under "sh -x".

And obviously this wouldn't go away with the proposal above, since we'd
still have to be looking for the "tell me this symbolic ref" packet. But
the solution you outlined in 0/5 sounded sane to me (and I think it
definitely needs to be addressed).

-Peff

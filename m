From: Jeff King <peff@peff.net>
Subject: Re: rename a remote does not update pushdefault (v1.9.5)
Date: Mon, 30 Mar 2015 23:52:56 -0400
Message-ID: <20150331035256.GA1408@peff.net>
References: <B2C5B27F9C4A45469123297E3F6BCF0C55DA0AEA07@XMAIL08.UGent.be>
 <xmqq384mxoka.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Duytschaever <Alexander.Duytschaever@UGent.be>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 05:53:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcnEg-0006nt-9M
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 05:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbCaDw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 23:52:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:40162 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750836AbbCaDw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 23:52:58 -0400
Received: (qmail 2750 invoked by uid 102); 31 Mar 2015 03:52:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 22:52:58 -0500
Received: (qmail 20302 invoked by uid 107); 31 Mar 2015 03:53:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 23:53:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 23:52:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqq384mxoka.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266510>

On Mon, Mar 30, 2015 at 12:39:17PM -0700, Junio C Hamano wrote:

> Whichever way you implement "remote rename", you will make half of
> the users happy while making other half unhappy.  One use case will
> be happier if remote.pushdefault is left intact; the other use case
> will be happier if remote.pushdefault is updated.  There are two
> sides to this coin.
> 
> I think the implementation took the most straight-forward path to
> say "we rename everything inside remote.C.* section and adjust the
> refspecs for remote-tracking branches because that is what appear in
> that section"; which allows the first use case and the second use
> case would be just a single "git config remote.pushDefault C" away.

I had a similar thought. But note that we do update "branch.*.remote"
that points to the renamed remote. So it seems inconsistent that we do
not similarly update "branch.*.pushremote". And if we update that, it
seems inconsistent that we do not update "remote.pushdefault".

In other words, we should probably choose to update all references or
none, but we are currently somewhere in between. Of course, the fact
that the code has been in this limbo for so long makes it doubly
awkward, as we do not know what people expect (and what they simply
consider a bug).

So I don't know what the right answer is.

I did take a peek at the code. I don't think updating these variables
would be too hard, but there needs to be some refactoring around
remote.c's pushremote_name.  After calling read_config(), we do not have
a value that exactly corresponds to remote.pushdefault; we overwrite it
with the branch-specific pushremote if there is one.

-Peff

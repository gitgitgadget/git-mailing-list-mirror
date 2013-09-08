From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] upload-pack: send the HEAD information
Date: Sun, 8 Sep 2013 03:22:43 -0400
Message-ID: <20130908072243.GK14019@sigill.intra.peff.net>
References: <20130906155204.GE12966@inner.h.apk.li>
 <20130906155608.GF12966@inner.h.apk.li>
 <xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
 <20130908071359.GJ14019@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 09:22:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZKd-0005WG-BU
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab3IHHWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:22:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:43269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab3IHHWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:22:47 -0400
Received: (qmail 7845 invoked by uid 102); 8 Sep 2013 07:22:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 02:22:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 03:22:43 -0400
Content-Disposition: inline
In-Reply-To: <20130908071359.GJ14019@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234212>

On Sun, Sep 08, 2013 at 03:13:59AM -0400, Jeff King wrote:

> What do you think about teaching git to read extra data after "\0" for
> _every_ ref line? And then ref advertisement might look something like:
> 
>   <sha1> HEAD\0multi_ack thin-pack ... symref=refs/heads/master\n
>   <sha1> refs/heads/master\n
>   <sha1> refs/heads/my-alias\0symref=refs/heads/master
> 
> That would leave us future room for more ref annotations if we should
> want them, and I think (but haven't tested) that existing receivers
> should ignore everything after the NUL.

Meh, elsewhere you said:

  The capability list _could_ be sent more than once, and the
  receiving end is prepared to accept such a stream.  Everything
  learned from an older capability list needs to be forgot and only
  the last one is honored, I think.

and I think you are right. We simply keep a copy of the string the
server sent, and when we see a new one, we free the old and replace it.
So each subsequent ref would have to re-send the whole capability string
(only if it is a symref, but still, it is somewhat ugly).

-Peff

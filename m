From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 18:57:37 -0500
Message-ID: <20151214235736.GA26133@sigill.intra.peff.net>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
 <1450121838-7069-4-git-send-email-sbeller@google.com>
 <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
 <xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <ericsunshine@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 00:57:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8czw-0001rn-Jh
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbbLNX5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:57:40 -0500
Received: from cloud.peff.net ([50.56.180.127]:41732 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932197AbbLNX5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:57:40 -0500
Received: (qmail 32672 invoked by uid 102); 14 Dec 2015 23:57:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 17:57:40 -0600
Received: (qmail 3340 invoked by uid 107); 14 Dec 2015 23:57:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Dec 2015 18:57:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2015 18:57:37 -0500
Content-Disposition: inline
In-Reply-To: <xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282453>

On Mon, Dec 14, 2015 at 03:15:29PM -0800, Junio C Hamano wrote:

> -- >8 --
> From: Stefan Beller <sbeller@google.com>
> Date: Mon, 14 Dec 2015 11:37:13 -0800
> Subject: [PATCH] xread_nonblock: add functionality to read from fds without blocking
> 
> Provide a wrapper to read(), similar to xread(), that restarts on
> EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
> handle polling itself, possibly polling multiple sockets or performing
> some other action.

This makes me wonder why we restart xread() on EAGAIN in the first
place.

On EINTR, sure; signals can come and we want to keep going. But if do
not have non-blocking descriptors, it should never happen, right?

Are we trying to protect ourselves against somebody _else_ giving us a
non-blocking descriptor? In that case we'll quietly spin and waste CPU.
Which isn't great, but perhaps better than returning an error.

-Peff

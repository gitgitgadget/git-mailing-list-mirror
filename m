From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/41] usage.c: move format processing out of die_errno()
Date: Tue, 3 May 2016 00:45:28 -0400
Message-ID: <20160503044528.GA32259@sigill.intra.peff.net>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
 <1462101297-8610-2-git-send-email-pclouds@gmail.com>
 <CAPig+cQhQ2C-gOuQwJ9RBXM7HBBJkWORfRkq-t-PY=vvxgAonA@mail.gmail.com>
 <xmqqlh3stiyt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 06:45:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axSDI-0001Db-AH
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbcECEpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:45:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:60799 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751144AbcECEpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:45:32 -0400
Received: (qmail 10902 invoked by uid 102); 3 May 2016 04:45:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:45:31 -0400
Received: (qmail 22698 invoked by uid 107); 3 May 2016 04:45:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:45:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 00:45:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlh3stiyt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293322>

On Mon, May 02, 2016 at 11:26:02AM -0700, Junio C Hamano wrote:

> Caller supplied buffer would be the way to go when multiple threads
> could be showing errors and warnings, right?
> 
> It would not make too much of a difference for die(), though.

I think it can matter for die(). This is happening above the pluggable
die_routine() layer, so it's possible for an async task to call die()
which will end in pthread_exit(), while the main program is calling
die() to end in regular exit().

I imagine it's exceedingly unlikely, and of course both threads are
dying anyway, but it could result in some pretty weird memory errors.
It's probably worth taking precautions against, especially because it's
to easy to do so.

-Peff

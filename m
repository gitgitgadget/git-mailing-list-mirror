From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 22:14:33 -0500
Message-ID: <20151218031432.GB8467@sigill.intra.peff.net>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
 <56731715.9000509@web.de>
 <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
 <56731E19.7050504@web.de>
 <CAGZ79kYHjH7QgChn6_GU9iLrtyouFQFuMAZKADZofgHjBS73-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 04:14:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9lV9-0004HR-Qf
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 04:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbbLRDOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 22:14:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:44089 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753055AbbLRDOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 22:14:35 -0500
Received: (qmail 10655 invoked by uid 102); 18 Dec 2015 03:14:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 21:14:35 -0600
Received: (qmail 20708 invoked by uid 107); 18 Dec 2015 03:14:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Dec 2015 22:14:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2015 22:14:33 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kYHjH7QgChn6_GU9iLrtyouFQFuMAZKADZofgHjBS73-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282695>

On Thu, Dec 17, 2015 at 12:51:08PM -0800, Stefan Beller wrote:

> > poll() returns -1; errno = EAGAIN /* poll failed. If the fd was OK, the failure may be temporaly,
> >                                     as much as poll() can see.
> >                                     But most probably we run out ouf memory */
> 
> Before this patch we would not have asked poll, but had just a continue here,
> so I think we need to have it here again no matter of the return code
> of the poll.
> 
> If poll determines it is low on memory, this should not make this function fail,
> we can still do as good as we did before by just asking read
> repeatedly again, though?
> 
> So I'd be convinced now we'd want to have:
> 
>     poll(&pfd, 1, -1); /* this is only buying time
>                         for the fd to deliver data, in case it fails
>                         we don't care but just fall back to old
>                         behavior before this patch with busy spinning*/
>     continue;

Right. I think that is the only sensible thing, and your comment
explains perfectly what is going on.

-Peff

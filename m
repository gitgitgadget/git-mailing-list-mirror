From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 15:49:28 -0400
Message-ID: <20150922194927.GA622@sigill.intra.peff.net>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
 <1442875159-13027-3-git-send-email-sbeller@google.com>
 <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
 <5600DF2D.9010202@web.de>
 <CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
 <xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTZH-0003NT-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759569AbbIVTtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:49:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:34730 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758552AbbIVTta (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 15:49:30 -0400
Received: (qmail 28972 invoked by uid 102); 22 Sep 2015 19:49:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Sep 2015 14:49:30 -0500
Received: (qmail 8208 invoked by uid 107); 22 Sep 2015 19:49:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Sep 2015 15:49:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Sep 2015 15:49:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278424>

On Tue, Sep 22, 2015 at 12:45:51PM -0700, Junio C Hamano wrote:

> Jacob Keller <jacob.keller@gmail.com> writes:
> 
> > I don't think this patch actually changes behavior as it stands now. I
> > think Junio's suggestion does. Personally, I'd prefer some sort of
> > warning when you use xread and get EAGAIN or EWOULDBLOCK. I'd rather
> > see it somehow warn so that we can find the bug (since we really
> > really shouldn't be calling xread with a blocking socket, especially
> > if we have xread_noblock or similar as in this series.
> 
> One caveat is that the caller may not know in the first place.
> 
> The last time I checked the existing callers of xread(), there were
> a few that read from a file descriptor they did not open themselves
> (e.g. unpack-objects that read from standard input).  The invoker of
> these processes is free to do O_NONBLOCK their input stream for
> whatever reason.

Yeah. I do not think this is a bug at all; the user might have their
reasons for handing off an O_NONBLOCK pipe. If we take xread() to mean
"try to read from fd until we get a real error, some data, or an EOF",
then it is perfectly reasonable to replace spinning on read() (which we
do now) with a poll() for efficiency. The caller (and the user) does not
have to care, and should not notice; the outcome will be the same.

-Peff

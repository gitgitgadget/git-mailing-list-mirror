From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Thu, 5 Nov 2015 01:51:11 -0500
Message-ID: <20151105065111.GA4725@sigill.intra.peff.net>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
 <1446597434-1740-3-git-send-email-sbeller@google.com>
 <xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
 <563A6C3D.2050805@kdbg.org>
 <xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
 <20151104225618.GA18805@sigill.intra.peff.net>
 <xmqqvb9h8ale.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:52:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuEPm-0003OY-F2
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 07:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033657AbbKEGvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 01:51:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:53173 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1033638AbbKEGvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 01:51:15 -0500
Received: (qmail 19276 invoked by uid 102); 5 Nov 2015 06:51:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 00:51:14 -0600
Received: (qmail 10665 invoked by uid 107); 5 Nov 2015 06:51:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 01:51:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 01:51:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqqvb9h8ale.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280908>

On Wed, Nov 04, 2015 at 06:05:17PM -0800, Junio C Hamano wrote:

> I've always assumed that the original reason why we wanted to set
> the fd to nonblock was because poll(2) only tells us there is
> something to read (even a single byte), and the xread_nonblock()
> call strbuf_read_once() makes with the default size of 8KB is
> allowed to consume all available bytes and then get stuck waiting
> for the remainder of 8KB before returning.
> 
> If the read(2) in xread_nonblock() always returns as soon as we
> receive as much as there is data available without waiting for any
> more, ignoring the size of the buffer (rather, taking the size of
> the buffer only as the upper bound), then there is no need for
> nonblock anywhere.

This latter paragraph was my impression of how pipe reading generally
worked, for blocking or non-blocking. That is, if there is data, both
cases return what we have (up to the length specified by the user), and
it is only when there is _no_ data that we might choose to block.

It's easy to verify experimentally. E.g.:

  perl -e 'while(1) { syswrite(STDOUT, "a", 1); sleep(1); }' |
  strace perl -e 'while(1) { sysread(STDIN, my $buf, 1024) }'

should show a series of 1-byte reads. But of course that only shows that
it works on my system[1], not everywhere.

POSIX implies it is the case in the definition of read[2] in two ways:

  1. The O_NONBLOCK behavior for pipes is mentioned only when dealing
     with empty pipes.

  2. Later, it says:

       The value returned may be less than nbyte if the number of bytes
       left in the file is less than nbyte, if the read() request was
       interrupted by a signal, or if the file is a pipe or FIFO or
       special file and has fewer than nbyte bytes immediately available
       for reading.

     That is not explicit, but the "immediately" there seems to imply
     it.

> So perhaps the original reasoning of doing nonblock was faulty, you
> are saying?

Exactly. And therefore a convenient way to deal with the portability
issue is to get rid of it. :)

-Peff

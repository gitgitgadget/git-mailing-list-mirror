From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Wed, 4 Nov 2015 17:56:18 -0500
Message-ID: <20151104225618.GA18805@sigill.intra.peff.net>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
 <1446597434-1740-3-git-send-email-sbeller@google.com>
 <xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
 <563A6C3D.2050805@kdbg.org>
 <xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed Nov 04 23:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu6yo-000053-4p
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 23:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031293AbbKDW40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 17:56:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:53008 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030473AbbKDW4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 17:56:21 -0500
Received: (qmail 24381 invoked by uid 102); 4 Nov 2015 22:56:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 16:56:20 -0600
Received: (qmail 7657 invoked by uid 107); 4 Nov 2015 22:56:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Nov 2015 17:56:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2015 17:56:18 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280892>

On Wed, Nov 04, 2015 at 01:01:53PM -0800, Junio C Hamano wrote:

> But the symptom does not have to be as severe as a total deadlock to
> be problematic.  If we block B (and other tasks) by not reading from
> them quickly because we are blocked on reading from A, which may
> take forever (in timescale of B and other tasks) to feed us enough
> to satisfy strbuf_read_once(), we are wasting resource by spawning B
> (and other tasks) early when we are not prepared to service them
> well, on both our end and on the other side of the connection.

I'm not sure I understand this line of reasoning. It is entirely
possible that I have not been paying close enough attention and am
missing something subtle, so please feel free to hit me with the clue
stick.

But why would we ever block reading from A? If poll() reported to us
that "A" is ready to read, and we call strbuf_read_once(), we will make
a _single_ read call (which was, after all, the point of adding
strbuf_read_once in the first place).

So even if descriptor "A" isn't non-blocking, why would we block? Only
if the OS told us we are ready to read via poll(), but we are somehow
not (which, AFAIK, would be a bug in the OS).

So I'm not sure I see why we need to be non-blocking at all here, if we
are correctly hitting poll() and doing a single read on anybody who
claims to be ready (rather than trying to soak up all of their available
data), then we should never block, and we should never starve one
process (even without blocking, we could be in a busy loop slurping from
A and starve B, but by hitting the descriptors in round-robin for each
poll(), we make sure they all progress).

What am I missing?

-Peff

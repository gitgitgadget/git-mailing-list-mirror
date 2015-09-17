From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 13:35:37 -0400
Message-ID: <20150917173536.GA28987@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com>
 <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
 <20150917163012.GB25837@sigill.intra.peff.net>
 <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
 <20150917171308.GA28046@sigill.intra.peff.net>
 <CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:35:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcd60-0005TH-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbbIQRfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:35:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:60993 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751371AbbIQRfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:35:39 -0400
Received: (qmail 13839 invoked by uid 102); 17 Sep 2015 17:35:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:35:39 -0500
Received: (qmail 379 invoked by uid 107); 17 Sep 2015 17:35:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 13:35:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 13:35:37 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278149>

On Thu, Sep 17, 2015 at 10:26:19AM -0700, Stefan Beller wrote:

> > If we return -1, though, we have a similar annoyance. If the caller
> > notices a -1 return value and finds EAGAIN, they still may need to check
> > sb->len to see if they made forward progress and have data they should
> > be dealing with.
> 
> If errno == EAGAIN, we know it is a non blocking fd, so we could encode
> the length read as (- 2 - length), such that
> 
> ...-2 the length read if EAGAIN was ignored
> -1 for error, check errno!
> 0 for EOF
> +1... length if we just read it or restarted it due to EINTR.
> 
> The call site should know if it is non blocking (i.e. if the <-2 case can
> happen) and handle it appropriately.

I actually wonder if callers who are _expecting_ non-blocking want to
loop in strbuf_read() at all.

strbuf_read() is really about reading to EOF, and growing the buffer to
fit all of the input. But that's not at all what you want to do with
non-blocking. There you believe for some reason that data may be
available (probably due to poll), and you want to read one chunk of it,
maybe act, and then go back to polling.

You _can_ loop on read until you hit EAGAIN, but I think in general you
shouldn't; if you get a lot of input on this fd, you'll starve all of
the other descriptors you're polling.  You're better off to read a
finite amount from each descriptor, and then check again who is ready to
read.

And then the return value becomes a no-brainer, because it's just the
return value of read(). Either you got some data, you got EOF, or you
get an error, which might be EAGAIN. You never have the case where you
got some data, but then you also got EOF and EAGAIN, and the caller has
to figure out which.

So I think you really want something like:

  ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
  {
	ssize_t cnt;

	strbuf_grow(hint ? hint : 8192);
	cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
	if (cnt > 0)
		strbuf_setlen(sb->len + cnt);
	return cnt;
  }

(where I'm assuming xread passes us back EAGAIN; we could also replace
it with read and loop on EINTR ourselves).

-Peff

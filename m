From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 13:13:08 -0400
Message-ID: <20150917171308.GA28046@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com>
 <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
 <20150917163012.GB25837@sigill.intra.peff.net>
 <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:13:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcckL-0007ri-KX
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbbIQRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:13:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:60962 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751604AbbIQRNL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:13:11 -0400
Received: (qmail 12174 invoked by uid 102); 17 Sep 2015 17:13:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:13:11 -0500
Received: (qmail 32529 invoked by uid 107); 17 Sep 2015 17:13:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 13:13:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 13:13:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278145>

On Thu, Sep 17, 2015 at 09:58:00AM -0700, Junio C Hamano wrote:

> > Certainly anybody who does not realize their descriptor is O_NONBLOCK
> > and is using the spinning for correctness. I tend to think that such
> > sites are wrong, though, and would benefit from us realizing they are
> > spinning.
> 
> With or without O_NONBLOCK, not looping around xread() _and_ relying
> on the spinning for "correctness" means the caller is not getting
> correctness anyway, I think, because xread() does return a short
> read, and we deliberately and explicitly do so since 0b6806b9
> (xread, xwrite: limit size of IO to 8MB, 2013-08-20).

I think they have to loop for correctness, but they may do this:

  if (xread(fd, buf, len) < 0)
	die_errno("OMG, an error!");

which is not correct if "fd" is unknowingly non-blocking. As Stefan
mentioned, we do not set O_NONBLOCK ourselves very much, but I wonder if
we could inherit it from the environment in some cases.

The spinning behavior is not great, but does mean that we spin and
continue rather than bailing with an error.

> > But I think you can't quite get away with leaving strbuf_read untouched
> > in this case. On error, it wants to restore the original value of the
> > strbuf before the strbuf_read call. Which means that we throw away
> > anything read into the strbuf before we get EAGAIN, and the caller never
> > gets to see it.
> 
> I agree we need to teach strbuf_read() that xread() is now nicer on
> O_NONBLOCK; perhaps like this?
> 
>  strbuf.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/strbuf.c b/strbuf.c
> index cce5eed..49104d7 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -368,6 +368,8 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>  
>  		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
>  		if (cnt < 0) {
> +			if (errno == EAGAIN || errno == EWOULDBLOCK)
> +				break;
>  			if (oldalloc == 0)
>  				strbuf_release(sb);
>  			else

If we get EAGAIN on the first read, this will return "0", and I think we
end up in the "was it EOF, or EAGAIN?" situation I mentioned earlier.
If we reset errno to "0" at the top of the function, we could get around
one problem, but it still makes an annoying interface: the caller has to
check errno for any 0-return to figure out if it was really EOF, or just
EAGAIN.

If we return -1, though, we have a similar annoyance. If the caller
notices a -1 return value and finds EAGAIN, they still may need to check
sb->len to see if they made forward progress and have data they should
be dealing with.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 14:02:06 -0400
Message-ID: <20150917180205.GA29985@sigill.intra.peff.net>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
 <1442453948-9885-2-git-send-email-sbeller@google.com>
 <xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
 <20150917163012.GB25837@sigill.intra.peff.net>
 <xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
 <20150917171308.GA28046@sigill.intra.peff.net>
 <xmqqoah1hqxs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 20:02:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdVi-0001W2-Ri
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 20:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbbIQSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 14:02:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:32813 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751371AbbIQSCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 14:02:09 -0400
Received: (qmail 15794 invoked by uid 102); 17 Sep 2015 18:02:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 13:02:08 -0500
Received: (qmail 937 invoked by uid 107); 17 Sep 2015 18:02:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 14:02:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 14:02:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoah1hqxs.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278156>

On Thu, Sep 17, 2015 at 10:54:39AM -0700, Junio C Hamano wrote:

> OK.  Trying to repurpose strbuf_read() for non-blocking FD was a
> silly idea to begin with, as it wants to read thru to the EOF, and
> setting FD explicitly to O_NONBLOCK is a sign that the caller wants
> to grab as much as possible and does not want to wait for the EOF.
> 
> So assuming we want strbuf_read_nonblock(), what interface do we
> want from it?  We could:
> 
>  * Have it grab as much as possible into sb as long as it does not
>    block?
> 
>  * Have it grab reasonably large amount into sb, and not blocking is
>    an absolute requirement, but the function is not required to read
>    everything that is available on the FD (i.e. the caller is
>    expected to loop)?

I think we are crossing emails, but I would definitely argue for the
latter.

> If we choose the latter, then your "EAGAIN? EOF?" becomes easier,
> no?  We only have to do a single call to xread(), and then we:
> 
>  - get EAGAIN or EWOULDBLOCK; leave sb as-is, set errno==EAGAIN and
>    return -1.
> 
>  - get something (in which case that is not an EOF yet); append to
>    sb, return the number of bytes.
> 
>  - get EOF; leave sb as-is, return 0.

Yes, exactly.

> ssize_t strbuf_read_nonblock(struct strbuf *sb, int fd, size_t hint)
> {
> 	strbuf_grow(sb, hint ? hint : 8192);
> 	ssize_t want = sb->alloc - sb->len - 1;
> 	ssize_t got = xread_nonblock(fd, sb->buf + sb->len, want);
> 	if (got < 0) {
> 		if (errno == EWOULDBLOCK)
> 			errno = EAGAIN; /* make life easier for the caller */
> 		return got;
> 	}

I like the normalizing of errno, but that should probably be part of
xread_nonblock(), I would think.

> 	sb->len += got;
> 	sb->buf[sb->len] = '\0';

Use strbuf_setlen() here?

> 	return got;

If "got == 0", we naturally do not change sb->len at all, and the strbuf
is left unchanged. But do we want to de-allocate what we allocated in
strbuf_grow() above? That is what strbuf_read() does, but I think it is
even less likely to help anybody here.  With the original strbuf_read(),
you might do:

  if (strbuf_read(&buf, fd, hint) <= 0)
	return; /* got nothing */

but because the nature of strbuf_read_nonblock() is to call it from a
loop, you'd want to strbuf_release() when you leave the loop anyway.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 16:17:00 -0400
Message-ID: <20090405201700.GC4716@coredump.intra.peff.net>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org> <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com> <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org> <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com> <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:25:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYoT-00084S-2V
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785AbZDEURU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbZDEURU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:17:20 -0400
Received: from peff.net ([208.65.91.99]:56526 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130AbZDEURT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:17:19 -0400
Received: (qmail 17606 invoked by uid 107); 5 Apr 2009 20:17:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 05 Apr 2009 16:17:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2009 16:17:00 -0400
Content-Disposition: inline
In-Reply-To: <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115696>

On Sun, Apr 05, 2009 at 08:31:06PM +0100, Reece Dunn wrote:

> This is what `base64 -d` gives:
> [...]
> It's not "going to be", but "has been so for the last two years since
> 5d23e13".
> 
> It is an assert, and I think Peff's die("BUG: ...") would be a good idea.

Interestingly, I get a bunch of unprintable crap at the end. The culprit
seems to be that vger stupidly adds:

    --
    To unsubscribe from this list: send the line "unsubscribe git" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html

to the bottom, regardless of transfer-encoding. At best, this is
pointless and invisible, as the reader will just show the base64
content. But some decoders (like mutt) actually treat non-base64
characters not as "end of base64" but as "ignore and keep looking for
more base64". So this decodes into a bunch of random characters. And to
make it even more fun, it only happens if the message is a certain
length; otherwise, it needs "=" fill characters at the end, which
unambiguously signal the end.

"openssl base64 -d" stops decoding at the cruft. But I think what mutt
is doing is right. According to RFC 2045:

     The encoded output stream must be represented in lines of no more
     than 76 characters each.  All line breaks or other characters not
     found in Table 1 must be ignored by decoding software.  In base64
     data, characters other than those in Table 1, line breaks, and
     other white space probably indicate a transmission error, about
     which a warning message or even a message rejection might be
     appropriate under some circumstances.

I don't know if it is worth trying to get vger to be smarter. According
to this, they consider base64 text parts not worth handling:

  http://lkml.indiana.edu/hypermail/linux/kernel/0304.0/0901.html

So maybe it is worth trying to get Junio not to send base64 mail. ;)

-Peff

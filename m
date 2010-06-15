From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 07:07:10 -0400
Message-ID: <20100615110710.GA1682@sigill.intra.peff.net>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr>
 <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr>
 <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
 <0091febb4a3832a6680a0fbc2209f841@ensimag.fr>
 <20100615095452.GA32624@sigill.intra.peff.net>
 <aad13a73928536f87879ef7284d6cc75@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: bonneta <bonneta@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 13:07:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOTzR-0002el-0c
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 13:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757462Ab0FOLHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 07:07:16 -0400
Received: from peff.net ([208.65.91.99]:39277 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757456Ab0FOLHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 07:07:14 -0400
Received: (qmail 21648 invoked by uid 107); 15 Jun 2010 11:07:59 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Jun 2010 07:07:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Jun 2010 07:07:10 -0400
Content-Disposition: inline
In-Reply-To: <aad13a73928536f87879ef7284d6cc75@ensimag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149171>

[resending to cc git@vger]

On Tue, Jun 15, 2010 at 12:29:43PM +0200, bonneta wrote:

> We have changed the declaration of textconv_object() to:
> 
> static int textconv_object(const char *path,
>                            const unsigned char *sha1,
>                            char **buf,
>                            unsigned long *buf_size)
> 
> And now we can do:
> *buf_size = fill_textconv(textconv, df, buf);
> without any cast.

I assume you mean dropping the final buf_size parameter from that
declaration, which is what your usage example has. I would return either
an "unsigned long" or a size_t rather than an int. We are dealing with
potential whole-file sizes, so it is better to use at least as large a
data type as other parts of the code (we still may run into truncation
problems, but at least you are not making things any worse).

> But we have to do:
> textconv_object(read_from, null_sha1, &buf.buf, (unsigned long *)
> &buf.len))
> where buf.len is size_t.
> 
> Is that ok?

No, that has the same problem. Imagine a big endian machine with a
32-bit unsigned long and a 64-bit size_t. You would write into the first
32 bits of buf.len, which are the high bits, giving you a ridiculously
large answer.

The only portable way in C to convert between types is by assignment. So
you have to do:

  unsigned long foo;
  textconv_object(read_from, null_sha1, &buf.buf, &foo);
  buf.len = foo;

But now I'm confused. That matches the declaration you gave in the first
part of your email, but not the usage example.

-Peff

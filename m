From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Wed, 4 Jul 2012 02:44:50 -0400
Message-ID: <20120704064450.GA24807@sigill.intra.peff.net>
References: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
 <20120703063511.GA16679@sigill.intra.peff.net>
 <CAGxub4-9E0W8ZgsPHeTyUyxmPD80LUd7NjSezg5Zt2-nZPBMJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: Katsuyama Takeharu <gkatsu.ne@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 08:45:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJKd-0006yP-Un
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 08:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755854Ab2GDGoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 02:44:55 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52802
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840Ab2GDGoy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 02:44:54 -0400
Received: (qmail 30653 invoked by uid 107); 4 Jul 2012 06:45:01 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jul 2012 02:45:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jul 2012 02:44:50 -0400
Content-Disposition: inline
In-Reply-To: <CAGxub4-9E0W8ZgsPHeTyUyxmPD80LUd7NjSezg5Zt2-nZPBMJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200985>

On Wed, Jul 04, 2012 at 03:19:31PM +0900, Katsuyama Takeharu wrote:

> diff --git a/pretty.c b/pretty.c
> --- a/pretty.c
> +++ b/pretty.c
> @@ -272,6 +272,13 @@ static void add_rfc2047(struct strbuf *sb, const char
> *line, int len,
>      static const int max_length = 78; /* per rfc2822 */
>      int i;
>      int line_len;
> +    int utf8_ctr, use_utf8;
> +    const char *utf8_start;
> +
> +    if (is_encoding_utf8(encoding) && encoding != NULL)
> +        use_utf8 = 1;
> +    else
> +        use_utf8 = 0;

I think you can drop the "encoding != NULL" here. If we don't have an
explicit encoding, git always assumes utf8 (also, as it happens we never
hit this point with a NULL encoding in the current code anyway, though
that could in theory change in the future).

> > Can we re-use utf8_width here instead of rewriting these rules?
> 
> Yes you can. But there are an issue which utf8_width seems not to return
> correct value.  It returns 3  even if  a provided code has 3 octet utf-8
> char(e.g. 0xE38292).
> I expect it returns 2.

Hmm. I think I may have led you astray. It seems that the return value
of utf8_width is not about the byte-width of the character
representation, but rather about the intended character-width of the
glyph. But since we are encoding the bytes, we care about the former.

So I think you would really want to use pick_one_utf8_char and see how
many characters it consumed, like this:

  const char *p = &line[i];
  pick_one_utf8_char(&p, NULL);
  if (!p) /* not valid utf8, just assume single byte */
          utf8_ctr = 1;
  else
          utf8_ctr = p - &line[i];

-Peff

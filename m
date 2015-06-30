From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 12:58:33 -0400
Message-ID: <CAPig+cTXc_RXbOAOaF2MFjrg+DSet=g0XQMZY0ErMYAmNVSV+g@mail.gmail.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net>
	<20150629222247.GA31607@flurp.local>
	<20150630102055.GA11928@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:58:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yrt-0004qc-6v
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbbF3Q6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 12:58:35 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35651 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbbF3Q6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:58:34 -0400
Received: by ykdy1 with SMTP id y1so14662567ykd.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0ismkc8MIzXKCW/wP+v+Sc2gulSHP82BZvBMRBu1pFY=;
        b=0y7Wef7bXpzDDEu+UZgfkxvK+RuTlnYdqsvPNLRFcm52DbojiskmVUNA3W5tQI5Kc2
         wYTCJjWgQXWyvui66AhBXzXnrkFHyTgFHf7ic8f0zUu3/5GLGR8oRUaqBpjYiSFqAleT
         BzzY/F4qYMRTXbPFMj4ljVFVDc6iqCFZwhlkqywOhGBr4ka7faZJobBR3RlwhdmuY+kI
         0UGprc3kLzldkp98M4PAwOc5LNtJIAa1J91FoeJKl3dzIu52IUjTxxTULLLd0FU/+5g1
         7CcMwat0kJUyyDR1MWbDYIKOOk1HcfJLqbWAJxDYwpD3Qr7DYoZcNnRi1kaZPdZ3FBRB
         041g==
X-Received: by 10.129.70.69 with SMTP id t66mr12825281ywa.4.1435683513409;
 Tue, 30 Jun 2015 09:58:33 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 09:58:33 -0700 (PDT)
In-Reply-To: <20150630102055.GA11928@peff.net>
X-Google-Sender-Auth: fsRNGaRLFW9xJH3bt7HWpIpGbAk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273081>

On Tue, Jun 30, 2015 at 6:20 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 29, 2015 at 06:22:47PM -0400, Eric Sunshine wrote:
>> void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
>> {
>>       size_t len;
>>       struct strbuf f = STRBUF_INIT;
>>
>>       /*
>>        * This is a bit tricky since strftime returns 0 if the result did not
>>        * fit in the supplied buffer, as well as when the formatted time has
>>        * zero length. In the former case, we need to grow the buffer and try
>>        * again. To distinguish between the two cases, we supply strftime with
>>        * a format string one character longer than what the client supplied,
>>        * which ensures that a successful format will have non-zero length,
>>        * and then drop the extra character from the formatted time before
>>        * returning.
>>        */
>>       strbuf_addf(&f, "%s ", fmt);
>
> Basically I was trying to avoid making any assumptions about exactly how
> strftime works. But presumably "stick a space in the format" is a
> universally reasonable thing to do. It's a hack, but it's contained to
> the function.

I don't think we're making any assumptions about strftime(). POSIX states:

    The format string consists of zero or more conversion
    specifications and ordinary characters. [...] All ordinary
    characters (including the terminating NUL character) are copied
    unchanged into the array.

So, we seem to be on solid footing with this approach (even though
it's a localized hack).

>>       do {
>>               strbuf_grow(sb, 128);
>>               len = strftime(sb->buf + sb->len, sb->alloc - sb->len,
>>                              f.buf, tm);
>>       } while (!len);
>
> I think we need to keep growing this 128 ourselves, or else each loop
> iteration will just say "yup, we have 128 bytes available; no need to
> grow".

Yeah, I toyed with the idea of increasing the requested amount each
iteration but wanted to keep the example simple, thus left it out.
However, for some reason, I was thinking that strbuf_grow() was
unconditionally expanding the buffer by the requested amount rather
than merely ensuring that that amount was availabile, so the amount
clearly needs to be increased on each iteration. Thanks for pointing
that out.

>> If this is performance critical code, then the augmented format
>> string can be constructed with less expensive functions than
>> strbuf_addf().
>
> This does get called a lot (e.g., once per commit). One extra allocation
> would probably not kill us there [...]

Beyond the extra allocation, I was also concerned about the
sledgehammer approach of "%s " to append a single character when there
are much less expensive ways to do so.

> [...] but I think we could fairly trivially put this on the unlikely path:
>
>   size_t hint = 128;
>   size_t len;
>
>   /* optimize out obvious 0-length case */
>   if (!*fmt)
>         return;
>
>   strbuf_grow(sb, hint);
>   len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
>
>   /* maybe not enough room, or maybe 0-length output */
>   if (!len) {
>         struct strbuf f = STRBUF_INIT;
>         strbuf_addf(&f, "%s ", fmt);
>         while (!len) {
>                 hint *= 2;
>                 strbuf_grow(sb, hint);
>                 len = strftime(sb->buf + sb->len, sb->alloc - sb->len, f.buf, tm);
>         }
>   }
>
> I'd guess most cases will fit in 128 bytes and never even hit this code
> path. You could also get fancier and start the buffer smaller, but only
> do the fmt hack when we cross a threshold.

Yep, I toyed with other looping constructs as well before settling
upon do-while in the example for its simplicity. If called often
enough, this sort of optimization seems reasonable enough.

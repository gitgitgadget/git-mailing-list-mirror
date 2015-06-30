From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 10:05:33 -0700
Message-ID: <xmqqr3ot6s9u.fsf@gitster.dls.corp.google.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165545.GC23503@peff.net> <20150629222247.GA31607@flurp.local>
	<20150630102055.GA11928@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:05:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9yyb-0008NR-U1
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbbF3RFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:05:38 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36887 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597AbbF3RFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:05:36 -0400
Received: by igblr2 with SMTP id lr2so17016258igb.0
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 10:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+g/YrupgaysCqqSfGtaTZn3zhF94hu34vW+3tOcIvfw=;
        b=ajWzd6d6TQgCZ44D0lHJH+tP0rlsA+yn7V/BmdhxpTH78BvKNu0TUii2XS1C7Flm5u
         p8Tk8zAXouAUNn98DX5VJTrDBmhv5IeEIExdOr4VjzVmauhQ75eCOitX5dnxfUw4hL5U
         oLinduOacf5JDS60eBs2rmVRyKkYr1KmlH5HWvbk9IXRNJkb/CRjSy9oX9Ib4kDeK1wi
         S5SWt1BhX2FKWtFt2o5frWtuPOu3Zx7RdsFj4Q4/wghQyo5MscSanGwWcmcCjWPkz5pt
         rBCBVFrz0pkeitcX0xrIbznNyl5kRCBSROcVuKkKyNudnqw+Tw2+jdJbXrDcr/O8qbaE
         lT0A==
X-Received: by 10.42.135.69 with SMTP id o5mr27923268ict.47.1435683935424;
        Tue, 30 Jun 2015 10:05:35 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id rr5sm8122974igb.7.2015.06.30.10.05.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 10:05:34 -0700 (PDT)
In-Reply-To: <20150630102055.GA11928@peff.net> (Jeff King's message of "Tue,
	30 Jun 2015 06:20:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273084>

Jeff King <peff@peff.net> writes:

> This does get called a lot (e.g., once per commit). One extra allocation
> would probably not kill us there, but I think we could fairly trivially
> put this on the unlikely path:
>
>   size_t hint = 128;
>   size_t len;
>
>   /* optimize out obvious 0-length case */
>   if (!*fmt)
> 	return;
>
>   strbuf_grow(sb, hint);
>   len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);
>
>   /* maybe not enough room, or maybe 0-length output */
>   if (!len) {
> 	struct strbuf f = STRBUF_INIT;
> 	strbuf_addf(&f, "%s ", fmt);
> 	while (!len) {
> 		hint *= 2;
> 		strbuf_grow(sb, hint);
> 		len = strftime(sb->buf + sb->len, sb->alloc - sb->len, f.buf, tm);
> 	}
>   }
>
> I'd guess most cases will fit in 128 bytes and never even hit this code
> path. You could also get fancier and start the buffer smaller, but only
> do the fmt hack when we cross a threshold.

I'd assume that the "hint" thing will persist across calls somehow?
In an invocation of "git log --date=format:<some format>" for
millions of commits, it is likely that the length of the formatted
date string will stay the same or close to the same (yeah, I know
"Wednesday" would be longer than "Monday").

Answering myself to my earlier question, the reason is because I was
worried what happens when given fmt is a malformed strftime format
specifier.  Perhaps it ends with a lone % and "% " may format to
something unexpected, or something.

Are we checking an error from strftime(3)?

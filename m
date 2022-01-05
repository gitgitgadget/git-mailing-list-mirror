Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B25AC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 07:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiAEHKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 02:10:13 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:45008 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiAEHKM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 02:10:12 -0500
Received: by mail-pj1-f54.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so5527173pji.3
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 23:10:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9upj+0j92M/A8Oh9KW3wyYLfC06otABPiKSCQM6EzpQ=;
        b=zFAumMVabmVs5ziuAL6wm0yQdMoshqAmi7xpl6kyXiPaxjSaRhXz+CEftuiXla/noO
         yHuFdZQOZFp3BN6mCLOOCAxo3PjZHEFz3prX3DxL8YjFJIa63FwhuLYNlXvgtL1sYlQA
         I2WwNG+55JQoRkHIAKAvMlUxaGRl5TPWG7wxdITn61alkWkvgN/A+d/CTwpxVEeQEsOv
         xncYXRVk2CbiroUVfmgvND+bWQaPG7T3NPZlH+olqKFDsqZj1zJQkw1ipT6g5haB7Fq0
         DVDSI+Dbs7rNoXypY4zEgmdgQisw+VB/W8LZcD2CYDEQ4C/brzEoyCMH0olUn9OqLkyz
         7PyA==
X-Gm-Message-State: AOAM532iP2yyyHjS7ui2qhCGq2LJT6dBZdVF0165xqcc3jflfhAL+d5u
        UxQU2XhUY8k5lEQHTXuptdpxJjEKuMdkLFEPwFQ=
X-Google-Smtp-Source: ABdhPJztqLAOadKafLBuMq9Yj8MuyVf/Yf3ukTZZwXENvU+o0Jr80JOoA+HJgxSnMKMJTPlMrVjg7DtM8SKyJ5C+vpc=
X-Received: by 2002:a17:902:7e0f:b0:149:e08f:3b5a with SMTP id
 b15-20020a1709027e0f00b00149e08f3b5amr118200plm.35.1641366606947; Tue, 04 Jan
 2022 23:10:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1090.git.1638538276608.gitgitgadget@gmail.com>
 <20220103095337.600536-1-fs@gigacodes.de> <CAPig+cS6h6o2_dJAZC1M1Ace29bN2mhPgaEtTWtj3oXfcHq9cA@mail.gmail.com>
 <xmqqee5oieb2.fsf@gitster.g> <CAPig+cTM3wZz4NXjxYeBuFv0CVNS-T+pBFeVkfMQ-25pL1kBzw@mail.gmail.com>
 <xmqqmtkcguvm.fsf@gitster.g> <CAPig+cR93GyN53JoZbaiROrNtzGjiet7eTPQOk-26G+mB0KaCA@mail.gmail.com>
 <20220104125534.wznwbkyxfcmyfqhb@fs> <xmqqo84rcn3j.fsf@gitster.g>
In-Reply-To: <xmqqo84rcn3j.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Jan 2022 02:09:55 -0500
Message-ID: <CAPig+cQinNZp_2=eo7nokMCZ9gc-tAKO1V_jejL2Ei9J63tSDQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: trim CR from ssh-keygen
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>, Git List <git@vger.kernel.org>,
        Pedro Martelletto <pedro@yubico.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 4, 2022 at 2:33 PM Junio C Hamano <gitster@pobox.com> wrote:
> Fabian Stelzer <fs@gigacodes.de> writes:
> > I guess we need a bit more context for this patch to make sense:
> >
> > for (line = ssh_principals_out.buf; *line;
> >      line = strchrnul(line + 1, '\n')) {
> >       while (*line == '\n')
> >               line++;
> >       if (!*line)
> >               break;
> >
> >       trust_size = strcspn(line, "\n"); /* truncate at LF */
> >       if (trust_size && trust_size != strlen(line) &&
> >           line[trust_size - 1] == '\r')
> >               trust_size--; /* the LF was part of CRLF at the end */
> >       principal = xmemdupz(line, trust_size);
>
> Ahh, OK.  Sorry for being ultra lazy for not visiting the actual
> source but just responding after reading only somebody else's
> comments.

I'm also guilty of being lazy and not consulting the actual source. Sorry.

Fabian, thanks for all the extra context information.

> OK, so I was completely missing the idea.  And I agree that it may
> be a good idea to check how strcspn() returned to deal with an
> incomplete line, although as you hint later in the message I am
> responding to, checking line[trust_size] would be a more obvious
> implementation.
>
> In any case, I think the earlier part of the loop is more confusing,
> and I think fixing that would naturally fix the trust_size
> computation.  For example, wouldn't this easier to grok?

Indeed, the existing code is confusing me. I've been staring at it for
several minutes and I think I'm still failing to understand the
purpose of the +1 in the strchrnul() call. Perhaps I'm missing
something obvious(?).

>         const char *next;
>
>         for (line = ssh_principals_out.buf;
>              *line;
>              line = next) {
>                 const char *end_of_text;
>
>                 /* Find the terminating LF */
>                 next = end_of_text = strchrnul(line, '\n');
>
>                 /* Did we find a LF, and did we have CR before it? */
>                 if (*end_of_text &&
>                     line < end_of_text &&
>                     end_of_text[-1] == '\r')
>                         end_of_text--;

It took several seconds for me to convince myself that the -1 array
index was safe. Had the `line < end_of_text` condition been written
`end_of_text > line`, I think it would have been immediately obvious,
but it's subjective, of course.

>                 /* Unless we hit NUL, skip over the LF we found */
>                 if (*next)
>                         next++;
>
>                 /* Not all lines are data.  Skip empty ones */
>                 if (line == end_of_text)
>                         /*
>                          * You may want to allow skipping more than just
>                          * lines with 0-byte on them (e.g. comments?)
>                          * depending on the format you are reading.
>                          */
>                         continue;
>
>                 /* We now know we have an non-empty line. Process it */
>                 principal = xmemdupz(line, end_of_text - line);
>                 ...
>         }
>
> The idea is to make sure that the place where the line ending
> convention is taken care of is very isolated at the beginning of the
> loop.

Yes, this may be an improvement, though the cognitive load is still
somewhat high. Using one of the `split` functions from strbuf.h or
string-list.h might reduce the cognitive load significantly, even if
this code still needs to handle CR removal manually since none of the
`split` functions are LF/CRLF agnostic. (Adding such a function might
be useful but could be outside the scope of this bug fix patch.)

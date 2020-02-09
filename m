Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C377AC352A4
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6340207FF
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgBIRgf convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 Feb 2020 12:36:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46085 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgBIRgf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 12:36:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so4632256wrl.13
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 09:36:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G6CO+USGkQFFv4mkN1q1T24HzbhAxIRVOdukLORV/p8=;
        b=ipCPLmujizGJfK9smZ3KjJSdHiQYCpyTtbYS4fazIgVHDBpImGJ0pJk9i7n373WZHy
         4HQ3GT0uiRC2pLOkdjAjxwpRwpGqw8nbHxaR8PHaLeXBjR40/LxkZ5Xq2oUEXHobACVg
         LdhwJ47ZlwIaxpTCUz7rTsNwH2LvruA8H25fjadEUkJhyy+h7qb/JRgn6mOaKce8W73L
         wiwVLlHETNKVFr4Gw5TGMzKFvJHpurTPHj4r3jg9T1eA6Xkrw82TVnRFHqE1BtFouRDF
         KGBiKUSVrctKCiyx6mG3ZexXrMTElwxsaHfIQGEdOFNEqYDo2M9+VCXr1Np07Qdz+1Pa
         fxZA==
X-Gm-Message-State: APjAAAXd9dpwFAy75ldwU59A/iMW0iePX/frty7O1EujSh/LkQvCBcmq
        kG/nrVApcgj58yVD0O/hCXz8CojmJF8zMW2yC6c=
X-Google-Smtp-Source: APXvYqxL6TSICbodVhh/IZuEaLSEnnXjkCyNq7aOePJE4KftM+S1RC9uiea+voEKGlfy279Ze6Te+CE2Zmdqnfjxd+U=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr12529054wrr.226.1581269793513;
 Sun, 09 Feb 2020 09:36:33 -0800 (PST)
MIME-Version: 1.0
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de> <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
In-Reply-To: <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Feb 2020 12:36:22 -0500
Message-ID: <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 9, 2020 at 8:45 AM René Scharfe <l.s.r@web.de> wrote:
> Add a function for inserting a C string into a strbuf.  Use it
> throughout the source to get rid of magic string length constants and
> explicit strlen() calls.
>
> Like strbuf_addstr(), implement it as an inline function to avoid the
> implicit strlen() calls to cause runtime overhead.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> diff --git a/mailinfo.c b/mailinfo.c
> @@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
>                 len = strlen("Content-Type: ");
>                 strbuf_add(&sb, line->buf + len, line->len - len);
>                 decode_header(mi, &sb);
> -               strbuf_insert(&sb, 0, "Content-Type: ", len);
> +               strbuf_insertstr(&sb, 0, "Content-Type: ");
>                 handle_content_type(mi, &sb);

Meh. We've already computed the length of "Content-Type: " a few lines
earlier, so taking advantage of that value when inserting the string
literal is perfectly sensible. Thus, I'm not convinced that this
change is an improvement.

Digging deeper, though, I have to wonder why this bothers inserting
"Content-Type: " at all. None of the other cases handled by
check_header() bother re-inserting the header, so why this one? I
thought it might be because handle_content_type() depends upon the
header being present, but from my reading, this does not appear to be
the case. handle_content_type() calls has_attr_value() and
slurp_attr() to examine the incoming line, but neither of those seem
to expect any sort of "<Header>: " either. Thus, it appears that the
insertion of "Content-Type: " is superfluous. If this is indeed the
case, then rather than converting this to strbuf_insertstr(), I could
see it being pulled out into a separate patch which merely removes the
strbuf_insert() call.

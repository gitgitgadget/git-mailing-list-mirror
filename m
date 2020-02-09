Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B3C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760C62081E
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 17:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgBIR4N convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 9 Feb 2020 12:56:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39135 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgBIR4N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 12:56:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id c84so7977671wme.4
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 09:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFUpogqxspNYJdx/9Xa5eP9PjIye2oQOuQT6BI5nPRM=;
        b=pZ/LxMuLBP4wYf0epaQET5MyMw3CaNQOKJnrkFEx6mU6RjM872H8vRYegbFQ0zwrYZ
         +gqlzgNe6GXwtESnjgCfh8M2sGwBd944ZVb0jE6SEFLaNLzy9s3U85lXbZ+omoK5w3+A
         wGEqRJGgPi7hiCNuweteKIvAWMJ4pH/GH8pkLYGPp7zclv4sFrJeMtkxoB/dQLJPb8zu
         QobmHSqxVYZzXuj7r399U30bip4Zk88VNI3IwczU6zdvy4NSKyknaFHKKUXctC98US8O
         I+YHv1rJhoRq1/qnlwfAv5QpJMpeDYnz+w8pshsfjxvd/wkqY94PQv4a3W/SYAEgwP6R
         +spQ==
X-Gm-Message-State: APjAAAVd+lXfGhTBQG/7iq1uzoCgBcWmSyYACw7XeVqiCF2y6pwhffAu
        S3bqMpXw60Roi6dxwSdsXYBzyHdKvwXOBtUxZaY=
X-Google-Smtp-Source: APXvYqzKClei4Zh74FYxZ6x7Gzhoj4zjAlYeBQjTZRepdPdVumT+5Vq83BakW7ziomBXyYb0OijOqPi6zfoOpPzVUOU=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr10628186wmi.107.1581270970991;
 Sun, 09 Feb 2020 09:56:10 -0800 (PST)
MIME-Version: 1.0
References: <11b82734-f61c-5e73-2d0c-22208c06d495@web.de> <c729aaab-68d7-9cfa-8981-97eaa72a5ebe@web.de>
In-Reply-To: <c729aaab-68d7-9cfa-8981-97eaa72a5ebe@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 9 Feb 2020 12:56:00 -0500
Message-ID: <CAPig+cQpzc6eZyOo9N=4sR3pBFza299rRn_wP0w2W7Zf5CWThg@mail.gmail.com>
Subject: Re: [PATCH 2/4] parse-options: factor out parse_options_count()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 9, 2020 at 10:56 AM René Scharfe <l.s.r@web.de> wrote:
> Add a helper function to count the number of options (excluding the
> final OPT_END()) and use it to simplify parse_options_dup() and
> parse_options_concat().
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> diff --git a/parse-options-cb.c b/parse-options-cb.c
> @@ -159,16 +159,20 @@ int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
>  struct option *parse_options_dup(const struct option *o)
>  {
>         const struct option *orig = o;
>         struct option *opts;
> -       int nr = 0;
> -
> -       while (o && o->type != OPTION_END) {
> -               nr++;
> -               o++;
> -       }
> +       size_t nr = parse_options_count(o);
>
>         ALLOC_ARRAY(opts, nr + 1);
>         COPY_ARRAY(opts, orig, nr);

This could use a little more cleanup. After this change, 'o' is never
again consulted or changed, and 'orig' points at the original value of
'o', which means 'o' and 'orig' have the same value now always.
Therefore, the additional cleanup would be to drop the declaration and
assignment of 'orig' and reference 'o' in COPY_ARRAY() rather than
'orig'.

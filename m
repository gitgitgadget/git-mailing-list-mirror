Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5FBC18E00
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB3F2465D
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 19:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSTLi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:11:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43105 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBSTLh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 14:11:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so1824651wrq.10
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 11:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsDfeVVd6mznjLOAyr7baIl2aKxt0OnUxpJ4nawJOYA=;
        b=lMG4So2dgDWy781nK++kcdod8XPvJDivm7dw/M3k6ojcth3teXW5vYk0q02Udt3dUP
         3/8PFXa0tOYveo3dvVIDlLITodAcGzM73hUVDLptHT52bOTKUPSRd2TrNhLLeVbN7lJK
         fOfr6vVfq34AskmIuRcNuHTFpvvMW2TvHyFZrK/1HZr2TVg/FrGPClby3HAsdsX3zfGA
         v61pl0N9Dpm2gmQ+TI5LZO15eTLkLIIBJo9KtPU3uQd9CJY7yO/K8Py+Bb4kJxUf5Vmy
         Cu1DKT2g8m6kN5WZiN5+IdOUB0BM63kg2FQen3p3jhbelgg/TjaZ7Gp/BPMvDQAFz02i
         Xx4w==
X-Gm-Message-State: APjAAAXlIzU8jIHULu2TX0F3QD51C24pbfS3cOSIcLlR8kbahJM2q9/u
        YnWZCGgFJt4vdYnRLiJAwEOSvYPOXJo7rVzXLDiSXUUm
X-Google-Smtp-Source: APXvYqwFZBvXKFPqPyA7QdN02qzWu4QHJNfn8fCxXdtTHE+P1s4wbMW7MZjNjVUursur4Da0IiWU6YKGu81/bbUK4ls=
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr38001867wrx.386.1582139495646;
 Wed, 19 Feb 2020 11:11:35 -0800 (PST)
MIME-Version: 1.0
References: <20200219161352.13562-1-pbonzini@redhat.com> <20200219161352.13562-2-pbonzini@redhat.com>
In-Reply-To: <20200219161352.13562-2-pbonzini@redhat.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 19 Feb 2020 14:11:24 -0500
Message-ID: <CAPig+cQkBKJLW3-W4SS0KX9+Gs2fT-Z-DrvVpcVOLZpFmVBoQA@mail.gmail.com>
Subject: Re: [PATCH 1/4] parse-options: convert "command mode" to a flag
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Git List <git@vger.kernel.org>, bfields@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 19, 2020 at 11:15 AM <pbonzini@redhat.com> wrote:
> OPTION_CMDMODE is essentially OPTION_SET_INT plus the extra check
> that the variable had not set before.  In order to allow custom
> processing, change it to OPTION_SET_INT plus a new flag that takes
> care of the check.  This works as long as the option value points
> to an int.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> @@ -324,6 +326,22 @@ test_expect_success 'OPT_NEGBIT() works' '
> +test_expect_success 'OPT_CMDMODE() detects incompatibility' '
> +       test_must_fail test-tool parse-options --mode1 --mode2 >output 2>output.err &&
> +       test_must_be_empty output &&
> +       grep "incompatible with --mode" output.err
> +'

The error message may have been localized, so use test_i18ngrep()
instead of 'grep':

    test_i18ngrep "incompatible with --mode" output.err

> +
> +test_expect_success 'OPT_CMDMODE() detects incompatibility with something else' '
> +       test_must_fail test-tool parse-options --set23 --mode2 >output 2>output.err &&
> +       test_must_be_empty output &&
> +       grep "incompatible with something else" output.err
> +'

Ditto.

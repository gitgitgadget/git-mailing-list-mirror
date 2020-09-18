Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B965C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 05:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A3D2176B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 05:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgIRFDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 01:03:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40014 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgIRFDN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 01:03:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id t16so4757575edw.7
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 22:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebMhTDlyEaKBJOX+VPwH5XO6ysXiER7zIq8i8MJakVg=;
        b=kLzLlEkRAxxEaQWg9SyAxRQV/+RImRLJynROuy7rbthjC+1yqqy/9LDc/oMVmoJ3gb
         maRdr27xOi2qeYpxTFHm59ScVj1D2maX6RFWzHPCL92jYreno/l843V6tElq0dj/SAkv
         rRI0I0Hg0LVnSXB83OzWV8U9hLZEmHas0MRLBZO3VogxZ+BZDdr4wv7Ig979rtXqCSam
         skFP8ok20hv0BWKGzt52ydzVeWKrgynzjMvF3K7PqNADc8NkEDYNWNuuFYmXgCgx4+ov
         g5fF61HzALKm0AB3HvF90yuxS5xBOtkHpdB2OMbSO3huXr0DuHPTD7TuWzEa7ox85j2G
         N4NQ==
X-Gm-Message-State: AOAM530TlmQYFUikdVOCKJJAhg/kTcwYF0WVDftt9e798XQ0yeOR3+o/
        l+jiSma9KDkijx9gLx8INR3BxR1u3QrML5pK0iM=
X-Google-Smtp-Source: ABdhPJxxc8y0npVdthOglHv0ahZ0gezxkGtYY8gUvzbYKYe0fJtAxqX4oYRp8OxtLhwzsITWvseNcu1IBl6dV8Qjako=
X-Received: by 2002:aa7:d15a:: with SMTP id r26mr37144572edo.181.1600405391609;
 Thu, 17 Sep 2020 22:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916020840.84892-1-alipman88@gmail.com> <20200918004909.32474-1-alipman88@gmail.com>
 <20200918004909.32474-2-alipman88@gmail.com>
In-Reply-To: <20200918004909.32474-2-alipman88@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 18 Sep 2020 01:03:00 -0400
Message-ID: <CAPig+cRXJ5hCEM0dFsSSnGWaYu76gPhpM3fV4FaV+Db4r6dX4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: refactor do_merge_filter()
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 8:49 PM Aaron Lipman <alipman88@gmail.com> wrote:
> ref-filter: refactor do_merge_filter()
>
> Rename to reach_filter() to be more descriptive.
>
> Separate parameters to explicitly identify what data is used by the
> function, instead of passing an entire ref_filter_cbdata struct.
>
> Rename and move associated preprocessor macros from header to source
> file, as they're only used internally in a single location.

One thing that this commit message lacks is a high-level explanation
of why these changes are being made. One possible rewrite would be:

    ref-filter: make internal reachable-filter API more precise

    The internal reachable-filter API is a bit loose and imprecise; it
    also bleeds unnecessarily into the public header. Tighten the API
    by:

    * renaming do_merge_filter() to reach_filter()

    * separating parameters to explicitly identify what data is used
      by the function instead of passing an entire ref_filter_cbdata
      struct

    * renaming and moving internal constants from header to source
      file

> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -2231,19 +2231,18 @@ void ref_array_clear(struct ref_array *array)
> +static void reach_filter(struct ref_array *array,
> +                        struct commit_list *check_reachable,
> +                        int include_reached)
>  {
>         [...]
> +       if (!check_reachable)
>                 return;

I would probably drop this conditional return altogether since it
incorrectly conveys to the reader that it is legal to call this
function with NULL for 'check_reachable', whereas, in reality, it
would be pointless to do so. If this function were public, and the
possible list of callers open-ended, then it might be reasonable for
it to do this to alert callers early of their error:

    if (!check_reachable)
        BUG("check_reachable must not be NULL");

However, as this function is private, and the set of callers can be
precisely determined, it's not necessary to make the check at all. If
anyone adds a new call in this file which incorrectly passes NULL,
they will discover the error quickly enough when the program crashes
at the new call site.

If you were to drop this conditional, then that change would deserve
another bullet point in the commit message.

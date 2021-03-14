Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCCC433E9
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C7F64EB6
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCNWfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:35:42 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:38845 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhCNWfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:35:36 -0400
Received: by mail-ed1-f42.google.com with SMTP id h13so15137530eds.5
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 15:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yyl8IXZzWahch/h7AGcERRsaBpP14lphKzd3ZrUxsjY=;
        b=oh6wfyejbyX236I8NRWpQJzKhFO5sTFTEzGsMRlTAyBdo9UnnrGVdwcxgCmFjosotq
         tHry41P+QqvWEUJG9u+Y2X1O5Y5JIcCcH9T0tsF6+ajC7CXhbYtGm9JiKpr74Gn74mfw
         p6GMEDsseT+LnrpqOXFOCRBhb1BKMlrbIQ+RMw64ugey5GLpge3e3TrqrBYMDx1kYdtF
         M9Ki+wjkG7bVdQ4ksKm4bbyTgXwsqXD+NzIX0i/8qpRZ9PgVAB8y0Wansm7PWypxCddt
         g7TVRfxfUIIqrMY/EzPR316IopMOjRaYbKYsXe/FD+aoAeloeVhypXqe7L0Uw72dgnOk
         yiaQ==
X-Gm-Message-State: AOAM5318kDPMapMxA+bSzEciIU90Hmxjty4LfcwpxmI+QFv3Hb2cltTs
        dNH6MPwK9dGAgZiP2GQsFiRcCgv2dq369EAT0JYDw0Wc
X-Google-Smtp-Source: ABdhPJyjMfvnucKr0TuLM2MltP0jZppE1GKWDYvE0bRbrduaXM1SGPq1zY36Zeo2Qtz844rD7uj9Cusk8c6AO8AYnIc=
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr26635200edc.94.1615761335045;
 Sun, 14 Mar 2021 15:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.903.git.1615760258.gitgitgadget@gmail.com> <dda5b537a3f0706ebf933e2b2efd996267e9d9b1.1615760258.git.gitgitgadget@gmail.com>
In-Reply-To: <dda5b537a3f0706ebf933e2b2efd996267e9d9b1.1615760258.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Mar 2021 18:35:24 -0400
Message-ID: <CAPig+cT9aAPGzysqAz2OBrZP-7Ci+h+W5wFgnRm8bsde9K6zdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsmonitor: add assertion that fsmonitor is valid to check_removed
To:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 14, 2021 at 6:19 PM Nipunn Koorapati via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Validate that fsmonitor is valid to futureproof against bugs where
> check_removed might be called from places that haven't refreshed.
>
> Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
> ---
> diff --git a/fsmonitor.h b/fsmonitor.h
> @@ -49,6 +49,17 @@ void refresh_fsmonitor(struct index_state *istate);
> +/*
> + * Check if refresh_fsmonitor has been called at least once.
> + * refresh_fsmonitor is idempotent. Returns true if fsmonitor is
> + * not enabled (since the state will be "fresh" w/ CE_FSMONITOR_VALID unset)
> + * This version is useful for assertions
> + */
> +static inline int is_fsmonitor_refreshed(const struct index_state *istate)
> +{
> +    return !core_fsmonitor || istate->fsmonitor_has_run_once;
> +}

Unusual 4-space indentation rather than typical 1-tab.

Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0579DC433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77202063A
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgHEVIY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 5 Aug 2020 17:08:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54975 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:08:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id d190so7008489wmd.4
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 14:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fPVYtt28B8UrQgOHyjFy9irO60OTYRkW8o7d2Al3ulQ=;
        b=IARbXe6btOIXDo3oMIxc0ya/NGtSIzC2v4z6HhgLQ/ktkz5rY1hgCCVAPysDq/gywf
         kg8M0XmL3L8BC64w1JBi4y8SPVtKM1VL5hyc6JtnIifA2rj6D6FWOwRQvfoEQOWnSRON
         RE1M/otFPgbNIHqvjNn1jZQ11Vb/tkXg9xDEIM+rxPYy0uf1PXIfmFg1vci+XE7NqVcH
         wRzB2sGFxESMVpV2iVmGUR+tDK0hcFrWddiEuEUBHmcW21rv3QzebN2QkhGNAyrdHMyB
         9pZAoRFWm8PRoxFIlXIH7wx6gbZbTn8PBAVdGmgH+ZPJDxPlqINSNh0YmRZQJwbE2HLd
         Vnfw==
X-Gm-Message-State: AOAM532yq8p9YwzF6xCEJ1JuRLHHRJCf6r+atP2XRsaZCYVv5TcwCkxB
        bICF2/8/qWMl5oPwbkC4WrdWxIkD//HRO0PsYeM=
X-Google-Smtp-Source: ABdhPJynIt+q7ryPtEpsjnZj7rAD5f8i5tLVXpTdookjuLs0AZQWI3u39h+f4WC7hSdUWePeeRHv7CvcoB2oQY5gLew=
X-Received: by 2002:a1c:e304:: with SMTP id a4mr4819121wmh.11.1596661701464;
 Wed, 05 Aug 2020 14:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com> <fc0d2b103ec080fa38e5d51bf2205b7360c1b601.1596634463.git.gitgitgadget@gmail.com>
In-Reply-To: <fc0d2b103ec080fa38e5d51bf2205b7360c1b601.1596634463.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 5 Aug 2020 17:08:10 -0400
Message-ID: <CAPig+cRX3_ArTYQwc1jWHznBxLf+j0McYSo=nPq4C319J=DBvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mergetool-lib: keep a list of cross desktop merge tools
To:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 5, 2020 at 3:53 PM Marco Trevisan (Treviño) via
GitGitGadget <gitgitgadget@gmail.com> wrote:
> Instead of repeating the same tools multiple times, let's just keep them
> in another variable and list them depending the current desktop
>
> Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
> ---
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> @@ -288,11 +288,12 @@ list_merge_tool_candidates () {
>         if test -n "$DISPLAY"
>         then
> +               cross_desktop_tools="opendiff kdiff3 tkdiff xxdiff"
>                 if is_desktop "GNOME"
>                 then
> -                       tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
> +                       tools="meld $cross_desktop_tools $tools"
>                 else
> -                       tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
> +                       tools="$cross_desktop_tools meld $tools"
>                 fi

I have mixed feelings about this change. On the one hand, I see the
reason for doing it if the list of tools remains substantially the
same in each case, but it also seems like it could become a burden,
possibly requiring factoring the list into more pieces, as new
platforms or tools are added.

What I might find more compelling is creation of a table of tools and
the platforms for which they are suitable. It doesn't seem like it
would be too difficult to express such a table in shell and to extract
the desired rows (but that might be overkill). At any rate, I'm rather
"meh" on this change, though I don't oppose it strongly.

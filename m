Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90061F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfA0XqX (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:46:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39591 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfA0XqW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:46:22 -0500
Received: by mail-qk1-f193.google.com with SMTP id c21so8470606qkl.6
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iNw0Eo1Mp4knoI/uMSbTwLp/4fyYX7umY1nNHIx280=;
        b=DquEFTR5cJetYhcK6fa7EHn+q9FVSv8Ntz/lMfTKghq+y64HC6cx/uSbqPphlUGYnN
         5eGLVvU8OOqT5+GOngXTL49O8MqysS6edO2DYkQH+SkXeJD+bjObdQ5/uohCA+gnFUQU
         h0v3JATD04EMkvoLivpnEv9HEwabLNmX8JpeG8vvhAFyTemfpGouJF5lf3TTrHWgw/E3
         Y/NprG+xYRX397xhryj3Y2a15l+SQw4R+Y10WQz3FdCrhATnEtjLR7J2gpext4wlG5fD
         +SBz4ZQGI0Do6cEI8xBs6U9kL1X0tTzhYCrxS+Gb9M0NdVC5aL49VHXM9OnIZEzHQmvn
         XiFQ==
X-Gm-Message-State: AJcUukfDo4PVoV6dRJ/7N2XA2yGmk8l1XSRKlplmtt1q0f0M7JazheSg
        DhhVCLVhLBfrWDg8v1RnpQWUruHOEuZU8xWXET4=
X-Google-Smtp-Source: ALg8bN6FL4FRxc9B6/lvBBm1+NlvWm2ASimEyU0fy1sFBCE3tVU5JBWMUqpSVgtlqohXTkORDr+XHj7aEDC/x7wMHX8=
X-Received: by 2002:a37:9584:: with SMTP id x126mr17708372qkd.36.1548632781654;
 Sun, 27 Jan 2019 15:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20190127192740.8678-1-svenvh@gmail.com>
In-Reply-To: <20190127192740.8678-1-svenvh@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 27 Jan 2019 18:46:10 -0500
Message-ID: <CAPig+cRLLTYB=tVOY39dojLYZqoX=yxPRZY9fjo9z+5+P2BKKg@mail.gmail.com>
Subject: Re: [PATCH v2] git-submodule.sh: shorten submodule SHA-1s using rev-parse
To:     Sven van Haastregt <svenvh@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 2:28 PM Sven van Haastregt <svenvh@gmail.com> wrote:
> Until now, `git submodule summary` was always emitting 7-character
> SHA-1s that have a higher chance of being ambiguous for larger
> repositories.  Use `git rev-parse --short` instead, which will
> determine suitable short SHA-1 lengths.
>
> We cannot rely on always successfully invoking `git rev-parse` in the
> submodule directory.  Keep the old method using `cut` as a fallback.
>
> Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
> ---
> diff --git a/git-submodule.sh b/git-submodule.sh
> @@ -850,8 +850,16 @@ cmd_summary() {
> +               # Ensure we have crudely abbreviated SHA-1s as fallback in case
> +               # rev-parse fails to shorten the SHA-1s.
>                 sha1_abbr_src=$(echo $sha1_src | cut -c1-7)
>                 sha1_abbr_dst=$(echo $sha1_dst | cut -c1-7)
> +
> +               sha1_abbrev=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src) &&
> +               sha1_abbr_src=$sha1_abbrev
> +               sha1_abbrev=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst) &&
> +               sha1_abbr_dst=$sha1_abbrev

This could be made a bit easier to follow by using indentation and ||
rather than &&. For instance, rewriting the entire block as:

    # Shorten with hard-coded fallback if rev-parse fails
    sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src ||
        echo $sha1_src | cut -c1-7)
    sha1_abbr_dst=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_dst ||
        echo $sha1_dst | cut -c1-7)

In fact, the code is clear enough that the comment isn't even needed.

By the way, if git-rev-parse does fail, is it going to produce an
error message on stderr that needs to be suppressed?

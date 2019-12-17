Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C54FC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B2520733
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 19:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfLQTcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:32:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41088 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfLQTcW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 14:32:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so1787227wrw.8
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 11:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xPCNT6zjir5b3jZpjCgAHlnQjTXUx6j/gYGMKwPbSc=;
        b=fx+mOe1GA9vOgX4wtpjVMrSTDq2yfJQrdwfeXy0nAldXMh3Dm245TfgX1RvPj2SlxX
         RNS5r3TmJ07bq/TqWloXxGhBK/C1PxstkffNUM3HqFZuWBB+W45/QbARwgaL0ddIVrL0
         qbxE5p0V67RJMFRnlyE+QZCZdrxn/elXUMzpNYrYXiAmGBEwO0tl/4GVgB4F3kCW+GCF
         srrp1flPWIfW4WBU+wrBgltxa8VcRTLtn0Xi1LmdziYMlLpl/KlRdmjH4RvFLL9RvP+v
         M74UEd7jOBQIfGB4e/YwCrcORDGGei+tgD6vqhX/GrabJE6j7kGgaP0r2xtU5y4D97wk
         K4DA==
X-Gm-Message-State: APjAAAWv3iCY9mFF1jadRTS3DpWkFNIFw6409uGU6017rH6F3Vfsv0/z
        O9XaCT1zSWANaGxsOZV9p2oDL0BryQ70Suletn0=
X-Google-Smtp-Source: APXvYqyT8wiY8y4UFOsa0j/H8Bb+QPlkGfnr4jN/sU+ZStWHvFtUlC8/LTO67FyZMjVb1MV2B/9ilZKDqSmNoy7X8bY=
X-Received: by 2002:adf:b193:: with SMTP id q19mr38917319wra.78.1576611140588;
 Tue, 17 Dec 2019 11:32:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576583819.git.liu.denton@gmail.com> <d228dcfdc7d3f41c53a3813c52e56638cd8dd95e.1576583819.git.liu.denton@gmail.com>
In-Reply-To: <d228dcfdc7d3f41c53a3813c52e56638cd8dd95e.1576583819.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 17 Dec 2019 14:32:09 -0500
Message-ID: <CAPig+cQJRCAYkn+9CoK0YOXa66B7ocv2qXGLBXy8f-sgE3ipBA@mail.gmail.com>
Subject: Re: [PATCH 07/15] t0020: drop redirections to /dev/null
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 17, 2019 at 7:02 AM Denton Liu <liu.denton@gmail.com> wrote:
> Since output is silenced when running without `-v` and debugging output
> is useful with `-v`, remove redirections to /dev/null as it is not
> useful.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
> @@ -5,7 +5,7 @@ test_description='CRLF conversion'
>  has_cr() {
> -       tr '\015' Q <"$1" | grep Q >/dev/null
> +       tr '\015' Q <"$1" | grep Q
>  }

I'm not sure that I agree with this change since dropping >/dev/null
doesn't improve the situation when someone is trying to debug a
failing test. What this change will do is fill the -v output with a
bunch of lines ending with "Q" when CR is expected -- the normal
_successful_ case for about half the calls to has_cr() -- so -v output
will become a lot noisier without really adding much, if any,
debugging value. If you really want to help people trying to diagnose
failures, I could see you replacing has_cr() with two new functions
which actually provide useful diagnostic output; for instance
something like:

    expect_cr () {
        if ! tr '\015' Q <"$1" | grep Q >/dev/null
        then
            echo "missing CR termination in: $1" >&2 &&
            return 1
        fi
    }

    expect_no_cr () {
        if tr '\015' Q <"$1" | grep Q >/dev/null
        then
            echo "unexpected CR termination in: $1" >&2 &&
            return 1
        fi
    }

However, I'm not convinced that introducing and debugging these
functions is worth the effort over simply dropping this patch from the
series.

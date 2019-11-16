Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 784BD1F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 10:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfKPKLZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 05:11:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34694 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPKLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 05:11:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id j18so11891870wmk.1
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 02:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uAKFCQRpYno3+501iC/INtNOYHd4mIIewC0z65KqI4=;
        b=mgiv4wKEPhFKjR3JvQfyLUItNhMRSiyRIjlEo+X8x3UBxS8O/eQvoUNOyPJdaw60bR
         Se2rpa3kyo6JFUC03/Ke5rXTBAYKQmw+PRToymi82oUJlMDVlBGJqxL6lVFvxIZOk7yW
         ff/326y8mSDjDmXXeuWgoz9cSqGgOnESN/ePcz+yJJoTEepzAgtgr2/4uaDU6pbWqaBg
         CAkzWaJQ6W3UTYTnN1kC7cq0njtrRhzdMSh4FgQn3S8ez/02TEarVfKUuXmqgTql15I9
         jrYAiREyefrva0QNbxw4ZD6X7PqjyP0Zh+FogMvT5QMWsjD7CRDJExyhQHSqs9yiFjbb
         3FNQ==
X-Gm-Message-State: APjAAAVPpVcflHSkz+2GFQ1K8Cr7txy2wHMUHLBvKlQlnJ+pk0TF4o3r
        F/DyVyY7q4SCwD6LXYq1FVf7p330o0SnQBpJk3Azny2u
X-Google-Smtp-Source: APXvYqxnHg4znxF5RPS+8f9Uzt6XcVStcdeTEwch9LZhnpBmImT18xBP+xPBYKGdpVKhTzsrOhT2zRMydXpAJZy1WD0=
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr20111485wma.95.1573899083294;
 Sat, 16 Nov 2019 02:11:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573779465.git.liu.denton@gmail.com> <8fc59e67d74faabf43965a5eac1a4147124c56d5.1573779465.git.liu.denton@gmail.com>
In-Reply-To: <8fc59e67d74faabf43965a5eac1a4147124c56d5.1573779465.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Nov 2019 05:11:12 -0500
Message-ID: <CAPig+cTj5qOCFRoD4cZOg7BjVvetQWTgdRHzSvAfgtX2YgUXPg@mail.gmail.com>
Subject: Re: [PATCH 13/27] t5703: stop losing return codes of git commands
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 8:01 PM Denton Liu <liu.denton@gmail.com> wrote:
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> @@ -312,9 +324,11 @@ inconsistency () {
> +       oid1=$(git -C "$REPO" rev-parse $1) &&
> +       oid2=$(git -C "$REPO" rev-parse $2) &&
>         printf "s/%s/%s/" \
> -              $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
> -              $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
> +              $(echo "$oid1" | tr -d "\n") \
> +              $(echo "$oid2" | tr -d "\n") \
>                >"$HTTPD_ROOT_PATH/one-time-sed"

This code is rather odd. The $(...) substitution already takes care of
stripping out newlines, so the 'tr' invocations in both the original
and the revised code are superfluous. As this patch series
incorporates various other cleanups, it would not be inappropriate to
create a patch which removes the unnecessary 'tr' invocations
preparatory to this patch. The final result should be a simple:

    printf "s/%s/%s/" $oid1 $oid2 >"$HTTPD_ROOT_PATH/one-time-sed"

or even simpler:

    printf "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-sed"

In fact, given the way the tests actually employ "one-time-sed" via
$(cat one-time-sed) in t/lib-httpd/apply-one-time-sed.sh, it could
even be as simple as:

    echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-sed"

which makes it consistent with the final "server loses a ref - ref in
want" test, which does use 'echo' rather than 'printf'. (That change
might also deserve its own patch.)

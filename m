Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D752D1F403
	for <e@80x24.org>; Tue,  5 Jun 2018 10:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751498AbeFEKFN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 06:05:13 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36625 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFEKFM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 06:05:12 -0400
Received: by mail-yb0-f194.google.com with SMTP id x128-v6so324305ybg.3
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 03:05:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UgZP598lh8xdHTCQ7fQgFxNGgEc215YQV64pCR2yv6Q=;
        b=Jf7Mtny//l1jVXtA7lDT8dSdM+KKzolfb6qrhpwK1zf2HXLmwxM/pOJqD9HKdMv11p
         PTLrFzthtlvTfu6I+kLbP2xU4te2ZBoc3GN2PnrBaQpvo9d4zKZv9nSOnOAx6LeVHOeH
         3Xl9UsmVhdMsakHopaCiJOTR+IAZSC39eSou6xSsMgUZwuWT+tu1o8tgrRlo/i6G1isI
         jt1nD5psSmGZYiLd6oGUgT071iza0ATmlz7SmO2I1aULGtEDgZtTERUczxc8f/wVAU8r
         byEO4WQZdFJZe2l+Z54LiF353cHtPvSQaqIL04oCKZznpakAbBr7fR+XXz5IUbWcaA9d
         4L1A==
X-Gm-Message-State: APt69E2IR6Soec6O9gA7L01crkQFR2w9l38Sknr5MydOshcmT87b2z39
        V/96LkESsM4hVLdcr8Dc77SQK6k37ZJjxTwHNow=
X-Google-Smtp-Source: ADUXVKLCEq70wfNTknsFgSnWQNkum7zON7rahUZxbWOxJU1DS/PdvuGqUNjn5nTQ/n0WUW7Xiytnr5o56LfnCqskG9g=
X-Received: by 2002:a25:8741:: with SMTP id e1-v6mr558206ybn.194.1528193111491;
 Tue, 05 Jun 2018 03:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180605091350.14476-1-luke@diamand.org> <20180605091350.14476-4-luke@diamand.org>
In-Reply-To: <20180605091350.14476-4-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jun 2018 06:05:00 -0400
Message-ID: <CAPig+cQj1jxgHKMagkX71v3W7KHbkZOrEJ_aceY_LsiSWVt_yw@mail.gmail.com>
Subject: Re: [PATCHv1 3/3] git-p4: auto-size the block
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        merlorom@yahoo.fr, Miguel Torroja <miguel.torroja@gmail.com>,
        vin ku <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>, lex@lexspoon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 5:14 AM Luke Diamand <luke@diamand.org> wrote:
> git-p4 originally would fetch changes in one query. On large repos this
> could fail because of the limits that Perforce imposes on the number of
> items returned and the number of queries in the database.
>
> To fix this, git-p4 learned to query changes in blocks of 512 changes,
> However, this can be very slow - if you have a few million changes,
> with each chunk taking about a second, it can be an hour or so.
>
> Although it's possible to tune this value manually with the
> "--changes-block-size" option, it's far from obvious to ordinary users
> that this is what needs doing.
>
> This change alters the block size dynamically by looking for the
> specific error messages returned from the Perforce server, and reducing
> the block size if the error is seen, either to the limit reported by the
> server, or to half the current block size.
>
> That means we can start out with a very large block size, and then let
> it automatically drop down to a value that works without error, while
> still failing correctly if some other error occurs.
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -48,7 +48,8 @@ def __str__(self):
>  # Grab changes in blocks of this many revisions, unless otherwise requested
> -defaultBlockSize = 512
> +# The code should now automatically reduce the block size if it is required
> +defaultBlockSize = 1<<20

As worded, the new comment only has value to someone who knew the old
behavior (before this patch), not for someone reading the code fresh.
However, if reworded, it might be meaningful to all readers (new and
old):

    # The block size is reduced automatically if required

> @@ -983,10 +985,24 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
> +        try:
> +            result = p4CmdList(cmd, errors_as_exceptions=True)
> +        except P4RequestSizeException as e:
> +            if not block_size:
> +                block_size = e.limit
> +            elif block_size > e.limit:
> +                block_size = e.limit
> +            else:
> +                block_size = max(2, block_size // 2)
> +
> +            if verbose: print("block size error, retry with block size {0}".format(block_size))

Perhaps: s/retry/retrying/

> diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
> @@ -129,6 +129,7 @@ test_expect_success 'Create a repo with multiple depot paths' '
> +test_expect_success 'Clone repo with self-sizing block size' '
> +       test_when_finished cleanup_git &&
> +       git p4 clone --changes-block-size=1000000 //depot@all --destination="$git" &&
> +       (
> +               cd "$git" &&
> +               git log --oneline > log &&
> +               test_line_count \> 10 log
> +       )
> +'

Or, without a subshell (and dropping whitespace after redirection operator):

    git -C git log --oneline >log &&
    test_line_count \> 10 log

(not worth a re-roll)

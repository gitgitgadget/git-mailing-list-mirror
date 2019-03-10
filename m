Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1071B20248
	for <e@80x24.org>; Sun, 10 Mar 2019 09:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCJJvM (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 05:51:12 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39270 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfCJJvL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 05:51:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id z84so1534155wmg.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 01:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7h/y/hwxaX5qPNtRJw/YMI4Qbztx+0xDj70vKDKHeM=;
        b=sWyxHdegSwZQFG3li9DGh+21iQE1AVBpxZkjhX6YsZklEmVj5eOmMGsux71IIH5clh
         rV4lX2rXSc7y3xQYIujcs7r3cdEaeix3xct6j8Gwc6ss6NyCK8Dx0v814JpnGeRUrkrP
         5W+1ECgh6SicAeRY+EUPPX4sRMLGhpYP3RttkFbgQNihWYkmFg63dsW9GmpwEDva26Vh
         7+k1EM7ZYGcYJ3rBtMi69kaTeIW+URhR29pkQIazQI2eOvqWthNDKZOxblkbKjcwhjBr
         Gs8XHXJnQdqtgvNVLM7lDbZgLcVPbj81be11lBd5kP0Jz4Y8VziKB67ugabO+naWZ92m
         6OgQ==
X-Gm-Message-State: APjAAAVRmRo3uVUPYBfotwtg9/vXudjDuOnPUtEfwi09FC0IBBkQ7X6Z
        yv0FG/ZPjWsEQlG5TjVEvSS6VZkYQMvwvwtUin4=
X-Google-Smtp-Source: APXvYqy9sIIkIoLl3JFlL4ZF21jauII0/2hg5Xtk/bd5LyikqFQ0tUerkK0bJEDNfImpox6U2fAxk9RXpYXIkAF4gio=
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr13992249wmj.71.1552211469708;
 Sun, 10 Mar 2019 01:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20190310081023.64186-1-ttjtftx@gmail.com> <20190310081106.64239-1-ttjtftx@gmail.com>
In-Reply-To: <20190310081106.64239-1-ttjtftx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Mar 2019 05:50:58 -0400
Message-ID: <CAPig+cSMZrQFrLXoO5KE1uonUxmnYHikr-e6GAq_n6vx3+sPJA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 5/5] t0000-basic: use test_line_count instead of
 wc -l
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 4:11 AM Jonathan Chang <ttjtftx@gmail.com> wrote:
> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> @@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
> -       numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
> -       test $numparent = 1
> +       sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l >numparent &&
> +       test_line_count = 1 numparent

This transformation makes no sense. The output of 'sed' is fed to 'wc
-l' whose output is redirected to file "numparent", which means that
the output file will end up containing a single line no matter how
many "parent" lines are matched in the input. Since test_line_count()
checks the number of lines in the named file, the test will succeed
unconditionally (which makes for a pretty poor test).

Also, the filename "numparent" doesn't do a good job of representing
what the file is expected to contain. A better name might be
"parents". So, a more correct transformation would be:

    sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
    test_line_count = 1 parents

> @@ -1146,8 +1146,8 @@ test_expect_success 'update-index D/F conflict' '
> -       numpath0=$(wc -l <actual) &&
> -       test $numpath0 = 1
> +       wc -l <actual >numpath0 &&
> +       test_line_count = 1 numpath0

Same comment about bogus transformation. The entire sequence should
collapse to a single line:

    test_line_count = 1 actual

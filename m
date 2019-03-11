Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F4B520248
	for <e@80x24.org>; Mon, 11 Mar 2019 05:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfCKFtg (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 01:49:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKFtg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 01:49:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id o9so3580675wrv.9
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 22:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diyVk9FIfA7BfPyTHOr1Y89KHsVV1/S2DBVQeEHMatc=;
        b=JPAv0Y41mA0OF/2R73DusC7B2aYRM4MKL88lYvuAPkwjsEtEByxiEMrZmKLL+uHs1i
         6xXzO5ADzxz9/0mqxSqDfoiNjqWjJK46DPZNqxoyIGHc6ieRxaMzN3byVXmCYHy4Ienv
         q4aGR18UrBnsBY96jTGAFGKq2Gbdjt3/nPVxe9iRS6ILribxRMmAP9gztkn/0bXPI2IE
         15VBRUCuRBRQnKtAJ2L1JvlgbMSfDCo4WwP49qCflzsaBiFoxpQMQ0IMj++qR74G0n3q
         k8y0Z/K8bCCVbrdY5D8PO/d5IKLy7JMSbwicwk7nvYvREBAEGUxIx6XYrjJ29j+VDtyg
         XvVA==
X-Gm-Message-State: APjAAAUsAC4FzTgRagCQT7Zj6lSV+8yzVM8UjuxIdjy3VgcopQ496nYP
        dmxrUhw2TzMe/wHdzmYgFWgWgNa8QKjbyO1/bSzyJA==
X-Google-Smtp-Source: APXvYqwZlHW3e+mxT/cl9QKN+8AIDWu9WC6VkjdX5eOaVVCB260W/q3UyoH17qS73ImxbAQoI6Kcl0wFR2yyZR3vr7U=
X-Received: by 2002:adf:c7c6:: with SMTP id y6mr18464483wrg.217.1552283374141;
 Sun, 10 Mar 2019 22:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1548219737.git.liu.denton@gmail.com> <cover.1552275703.git.liu.denton@gmail.com>
 <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
In-Reply-To: <b2b82954e7060a3f5d47f77e4743493ff4256bd6.1552275703.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Mar 2019 01:49:23 -0400
Message-ID: <CAPig+cS5YsjxuLGNAtfFguQvy2p2bJECSsHksx356+WsO1ct5w@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] merge: cleanup messages like commit
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 11:42 PM Denton Liu <liu.denton@gmail.com> wrote:
> This change allows git-merge messages to be cleaned up with the
> commit.cleanup configuration or --cleanup option, just like how
> git-commit does it.
>
> We also give git-pull the passthrough option of --cleanup so that it can
> also take advantage of this change.
>
> Finally, add testing to ensure that messages are properly cleaned up.
> Note that some newlines that were added to the commit message were
> removed so that if a file were read via -F, it would be copied
> faithfully.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t7604-merge-custom-message.sh b/t/t7604-merge-custom-message.sh
> @@ -47,4 +47,65 @@ test_expect_success 'merge --log appends to custom message' '
> +test_expect_success 'cleanup commit messages (verbatim option)' '
> +       git reset --hard c1 &&
> +       git merge --cleanup=verbatim -F expect c2 &&
> +       git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&

An earlier patch in this series "fixed" a test with a Git command
upstream of a pipe. Yet, this test adds such an instance. (Also,
style: add space after '|'.)

> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'cleanup commit messages (whitespace option)' '
> +       git reset --hard c1 &&
> +       { echo;echo "# text";echo; } >text &&

Style: add space after semicolon or use &&-chaining inside {...}.

Alternately, less ugly:

    test_write_lines "" "# text" "" >text &&

(Or even a here-doc, though the leading and trailing blank lines make
the here-doc ugly.)

> +       echo "# text" >expect &&
> +       git merge --cleanup=whitespace -F text c2 &&
> +       git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&

Git upstream pipe.

> +       test_cmp expect actual
> +
> +'

Style: drop the blank line before the closing quote.

> +test_expect_success 'cleanup merge messages (scissors option)' '
> +       git reset --hard c1 &&
> +       cat >text <<EOF &&

This here-doc probably ought to be using '-' and '\', so:

    cat >text <<-\EOF &&

and indent the here-doc body.

> +# to be kept
> +
> +  # ------------------------ >8 ------------------------
> +# to be kept, too
> +# ------------------------ >8 ------------------------
> +to be removed
> +# ------------------------ >8 ------------------------
> +to be removed, too
> +EOF
> +
> +       cat >expect <<EOF &&

Ditto: <<-\EOF and indent body.

> +# to be kept
> +
> +  # ------------------------ >8 ------------------------
> +# to be kept, too
> +EOF
> +       git merge --cleanup=scissors -e -F text c2 &&
> +       git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&

Git upstream pipe.

> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'cleanup commit messages (strip option)' '
> +       git reset --hard c1 &&
> +       { echo;echo "# text";echo sample;echo; } >text &&

test_write_lines "" "# text" sample "" >text &&

> +       echo sample >expect &&
> +       git merge --cleanup=strip -F text c2 &&
> +       git cat-file -p HEAD |sed -e "1,/^\$/d">actual &&

Git upstream pipe.

> +       test_cmp expect actual
> +
> +'

Drop blank line before closing quote.

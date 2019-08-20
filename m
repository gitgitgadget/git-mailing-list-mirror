Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3B5A1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfHTUYj (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:24:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43539 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbfHTUYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:24:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id y8so13688324wrn.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 13:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dbn3JjWBMNvBcthtYhRB+6Iwhk/2Y5xwpNSVoH1y16A=;
        b=WKu8kKUdZync3XaEK0dkybT30Q48YneKInd0vsY5p10U8N8aIjsIzIxrcgEt/tkRQp
         bzU5iixQQqLDhsgnlPrRIVAIIu/YSAMJ/svKX45YttSKr3p+HcmdyRG38HfgpCK6eKkp
         IT1+OzF8yOkInzX9TrRr0xG6326qWAmiyLdGk6H7IBnb/k/0j2oxtEGCA/9mEGDpzsi4
         sKadgtFcPOVen8kjOGfhV1WBU6XFhvuzBXTDcooJzQygCTy3Ahfg5+1iqrOhpN52PDND
         aOEyIssg1Z3OSo43+rnNif4Qbx16WFPpCGiIhzo2i7NPqwvvdofPGuMNwZ7Bdz5J2HSY
         mliQ==
X-Gm-Message-State: APjAAAUGlmEpC7Ij6m7s2qteMJYnGR6EH34rvnwSEnQKRO5/YgBKbWLr
        9SbKI5kdUBLMjEa3F2QipGKF5HT2Tz58l8SOHXM=
X-Google-Smtp-Source: APXvYqyEJie31TkYfmPHjykwNLsi8cWseRuNyDnUAB1eQLxR+psN1/YcoOPZWS/22FlIyrXwvydcIZaHCXP7mYi9bxk=
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr35271941wrs.10.1566332676770;
 Tue, 20 Aug 2019 13:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190818095349.3218-3-ben@wijen.net> <20190820201237.10205-1-ben@wijen.net>
 <20190820201237.10205-2-ben@wijen.net>
In-Reply-To: <20190820201237.10205-2-ben@wijen.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Aug 2019 16:24:25 -0400
Message-ID: <CAPig+cQG0HDDBz-o=-7STos6LwYX377oFiBGBiDY+P27Q7ua-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rebase.c: make sure current branch isn't moved
 when autostashing
To:     Ben Wijen <ben@wijen.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 4:12 PM Ben Wijen <ben@wijen.net> wrote:
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> @@ -306,4 +302,13 @@ test_expect_success 'branch is left alone when possible' '
> +test_expect_success 'never change upstream branch' '
> +       test_when_finished "git reset --hard && git branch -D upstream" &&
> +       git checkout -b upstream unrelated-onto-branch &&
> +       echo changed >file0 &&
> +       git add file0 &&
> +       git rebase --autostash upstream feature-branch &&
> +       test_cmp_rev upstream unrelated-onto-branch
> +'

To be friendly to tests added after this one in the future, follow the
example of other tests in this script by ensuring that the test
switches back to the branch which was active prior to starting this
test. For instance:

    test_expect_success 'never change upstream branch' '
        git checkout -b upstream unrelated-onto-branch &&
        test_when_finished "git reset --hard &&
            git checkout - &&
            git branch -D upstream" &&
        echo changed >file0 &&
        git add file0 &&
        git rebase --autostash upstream feature-branch &&
        test_cmp_rev upstream unrelated-onto-branch
    '

(Don't actually copy/paste the code from the other tests, since most
of them switch back to the previous branch incorrectly by using "git
checkout <whatever>" as the last line of the test. That won't restore
the branch correctly if the test fails before it reaches that line;
instead, test_when_finished() should be used to switch back to the
original branch.)

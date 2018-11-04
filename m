Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A431F453
	for <e@80x24.org>; Sun,  4 Nov 2018 00:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeKDJiX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 4 Nov 2018 04:38:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33452 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDJiW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 04:38:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id o89so9209691qko.0
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 17:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARuJ6rr/ilHzv1Ea1Y5msWjieh6RnHMH00e7ojywAIs=;
        b=o5iobBUUvgvfy6n3uzRjHEb1x9hEHNEImRBn1jRafKHh4hlwiixms/Dum0qGKvKxAh
         jNlRr4c2xLx7MAmiMGpqXs3szHXOmsMg+5xsiO+t/xwJEr0d62CD+osi2WMk1+9xOHzF
         kOyf2v3CGOsPTILf5jlh+3qBBSZVvnDKKRmleUIxkHKlNQoLP0smlchU5nQyrZKUPbi+
         isss2oH4aU/XV18hh2CwejBgSrPOfgWWkqg0Y5nXBIvV6ORMYMFI6U1S1Pd2PaxPY8pg
         VuHN1nyRhDsgR06A5nQiLWrY8qZboLOGzCaRq6n90pHQj9SauOXPWvU2mLcXvNn4vwRS
         qYMA==
X-Gm-Message-State: AGRZ1gJmwDxcA1mjLsCVpKAWWgbl4yh2olJBN4RhlfMg+oI9U99f2+8J
        d/KubgVISdwAiVdRMD6/svrqpGO23/31Bqt67UM=
X-Google-Smtp-Source: AJdET5fecW4TW+2IyXlZbvC0fS3frR4mXBU5MMU3vEHDHNjKoHS56w4kS63stqNw1U7rmwIKX+81Txh/Bz2Gw5TJRhI=
X-Received: by 2002:a37:66c1:: with SMTP id a184mr14035642qkc.314.1541291126031;
 Sat, 03 Nov 2018 17:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGOLd-5Gbt6fQTvm+7018uX+8WF7NUWpa1sFWAg3-5bxtmOt-Q@mail.gmail.com>
 <20181103153049.22850-1-pclouds@gmail.com>
In-Reply-To: <20181103153049.22850-1-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Nov 2018 20:25:14 -0400
Message-ID: <CAPig+cS7b0nenb0+0jyXE=-bDkhapmYE8Yr6VfyAWRq3ydjPOg@mail.gmail.com>
Subject: Re: [PATCH] tree-walk.c: fix overoptimistic inclusion in :(exclude) matching
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     christophe.bliard@trux.info, Git List <git@vger.kernel.org>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 3, 2018 at 11:31 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> Rules 8 and 18 are now updated to be less eager. We conclude that the
> current entry is positively matched and included. But we say nothing
> about remaining entries. tree_entry_interesting() will be called again
> for those entries where we will determine entries individually.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
> diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
> @@ -194,4 +194,21 @@ test_expect_success 'multiple exclusions' '
> +test_expect_success 't_e_i() exclude case #8' '
> +       git init case8 &&
> +       (
> +               cd case8 &&
> +               echo file >file1 &&
> +               echo file >file2 &&
> +               git add . &&

Won't this loose git-add invocation end up adding all the junk files
from earlier tests? One might have expected to see the more restricted
invocation:

    git add file1 file2 &&

to make it easier to reason about the test and not worry about someone
later inserting tests above this one which might interfere with it.

> +               git commit -m twofiles &&
> +               git grep -l file HEAD :^file2 >actual &&
> +               echo HEAD:file1 >expected &&
> +               test_cmp expected actual &&
> +               git grep -l file HEAD :^file1 >actual &&
> +               echo HEAD:file2 >expected &&
> +               test_cmp expected actual
> +       )
> +'

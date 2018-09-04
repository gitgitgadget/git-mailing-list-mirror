Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205B51F404
	for <e@80x24.org>; Tue,  4 Sep 2018 00:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeIDFGW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 01:06:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41157 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIDFGW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 01:06:22 -0400
Received: by mail-qt0-f194.google.com with SMTP id t39-v6so2222914qtc.8
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 17:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=13VyGe8w5us9CdCD8r+438o07PKiVUOPdvyVJ/YqgvA=;
        b=TPoOa2J58IrhqBuMbKIbjxP2G52IjK99DVkwpylCECh9OLGzI+uSRrg1TYSQfUIL3U
         f5oDJkq4BBxnJVKGQlQ5KvHDpnYx0+WMAR22dtxeHWngis6PQwtbmOFhhLRm7Q/H7Wob
         fk+sK/6BnQkC1n0cVoCMuYWvNo2kpQrUS5eVdlCWfrSGwFFJGFY+CZA1Z7ubxo4dHV0F
         bGhPhs6pymkyJSFoY3jl9BDznc+9te4M/WHTSN7IbSrJ0gEesw7pMjJl34z8UuYYy2QB
         J9+Jnjj9X2feqd13G/Tb8SIVdLPt9H6K8bOFtmyt839T7yKu9DiWjDKBctwmo3UIMR65
         s49Q==
X-Gm-Message-State: APzg51C+hgjC85DniikACc1JNR9yN8UvvV/MwpXENkA59FhWX/23oAEX
        R9fSWl41osVqH8kMWim3/B4Kj4RiQ7WqM5YgTxs=
X-Google-Smtp-Source: ANB0Vdaou4I3D+MXNViHQeKzeFsMvYDGgsIGXk5zNPuO9h3KR3x6cb/1zGMo6hWAWO2e4gKr5Ibbprm1YEaKLFWn9OA=
X-Received: by 2002:ac8:764c:: with SMTP id i12-v6mr27326306qtr.250.1536021825411;
 Mon, 03 Sep 2018 17:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <2b5d6785944ed1a66f0272896a45fece8521d10f.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <2b5d6785944ed1a66f0272896a45fece8521d10f.1536009027.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 3 Sep 2018 20:43:34 -0400
Message-ID: <CAPig+cTJzguROwyGgyeUt5CrpKt2kyps04QD37wa_Bt3JPwWsg@mail.gmail.com>
Subject: Re: [PATCH 4/9] tests: optionally write results as JUnit-style .xml
To:     gitgitgadget@gmail.com
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 3, 2018 at 5:10 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This will come in handy when publishing the results of Git's test suite
> during an automated VSTS CI run.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> @@ -431,11 +434,24 @@ trap 'exit $?' INT
>  test_failure_ () {
> +       if test -n "$write_junit_xml"
> +       then
> +               junit_insert="<failure message=\"not ok $test_count -"
> +               junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
> +               junit_insert="$junit_insert $(xml_attr_encode \
> +                       "$(printf '%s\n' "$@" | sed 1d)")"
> +               junit_insert="$junit_insert</failure>"

This is a genuine failure, so you're creating a <failure> node. Okay.

> +               write_junit_xml_testcase "$1" "      $junit_insert"
> +       fi
> @@ -444,11 +460,19 @@ test_failure_ () {
>  test_known_broken_ok_ () {
> +       if test -n "$write_junit_xml"
> +       then
> +               write_junit_xml_testcase "$* (breakage fixed)"
> +       fi
>         test_fixed=$(($test_fixed+1))
>         say_color error "ok $test_count - $@ # TODO known breakage vanished"
>  }

This was expected to fail but didn't, which means it probably needs
some sort of attention. test_known_broken_ok_() prints this result in
the 'error' color, and test_done() re-inforces that by printing a
message, also in 'error' color:

    42 known breakage(s) vanished; please update test(s)

So, should this emit a <failure> node also, perhaps with 'type'
attribute set to "warning" or something? (<failure type="WARNING"
message="...">)

> @@ -758,9 +793,58 @@ test_at_end_hook_ () {
> +xml_attr_encode () {
> +       # We do not translate CR to &#x0d; because BSD sed does not handle
> +       # \r in the regex. In practice, the output should not even have any
> +       # carriage returns.
> +       printf '%s\n' "$@" |
> +       sed -e 's/&/\&amp;/g' -e "s/'/\&apos;/g" -e 's/"/\&quot;/g' \
> +               -e 's/</\&lt;/g' -e 's/>/\&gt;/g' \
> +               -e 's/  /\&#x09;/g' -e 's/$/\&#x0a;/' -e '$s/&#x0a;$//' |
> +       tr -d '\012\015'
> +}

It's possible to insert a literal CR in the 'sed' expression, which
does match correctly on BSD (and MacOS). For instance:

    CR=$(printf "\r")
    sed -e "s/$CR/\&#x0d;/g"

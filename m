Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA24B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 04:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeIDIyO (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 04:54:14 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46389 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeIDIyO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 04:54:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so2564749qtn.13
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 21:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txNtb9z2mxN/YFwilrX/SN3wW4z/8RiyXK5oAXATBhY=;
        b=FnAocaCGRAl8Sx+KrhkgpmDLrex05lD6+AazKfjBwfOBhAKcdSLQyziR0HRaM0lrL9
         UhREAhVDznOAi8LxqeSgNHeg4ow/v5XbCyLElZYbukFMoU6NaACI0Qk48JC9BcpGZBK6
         dHJGEFFs6GbB6dnQkOSCmPmfF+i7lRU+A0gumxp/Syk1drPurBfgi8P0Jjh00tk0a9ER
         PBDharWKC/xLj/TpsrT+dmdAhJBrpV4hwuqK9aKa2TVeRwaZ7JKJ8quFv1AscdIdNKwY
         bf2uzijmJCxhcCRn43eLlOOrhBZN8LOcVaXywujOz4WarEZRIDEbhC8LDFEF5mHDvkJo
         o1IA==
X-Gm-Message-State: APzg51DwbSmFz5UHmRmV44fD3MqjK1c+utcsHyyCUfSquvSPZ8PilRvw
        Shvc7NDZhyL7y+liOzVsiKrwpq0J60Iig+qEjqVm+A==
X-Google-Smtp-Source: ANB0VdZntgTTz9wPQK61rHKw2OWr2BHMygTNB9PaVOiYFEfqy53raXEMozGXm4Wg2zj5rBUNzLebCGl3ml6xJRcXiT0=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr28788962qtc.50.1536035457602;
 Mon, 03 Sep 2018 21:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.31.git.gitgitgadget@gmail.com> <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <942bf423a461a3b44e2ff254c90907a539d7abbe.1536009027.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 4 Sep 2018 00:30:45 -0400
Message-ID: <CAPig+cRGHPfNqdgRr6H_D_siKCFZBDsUrcp0F+CWNCx884AJVg@mail.gmail.com>
Subject: Re: [PATCH 7/9] tests: include detailed trace logs with
 --write-junit-xml upon failure
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
> So let's do something different in VSTS: let's run all the tests with
> `--quiet` first, and only if a failure is encountered, try to trace the
> commands as they are executed. [...]
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> @@ -445,10 +452,37 @@ test_ok_ () {
>  test_failure_ () {
>         if test -n "$write_junit_xml"
>         then
> +               if test -z "$GIT_TEST_TEE_OUTPUT_FILE"
> +               then
> +                       case "$(type kill_p4d 2>/dev/null | head -n 1)" in
> +                       *function*) kill_p4d;;
> +                       esac
> +
> +                       case "$(type stop_git_daemon 2>/dev/null |
> +                               head -n 1)" in
> +                       *function*) stop_git_daemon;;
> +                       esac

In the long run, it might make more sense, and be more scalable, to
have those scripts define a "prepare_for_rerun" variable or function
which this code then runs generically rather than having special
knowledge of those facilities.

I could imagine, for instance, test-lib.sh defining a no-op:

    test_failure_prepare_rerun () {}

and then each of those scripts overriding the function:

    # in lib-git-p4.sh
    test_failure_prepare_rerun () {
        kill_p4d
    }

    # in lib-git-daemon.sh
    test_failure_prepare_rerun () {
        stop_git_daemon
    }

> +                       # re-run with --verbose-log
> +                       echo "# Re-running: $junit_rerun_options_sq" >&2
> +
> +                       cd "$TEST_DIRECTORY" &&
> +                       eval "${TEST_SHELL_PATH}" "$junit_rerun_options_sq" \
> +                               >/dev/null 2>&1
> +                       status=$?
> +
> +                       say_color "" "$(test 0 = $status ||
> +                               echo "not ")ok $test_count - (re-ran with trace)"
> +                       say "1..$test_count"
> +                       GIT_EXIT_OK=t
> +                       exit $status
> +               fi
> +
>                 junit_insert="<failure message=\"not ok $test_count -"
>                 junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
>                 junit_insert="$junit_insert $(xml_attr_encode \
> -                       "$(printf '%s\n' "$@" | sed 1d)")"
> +                       "$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
> +               >"$GIT_TEST_TEE_OUTPUT_FILE"
>                 junit_insert="$junit_insert</failure>"
>                 write_junit_xml_testcase "$1" "      $junit_insert"
>         fi

This junit-related stuff is getting pretty lengthy. I wonder if it
would make sense to pull it out to its own function at some point
(again, in the long run).

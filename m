Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684671F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeF0Hpt (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:45:49 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38252 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeF0Hps (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 03:45:48 -0400
Received: by mail-yw0-f196.google.com with SMTP id w13-v6so373209ywa.5
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 00:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nu4dbMfWIWW4N97a8VQnBjDL+JfvJibKuUYRjyU7XnU=;
        b=cefsK4IWgJbIMKjeE/5fsuG4tZzkDb87bbI3ehm2FjnQy9AR/6gjhqW5BAdIIvwGR7
         3bH0CXgpsPs5VmtFORgYgtYXud6/guGKPcIpdND75xDf8UWwHEAFI2irYqxJm47BPIud
         8orbUJwLTRBtLwahC5jmhdVJRS0R/VKBEoKjA62fQJv2tpZqOQccpDLJVdVtLqxUVkGa
         eeI4zwsBe26ozVdIEgTGutZI/P0Iim9du+oabPI874lpRhAPoosrqYTO+lVJIj1QobhU
         pJ2mMz+f53r8WjJyejAH/anE++Y3zXi8ROMjA90hiWfQfxogOMtm3+Ozoz07zjXbT0K+
         904g==
X-Gm-Message-State: APt69E1PeWI3FZdJNelZ9s/sz4NzarfHi1WSj9Pvx3/Wq1Xx+YYPCDqx
        6qPrwjdZoRgtIKXNsmMs2lwrf5SFBK7Roh47hzE=
X-Google-Smtp-Source: AAOMgpdjTrFMIItMbm2PX5voYSzc0edkI4r2Xcn8davjyMoPRLBRDKQCZ6MYltEKiKq2f+DvqFmIuksmUhCq8TdqqnM=
X-Received: by 2002:a81:60c1:: with SMTP id u184-v6mr2364072ywb.418.1530085548232;
 Wed, 27 Jun 2018 00:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180607050845.19779-1-newren@gmail.com> <20180627073623.31725-1-newren@gmail.com>
 <20180627073623.31725-2-newren@gmail.com>
In-Reply-To: <20180627073623.31725-2-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 27 Jun 2018 03:45:37 -0400
Message-ID: <CAPig+cTwwuqPgF2NtGRgpcdjFqJK22+FFDV2c-20oQXFLEPaWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t3418: add testcase showing problems with rebase
 -i and strategy options
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 27, 2018 at 3:36 AM Elijah Newren <newren@gmail.com> wrote:
> We are not passing the same args to merge strategies when we are doing an
> --interactive rebase as we do with a --merge rebase.  The merge strategy
> should not need to be aware of which type of rebase is in effect.  Add a
> testcase which checks for the appropriate args.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> @@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
> +test_expect_failure 'rebase -i --continue handles merge strategy and options' '
> +       rm -fr .git/rebase-* &&
> +       git reset --hard commit-new-file-F2-on-topic-branch &&
> +       test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
> +       test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
> +       mkdir test-bin &&
> +       cat >test-bin/git-merge-funny <<-EOF &&
> +       #!$SHELL_PATH
> +       echo "\$@" >>funny.args
> +       case "\$1" in --opt) ;; *) exit 2 ;; esac
> +       case "\$2" in --foo) ;; *) exit 2 ;; esac
> +       case "\$4" in --) ;; *) exit 2 ;; esac
> +       shift 2 &&
> +       >funny.was.run &&
> +       exec git merge-recursive "\$@"
> +       EOF
> +       chmod +x test-bin/git-merge-funny &&
> +       (
> +               PATH=./test-bin:$PATH

Broken &&-chain (in subshell).

> +               test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
> +       ) &&
> +       test -f funny.was.run &&
> +       rm funny.was.run &&
> +       echo "Resolved" >F2 &&
> +       git add F2 &&
> +       (
> +               PATH=./test-bin:$PATH

Ditto.

> +               git rebase --continue
> +       ) &&
> +       test -f funny.was.run
> +'

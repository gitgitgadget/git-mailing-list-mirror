Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756371F403
	for <e@80x24.org>; Sun, 17 Jun 2018 03:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754238AbeFQDg2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 23:36:28 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:37550 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754063AbeFQDg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 23:36:27 -0400
Received: by mail-yw0-f194.google.com with SMTP id j134-v6so4630311ywg.4
        for <git@vger.kernel.org>; Sat, 16 Jun 2018 20:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cO5nlTOxBF54zevUyMqCduYCrtz6eq+VmIqtIy6uvoE=;
        b=X+syXzNLhjYBzEoAh/exbyJmwzGwZBgZ4AVaR9mC7KmDtNqZotgU/WxlrpkE7lKebA
         mBeU5edgi9Is/BZGLT72FIQgmXN/cBQC+suwANZWcqAFWJYMGst0JcbDQHFaQvzbCq9x
         SNEc7QyjKlHpRgurXoqZztm5i42119kjFLHB1WoN7Iq+Izqmybmnmy/iBj38NEpm+bl2
         5FJthB3dYBlPGgNmcpexw26f4OlGbBXozy9ZDyaZeb+c7OL0rup32rAviaoS2siUsX5e
         JQqNTR7r9tPxtDDtrCdzeUMnmQ+r8tf0LKHI6FU8H6MOZhgnGMbAxC/mbsb1O8a39PCo
         Xk5g==
X-Gm-Message-State: APt69E0zQXq4fJ3/6lsMY8ElGlJBQUSIa/Nc6g5KWHodsAJu2YW16YGF
        amqxUhC+/zY4CRdVGMZdPAygxCINu57jxWH5vsA=
X-Google-Smtp-Source: ADUXVKKfCI3s/WySvKH07N7YLACHbnqUhYjiSBzJwkL59WCcDH5JHi8JZSYKgokxCHoPwZK1JFO7lbsasXHCg0w6FGg=
X-Received: by 2002:a81:4303:: with SMTP id q3-v6mr3689785ywa.98.1529206586685;
 Sat, 16 Jun 2018 20:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <8e28202a-8646-53e8-8c22-389d61791c70@onlinehome.de> <20180616160804.10914-1-newren@gmail.com>
In-Reply-To: <20180616160804.10914-1-newren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Jun 2018 23:36:16 -0400
Message-ID: <CAPig+cRKxpNrTNSEgB66LBxcJk1b24ViR=T-fkqo07wxMFywpQ@mail.gmail.com>
Subject: Re: [BUG] git-rebase: reword squashes commits in case of merge-conflicts
To:     Elijah Newren <newren@gmail.com>
Cc:     cr@onlinehome.de, Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 16, 2018 at 12:08 PM Elijah Newren <newren@gmail.com> wrote:
> Subject: [PATCH] sequencer: do not squash 'reword' commits when we hit
>  conflicts
> [...]
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
> @@ -0,0 +1,44 @@
> +test_expect_success 'reword comes after a conflict preserves commit' '

s/comes//

> +       git checkout stuff^0 &&
> +
> +       set_fake_editor &&
> +       test_must_fail env FAKE_LINES="reword 2" \
> +               git rebase -i -v master &&

If some command fails between here and "git rebase --continue" below,
then the test will exit with an in-progress (dangling) rebase, which
could confuse tests added later to this script. I wonder, therefore,
if it would make sense to insert the following cleanup before "git
rebase -i":

    test_when_finished "reset_rebase" &&

> +       git checkout --theirs file-2 &&
> +       git add file-2 &&
> +       FAKE_COMMIT_MESSAGE="feature_b_reworded" git rebase --continue &&
> +
> +       test "$(git log -1 --format=%B)" = "feature_b_reworded" &&
> +       test $(git rev-list --count HEAD) = 2
> +'

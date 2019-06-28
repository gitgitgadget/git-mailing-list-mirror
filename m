Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 121561F461
	for <e@80x24.org>; Fri, 28 Jun 2019 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF1Vcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 17:32:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40738 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfF1Vcs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 17:32:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so7642039wre.7
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 14:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cx+c9irOOvhkyfBxZCB9sNo9FQjn3kKFKpMteF9U6Wo=;
        b=WHfi/uW67arK5kNEXKnkEMx2FJjPkPYwPu4bpo8zw8r1ll2yb1o1yMbTvsdNqqZ+0J
         TeBPFrlEAsMPzCJyNKIr+Wp7pWgyvxh+f8D1tuqIQBxYCyyrl7wo++Q3YLPoj430T7b5
         DAuFYWY59ZUMFgIJKrMf7mnDTZEZfuMtAhKZWABjtOB+//7eBflpTVlZWHbF1E+p2gIT
         /LWULLdXYqIm9f9/A4yH7sF2MJBZSpt4Dhmfs7CjoapAiS60yp+n86VmZlCxvuuMBG+h
         J50ygATU8N+TRVyW0QJS16hk5ciLOPY7zBCEkBlBA+6gtxhHoe5syv806WtU9Ka+Md59
         KXFw==
X-Gm-Message-State: APjAAAX45SfsqGa3yuaQH3qJJlyU2u9RcTC5JyCfZMGEswR2Nmz1cLTL
        tcBgcGB0Q9vXPzR9lXYn/4QjpK4o6J0ZYIsJGCrQAGkJ
X-Google-Smtp-Source: APXvYqwkDtXiqT5XSLU8bRUJfDxcCQDZ1AgRYocoRGSrNKb8vCMoVaLfoQoF1HvCg7gg068Mt4+1XlFdfOWWMqJ+UKQ=
X-Received: by 2002:a5d:554b:: with SMTP id g11mr7461245wrw.10.1561757565961;
 Fri, 28 Jun 2019 14:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190628093751.GA3569@sigill.intra.peff.net> <20190628093911.GA27329@sigill.intra.peff.net>
In-Reply-To: <20190628093911.GA27329@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 28 Jun 2019 17:32:35 -0400
Message-ID: <CAPig+cQAKVOqYH-CcqzViP_zuKwg5fWO2_i8=Z5t=BVf9uoAXQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 5:39 AM Jeff King <peff@peff.net> wrote:
> [...]
> For bulk creation, we can do much better by using fast-import, but it's
> often a pain to generate the input. Let's provide a helper to do so.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -233,6 +233,137 @@ test_merge () {
> +# Similar to test_commit, but efficiently create <nr> commits, each with a
> +# unique number $n (from 1 to <nr> by default) in the commit message.
> +#
> +# Usage: test_commit_bulk [options] <nr>
> +#   [...]
> +#
> +# The message, filename, and contents strings are evaluated by the shell inside
> +# double-quotes, with $n set to the current commit number. So you can do:
> +#
> +#   test_commit_bulk --filename=file --contents='modification $n'

Considering that test_commit_bulk() is intended to be used within a
test body, and considering that test bodies are almost always
encapsulated in single quotes, recommending single quoting the value
of --contents= seems contraindicated. Double quotes likely would be
better.

> +# to have every commit touch the same file, but with unique content. Spaces are
> +# OK, but you must escape any metacharacters (like backslashes or
> +# double-quotes) you do not want expanded.
> +#
> +test_commit_bulk () {
> +       [...]
> +       in_dir=${indir:+-C "$indir"}

Doesn't this suffer the problem in which some older/broken
shells[1][2][3][4] incorrectly expand this to:

    "-C <dir>"

rather than the expected:

    -C "<dir>"

? Is this something we still care about?

Same comment applies to other instances of ${indir:+-C "$indir"} below.

[1]: http://public-inbox.org/git/20160517215214.GA16905@sigill.intra.peff.net/
[2]: http://public-inbox.org/git/e3bfc53363b14826d828e1adffbbeea@74d39fa044aa309eaea14b9f57fe79c/
[3]: http://public-inbox.org/git/20160518010609.Horde.sM8QUFek6WMAAwho56DDob8@webmail.informatik.kit.edu/
[4]: http://public-inbox.org/git/1240044459-57227-1-git-send-email-ben@ben.com/

Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA68C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE29206C3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLTRzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:55:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55752 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbfLTRzs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:55:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so9811351wmj.5
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=83KDZbyiTJqryRvoJX7hL+1INKMvgcBhkHDYoZOxSE8=;
        b=NoodObof2gquTPdLofED3qmYlbgNoe+A8F8mDvHLBHQf7sTdIyLHke+eDxfs9eV2I3
         SbFQ86DXSloK9sZeBC4x2etsPs+lSm8vOiotfSZccVveVORCzuKes8IYZOoRAm5rdqDi
         md74Mgtr7+cObldK/r7QF+V2xDvStgx00Y3xNISUBh9LyQiHZj1LZ7iEzMzTc9ktwE+I
         0LqbVHclG7MrcDv9Hx0KUCQiSzaGq5jI9SKyBaNchV6LHqhKLreDJqMIP4aHWkFVsd7j
         wc88Hebjl/WcXcKZOw7oUMS+XqEWeiUQekLiRL3+eeuhvaOFCzmQgxDY/N2z1usz7Tuf
         2RCw==
X-Gm-Message-State: APjAAAUstv0Wmanu1ctQFJrAHcsb1QXU1Hz4z6uPhF2cQWYY5EVHjszN
        hQWby5Y/u21C+JQ21rwskm9IB+OYrQflKfUJWrYBCAClYEc=
X-Google-Smtp-Source: APXvYqwfu/6YPTqLpdkclMue8dySqOPooliKJENNlradoSXtwdjue0rGlO8XDRMMpHJhgnE9V3hc29plTPIKXCh60Kk=
X-Received: by 2002:a05:600c:24ca:: with SMTP id 10mr17089924wmu.4.1576864545997;
 Fri, 20 Dec 2019 09:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20191219015833.49314-1-emaste@FreeBSD.org> <20191220153814.54899-1-emaste@FreeBSD.org>
In-Reply-To: <20191220153814.54899-1-emaste@FreeBSD.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Dec 2019 12:55:34 -0500
Message-ID: <CAPig+cS6XPc9KZo3ytEHLFjMxEFqCk5OJMUjZyFBP0cA95u9Lw@mail.gmail.com>
Subject: Re: [PATCH v3] sparse-checkout: improve OS ls compatibility
To:     Ed Maste <emaste@freebsd.org>
Cc:     git mailing list <git@vger.kernel.org>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 10:38 AM Ed Maste <emaste@freebsd.org> wrote:
> On FreeBSD, when executed by root ls enables the '-A' option:
>
>   -A  Include directory entries whose names begin with a dot (`.')
>       except for . and ...  Automatically set for the super-user unless
>       -I is specified.
>
> As a result the .git directory appeared in the output when run as root.
> Simulate no-dotfile ls behaviour using a shell glob.
>
> Signed-off-by: Ed Maste <emaste@FreeBSD.org>
> ---
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> @@ -4,6 +4,13 @@ test_description='sparse checkout builtin tests'
> +# List files in a directory, excluding hidden dot files (such as .git).
> +# This is similar to ls, but some ls implementations include dot files by
> +# default when run as root.
> +list_files() {
> +       (cd "$1" && printf '%s\n' *)
> +}

Nit: While this may indeed be a case for which an explanatory comment
is justified, the comment itself is a bit lacking -- just enough to
keep it from being helpful for the next person who comes along to work
on this code. For instance, the too-abstract "some ls implementations"
doesn't provide enough information to point at a specific 'ls'
implementation if a person needs to do testing against one of these
implementations or wants to know if (say, several years from now) that
anomalous behavior is still present. It would be helpful, therefore,
to mention such an implementation by name:

    ...some 'ls' implementations, such as on FreeBSD, include...

(One can, of course, always argue that the commit message can be
consulted to learn about a particular 'ls' implementation, but then
why have an in-code comment at all?)

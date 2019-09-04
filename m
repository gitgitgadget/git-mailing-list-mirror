Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DBE91F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfIDUaF (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:30:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50711 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDUaF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:30:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so210050wmc.0
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXbXcCqfrZtEuTEQLLMNWT947jLuAe6QoC8CboINIyI=;
        b=HWvP6lYTTDqPTvFfwOXEZFQW8oDVExz06c/LEp2+k0BV5IoSF7OB8736ZBUQ7nyMri
         XZj+kAmSy0z0BmkVps8PlLUneZ5lnl3/l7gJ1PNDFqA1WQEIM61Ws0PkremVvP1UFNcH
         pMYdm3dL1IAUUHWzlWmtGBqQdqW6wzebBcwrPQPR82zhXgnICO4VWD5dwzRUl7aiTR6j
         AKMyXXXw4S5RxFHECmCGOLgXFexJ00p1BOm2fgDKhiwihfWO38g6ROi3md2rQO7ZuiNR
         KErYA8MKl15Iu/QFSyzkmYWpFO4VSMdmUnsheo3ueZCUdnKWZCsuUFuCHkbY78zQuJEW
         9zAA==
X-Gm-Message-State: APjAAAWwgkO1421T7OG4U3IqBpYvbB/rs3CRRQZQEA6CJPjzDrSfMWnA
        2X8l2XFbpJqce6E7tOzBM61AZbealzG4T4Ji4O4=
X-Google-Smtp-Source: APXvYqy1A4OE1hDG/wCw0ws2f7vkhB34oRdMUGEIMEn4ZviIOiPbDawop/YptrfHkGeyYbVmYd9DDMhQx5QqzVPNo9g=
X-Received: by 2002:a05:600c:12:: with SMTP id g18mr78086wmc.95.1567629003105;
 Wed, 04 Sep 2019 13:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
In-Reply-To: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Sep 2019 16:29:52 -0400
Message-ID: <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>, me@yadavpratyush.com,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 4:10 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> The commit message widget does not wrap the next and has a configurable

s/next/text/

> fixed width to avoid creating too wide commit messages. Though this was
> only enforced in the GUI. Now we also check the commit message at commit
> time for long lines and ask the author for confirmation if it exceeds the
> configured line length.

Hmm, more confirmation dialogs tend to mean more annoyance for users,
especially considering that the line length limit is a
project-specific _policy_ (so this has the potential to annoy a lot of
people), and also because there often are legitimate reasons for
exceeding the limit (such as pasting in URLs).

As an alternative to a confirmation dialog, how about instead adding a
_warning_ message (perhaps with red text) on the window itself
alongside to the commit message field (below or above it or
something)? Is that something that could be triggered by a text widget
callback?

> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> ---
> diff --git a/lib/commit.tcl b/lib/commit.tcl
> @@ -215,6 +215,16 @@ A good commit message has the following format:
> +       if {[tcl::mathfunc::max {*}[lmap x [split $msg "\n"] {string length $x}]] >= $repo_config(gui.commitmsgwidth) \

Does this take TABs into account?

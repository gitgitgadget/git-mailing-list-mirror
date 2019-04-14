Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6654220248
	for <e@80x24.org>; Sun, 14 Apr 2019 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfDNXaH (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 19:30:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34895 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfDNXaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 19:30:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so19438934wrp.2
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 16:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ydsOk07L8s8OaM/lVTb+WDpIa5H4W2qIO9T/7HNZKA=;
        b=XejAduvOZZY/L2tu96GNl4TsDQAYqtvA36RARcX2zEX1w8ktHV3m+WJIoxjRVyCa0O
         RGarktqK86quYZ0AQAklg526mTe1yz3VIszD61THXD5DHm0cPb1a/f8rsgLlcexMKwm+
         YCXPXNE5onWnpZMHtG4kYP3XOWa64R7gKTkBG3rFtnPRFEQJ7O9WEeAFfXOZFZsv7iP6
         n2joeSzxHAtCch/DOo8yncOCD5LMyxbYc6OLZ/63Vr6vxWJ9mPtsCfosDqcsPzVlCFTn
         NMubcW8MyiYX3l+ezbKkHTR3IhiLNTxiKC8pClbtJ4ruv3VS9oB77IgXecfH8KmzP3H5
         PlKw==
X-Gm-Message-State: APjAAAWoN3F4RoNcdk9v0XzK9HjljVFupsyFPqEaxOqnoG5xdVuK/yhY
        9qMGcRgetjXf63iQWL8Zry0/SpAjasEbP064rDY=
X-Google-Smtp-Source: APXvYqzNxNtZiODvU7/kt99bSAB2c2X0C9zMNLtlRtwQYlEj237PJEdpcu7XNFxLzqjo9ede3zDzzP76RDWxy5WXE4A=
X-Received: by 2002:adf:d848:: with SMTP id k8mr45860699wrl.185.1555284605503;
 Sun, 14 Apr 2019 16:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190411220532.GG32487@hank.intra.tgummerer.com>
 <20190414210933.20875-1-t.gummerer@gmail.com> <20190414210933.20875-4-t.gummerer@gmail.com>
In-Reply-To: <20190414210933.20875-4-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Apr 2019 19:29:54 -0400
Message-ID: <CAPig+cTJyYLGAfHM_PrZd9DDaZBcVUetcWFcANGCYPvaMh2qxA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] range-diff: add section header instead of diff header
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 14, 2019 at 5:10 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> [...]
> Introduce a new range diff hunk header, that's enclosed by "##",
> similar to how line numbers in diff hunks are enclosed by "@@", and
> give human readable information of what exactly happened to the file,
> including the file name.
> [...]
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> diff --git a/range-diff.c b/range-diff.c
> @@ -90,8 +91,37 @@ static int read_patches(const char *range, struct string_list *list)
> +               } else if (starts_with(line.buf, "--- ")) {
> +                       if (!strcmp(line.buf, "--- /dev/null"))
> +                               strbuf_remove(&line, 0, 4);
> +                       else
> +                               strbuf_remove(&line, 0, 6);
> +                       strbuf_rtrim(&line);
> +                       strbuf_reset(&filename_a);
> +                       strbuf_addbuf(&filename_a, &line);
> +               } else if (starts_with(line.buf, "+++ ")) {

At this point, we know that line.buf starts with "+++"...

> +                       strbuf_addstr(&buf, " ## ");
> +                       if (!strcmp(line.buf, "--- /dev/null"))

so, it seems unlikely that it's ever going to match "--- /dev/null".

> +                               strbuf_remove(&line, 0, 4);
> +                       if (!strcmp(filename_a.buf, "/dev/null")) {
> +                               strbuf_addstr(&buf, "new file ");
> +                               strbuf_addbuf(&buf, &line);
> +                       } else if (!strcmp(line.buf, "/dev/null")) {
> +                               strbuf_addstr(&buf, "removed file ");
> +                               strbuf_addbuf(&buf, &line);
> +                       } else if (strbuf_cmp(&filename_a, &line)) {
> +                               strbuf_addstr(&buf, "renamed file ");
> +                               strbuf_addbuf(&buf, &filename_a);
> +                               strbuf_addstr(&buf, " -> ");
> +                               strbuf_addbuf(&buf, &line);
> +                       } else {
> +                               strbuf_addstr(&buf, "modified file ");
> +                               strbuf_addbuf(&buf, &line);
> +                       }

All of these disposition strings end with "file", which seems
redundant. Short and sweet "new", "removed", "renamed", "modified"
provide just as much useful information.

Also, should these strings be localizable? Alternately, rather than
using prose to describe the disposition, perhaps do so symbolically
(thus universally), say with "+", "-", "->", "*" (or ""),
respectively?

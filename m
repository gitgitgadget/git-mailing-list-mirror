Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA76DC433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 07:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A25E560ED7
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 07:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238187AbhIQHLw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:11:52 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:37565 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhIQHLq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 03:11:46 -0400
Received: by mail-ed1-f49.google.com with SMTP id g21so26384016edw.4
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 00:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6DlhooSohuiDdXE3coev9lZkvTKQH6p1/lZTI225KU=;
        b=Vkq4uX71K6NlDEEyn7E6X3MbnRLJGdtMlFzZJgLbjM1XagunXB4YiQb5Z2Se/RvP4J
         fRRfuRvRKJxA+qW2J7tUeczMSbh74xbvpj78P/oH9xY/p+UJfeyG/zQyYUfvJHCn8pmh
         H4WKkcl1xIQSzd2aq/vtnyCrs7iLRQrDf3cCN87FKqSS+W/zqHG3//u7AqKDkEiP0/Zv
         jmXOY1oOJhFjCLPFvAZzatSH9LUHEZz7KSDxrdfAdCQkNtpE//IR4LXT+F9y3jfvyCyw
         3KHyhzvZd5KdDh/HDRNZmJYpwataO1sOxfuNMiKAcQrRPCONHZy6gxK2Qm0ejr4L9lET
         j2ZA==
X-Gm-Message-State: AOAM530WrbLBc+pOUO05ln/DkJZmN/vhny+N0/XBTvgpV0WZw+yg+Zew
        zPK/TLaFLiB/yplFRiuvmnXtY5Jacv9/rVVry+o=
X-Google-Smtp-Source: ABdhPJz4Mxgs7g6TbSvozwaD2E71KvCuHYibCiQwKZ5VTF5oykjTqtw0A/ZPF/6eGa5D/2mJHCepAUTtt3J9KKJJMTE=
X-Received: by 2002:a17:907:990d:: with SMTP id ka13mr10497793ejc.392.1631862623729;
 Fri, 17 Sep 2021 00:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210916140943.2442184-1-someguy@effective-light.com> <20210916140943.2442184-2-someguy@effective-light.com>
In-Reply-To: <20210916140943.2442184-2-someguy@effective-light.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Sep 2021 03:10:12 -0400
Message-ID: <CAPig+cRfFZ=GAevJ0b9oBGTR8P3MnSg+R43ujSP0dZJL08riqA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pretty: colorize pattern matches in commit messages
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 10:10 AM Hamza Mahfooz
<someguy@effective-light.com> wrote:
> [...]
> Teach the pretty-printer code to highlight matches from the
> "--grep=<pattern>", "--author=<pattern>" and "--committer=<pattern>"
> options (to view the last one, you may have to ask for --pretty=fuller).
> [...]
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

A few relatively superficial comments below...

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> @@ -241,6 +241,14 @@ This setting can be disabled by the `--no-notes` option,
> +color.grep.selected::
> +       Determines the non matching text (background) color of selected lines,
> +       when `--grep`, `--author` or `--committer` are used.
> +
> +color.grep.matchSelected::
> +       Determines the matching text (foreground) color of selected lines, when
> +       `--grep`, `--author` or `--committer` are used.

Should these be documented instead in Documentation/config/color.txt
as entries in the table under `color.grep.<slot>`?

> diff --git a/pretty.c b/pretty.c
> @@ -431,15 +431,74 @@ const char *show_ident_date(const struct ident_split *ident,
> +static inline void strbuf_add_with_color(struct strbuf *sb, const char *color,
> +                                        char *buf, size_t buflen)
> +{
> +       strbuf_add(sb, color, strlen(color));

There is no need to call strlen() here; instead use strbuf_addstr():

    strbuf_addstr(sb, color);

> +       strbuf_add(sb, buf, buflen);
> +       if (strlen(color))
> +               strbuf_add(sb, GIT_COLOR_RESET, strlen(GIT_COLOR_RESET));

Likewise, no need for strlen() in the conditional or when adding the
RESET color:

    if (*color)
        strbuf_addstr(sb, GIT_COLOR_RESET);

> +}
> +
> +static void append_line_with_color(struct strbuf *sb, struct grep_opt *opt,
> +                                  const char *line, size_t linelen,
> +                                  int color, enum grep_context ctx,
> +                                  enum grep_header_field field)
> +{
> +       strbuf_init(&tmp_sb, linelen + 1);

What is the +1 for? Is that to account for the NUL byte at the end of
the string? If so, there's no need to do so manually since strbuf will
take that into account itself.

> +       strbuf_add(&tmp_sb, line, linelen);
> +
> +       buf = tmp_sb.buf;
> +       eol = buf + linelen;

`buf` and `eol` seem like an accident waiting to happen...

> +       line_color = opt->colors[GREP_COLOR_SELECTED];
> +       match_color = opt->colors[GREP_COLOR_MATCH_SELECTED];
> +
> +       while (grep_next_match(opt, buf, eol, ctx, &match, field, eflags)) {
> +               if (match.rm_so == match.rm_eo)
> +                       break;
> +
> +               strbuf_grow(sb, strlen(line_color) + strlen(match_color) +
> +                           (2 * strlen(GIT_COLOR_RESET)));

... because strbuf_grow() may reallocate the underlying buffer, which
means that `buf` and `eol` will end up pointing at freed memory, which
will be accessed by the next call to grep_next_match().

I also wonder if these manual calls to strbuf_grow() and the "hint"
passed to strbuf_init() are actually helping considering that strbuf
should do a pretty good job of managing its underlying buffer growth
without this sort of micromanagement. Have you done performance
testing which indicates that such manual management is beneficial (and
that this isn't a case of premature optimization)?

> +               strbuf_add_with_color(sb, line_color, buf, match.rm_so);
> +               strbuf_add_with_color(sb, match_color, buf + match.rm_so,
> +                                     match.rm_eo - match.rm_so);
> +               buf += match.rm_eo;
> +               eflags = REG_NOTBOL;
> +       }
> +
> +       if (buf != line) {
> +               strbuf_grow(sb, strlen(line_color) + strlen(GIT_COLOR_RESET));
> +               strbuf_add_with_color(sb, line_color, buf, eol - buf);
> +       } else {
> +               strbuf_add(sb, buf, eol - buf);
> +       }

I'm confused by this. How can `buf` ever equal `line` considering that
the above code does:

    strbuf_add(&tmp_sb, line, linelen);
    ...
    buf = tmp_sb.buf;

so that the strbuf contains a _copy_ of `line`, and `buf` is pointing
into the strbuf.

> +       strbuf_release(&tmp_sb);
> +}
> +
>  void pp_user_info(struct pretty_print_context *pp,
>                   const char *what, struct strbuf *sb,
>                   const char *line, const char *encoding)
>  {
> +       struct strbuf id;
> +       enum grep_header_field field = GREP_HEADER_FIELD_MAX;
> +       struct grep_opt *opt = pp->rev ? &pp->rev->grep_filter : NULL;

These new variables only ever seem to be used...

>         if (pp->fmt == CMIT_FMT_ONELINE)
>                 return;
> @@ -496,9 +555,22 @@ void pp_user_info(struct pretty_print_context *pp,
>                         strbuf_addch(sb, '\n');
>                 strbuf_addf(sb, " <%.*s>\n", (int)maillen, mailbuf);
>         } else {
> -               strbuf_addf(sb, "%s: %.*s%.*s <%.*s>\n", what,
> -                           (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0, "    ",
> -                           (int)namelen, namebuf, (int)maillen, mailbuf);

... within this block, so they should be declared here rather than in
the outer block in order to reduce their scope.

> +               strbuf_init(&id, namelen + maillen + 4);

Again, I wonder if this micromanagement of strbuf allocation is a case
of premature optimization.

> +               if (!strcmp(what, "Author"))
> +                       field = GREP_HEADER_AUTHOR;
> +               else if (!strcmp(what, "Commit"))
> +                       field = GREP_HEADER_COMMITTER;
> +
> +               strbuf_addf(sb, "%s: %.*s", what,
> +                           (pp->fmt == CMIT_FMT_FULLER) ? 4 : 0, "    ");

It's subjective, but this may be overly clever and unnecessarily
compact. The slightly more verbose:

    strbuf_addf(sb, "%s: ", what);
    if (pp->fmt == CMIT_FMT_FULLER)
        strbuf_addchars(sb, ' ', 4);

is easier to understand at-a-glance, as is this equivalent:

    strbuf_addf(sb, "%s: ", what);
    if (pp->fmt == CMIT_FMT_FULLER)
        strbuf_addstr(sb, "    ");

> +               strbuf_addf(&id, "%.*s <%.*s>", (int)namelen, namebuf,
> +                           (int)maillen, mailbuf);
> +
> +               append_line_with_color(sb, opt, id.buf, id.len, pp->color,
> +                                      GREP_CONTEXT_HEAD, field);
> +               strbuf_addch(sb, '\n');
> +               strbuf_release(&id);
>         }
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> @@ -449,6 +449,61 @@ test_expect_success !FAIL_PREREQS 'log with various grep.patternType configurati
> +cat > expect << EOF
> +Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
> +EOF
> +
> +test_expect_success 'log --author' '
> +       git log -1 --color=always --author="A U" >log &&
> +       grep Author log >actual.raw &&
> +       test_decode_color <actual.raw >actual &&
> +       test_cmp expect actual
> +'

I realize that you're mirroring how this is done in a few existing
tests in this script, but these days we like to place all code,
including creation of the `expect` file, inside the test body. Also,
style guidelines state that there shouldn't be any whitespace
following the `>` and `<<` operators. Finally, since no variables need
to be interpolated into the here-doc content, we use `\EOF` instead of
`EOF`, and since we want to indent the here-doc content inside the
test body, we use `-\EOF`. So:

    test_expect_success 'log --author' '
        cat >expect <<-\EOF
        Author: <BOLD;RED>A U<RESET> Thor <author@example.com>
        EOF
        ...

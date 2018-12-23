Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EED8820A1E
	for <e@80x24.org>; Sun, 23 Dec 2018 22:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbeLWWlh (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 17:41:37 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34861 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeLWWlh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 17:41:37 -0500
Received: by mail-oi1-f177.google.com with SMTP id v6so8930404oif.2
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 14:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9+Yjhu6E2MS6gHMSSdrqxaKJ4Q1Y1lonINcXjsz/6OM=;
        b=l/HRYLgc3DNAwzdYCWvc9CfiLsaNvGmXLxyfacey6iXOYs8JnlIHKhRWmlFBp5CU/T
         XjL+3jqxhyLx+SfvFl89IHIlSnNkVj8Bi29oYwfsFCvgOTzpyooeGFwJuLRemE1n66mu
         bnuOXff3z1V2m+aw1RbbdboKKdnGS5xLacey61H8X4aH7fkCsS+8TvkeiJcmXYskqc0v
         u+FbsXrlcUAff/xkvX0F3V4ON7iTuT+uF2W+1ULCjDZpLyn5CCi3c8YcyUXcOCpI8OAq
         pqMMS5KmXxh4juMlEq0BFhsACyzsz6IM0Yj3/6hm1rDExvrE0cylFe+YQ/7OOi+1DAHN
         SkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9+Yjhu6E2MS6gHMSSdrqxaKJ4Q1Y1lonINcXjsz/6OM=;
        b=D8juIID4QDiV/+UpVkfe08OxAwFijYke0omT6tGHOQ8Q7lIXIuFaN/hO8tylpPb0uH
         jkicoAw69PABvYFZ01oqx5ICIYql9JaDrPYHrTYKPkdeCKsyWNSrxBw7wHZCE/xoZhp1
         Y7BCmdcjijA3eLB6HRtoKEDKaCMIJ8VYeehBJwA+A89Cl75X+LPz/y0kZDnngSE64x6K
         hvHNJYnl5id4ZExMe8ny9hwlYyGoTkTSats6fLvN47GDLUz0yGMUrCZHJstzKxIyrFh8
         XIhrmorDi8k6gA5NPzqFmhNSDwvo4cFLNSBC1eJAuHpP6egUEjHlTdTS9bT6aYdegtWJ
         pOPg==
X-Gm-Message-State: AA+aEWZ3BbWVEaBJ10rd8XfMWR90wlxom+tWRaEXqlGt7zdBH5EkQ96J
        2weRoXoJDig/WWFdiXWSZOCgC6wjZgV5kx7nZpWwyP1h
X-Google-Smtp-Source: ALg8bN7h4+2o7ow9Y6fITNkq+M/3DJ1yytOuovjJaAakYV1eJfRrkdLybumujcKw5aDXobefJQFbzbdc4bo2JvaVmAE=
X-Received: by 2002:a05:6808:159:: with SMTP id h25mr6437996oie.285.1545604896224;
 Sun, 23 Dec 2018 14:41:36 -0800 (PST)
MIME-Version: 1.0
From:   William Chargin <wchargin@gmail.com>
Date:   Sun, 23 Dec 2018 14:41:20 -0800
Message-ID: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
Subject: Parsing trailers
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm interested in parsing the output of `git-interpret-trailers` in a
script. I had hoped that the `--parse` option would make this easy, but
it seems that the `trailer.separators` configuration option is used to
specify both the input format (which separators may indicate a trailer)
and the output format of `git interpret-trailers --parse`. Given that
`trailer.separators` may contain any (non-NUL) characters, including
whitespace, parsing the output is not straightforward.

Here's what I've come up with. The output format is "<tok><sep> <val>",
where "<tok>" and "<val>" have been trimmed and so have no leading or
trailing whitespace, but "<val>" may have internal whitespace while
"<tok>" may not. Thus, the first space character in the output may
correspond to either "<sep>" or the fixed space, but we should be able
to determine which is the case: the first space is immediately followed
by a second space if and only if the first space corresponds to "<sep>".

Assuming that the above analysis is correct, the following procedure
should suffice to safely parse the output:

  - Let `i` be the index of the first space in `s`.
  - If `s[i+1]` is a space, let `sep_pos` be `i`. Otherwise, let
    `sep_pos` be `i - 1`.
  - The substring `s[:sep_pos]` is the token.
  - The character at index `sep_pos` is the separator.
  - The character at index `sep_pos + 1` is the fixed space.
  - The substring `s[sep_pos+2:nl]` is the value, where `nl` is the
    index of the first newline in `s` after `sep_pos`.

(It seems unfortunately complicated when all we want to do is parse the
output of `--parse`, but I don't see a better approach!)

My questions:

  - Is this accurate?
  - Is this algorithm guaranteed to remain correct in future versions of
    Git?
  - Is there a simpler way to extract the token-value pairs from a
    commit message string?

Would appreciate any advice.

Thanks!
WC

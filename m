Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B15D61F453
	for <e@80x24.org>; Thu, 31 Jan 2019 08:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfAaI5n (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 03:57:43 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:45009 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfAaI5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 03:57:43 -0500
Received: by mail-ua1-f46.google.com with SMTP id d19so755855uaq.11
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 00:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jnfrGReIPAEP5Z0pRGUtyGYHthhIfWKw9BKywxqtkr4=;
        b=QBS8Ayi06CFckuaVVfdWTp7JYKI7+l2sea/rzYhBxhY9Ii8af6JmZxn4y137LBeOKX
         T4/BfrxSZmDAGrTOaowT0nYQelrL2BQiY+ZVI37lv90YZIvdOomH6x3NGWGfbzbgvqh7
         juavDxk/ruxNtlBnEuuQEkZ9MZU3rVpNM2UOKE2SM64yYpeJ4GcCTCNc56FqtHvI/ndJ
         66uJ+FR0iiY7F4QG8bCsBIvZW/EGy7kEaDLTtHBEI2ghJiVhpUphYO6LLQAD9MZkd7vo
         lSFj9S+HCmfmEr6QpAnrT7sQq+0xhpqFPbkrsHLLTk+5ZhR4lISnLca49k6YUdIVzEaz
         7hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jnfrGReIPAEP5Z0pRGUtyGYHthhIfWKw9BKywxqtkr4=;
        b=O6GlpejJjJb1yuGqVB7KncKSH/A5LosPrQNSJEvZt5PdXsaxINnkbReTCYXg1KMCOg
         xXDCz2dk6lpz24x3wQMyEpD6TP96+Y4PrTJOqlvUHcdM0AO9mVHkakaP+myE2WodGJNU
         3Ee/BBRuMc/WTG67wXhd7tRcMzH8adtQUUP2M4oWYBgSL4S2P3V0SPkOGJ49n+wyl5g5
         SchYfPbn/X2pURXloNaZKP4we72UpHxN/aVADFWHfS6qNhVUQj9qySepll6TWUOP7A/j
         owN7Y8iNJ2Q+lRC9oYDuqUViCJIsq7EbDxMEwjZA2m0J5XGoiZI6Fts5znpSh4GunJLR
         A4UQ==
X-Gm-Message-State: AJcUukcBasmD7NH0p2LFR/89wwVXlmGHhjW+WrcBhMWdZ04l2KVsq+ti
        EMnHNhPhyQdnOHsbqwoiQmwWOTlutdUxBSMM1L8m7cUdxQE=
X-Google-Smtp-Source: ALg8bN5LhJLRkBp/s7NbQQq/sw1EQI/jUxZVpeC3+u0dUhzmpEZp1VSUGGvMNIi/OjfA8oF9fCif00llWfP+TijmzLg=
X-Received: by 2002:ab0:216:: with SMTP id 22mr13797643uas.28.1548925061999;
 Thu, 31 Jan 2019 00:57:41 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 31 Jan 2019 00:57:36 -0800
Message-ID: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
Subject: New command/tool: git filter-repo
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

git-filter-repo[1], a filter-branch-like tool for rewriting repository
history, is ready for more widespread testing and feedback.  The rough
edges I previously mentioned have been fixed, and it has several useful
features already, though more development work is ongoing (docs are a
bit sparse right now, though -h provides some help).

Why filter-repo vs. filter-branch?

  * filter-branch is extremely to unusably slow (multiple orders of
    magnitude slower than it should be) for non-trivial repositories.

  * filter-branch made a number of usability choices that are okay for
    small repos, but these choices sometimes conflict as more options
    are combined, and the overall usability often causes difficulties
    for users trying to work with intermediate or larger repos.

  * filter-branch is missing some basic features.

The first two are intrinsic to filter-branch's design at this point
and cannot be backward-compatibly fixed.

Requirements:
  * Python 2 (for now?)
  * A version of git with en/fast-export-import topic (in master of git.git)
  * A version of git with the --combined-all-names option to diff-tree;
    I have submitted[2] this patch, but it hasn't been picked up yet.

What's the future?  (Core command of git.git?  place it in contrib?  keep it
in a separate repo?)  I'm hoping to discuss that at the contributor summit
today, but feedback on the list is also welcome.


Thanks,
Elijah

[1] https://github.com/newren/git-filter-repo; it's a ~2800 line
    single-file python script, depending only on the python standard
    library (and execution of git commands), all of which is designed
    to make build/installation trivial: you just need to add it to
    your $PATH.
[2] https://public-inbox.org/git/20190126221811.20241-1-newren@gmail.com/

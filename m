Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5681EC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 07:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3861061002
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 07:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhJYHl5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJYHl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 03:41:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD249C061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 00:39:34 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q187so10096335pgq.2
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=0EnAOkRdhP1/qXLILUZGika0hagEnJeP+Q9AVDD9DYc=;
        b=U2DrUBfiLnsGdrsTDvn62xO68zSzRfw0ZtNJViKxNIGxGY1s5VoNtJ5jk6GuFLIUyU
         oy/bv9IO7eCzh7ESgsBObkEqbokSh5x819nzsHKyB+8vCXr1p/1yRjuMTkl8jg0fZhtM
         AC6D0nTbKa+CZh7T8XG7nQQvG7sE58JZZRqcsLo8knDUxXsmkRCGrrX+WuqACKPaWHg3
         /SJLQDx702v0vtyxw3cnrwq+DIzPdHxc+5MrsTHJACuPMbrKzvhqMtmtwiBYUDIAQeQO
         ZmvW1QaPqJ6ICpdTye0ZAbShR5wSBbAxcwGj422oIXkCT4tBT/8cON10whCnyq8WjY/O
         2/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0EnAOkRdhP1/qXLILUZGika0hagEnJeP+Q9AVDD9DYc=;
        b=On8gz0TEccSCOUFOMq+/SN8/9sfKTZkeU27oOzf/Xt3M+vM6CqKg4L/tDL/1Yj/eu2
         gZODf2I746y3580QdZUftgllqklI8HW+WeqTFUsW3ge8KoyTjUH9EtRmXEO37bmsEakq
         lOM9BCO/Ek35+L8a2n+Hx/WtksmrBxsjgMlbXknztdTOxqvq5hhr5JQGw0jKYrBnsVSK
         R8Oe0IGset7ua3hJH6iLk8hKFxPtMLXou4aPVjKSBwhxt6dHkwgFWwpUaLWCN8khR3q0
         okCxUWxotOkbsvx9wnuUPsXW7GcG1A/dyVtMhUUB7AppwhdogZJl9nIc7MGAUGm7KrEM
         /Aog==
X-Gm-Message-State: AOAM5338ffTSFxLc2ST+TmDLycdkA2cWJgaPwNsIowB+hX55txqtqAkR
        VKSmFVXqQezP1/L39FnN8qO0pNGTkF60hg0+5uQeVSPZzzY=
X-Google-Smtp-Source: ABdhPJxb7M8nGb5HASgo/R1jrpk53qBk6dqBIwBgn7MZqRuV7dq2bxxhz86/W5n9FPk5kccArmQFnKATxVOpocLgZJo=
X-Received: by 2002:a63:7418:: with SMTP id p24mr2186210pgc.204.1635147574212;
 Mon, 25 Oct 2021 00:39:34 -0700 (PDT)
MIME-Version: 1.0
From:   Yiyuan guo <yguoaz@gmail.com>
Date:   Mon, 25 Oct 2021 15:39:23 +0800
Message-ID: <CAM7=BFoQ3-VfES+n-pH7Oukq1PODVbE9Uu9Y-4XuSA5SjQo=uw@mail.gmail.com>
Subject: [BUG] Integer overflow bug in cache-tree.c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the file cache-tree.c, the function "static struct cache_tree
*read_one(const char **buffer, unsigned long *size_p)"
has the following code
(link:https://github.com/git/git/blob/9d530dc0024503ab4218fe6c4395b8a0aa245478/cache-tree.c#L592-#L593):

int subtree_nr;
subtree_nr = strtol(cp, &ep, 10);

it->subtree_alloc = subtree_nr + 2;
CALLOC_ARRAY(it->down, it->subtree_alloc);

The variable subtree_nr is converted from the string buffer. Suppose
it equals INT_MAX, the computation of
it->subtree_alloc can trigger a signed integer overflow, which is
later used to calculate allocation size.

This can cause security problems if the function do_read_index is
given a crafted index file.

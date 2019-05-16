Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A341F461
	for <e@80x24.org>; Thu, 16 May 2019 11:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEPLdP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 07:33:15 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54930 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEPLdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 07:33:15 -0400
Received: by mail-wm1-f51.google.com with SMTP id i3so3243383wml.4
        for <git@vger.kernel.org>; Thu, 16 May 2019 04:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcxcVNxdhxxIHZuNctI10dNd/edC+iT6GFu7ua0wv78=;
        b=h30PjGqChXUSteCi5OrRDhXM46J3luOFDD3+X0Q7bEBqEcVhKih8KmlSRzZx7ea0FD
         qKdZpNeo5N16DpCi7xV9mc48+569QW0VSsDSmui7GGSheGJYPvknPAVuYbEN2K1k6756
         e5/w130qIvQ0CyvkeKDPS1UMct87QL71c+UjPi0cbcXxL91ruPTkszv3IBYTR9R8vEIC
         j67mQOucngmtMhIVuk1mhDMaQMVmYEk7jSZwsZTytJi/sYDDlQg0k/GAmc4S94DtTsvr
         QF/e3wq8WsX3dIZDXiezw40nNgk4b3SToSB4whNyDKAeChGagiCeQO/oapzzuGWVAyjn
         PPKw==
X-Gm-Message-State: APjAAAWuTNrF6rS6SqEudWGWMmdZJMrqzUNru5xS9LKZzcw3SAQv6GIm
        enERIX30yuKPTDTu2jGUycR+/0yP4YXwR2OLQ6VoXTyd
X-Google-Smtp-Source: APXvYqx0jzo78a6h70lPViqDYRo/lgDbqsMyoPihq8vXGsQOO2x72pCW0jlUnzLhHB74IQsUe0DmMOLNwtzr9y8SWsE=
X-Received: by 2002:a1c:760f:: with SMTP id r15mr14182887wmc.134.1558006392906;
 Thu, 16 May 2019 04:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJFQqN+Z9eX6onaj8vVSqpvf-nOC7-Y0Un4NLUie6x6bGfmvZA@mail.gmail.com>
 <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
In-Reply-To: <CACsJy8DnkjuZD-9pbhAsFo16jHKt8U831LLxb3-nCQP5_FOmtA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 May 2019 07:33:02 -0400
Message-ID: <CAPig+cTQrF1W4LEgOiEoKn4f69OEygFat=4V8aTzf0Rxom2hEw@mail.gmail.com>
Subject: Re: Running 'git worktree add' in 'pre-commit' hook
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Cosmin Polifronie <oppturbv@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 7:25 AM Duy Nguyen <pclouds@gmail.com> wrote:
> pre-commit hook sets GIT_INDEX_FILE to this "index.lock" so you have
> the latest index content (which is not the same as from
> $GIT_DIR/index). This variable will interfere with any commands that
> work on a different worktree.
>
> So you probably can still make it work by backing up $GIT_INDEX_FILE
> (in case you need it), then unset it before you use "git worktree" (or
> cd to it if you keep a permanent separate worktree for pre-commit
> activities). To make sure you don't have similar problems, you
> probably should do "env | grep GIT" from the hook and see if any other
> variables are set.

I researched this also and concluded that it's a bug in git-commit.
You run afoul of it in other situations, as well. For instance, say
you have your index file in a non-standard location:

    $ export GIT_INDEX_FILE=../storage/index
    $ git worktree add --detach other
    Preparing worktree (detached HEAD c9156d2)
    fatal: Unable to create '/.../foo/other/../storage/index.lock': No
such file or directory
    $

I think the correct fix is for git-commit to assign GIT_INDEX_FILE
with the absolute path to the index file, not a relative path.

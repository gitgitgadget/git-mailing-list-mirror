Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74351F597
	for <e@80x24.org>; Fri,  3 Aug 2018 07:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeHCJy6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 05:54:58 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43288 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeHCJy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 05:54:58 -0400
Received: by mail-yb0-f194.google.com with SMTP id y3-v6so2332030ybo.10
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 00:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5//MMRvtZqiWcf474K0rPgkIJmf8EdXXu5ulPwovX94=;
        b=rs/gkhp+HCe7+qGE32OHVXlp4Z8ajvAD2O2kUZCMbDAGLG9kdqIDrYisyr8+yZHyth
         vjaZkYXsiVeoLw7T/ETA/t0x/i3qkNh8P6K3phoNqNu+MRDst7qI4sokjlPjvJoCQ/s4
         PcVhdEfo10hre2WQhSr6D7Q21NroHkpI+NjfWmuXPGa/nn75wtK1cQLEz5oAickCU2AG
         UsPahpiHySRL69n8I44Y6/I9VjpXKL/K/JPBi2tZvj6iWs4eSBc8UdyhCB0j3S4MrTBl
         YFLSJsIMHt21YK4QvRZdsFZEIJe6g94NA2nm7JkScQ3i/rZxLjWCjze23H2piaqbQCKZ
         DYIQ==
X-Gm-Message-State: AOUpUlERjGAUNHcl6GTjLSVO63ctsuIgvvaWy38khmRLCODGGL+laEgn
        412wvALfTAF+eJTa6QpHuNBIVTziusxT3wbVlvg=
X-Google-Smtp-Source: AAOMgpcKUlXrIoURCB0e0iYgz5abHWHxC1oXPuOhJGd90Vxzbwbt+mzJQZdWIy58NRF7ZWfHrz0ZSs8r8XWLxtcIRyE=
X-Received: by 2002:a25:2d28:: with SMTP id t40-v6mr403836ybt.497.1533283191128;
 Fri, 03 Aug 2018 00:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net> <20180802112002.720-3-phillip.wood@talktalk.net>
 <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 3 Aug 2018 03:59:39 -0400
Message-ID: <CAPig+cQaaHfkR8jrXb-+PB4bSZbKLQzRkZNo+DNfz92hKO=04Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 2, 2018 at 1:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
> > For other interactive rebases this only affects external scripts that
> > read the author script and users whose git is upgraded from the shell
> > version of rebase -i while rebase was stopped when the author contains
> > "'". This is because the parsing in read_env_script() expected the
> > broken quoting.
>
> I wasn't following the discussion, but is it the general consensus
> that reading the broken a-i file is a requirement for the new code?
> Not an objection phrased as a question.
>
> I do not think it is worth worrying about the "upgrade while rebase
> was in progress" case, if it involves much more code than necessary
> without its support, especially if the only thing the user needs to
> do recover from such a situation is to say "rebase --abort" and then
> to retry the same rebase with the fixed version that was installed
> in the meantime. [...]
>
> [...] It still does look
> unnecessarily ugly and over-engineered to have this (and the
> "version" reading code), though, at least to me, but perhaps it is
> just me.

It's not just you. I also questioned[1] if such backward compatibility
was needed, and had concerns[2] about a version file being heavyweight
and over-engineered.

This is a lot of new code (possibly harboring its own bugs) for a
situation unlikely to arise, and which becomes ever more unlikely as
time passes. Also, unlike long-lived (years or decades) resources,
such as a repository or pack file, for instance, for which a version
number makes sense, this file is very short-lived, which makes it even
more difficult to justify adding this much machinery for something so
unlikely to arise in practice.

The overall aim of this series to fix these bugs is laudable, but I
would be happy to see this one reduced to just a "bug fix" patch
without all the backward-compatibility machinery (and wouldn't mind
seeing patch 1/2 simplified[3], as well).

Thanks.

[1]: https://public-inbox.org/git/CAPig+cR5VHP8muo5_A_9t7OPZam8O_uPb0nd73B15Ye92n+p7Q@mail.gmail.com/
[2]: https://public-inbox.org/git/CAPig+cTttbV2FjnoS_SZtwh2J4wwzsbK+48BAbt1cV0utynYzw@mail.gmail.com/
[3]: https://public-inbox.org/git/CAPig+cSZ3Zm=qFcvGjyj_uStn=JMAYuskMa0O_2yxkKjaRWTSg@mail.gmail.com/

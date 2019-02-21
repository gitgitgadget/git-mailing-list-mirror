Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684261F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfBURMj convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 21 Feb 2019 12:12:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43783 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfBURMj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:12:39 -0500
Received: by mail-io1-f67.google.com with SMTP id y6so2323531ioq.10
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 09:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IjibgQdeYdvJZ12Vc93g/ta4iGvJLN0Do1fHHvlOQjs=;
        b=tHN6q7sa+Yf1vL/NxsOglMa6HKNyh6zVu4WMHKyh3jyVCNqHa6pAeJ4lPnNL4aG8Ic
         PJBMs1gW6WEa+PMcEOZcsDeuyhSTe/ZIIQHAja9IpDnxbuZBiUtdmCqiVaJFrUGdXyAC
         oGK8F4ujmad7YQhKFeGTsdVFyZsatGE87l7JorktB70ddvV5w/AXR4q9DBeU+S/igecq
         NGzbLRtaiAKPdH15gCxWd0jmASghDT0mtUOfEhDYYVmWyhhmJSFbP0SBeTQ1zesEGQVP
         YDdPW5SSnPL8TQmgvLErQEb9m43uSBdt4S6N7+FPdelI0y8Tt50FSU8LNwMZ68DXJ9g2
         7s2Q==
X-Gm-Message-State: AHQUAuaIXw4is4I79G6wgYkFgQZtZxsaaBZonAiZvG/BUeTyjeGVXXaq
        dv5tgDg65GkHrzmRl9vNmjm0oyYgV1in3Rvg7R8=
X-Google-Smtp-Source: AHgI3Ia6ZWBsncg54LoQSkOXv9G08Qt47mWTnRX/r1o8rossqA74GXHfXVooG6MnPBU4E/mSmYkeL8vbI0VTHfjuKpQ=
X-Received: by 2002:a6b:760d:: with SMTP id g13mr17877726iom.273.1550769158432;
 Thu, 21 Feb 2019 09:12:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550508544.git.msuchanek@suse.de> <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
 <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
 <20190221145056.53b98b2a@kitsune.suse.cz> <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
In-Reply-To: <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 21 Feb 2019 12:12:28 -0500
Message-ID: <CAPig+cTQMZFF-oX-SOzB5JR=V1WThBihC+kNm-2wjbpAWf-OHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 12:07 PM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 21/02/2019 13:50, Michal Suchánek wrote:
> >> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:
> > The problem is we don't forbid worktree names ending with ".lock".
> > Which means that if we start to forbid them now existing worktrees
> > might become inaccessible.
>
> I think it is also racy as the renaming breaks the use of mkdir erroring
> out if the directory already exists. One solution is to have a lock
> entry in $GIT_COMMON_DIR/worktree-locks and make sure the code that
> iterates over the entries in $GIT_COMMON_DIR/worktrees skips any that
> have a corresponding ignores in $GIT_COMMON_DIR/worktree-locks. If the
> worktree-locks/<dir> is created before worktree/<dir> then it should be
> race free (you will have to remove the lock if the real entry cannot be
> created and then increment the counter and try again). Entries could
> also be locked on removal to prevent a race there.

I wonder, though, how much this helps or hinders the use-case which
prompted this patch series in the first place; to wit, creating
hundreds or thousands of worktrees. Doing so serially was too slow, so
the many "git worktree add" invocations were instead run in parallel
(which led to "discovery" of race conditions). Using a global worktree
lock would serialize worktree creation, thus slowing it down once
again.

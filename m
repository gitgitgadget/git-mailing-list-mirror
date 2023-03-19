Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F429C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 19:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCSTey (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCSTew (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 15:34:52 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2380413DFA
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 12:34:49 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AD5631F428;
        Sun, 19 Mar 2023 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1679254489;
        bh=dTUsK/OiCaO4qMCv4Zp5DXlyoN7375tsqnrOSLZwlTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKd6vyBUJUbBy8Bu/O0Q6aeQI665qH+/0c0xBmU2atn6r4/TKMtQShz+PpJOka9/p
         4lh0Iv3+7Sr+FLhovUZw1W290A8wHlh6y4/OK1wJYiwHN1409G0Vjq1HJuSIcXLd8x
         CHlCxZeU8V7FedgLFcBuX1w1zAMget0yPG/ahn5A=
Date:   Sun, 19 Mar 2023 19:34:49 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Paul Eggert <eggert@cs.ucla.edu>
Subject: Re: [PATCH 2/2] git-compat-util: use gettimeofday for current time
Message-ID: <20230319193449.M629601@dcvr>
References: <20230319064353.686226-1-eggert@cs.ucla.edu>
 <20230319064353.686226-3-eggert@cs.ucla.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230319064353.686226-3-eggert@cs.ucla.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Eggert <eggert@cs.ucla.edu> wrote:
> Use gettimeofday instead of time(NULL) to get current time.
> This avoids clock skew on glibc 2.31+ on Linux, where in the
> first 1 to 2.5 ms of every second, time(NULL) returns a
> value that is one less than the tv_sec part of
> higher-resolution timestamps such as those returned by
> gettimeofday or timespec_get, or those in the file system.
> There are similar clock skew problems on AIX and MS-Windows,
> which have problems in the first 5 ms of every second.

Wow, this is enlightening... and unfortunate :<

I decided to check glibc archives to find more discussion on it.
So far, I've found:

  https://inbox.sourceware.org/libc-alpha/20230306160321.2942372-1-adhemerval.zanella@linaro.org/T/

and the original bug:
  https://sourceware.org/bugzilla/show_bug.cgi?id=30200

And this is due to the time64 changes in glibc 2.31+?
(<= 2.30 isn't affected?)

<snip>

> Yet another possibility would be to fix the Linux kernel so
> that the time syscall is consistent with the other timestamp
> syscalls.  I suppose this has not been done due to
> performance implications.  (Git's use of timestamps is rare
> enough that performance is not a significant consideration
> for git.)  However, this wouldn't fix Git's problem on older
> Linux kernels, or on AIX or MS-Windows.

Agreed on the older kernels and other OSes part.

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F40420970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbdDKTqd (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:46:33 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34047 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdDKTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:46:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id c198so3115886pfc.1
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 12:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rSIwr1gC4DKLIp9d6WRtV/h4K3ZdQeSEPgimVmfHTIo=;
        b=H89ww+OZELCjFSU8maeAIaeg+DDIQec+GvBSwVmd+RNxVmGout8xwJjpBrGaptdjNh
         VTlMsi5Lww4O5y3yNta5vmkFTJh4Bxok3pSf23aJql1XXG1qZ+jY8eLbnWbyAEhlli8a
         j3UPnWr+m3mZBNVNm2BgByk89XtDd8u7qByvxS0HUwBuWKLQmV7ZfXOpmIi5yU8B0VV0
         tXHWpEQ4CIWjsGf8gNJXoaF4otySKkX+pWDMApwourjm4/t/8xsXlyhTSj2bqs9646tl
         0JknJ1hL1HB2CsbNJy4f06OifHZ9QUsq0v3Z17c4WOZx9eqpDisO0b2X2LJOhVr1fBGx
         uBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rSIwr1gC4DKLIp9d6WRtV/h4K3ZdQeSEPgimVmfHTIo=;
        b=R3RslUQ1ziX3PcmC3lPYeM55qrGbiZjbJr7e2A9yM9TT7YCGiTDPzezBlyPggPZVzs
         7/3GSnqbriT51Lokvd1VbxR4Gfhsi7bHdiFWHhRJNnEVKzddEL+FrTPjrxhONqef4Vnt
         oSfmMuQBU4G9gpNBYtTrOYUp4LDUanEsrZ5Qqg46rJJUQndtEQEubc04fyj12PcgdAwZ
         mN1zkPbYcK1NLZy1oAnPCI83SyyZ/9fAj17WzTOMatHFYGo258wfbpDMD5peAUxnwrN/
         WIB8vvOmpLkINKLYdttr+cH3MPtqsbDmucGRnf48tDkT2e8MbM/E5ZCdJNsuI3sAa0Xa
         38qg==
X-Gm-Message-State: AFeK/H1T8alDoGjVsYHwFJeKj+fGZfTbVkde6XDMeXl1WQE64NZmAsAZMOqGo3YTQn0rPiEc
X-Received: by 10.98.192.25 with SMTP id x25mr63952958pff.158.1491939991301;
        Tue, 11 Apr 2017 12:46:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8428:a428:cb31:88df])
        by smtp.gmail.com with ESMTPSA id s27sm32105606pfi.10.2017.04.11.12.46.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 12:46:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, maxime.viargues@serato.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] clone: record submodule alternates when not recursing
Date:   Tue, 11 Apr 2017 12:46:14 -0700
Message-Id: <20170411194616.4963-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The meat is in the second patch:
    The commit 31224cbdc7 (clone: recursive and reference option triggers
    submodule alternates, 2016-08-17) argued for any further `submodule update`
    to respect the initial setup. This is not the case if you only pass
    '--reference[-if-able]' to the initial clone without instructing to
    recurse into submodules.
    
    If there are submodules however the user is likely to later run
    a 'submodule update --init' to obtain the submodules. In this case we
    also want to have the references available.

The first patch produces a nice helper function and some refactoring.

Thanks,
Stefan

Stefan Beller (2):
  submodule.c: add has_submodules to check if we have any submodules
  clone: remember references for submodules even when not recursing

 builtin/checkout.c          |  2 +-
 builtin/clone.c             |  8 +++--
 builtin/fetch.c             |  2 +-
 builtin/read-tree.c         |  2 +-
 builtin/submodule--helper.c |  6 ++--
 submodule.c                 | 78 +++++++++++++++++++++++++++++++++++----------
 submodule.h                 |  8 ++++-
 unpack-trees.c              |  2 +-
 8 files changed, 82 insertions(+), 26 deletions(-)

-- 
2.12.2.575.gb14f27f917


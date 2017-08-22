Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56691F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbdHVXIt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:08:49 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35791 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdHVXIs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:08:48 -0400
Received: by mail-yw0-f176.google.com with SMTP id s187so804998ywf.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SEvdQyku3lmGG5s2GCh56+bTv3TktQylCZg9Kee9+FU=;
        b=b+fmd1XY9TPVGDWHpZFa+s0vaNJU8ZH45mX2TqZYwZEVBY2+x0TUQI9iMxLKMJK3hQ
         UMGK+gIj0IaIaDFVL5m6YaItPKt0JadcwD5M7u0x+vT5PBaGSIPj5oiRB+iwln8KOPpN
         CyV1ABEx4ub5ohflaMGubDCG1xjlTOXR5LB0jPMBZ2+cw63cvWHKdN9fFR58p0a5ZMfF
         9Jd2NBb9IPK/TfcsiSHU3Y1uD7+0YhWvxN1dSSI+rF4zzIfcrIm7LkEjo2lT7IL7qREx
         TclxA4tdVne/esKRlUY72QiOaqH1ny+uKUehCLSPRgpMFUTcuFtqbO72YFzegVCcjgdV
         wErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SEvdQyku3lmGG5s2GCh56+bTv3TktQylCZg9Kee9+FU=;
        b=RwCDE9dvVpNZiR2nYrQnPnmKsPG+65D5CUIQazjQYENzykNUlH9BfHxMMIH9XX3wSR
         3GgXsSHhpGWp9TX4ARopQs6kzO5HmzT/j1Do0J/hDEP9x7CyqO2JQf9Phopw3ILGAtVb
         4xSUdS1fxrpPS7L0IiVQLTB22S84UhT62FNpYyjKU3Zw+zF87pji9kfagO3lGVgLcK1U
         A6D4VBWcJini/bAnK/cUPd0D20mDNAvQC8JlCX47atW1PHJ4mko31Wmzv3GU48vK5sxd
         lPhVb1pkBn5zLbYiFYlvP2h+eC/yTy0M/EPJQp36NFqMebL+2DyLiyh8K9nkNUzV6w74
         oU8w==
X-Gm-Message-State: AHYfb5gNwOkHGNtToLqo7SjHB3DuFyiTQwHeKlgROHYANfTO+YRIw7vm
        TwBA+HFuWz1bbRKV5Hf1g+9jtZ7XLkX/0Z/Dmw==
X-Received: by 10.13.212.149 with SMTP id w143mr656663ywd.4.1503443327442;
 Tue, 22 Aug 2017 16:08:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 16:08:46 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 16:08:46 -0700
Message-ID: <CAGZ79kYinci-OWXV2VfScLPcUDCHyhSb=7TxTWUWHPnKV5PuDA@mail.gmail.com>
Subject: [BUG] rebase -i with empty commits + exec
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently I am working on a longer series, for which I decided
to keep track of progress in an empty commit. This empty commit
is in the middle of the series (to divide the commits into two sets,
the foundation that I consider stable and the later parts that are not
as stable for my development, they contain things that may be useful)

Then I invoked "git rebase -i <base> -x make" to see
in which shape the series is.

The editor opened proposing the following instruction sheet,
which in my opinion is buggy:

    pick 1234 some commit
    exec make
    pick 2345 another commit
    exec make
    pick 3456 third commit
    # pick 4567 empty commit
    exec make
    pick 5678  yet another commit
    exec make

I think the lines of the empty commit and the following exec should
be swapped, because that exec should work on the third commit.
Maybe we'd want to see another commented exec:

    pick 1234 some commit
    exec make
    pick 2345 another commit
    exec make
    pick 3456 third commit
    exec make
    # pick 4567 empty commit
    # exec make <- unsure about this line
    pick 5678  yet another commit
    exec make

Thoughts?

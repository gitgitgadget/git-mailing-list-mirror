Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DFA520756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbdAJUmq (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:42:46 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33338 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdAJUmj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:39 -0500
Received: by mail-qk0-f169.google.com with SMTP id s140so165029458qke.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6RGqe6tc9wt0av7+gUYYakEZHkVrid9RSUAkIcTciE4=;
        b=iuxvIvgQsOmwZDF5qpralfK9je7zPyn+WbpGpa7M5goqUdwX46NIZKt6v+aI90APF/
         kcIJabjZ6n1I8Io1u42glGBObXfHK3XM0g2PnjW0E2fYijw8V2zh7FMNXw62nI5Uu5QS
         4VF5TdN7NtRvpRVhLopc4fgRSpr37M8+B6oT3ALJ7sZbsE0uj0oilNoBUyont0dzpHSj
         7Af3/xVu7kNEjfdTgP8ty3/tJNvAbzdcbx6/qiQ2f2EgW7uhYXQTVbYPmx6tB7TJwcK+
         uU1uXEXq25t+U+zaAsXkZdBSj1zT7uSqWwpO5k0mm+zb18qUlUi0xJGc3Bz8erLJTKmc
         O+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6RGqe6tc9wt0av7+gUYYakEZHkVrid9RSUAkIcTciE4=;
        b=EG1w5blCfdEFIEe1OIb3GiH5YrzHQjDR9KtqTZUnBQWPEiAnseWWnTtT86xPzUMgab
         8j0QSA6Lbd6kU58afIQug56qyouR+CK3fF5eVjFETKZ0pGhYC50kVvglpBfknjKtWNw/
         JnvZHtWKxt4MdMyyk2KFg/bpPFgD9NXKkeCAgo8ctNA5mXJvTh6mMYUBhVHXodzOCOZp
         jczFoEUfcW9ExUcr0WK4xOaEBO/bH1g9g+OiOIa+oFoBFEhiRnVW2gGkPk4fKr7TSIfb
         acrC2Gv5SjEEtN2vGKsr1nN36oX6qOMttfE7g3pr1lWqONTByawQmkqiuJCodWljCNY+
         +vrA==
X-Gm-Message-State: AIkVDXK+lP+W/wV5xIxlr7zp7Ed/2H3Dd5xdzvjYXGdJwxjpIlMCdlTWrtn7sCI1jKRe3Ghj
X-Received: by 10.55.220.199 with SMTP id v190mr4804609qki.42.1484080958941;
        Tue, 10 Jan 2017 12:42:38 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:38 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 00/14] fix mergetool+rerere+subdir regression
Date:   Tue, 10 Jan 2017 15:41:48 -0500
Message-Id: <20170110204202.21779-1-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170109232941.43637-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If rerere is enabled, no pathnames are given, and mergetool is run
from a subdirectory, mergetool always prints "No files need merging".
Fix the bug.

This regression was introduced in
57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).

Changes since v4:
  * Revert to Junio's original proposal for 14/14.  (Junio:  Please
    feel free to take author credit on 14/4; it's now 100% your code.)
  * Do:
        # rev-parse provides the -- needed for 'set'
        eval "set $(git rev-parse --sq -- "$@")"
    instead of:
        eval "set -- $(git rev-parse --sq -- "$@")"
        shift
    for both 02/14 and 14/14.

Richard Hansen (14):
  .mailmap: Use my personal email address as my canonical
  rev-parse doc: pass "--" to rev-parse in the --prefix example
  t7610: update branch names to match test number
  t7610: Move setup code to the 'setup' test case.
  t7610: use test_when_finished for cleanup tasks
  t7610: don't rely on state from previous test
  t7610: run 'git reset --hard' after each test to clean up
  t7610: delete some now-unnecessary 'git reset --hard' lines
  t7610: always work on a test-specific branch
  t7610: don't assume the checked-out commit
  t7610: spell 'git reset --hard' consistently
  t7610: add test case for rerere+mergetool+subdir bug
  mergetool: take the "-O" out of $orderfile
  mergetool: fix running in subdir when rerere enabled

 .mailmap                        |   2 +
 Documentation/git-rev-parse.txt |   3 +-
 git-mergetool.sh                |  21 ++-
 t/t7610-mergetool.sh            | 281 ++++++++++++++++++++++++----------------
 4 files changed, 187 insertions(+), 120 deletions(-)

-- 
2.11.0.390.gc69c2f50cf-goog


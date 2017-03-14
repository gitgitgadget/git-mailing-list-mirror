Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23FCD20951
	for <e@80x24.org>; Tue, 14 Mar 2017 22:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdCNWLP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 18:11:15 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34984 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751061AbdCNWLO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 18:11:14 -0400
Received: by mail-pg0-f48.google.com with SMTP id b129so96590897pgc.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4rsmoYpnU7s88fek0SMK550zeEiQtIJFR6voYyKXZDs=;
        b=apZSHkRAsyZ3jKoHxxv77TMzno8xG3ADUYQRg1YVBzm1GgxXK3skLCz8Nohf1YjN9/
         B4wKR9rMijIPx+d1O6KqJd95to8VS9DsEXj9Ey8PN+KeJ2ycMMgReo3mBXKNF28igih9
         /9gvTE4KKeBuhl6FxYzVKigz+L69qiBWNQd9sjqY4Xn8c9KyJ3wpwRzwJQPHGy6OHAy8
         ALBizmLV+1C7RwWTd95l7yV1vzxlltRfp9gkqO9Ak4IVH7+W0VEv2v9u/Pb/z1BSQOxT
         NIyGOdpkRNeHqVvLFJMaK1t92N5LtloeYSuoZp90FPJlXibO8vcyRfsdY+xYMri/4ID3
         faNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4rsmoYpnU7s88fek0SMK550zeEiQtIJFR6voYyKXZDs=;
        b=m7NiP0o7Un83PZh6fvMkkkasg0Be1sNeI+bsq2gKJ0926EHdJrxiz0N/rkQOGTEpBe
         Gv9DKp3k1CTwava6znj9dfaGHttumBMPHz39URfIzgfPlSA3JPKi4BRii5Hd2MpOwTr1
         LjTBuJkUZVw7Ys1PHp+pNcC1ytZUfmbk/bMWdjFUN7ajwwklaWcle24maw3P3yW89lHS
         Hqq4AVAPxKTu4n0HmHaKwXCgtDIGujCsDKzCyBjtJ4YxJjVLMBi+EMLf6aj/BVFAo0VM
         KK0v0FNdHzrrxk73OuvrBrWXkgaDnEbCTi02Q9z9rWUfndqPkAy4irvgMN1L0Jgr6yo3
         cGdw==
X-Gm-Message-State: AMke39kl6xzBSSwAr+cKoLK3VtrNhvF04Wm0huwcY9hSNdfhIYmT5wRuamlSLtbyJNwHU2lG
X-Received: by 10.98.98.69 with SMTP id w66mr46385117pfb.41.1489529473012;
        Tue, 14 Mar 2017 15:11:13 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id r12sm40691742pgn.26.2017.03.14.15.11.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 15:11:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, peff@peff.net, johannes.schindelin@gmx.de,
        pclouds@gmail.com
Subject: [PATCH v2 0/4] recursing submodules with relative pathspec (grep and ls-files)
Date:   Tue, 14 Mar 2017 15:10:56 -0700
Message-Id: <20170314221100.24856-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170224235100.52627-1-bmwill@google.com>
References: <20170224235100.52627-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 of the series tackles the problem slightly differently than v1 did, and in a
less invasive way in my opinion.  v1 also didn't fix everything.

v2 introduces a way to pass a 'prefix' that is respected by a git process.
This allows the git child processes (which operate on submodules) to have the
super_prefix (the path from the root of the superproject to the submodule) and
the prefix (path from the root of the superproject to the directory in which
the original command was launched).  With these two pieces of information the
child process can correctly handle pathspec matching as well as correctly
formatting their output with relative paths.

In order to pass the prefix to a child I made a new env var since the existing
GIT_PREFIX isn't respected.  I'm not sure this is the best method so I'm open
to ideas on the best way to convey this information to a child process.

Brandon Williams (4):
  grep: fix help text typo
  setup: allow for prefix to be passed to git commands
  grep: fix bug when recursing with relative pathspec
  ls-files: fix bug when recursing with relative pathspec

 builtin/grep.c                         | 41 +++++++++++--------
 builtin/ls-files.c                     | 41 ++++++++++---------
 cache.h                                |  1 +
 git.c                                  |  2 -
 setup.c                                |  6 +++
 t/t3007-ls-files-recurse-submodules.sh | 39 ++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh     | 75 ++++++++++++++++++++++++++++++++++
 7 files changed, 167 insertions(+), 38 deletions(-)

-- 
2.12.0.367.g23dc2f6d3c-goog


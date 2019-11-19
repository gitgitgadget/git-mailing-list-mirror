Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC771F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 14:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKSOBr (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 09:01:47 -0500
Received: from slonopotamus.org ([172.104.130.55]:42634 "EHLO slonopotamus.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSOBq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 09:01:46 -0500
Received: from marat by slonopotamus.org with local (Exim 4.92.3)
        (envelope-from <marat@slonopotamus.org>)
        id 1iX44V-0001wt-Gf
        for git@vger.kernel.org; Tue, 19 Nov 2019 17:01:35 +0300
Date:   Tue, 19 Nov 2019 17:01:35 +0300
From:   marat@seldon.slonopotamus.org
To:     git@vger.kernel.org
Subject: git check-ignore returns 0 for negated masks
Message-ID: <20191119140135.GA7389@seldon.slonopotamus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Way to reproduce:

$ git --version
git version 2.24.0
$ mkdir /tmp/checkignore
$ cd /tmp/checkignore
$ git init
Initialized empty Git repository in /tmp/checkignore/.git/
$ echo '!*.txt' > .gitignore
$ git check-ignore 1.txt
1.txt
$ echo $?
0

I believe this is a bug because it contradicts check-ignore documentation:

  0 - One or more of the provided paths is ignored.
  1 - None of the provided paths are ignored.

This bug isn't hard to fix, however:

1. That causes several tests to fail because they test for exit code that I concider to be wrong.
2. I'm not sure how to handle negated masks when check-ignore prints matching patterns.
   Printing what pattern caused file to be *not* ignored seems useful,
   but others may think that there's "mask is printed iff the file is ignored" rule.

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 5a4f92395f..d0711434e6 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -111,7 +111,7 @@ static int check_ignore(struct dir_struct *dir,
                }
                if (!quiet && (pattern || show_non_matching))
                        output_pattern(pathspec.items[i].original, pattern);
-               if (pattern)
+               if (pattern && !(pattern->flags & PATTERN_FLAG_NEGATIVE))
                        num_ignored++;
        }
        free(seen);

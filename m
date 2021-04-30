Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2611EC433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1254613CD
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 10:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhD3K23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3K22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 06:28:28 -0400
X-Greylist: delayed 1712 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Apr 2021 03:27:40 PDT
Received: from lune.etla.org (lune.etla.org [IPv6:2a00:1098:82:c2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB73C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 03:27:40 -0700 (PDT)
Received: from nick by lune.etla.org with local (Exim 4.92)
        (envelope-from <nick@ccl4.org>)
        id 1lcPvO-0005dS-Jn; Fri, 30 Apr 2021 09:59:06 +0000
Date:   Fri, 30 Apr 2021 09:59:06 +0000
From:   Nicholas Clark <nick@ccl4.org>
To:     git@vger.kernel.org
Cc:     Nicholas Clark <nick@ccl4.org>
Subject: [PATCH] submodule update: silence underlying fetch with "--quiet"
Message-ID: <20210430095906.GG9170@etla.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commands such as

    $ git submodule update --quiet --init --depth=1

involving shallow clones, call the shell function fetch_in_submodule, which
in turn invokes git fetch.  Pass the --quiet option onward there.

Signed-off-by: Nicholas Clark <nick@ccl4.org>
---
I tried to adopt the same approach as the previous commit that fixed a
--quiet bug, 3ad0401e9e (submodule update: silence underlying merge/rebase
with "--quiet", 2020-09-30)

I believe that the bugfix is correct but I struggled to create a concise
regression test demonstrates the bug and the bug fix.

That commit is not the only fix of a --quiet bug, so I'm wondering if there
are others still to find. I looked in git-submodule.sh and see many
invocations of git commands in git-submodule.sh, most of which don't pass
${GIT_QUIET:+--quiet} onward, but I don't know git well enough to know which
might matter (ie might generate output), and it feels like cargo-cult to
add that code unthinkingly to every git command, so I didn't do this.

 git-submodule.sh            |  4 ++--
 t/t7406-submodule-update.sh | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index eb90f18229..4678378424 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -420,9 +420,9 @@ fetch_in_submodule () (
 	cd "$1" &&
 	if test $# -eq 3
 	then
-		echo "$3" | git fetch --stdin ${2:+"$2"}
+		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
 	else
-		git fetch ${2:+"$2"}
+		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
 	fi
 )
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index ff3ba5422e..f4f61fe554 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1037,4 +1037,28 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	)
 '
 
+test_expect_success 'submodule update --quiet passes quietness to fetch with a shallow clone' '
+	test_when_finished "rm -rf super4 super5 super6" &&
+	git clone . super4 &&
+	(cd super4 &&
+	 git submodule add --quiet file://"$TRASH_DIRECTORY"/submodule submodule3 &&
+	 git commit -am "setup submodule3"
+	) &&
+	(cd submodule &&
+	  test_commit line6 file
+	) &&
+	git clone super4 super5 &&
+	(cd super5 &&
+	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
+	 test_must_be_empty out &&
+	 test_must_be_empty err
+	) &&
+	git clone super4 super6 &&
+	(cd super6 &&
+	 git submodule update --init --depth=1 submodule3 >out 2>err &&
+	 test_file_not_empty out &&
+	 test_file_not_empty err
+	)
+'
+
 test_done
-- 
2.31.1


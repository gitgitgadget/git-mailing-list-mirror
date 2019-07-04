Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D8D1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 08:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGDIJd (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 04:09:33 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61640 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfGDIJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 04:09:33 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 5C86AA113B;
        Thu,  4 Jul 2019 10:09:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id arGSfNZYM2l7; Thu,  4 Jul 2019 10:09:09 +0200 (CEST)
Date:   Thu, 4 Jul 2019 10:09:07 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     paulus@samba.org, max@max630.net
Cc:     git@vger.kernel.org
Subject: [PATCH] gitk: fix --all behavior combined with --not
Message-ID: <20190704080907.GA45656@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 4d5e1b1319 ("gitk: Show detached HEAD if --all is specified",
2014-09-09) the intention was to have detached HEAD shown when the --all
argument is given.

This was solved by appending HEAD to the revs list. By doing that the
behavior using the --not argument is now broken, since that inverts the
meaning of all following arguments passed to git rev-parse.

Lets fix this by prepending HEAD instead of appending, this way there
can not be any '--not' in front.

This was discovered because

	gitk --all --not origin/master

does not display the same revs as

	gitk --all ^origin/master

which it should.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index a14d7a1..19d95cd 100755
--- a/gitk
+++ b/gitk
@@ -295,7 +295,7 @@ proc parseviewrevs {view revs} {
     if {$revs eq {}} {
 	set revs HEAD
     } elseif {[lsearch -exact $revs --all] >= 0} {
-	lappend revs HEAD
+	linsert revs 0 HEAD
     }
     if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
 	# we get stdout followed by stderr in $err
-- 
2.21.0


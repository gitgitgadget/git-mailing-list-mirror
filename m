Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A151201C8
	for <e@80x24.org>; Thu,  9 Nov 2017 20:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755236AbdKIUjR (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 15:39:17 -0500
Received: from s019.cyon.net ([149.126.4.28]:32990 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755204AbdKIUjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 15:39:16 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Nov 2017 15:39:16 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=REOQCuSJK1XceA4IEaiIA2o+JuwgSSQtGxSbP80o4Wg=; b=Dc8U/YPd1A/O4++z67rN0IH7SP
        eWPaCjIAqcO/FploCWxePQNkVwHY1G/9Juv2ByyIReTO+Ko+0KsbI6aeTKaC0xweYzPXZfIDpGMb6
        N3PlgsOVQXsRw5eHp7Hj5JYJAcx64bF/B/vaU2STZEsqbJ1vxlEzSJZt1WPp0LcMoDxC7Wp2R5neN
        w7cI5ZSEsuHVl6U3oTzTx5eaKb45ylkw5s6zObY7K/Qk/w8bvdwDKCCfKOs0SBbSYEvgwXwAQ6e5g
        9mFEsUW3FdZHgA9qJpBVTJSmlG6p9ZDZ6Ds3QWT896oPkQmXBoE/4PSuxTOLTA7d2PfKbtfZISdob
        tQMUKxQQ==;
Received: from [10.20.10.232] (port=41940 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.89)
        (envelope-from <bb@drbeat.li>)
        id 1eCtTE-0006gj-Tj; Thu, 09 Nov 2017 21:30:41 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 5F89920013; Thu,  9 Nov 2017 21:30:40 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] contrib/git-jump: allow to configure the grep command
Date:   Thu,  9 Nov 2017 21:30:31 +0100
Message-Id: <20171109203031.25227-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the configuration option "jump.grepCmd" that allows to configure the
command that is used to search in grep mode. This allows the users of
git-jump to use ag(1) or ack(1) as search engines.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 contrib/git-jump/README   | 3 +++
 contrib/git-jump/git-jump | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 225e3f095..9f58d5db8 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -63,6 +63,9 @@ git jump grep foo_bar
 # same as above, but case-insensitive; you can give
 # arbitrary grep options
 git jump grep -i foo_bar
+
+# use the silver searcher for git jump grep
+git config jump.grepCmd "ag --column"
 --------------------------------------------------
 
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 427f206a4..80ab0590b 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -11,7 +11,8 @@ diff: elements are diff hunks. Arguments are given to diff.
 
 merge: elements are merge conflicts. Arguments are ignored.
 
-grep: elements are grep hits. Arguments are given to grep.
+grep: elements are grep hits. Arguments are given to git grep or, if
+      configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
 EOF
@@ -50,7 +51,9 @@ mode_merge() {
 # but let's clean up extra whitespace, so they look better if the
 # editor shows them to us in the status bar.
 mode_grep() {
-	git grep -n "$@" |
+	cmd=$(git config jump.grepCmd)
+	test -n "$cmd" || cmd="git grep -n"
+	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
 	s/^ *//;
-- 
2.15.0.rc1.299.gda03b47c3


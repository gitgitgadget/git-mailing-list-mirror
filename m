Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E224202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 23:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbdKSXFs (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 18:05:48 -0500
Received: from s019.cyon.net ([149.126.4.28]:40092 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdKSXFr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 18:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=REOQCuSJK1XceA4IEaiIA2o+JuwgSSQtGxSbP80o4Wg=; b=jGu2mmoqoYBeOLFm8sSfnPWWtV
        LSAKeCMUOXmkynI4MgEq40tnBOEjK2DlGXAxh0dP+2niCwE+u3nSssv1ghgQkfrTfWwp/jVcxgJKG
        paseE7kP6vrF/Qai84CSYb/bYeRcOTZGpd3YfVADDAZDmuOWzHh2vv9/DTrBfWtK6YxwFsELJ0bWD
        9ad7aYMu0HK5CY0Rg2CYKfwiBYzQd5pdI5KZ9/mYX3M67oCSzbzSqVrkeegopd9C6Y4YLmC3M/sH1
        oCc+LphnwlGCXGwbOt8z3kEpvh6jFWtpkKe2j7pJEB5iJjTC6gEUnWYEy483CGdz9CoKlc50ajE7Q
        DDsv7aYA==;
Received: from [10.20.10.233] (port=14490 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.89)
        (envelope-from <bb@drbeat.li>)
        id 1eGYem-0001pQ-Hn; Mon, 20 Nov 2017 00:05:44 +0100
Received: by drbeat.li (Postfix, from userid 1000)
        id 202E91FFE5; Mon, 20 Nov 2017 00:05:44 +0100 (CET)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] contrib/git-jump: allow to configure the grep command
Date:   Mon, 20 Nov 2017 00:05:36 +0100
Message-Id: <20171119230536.1628-1-dev+git@drbeat.li>
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


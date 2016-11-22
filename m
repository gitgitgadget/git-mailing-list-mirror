Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185E71FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933834AbcKVRw5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:52:57 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:44802 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933787AbcKVRwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:52:55 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tNY391YRQz5tlT;
        Tue, 22 Nov 2016 18:52:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 712DF1D04;
        Tue, 22 Nov 2016 18:52:52 +0100 (CET)
To:     Pat Thoyts <patthoyts@gmail.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] git-gui: pass the branch name to git merge
Message-ID: <6a6dd0b9-436d-327f-c33d-e5cce078b3a0@kdbg.org>
Date:   Tue, 22 Nov 2016 18:52:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent rewrite of the 'git merge' invocation in b5f325cb
(git-gui: stop using deprecated merge syntax) replaced the
subsidiary call of 'git fmt-merge-msg' to take advantage of
the capability of 'git merge' that can construct a merge log
message when the rev being merged is FETCH_HEAD.

A disadvantage of this method is, though, that the conflict
markers are augmented with a raw SHA1 instead of a symbolic
branch name. Revert to the former invocation style so that
we get both a useful commit message and a symbolic name in the
conflict markers.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 A minor regression of our effort to get rid of
 deprecated merge syntax. Even though I had done a number of
 merges since then, I noticed this only today because I
 actively looked for the branch name.

 lib/merge.tcl | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/lib/merge.tcl b/lib/merge.tcl
index 9f253db..39e3fb4 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -112,16 +112,9 @@ method _start {} {
 	close $fh
 	set _last_merged_branch $branch
 
-	if {[git-version >= "2.5.0"]} {
-		set cmd [list git merge --strategy=recursive FETCH_HEAD]
-	} else {
-		set cmd [list git]
-		lappend cmd merge
-		lappend cmd --strategy=recursive
-		lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
-		lappend cmd HEAD
-		lappend cmd $name
-	}
+	set cmd [list git merge --strategy=recursive --no-log -m]
+	lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
+	lappend cmd $name
 
 	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
 	set cons [console::new [mc "Merge"] "merge $stitle"]
-- 
2.11.0.rc1.52.g65ffb51


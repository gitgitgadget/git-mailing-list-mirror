Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B0B1FAE2
	for <e@80x24.org>; Mon, 29 Jan 2018 23:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbeA2XQz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 18:16:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60394 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751363AbeA2XQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 18:16:54 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1FF601F404;
        Mon, 29 Jan 2018 23:16:54 +0000 (UTC)
Date:   Mon, 29 Jan 2018 23:16:53 +0000
From:   Eric Wong <e@80x24.org>
To:     Todd Zullinger <tmz@pobox.com>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: [PATCH] git-svn: control destruction order to avoid segfault
Message-ID: <20180129231653.GA22834@starla>
References: <20180129015134.GN431130@genre.crustytoothpaste.net>
 <20180129025812.GD1427@zaya.teonanacatl.net>
 <20180129120627.al2xvx4yhhvwn6ih@untitled>
 <20180129184345.GI1427@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180129184345.GI1427@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> wrote:
> I'm running the tests with and without your patch as well.
> So far I've run t9128 300 times with the patch and no
> failures.  Without it, it's failed 3 times in only a few
> dozen runs.  That's promising.

Thanks for confirming it works on other systems.
Pull request and patch below:

The following changes since commit 5be1f00a9a701532232f57958efab4be8c959a29:

  First batch after 2.16 (2018-01-23 13:21:10 -0800)

are available in the Git repository at:

  git://bogomips.org/git-svn.git svn-branch-segfault

for you to fetch changes up to 2784b8d68faca823489949cbc69ead2f296cfc07:

  git-svn: control destruction order to avoid segfault (2018-01-29 23:12:00 +0000)

----------------------------------------------------------------
Eric Wong (1):
      git-svn: control destruction order to avoid segfault

 git-svn.perl | 5 +++++
 1 file changed, 5 insertions(+)

---------8<---------
Subject: [PATCH] git-svn: control destruction order to avoid segfault

It seems necessary to control destruction ordering to avoid a
segfault with SVN 1.9.5 when using "git svn branch".
I've also reported the problem against libsvn-perl to Debian
[Bug #888791], but releasing the SVN::Client instance can be
beneficial anyways to save memory.

ref: https://bugs.debian.org/888791
Tested-by: Todd Zullinger <tmz@pobox.com>
Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Eric Wong <e@80x24.org>
---
 git-svn.perl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 76a75d0b3d..a6b6c3e40c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1200,6 +1200,11 @@ sub cmd_branch {
 	$ctx->copy($src, $rev, $dst)
 		unless $_dry_run;
 
+	# Release resources held by ctx before creating another SVN::Ra
+	# so destruction is orderly.  This seems necessary with SVN 1.9.5
+	# to avoid segfaults.
+	$ctx = undef;
+
 	$gs->fetch_all;
 }
 
-- 
EW

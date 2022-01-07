Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BDC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 12:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbiAGM6D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 07:58:03 -0500
Received: from ec2-54-173-99-29.compute-1.amazonaws.com ([54.173.99.29]:52398
        "EHLO localhost" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231207AbiAGM6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 07:58:02 -0500
X-Greylist: delayed 1099 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jan 2022 07:58:02 EST
From:   Tom Levy <tomlevy93@gmail.com>
To:     git@vger.kernel.org
Cc:     Tom Levy <tomlevy93@gmail.com>
Subject: [PATCH] git-gui: reload tracking branches after adding remote
Date:   Fri,  7 Jan 2022 12:39:39 +0000
Message-Id: <20220107123939.1955-1-tomlevy93@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git-gui does not display new tracking branches after adding a remote.

Steps to reproduce issue:

$ git init test_repo
$ cd test_repo
$ git commit --allow-empty -m "Initial commit"
$ git gui
Remote > Add... > Name: "test_remote", Location: ".". Add.
(Fetch output: [new branch] master -> test_remote/master. Close.)
Branch > Create... . Select "Tracking Branch".

Expected result: test_remote/master should be displayed.
Actual result: No tracking branches displayed.

A workaround is to close and re-open git-gui.

The patch below fixes the issue by reloading the tracking branches
after adding a remote (see the commit message for more details).

It may be a good idea to also reload the tracking branches when
removing a remote (something this patch doesn't do). It's not strictly
necessary with the way the code is currently written (see the commit
message).

Regards,
Tom Levy

-- >8 --

Subject: [PATCH] git-gui: reload tracking branches after adding remote

Otherwise newly-fetched tracking branches are not displayed in the
revision chooser's Tracking Branch tab ($tracking_branches is not
updated, so 'all_tracking_branches' does not return the new branches).

The reload is done using 'load_all_remotes', which also reloads
$all_remotes and $repo_config, so they don't need to be manually
updated any more.

When removing remotes, it's not necessary to reload the tracking
branches. This is because 'all_tracking_branches' is only called from
choose_rev.tcl, which filters out non-existent refs.

Signed-off-by: Tom Levy <tomlevy93@gmail.com>
---
 lib/remote.tcl | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/remote.tcl b/lib/remote.tcl
index ef77ed7..ed26170 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -285,15 +285,9 @@ proc populate_remotes_menu {} {
 }
 
 proc add_single_remote {name location} {
-	global all_remotes repo_config
-	lappend all_remotes $name
-
 	git remote add $name $location
 
-	# XXX: Better re-read the config so that we will never get out
-	# of sync with git remote implementation?
-	set repo_config(remote.$name.url) $location
-	set repo_config(remote.$name.fetch) "+refs/heads/*:refs/remotes/$name/*"
+	load_all_remotes
 
 	add_fetch_entry $name
 	add_push_entry $name
-- 
2.30.2


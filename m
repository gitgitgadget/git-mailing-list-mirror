Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CAC3F2D7
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F22146E
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCBSO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:14:59 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:52483 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBSO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 13:14:59 -0500
X-Originating-IP: 103.227.97.205
Received: from localhost (unknown [103.227.97.205])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id EC781FF80C;
        Mon,  2 Mar 2020 18:14:55 +0000 (UTC)
Date:   Mon, 2 Mar 2020 23:44:52 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Subject: Re: [PATCH v7 2/3] git-gui: update status bar to track operations
Message-ID: <20200302181452.gssh43l2sxu7kqak@yadavpratyush.com>
References: <pull.436.v6.git.1574929833.gitgitgadget@gmail.com>
 <pull.436.v7.git.1575167313.gitgitgadget@gmail.com>
 <8fe9dfc30771574344c1a2fc5cd8f21f1a617388.1575167313.git.gitgitgadget@gmail.com>
 <20200226082409.GA2270319@f3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226082409.GA2270319@f3>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Benjamin,

On 26/02/20 05:24PM, Benjamin Poirier wrote:
> On 2019/12/01 02:28 +0000, Jonathan Gilbert via GitGitGadget wrote:
> > From: Jonathan Gilbert <JonathanG@iQmetrix.com>
> > 
> > Update the status bar to track updates as individual "operations" that
> > can overlap. Update all call sites to interact with the new status bar
> > mechanism. Update initialization to explicitly clear status text,
> > since otherwise it may persist across future operations.
> > 
> > Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
> > ---
> 
> Hi Jonathan,
> 
> It appears that this change has caused a regression when using git-gui
> blame <file> -> right click on a source line -> "Show History Context"
> 
> There is an "Application Error" window that appears with the following
> details:
> can't read "::main_status": no such variable
> can't read "::main_status": no such variable
>     while executing
> "$::main_status  start  [mc "Starting %s... please wait..." "gitk"]"
>     (procedure "do_gitk" line 55)
>     invoked from within
> "do_gitk $cmdline"
>     (procedure "blame::_gitkcommit" line 47)
>     invoked from within
> "blame::_gitkcommit ::blame::__o1::__d"
>     invoked from within
> ".ctxm invoke active"
>     ("uplevel" body line 1)
>     invoked from within
> "uplevel #0 [list $w invoke active]"
>     (procedure "tk::MenuInvoke" line 50)
>     invoked from within
> "tk::MenuInvoke .ctxm 1"
>     (command bound to event)
> 
> The rest of the functionality seems unaffected but it's pretty annoying
> to have to dismiss this message each time.
> 
> Can you please look into it?

Does the following patch fix the problem? I will submit a proper patch 
soon.

-----8<-----
diff --git a/git-gui.sh b/git-gui.sh
index f41ed2e..d939844 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2205,11 +2205,13 @@ proc do_gitk {revs {is_submodule false}} {
 		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd

-		set status_operation [$::main_status \
-			start \
-			[mc "Starting %s... please wait..." "gitk"]]
+		if {[info exists main_status]} {
+			set status_operation [$::main_status \
+				start \
+				[mc "Starting %s... please wait..." "gitk"]]

-		after 3500 [list $status_operation stop]
+			after 3500 [list $status_operation stop]
+		}
 	}
 }
-----8<-----

-- 
Regards,
Pratyush Yadav

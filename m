Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347491F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 23:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbeJJHNB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 03:13:01 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:58122 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725750AbeJJHNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 03:13:01 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 03:13:01 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A04371F97E;
        Tue,  9 Oct 2018 23:45:02 +0000 (UTC)
Date:   Tue, 9 Oct 2018 23:45:02 +0000
From:   Eric Wong <e@80x24.org>
To:     Martin Langhoff <martin.langhoff@gmail.com>
Cc:     List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
Message-ID: <20181009234502.oxzfwirjcew2sxrm@dcvr>
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
 <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Hi folks,
> 
> Long time no see! Importing a 3GB (~25K revs, tons of files) SVN repo
> I hit the gc error:
> 
> warning: There are too many unreachable loose objects; run 'git prune'
> to remove them.
> gc --auto: command returned error: 255

GC can be annoying when that happens... For git-svn, perhaps
this can be appropriate to at least allow the import to continue:

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 76b2965905..9b0caa3d47 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -999,7 +999,7 @@ sub restore_commit_header_env {
 }
 
 sub gc {
-	command_noisy('gc', '--auto');
+	eval { command_noisy('gc', '--auto') };
 };
 
 sub do_git_commit {


But yeah, somebody else who works on git regularly could
probably stop repack from writing thousands of loose
objects (and instead write a self-contained pack with
those objects, instead).  I haven't followed git closely
lately, myself.

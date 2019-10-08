Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6019F1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 06:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbfJHGuO (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 02:50:14 -0400
Received: from quechua.inka.de ([193.197.184.2]:45255 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbfJHGuO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 02:50:14 -0400
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1iHjK0-0004ov-NN; Tue, 08 Oct 2019 08:50:12 +0200
Received: by raven.inka.de (Postfix, from userid 1000)
        id 5459212015C; Tue,  8 Oct 2019 08:45:38 +0200 (CEST)
Date:   Tue, 8 Oct 2019 08:45:38 +0200
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Why is "Sparse checkout leaves no entry on working directory" a
 fatal error?
Message-ID: <20191008064538.GB30443@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

This is a repost, since the original message seems to have been lost somehow.


I am trying to add a file to an arbitrary branch without touching the current
worktree with as little overhead as possible. This should work no matter in
which state the current worktree is in. And it should not touch the current WT
in any way.

For this, the sparse-checkout feature in conjuntion with the "shared
repository" feature seems to be perfect.

The basic idea goes like this:


   TMP=`mktemp -d /var/tmp/test-XXXXXXXXX`
   GD=$TMP/git
   WD=$TMP/wd
   
   git --work-tree $WD --git-dir $GD clone -qns -n . $GD
   git --work-tree $WD --git-dir $GD config core.sparsecheckout true
   echo path/of/file/which/I/want/to/create >>$GD/info/sparse-checkout
   
   git --work-tree $WD --git-dir $GD checkout -b some-branch remotes/origin/some-branch  # !!!
   
   ( cd $WD
     mkdir -p path/of/file/which/I/want/to
     echo huhuh >path/of/file/which/I/want/to/create
     git --work-tree $WD --git-dir $GD add path/of/file/which/I/want/to/create
     git --work-tree $WD --git-dir $GD commit
     git --work-tree $WD --git-dir $GD push
   )
   
   rm -rf $TMP


Unfortunately, the marked command errors out with

   "error: Sparse checkout leaves no entry on working directory"

and won't create/switch to the branch that is to be modified.

Why is this an error? Since there are no matching files, an empty worktree
is EXACTLY what I wanted. Why will the "git checkout -b" command error out?


Strange enough, I have some repositories at this machine where the
.git/info/sparse-checkout file contains only non-existing files and git
happily executes this "git checkout -b XXX remotes/origin/XXX" command leaving
the working tree totally empty all the time.

Someone understands this inconsistent behaviour?

Thanks,

-- 
Josef Wolf
jw@raven.inka.de

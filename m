Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D561F404
	for <e@80x24.org>; Fri,  9 Feb 2018 00:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBIAr5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 19:47:57 -0500
Received: from wes1-so1.wedos.net ([46.28.106.15]:42720 "EHLO
        wes1-so1.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBIAr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 19:47:57 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Feb 2018 19:47:56 EST
Received: from jvn (unknown [83.240.61.43])
        by wes1-so1.wedos.net (Postfix) with ESMTPSA id 3zcx5Y318Mz2cD
        for <git@vger.kernel.org>; Fri,  9 Feb 2018 01:39:13 +0100 (CET)
Date:   Fri, 9 Feb 2018 01:39:02 +0100
From:   Jan Viktorin <viktorin@rehivetech.com>
To:     git@vger.kernel.org
Subject: bad behaviour while using git rebase -i -p
Message-ID: <20180209013902.6702a0dd@jvn>
Organization: RehiveTech
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

since Git 2.16.1, I've noticed a bad behaviour of git rebase -i -p. It
screws up merge commits created with --log (or config merge.log = true)
in my history. A good merge commit with message like:

    Merge branch 'test'
    
    * test:
      c
      b

is changed after rebase (without touching that commit in any way) into:

    Merge branch 'test' a git-rebase-p-test.sh test: c b

It seems, like the commit message is interpreted somehow - the '*'
character is expanded to the list of files in the current directory and
the original spacing is removed. This happens during my regular work.

Here is a code that seems to be reproducing this behaviour well:

git init

touch a
git add a
git commit -m a

git checkout -b test
# a new branch made to merge back to master later

touch b
git add b
git commit -m b

touch c
git add c
git commit -m c

git checkout master
git merge --no-edit --log test
git log -1
# everything looks good at this point

export GIT_SEQUENCE_EDITOR='sed "1s/pick/reword/" -i'
# we are rewording only the first commit...
export EDITOR='sed "s/b/x/" -i'
# ...and changing its message from "b" to "x"

git rebase -i HEAD^1 -p
git log -1
# here, you can see the bad merge commit message

Regards
Jan

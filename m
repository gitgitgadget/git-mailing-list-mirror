Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639CE1F576
	for <e@80x24.org>; Fri, 26 Jan 2018 11:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeAZLVt convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 26 Jan 2018 06:21:49 -0500
Received: from oro-edge-01.luxoft.com ([109.166.244.21]:8952 "EHLO
        ORO-EDGE-01.luxoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeAZLVq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 06:21:46 -0500
Received: from ORO-HUBT-03.luxoft.com (172.30.115.38) by
 oro-edge-01.luxoft.com (172.30.19.21) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Fri, 26 Jan 2018 13:21:40 +0200
Received: from DB-HUBT-07.dbdc.luxoft.com (172.30.31.22) by
 ORO-HUBT-03.luxoft.com (172.30.115.38) with Microsoft SMTP Server (TLS) id
 14.3.319.2; Fri, 26 Jan 2018 13:21:44 +0200
Received: from DB-MBOX-07.dbdc.luxoft.com ([fe80::9527:405f:17d0:88c2]) by
 DB-HUBT-07.dbdc.luxoft.com ([::1]) with mapi id 14.03.0319.002; Fri, 26 Jan
 2018 13:21:43 +0200
From:   "Litvinenko, Evgeny" <EVLitvinenko@luxoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: reflog: git rebase <upstream> <branch> vs git checkout <branch> &&
 git rebase <upstream>
Thread-Topic: reflog: git rebase <upstream> <branch> vs git checkout
 <branch> && git rebase <upstream>
Thread-Index: AdOWkCpYCuaOxMZ1Sa2qEdqXhYLrMQAB2vFw
Date:   Fri, 26 Jan 2018 11:21:43 +0000
Message-ID: <B090F14416879147852DB59B4633393F01B4BFFCA2@DB-MBOX-07.dbdc.luxoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.249.136.136]
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community.

I have a question about reflog and "git-rebase(1) Manual Page".
As the man reads
------------------------- cut here -----------------------
git rebase [-i | --interactive] [options] [--exec <cmd>] [--onto <newbase>]
            [<upstream> [<branch>]]

...
If <branch> is specified, git rebase will perform an automatic git checkout <branch>
before doing anything else. Otherwise it remains on the current branch.
------------------------- cut here -----------------------

So I think that
  git rebase master b1
is the same as
  git checkout b1 && git rebase master
but in the reflog I see that the 'git rebase master b1' does not write 'git checkout b1'
into the reflog.

The question is - why there is no records in the reflog about ' automatic git checkout <branch>'?
Or maybe git's man page is not accurate about this step?

Here is my test:
------------------------- cut here -----------------------
mkdir git_rebase
cd git_rebase/
git init
echo "master 1" > file.txt
git add file.txt
git commit -m "master 1"
git checkout -b "b1"
echo "branch b1" > file_b1.txt
git add file_b1.txt
git commit -m "b1 1"
git checkout master
echo "master 2" >> file.txt
cat file.txt
git add file.txt
git commit -m "master 2"

# make a copy of repo directory (tar -cf ../repo_dir.tar .)
tar -cf ../git_rebase.tar .

# git rebase <upstream> <branch>
git reflog
git rebase master b1
git reflog

# restore the repo
cd ..
rm -Rf git_rebase
mkdir git_rebase && cd git_rebase && tar -xf ../git_rebase.tar

# git checkout <branch> && git rebase <upstream>
git reflog
git checkout b1 && git rebase master
git reflog
------------------------- cut here -----------------------

# In the case 'git rebase master b1'
# 'git reflog' shows
cac9cc7 (HEAD -> b1) HEAD@{0}: rebase finished: returning to refs/heads/b1
cac9cc7 (HEAD -> b1) HEAD@{1}: rebase: b1 1
29c7386 (master) HEAD@{2}: rebase: checkout master
29c7386 (master) HEAD@{3}: commit: master 2
5cb30a2 HEAD@{4}: checkout: moving from b1 to master
e75c314 HEAD@{5}: commit: b1 1
5cb30a2 HEAD@{6}: checkout: moving from master to b1
5cb30a2 HEAD@{7}: commit (initial): master 1

# In the case ' git checkout b1 && git rebase master '
c08d270 (HEAD -> b1) HEAD@{0}: rebase finished: returning to refs/heads/b1
c08d270 (HEAD -> b1) HEAD@{1}: rebase: b1 1
29c7386 (master) HEAD@{2}: rebase: checkout master
e75c314 HEAD@{3}: checkout: moving from master to b1 /* This line is absent in case of 'git rebase master b1' */
29c7386 (master) HEAD@{4}: commit: master 2
5cb30a2 HEAD@{5}: checkout: moving from b1 to master
e75c314 HEAD@{6}: commit: b1 1
5cb30a2 HEAD@{7}: checkout: moving from master to b1
5cb30a2 HEAD@{8}: commit (initial): master 1


Best regards and many thanks for your work.
Evgeny.

________________________________

This e-mail and any attachment(s) are intended only for the recipient(s) named above and others who have been specifically authorized to receive them. They may contain confidential information. If you are not the intended recipient, please do not read this email or its attachment(s). Furthermore, you are hereby notified that any dissemination, distribution or copying of this e-mail and any attachment(s) is strictly prohibited. If you have received this e-mail in error, please immediately notify the sender by replying to this e-mail and then delete this e-mail and any attachment(s) or copies thereof from your system. Thank you.

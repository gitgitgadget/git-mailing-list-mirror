Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812BB20196
	for <e@80x24.org>; Thu, 14 Jul 2016 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbcGNOSG (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 10:18:06 -0400
Received: from laurel.msg.io ([178.63.21.149]:40881 "HELO a.mx.msg.io"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbcGNOSF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 10:18:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2016 10:18:04 EDT
Received: (qmail 16665 invoked from network); 14 Jul 2016 14:11:19 -0000
To:	git@vger.kernel.org
From:	Bernhard Graf <gitml@augensalat.de>
Subject: Bug report: 'git rebase' confusing files with initially equal content
Message-ID: <d105b779-7eb7-845f-d503-263846919c1a@augensalat.de>
Date:	Thu, 14 Jul 2016 16:11:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

With the following steps content from one file ends up in another file 
by using 'git rebase' (and clobbers the original content).
It is rather straight forward and I discovered this behaviour when 
trying to replay http://gitforteams.com/resources/rebasing.html .
The special thing is, that both files have the same content at start.

   $ mkdir rebase
   $ cd rebase
   git --version
   git version 2.9.0
   $ git init
   Initialized empty Git repository in /home/graf/projects/git/rebase/.git/
   $ echo stub >file1
   $ echo stub >file2
   $ git add .
   $ git commit -m 'add stub'
   [master (root-commit) 0cb53e9] Add stubs
    2 files changed, 2 insertions(+)
    create mode 100644 file1
    create mode 100644 file2
   $ git checkout -b feature/1
   Switched to a new branch 'feature/1'
   $ echo line1 >file1
   $ git commit -am 'Add content'
   [feature/1 2f3dcc7] Add content
    1 file changed, 1 insertion(+), 1 deletion(-)
   $ git checkout master
   Switched to branch 'master'
   $ git rm file1
   rm 'file1'
   $ git commit -m 'Delete file1'
   [master 1b18590] Delete file1
    1 file changed, 1 deletion(-)
    delete mode 100644 file1
   $ git checkout feature/1
   Switched to branch 'feature/1'
   $ echo line2 >>file1
   $ git commit -am 'Add more content'
   [feature/1 36be376] Add more content
    1 file changed, 1 insertion(+)
   $ cat file1
   line1
   line2
   $ cat file2
   stub
   $ git rebase master
   First, rewinding head to replay your work on top of it...
   Applying  Add content
   Using index info to reconstruct a base tree...
   A	file1
   Falling back to patching base and 3-way merge...
   Auto-merging file2
   Applying  Add more content
   Using index info to reconstruct a base tree...
   A	file1
   Falling back to patching base and 3-way merge...
   Auto-merging file2
   $ ls -l
   total 8
   -rw-r--r--  1 graf  users  12 14 Jul 13:16 file2
   $ cat file2
   line1
   line2

If instead file1 and file2 initially had different contents, 'git 
rebase' runs into a merge conflict, so the user can fix it appropriatly.

I suppose this is related to the fact that Git manages the repo by file 
contents only. Still this is nothing what I would expect (and neither 
accept).

-- 
Bernhard Graf

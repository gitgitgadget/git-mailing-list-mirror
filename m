Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C632120986
	for <e@80x24.org>; Sun,  9 Oct 2016 06:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbcJIGsw (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 02:48:52 -0400
Received: from mail.pdinc.us ([67.90.184.27]:48752 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbcJIGsv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 02:48:51 -0400
Received: from black7 (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u996moCj016465
        for <git@vger.kernel.org>; Sun, 9 Oct 2016 02:48:50 -0400
Reply-To: <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: A head scratcher, clone results in modified files (tested linux and cygwin) - .gitattributes file?
Date:   Sun, 9 Oct 2016 02:48:49 -0400
Organization: PD Inc
Message-ID: <7E06D61EACFB462AB96DD60720930968@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIh+TDwbC4OlgFdTxquF4p4hNVmAw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.23403
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Does anyone have any ideas as to why this clone resulted in modified files and how to prevent it?

There is a .gitattributes in the tree, which says:

*        text=auto
*.java   text diff=java
*.html   text diff=html
*.css    text
*.js     text
*.sql    text

But even then the *.bin files full of non-ascii garbage are impacted?! But I cannot find a difference:

root@YYYYYYY /projects/commons-io
$ git cat-file -p 7c9cd59c8a00e0bd3f18da42b32cd40024ad1505 | hexdump -C
00000000  a9 fa bf e9 a4 6c a8 ca  0d 0a c1 63 c5 e9 a4 a4  |.....l.....c....|
00000010  a4 e5 0d 0a                                       |....|
00000014

root@YYYYYYY /projects/commons-io
$ git cat-file -p 7c9cd59c8a00e0bd3f18da42b32cd40024ad1505 | sha1sum.exe
d69820e1282801ccd627e35fb213e8832949c6ac *-

root@YYYYYYY /projects/commons-io
$ hexdump.exe -C src/test/resources/test-file-x-windows-950.bin
00000000  a9 fa bf e9 a4 6c a8 ca  0d 0a c1 63 c5 e9 a4 a4  |.....l.....c....|
00000010  a4 e5 0d 0a                                       |....|
00000014

root@YYYYYYY /projects/commons-io
$ sha1sum.exe src/test/resources/test-file-x-windows-950.bin
d69820e1282801ccd627e35fb213e8832949c6ac *src/test/resources/test-file-x-windows-950.bin

Deleting the .gitattributes and the checkout -- did not help. No luck deleting the file then restoring it either.

Not even git clone git://git.apache.org/commons-io.git --config core.attributesFile=/dev/null fixed it. Details below.

-Jason

Cygwin test:

root@YYYYYYY /projects
$ git clone git://git.apache.org/commons-io.git
Cloning into 'commons-io'...
remote: Counting objects: 21203, done.
remote: Compressing objects: 100% (3454/3454), done.
remote: Total 21203 (delta 10822), reused 21129 (delta 10794)
Receiving objects: 100% (21203/21203), 2.51 MiB | 607.00 KiB/s, done.
Resolving deltas: 100% (10822/10822), done.
Checking connectivity... done.

root@YYYYYYY /projects
$ cd commons-io/

root@YYYYYYY /projects/commons-io
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   src/main/java/org/apache/commons/io/serialization/package.html
        modified:   src/site/xdoc/upgradeto2_3.xml
        modified:   src/test/resources/org/apache/commons/io/FileUtilsTestDataCRLF.dat
        modified:   src/test/resources/test-file-gbk.bin
        modified:   src/test/resources/test-file-iso8859-1-shortlines-win-linebr.bin
        modified:   src/test/resources/test-file-utf8-win-linebr.bin
        modified:   src/test/resources/test-file-windows-31j.bin
        modified:   src/test/resources/test-file-x-windows-949.bin
        modified:   src/test/resources/test-file-x-windows-950.bin

no changes added to commit (use "git add" and/or "git commit -a")

root@YYYYYYY /projects/commons-io
$ git rev-parse HEAD
c5f2e40e7a8234fe48e08d451d3152ba58a03ac6

root@YYYYYYY /projects/commons-io
$ git version
git version 2.8.3

root@YYYYYYY /projects/commons-io
$ git config --list
user.email=jpyeron@pdinc.us
user.name=Jason Pyeron
credential.helper=cache --timeout=9999999999
push.default=simple
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
remote.origin.url=git://git.apache.org/commons-io.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master

$ uname -a
CYGWIN_NT-6.1-WOW YYYYYYY 2.5.2(0.297/5/3) 2016-06-23 14:27 i686 Cygwin

root@YYYYYYY /projects/commons-io
$

Linux test:

root@XXXXXX /tmp
# git clone git://git.apache.org/commons-io.git
Cloning into 'commons-io'...
remote: Counting objects: 21203, done.
remote: Compressing objects: 100% (3454/3454), done.
remote: Total 21203 (delta 10822), reused 21129 (delta 10794)
Receiving objects: 100% (21203/21203), 2.51 MiB | 176 KiB/s, done.
Resolving deltas: 100% (10822/10822), done.

root@XXXXXX /tmp
# cd commons-io/

root@XXXXXX /tmp/commons-io
# git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   src/main/java/org/apache/commons/io/serialization/package.html
#       modified:   src/site/xdoc/upgradeto2_3.xml
#       modified:   src/test/resources/org/apache/commons/io/FileUtilsTestDataCRLF.dat
#       modified:   src/test/resources/test-file-gbk.bin
#       modified:   src/test/resources/test-file-iso8859-1-shortlines-win-linebr.bin
#       modified:   src/test/resources/test-file-utf8-win-linebr.bin
#       modified:   src/test/resources/test-file-windows-31j.bin
#       modified:   src/test/resources/test-file-x-windows-949.bin
#       modified:   src/test/resources/test-file-x-windows-950.bin
#
no changes added to commit (use "git add" and/or "git commit -a")

root@XXXXXX /tmp/commons-io
# git rev-parse HEAD
c5f2e40e7a8234fe48e08d451d3152ba58a03ac6

root@XXXXXX /tmp/commons-io
# git version
git version 1.7.9.6

root@XXXXXX /tmp/commons-io
# git config --list
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
remote.origin.url=git://git.apache.org/commons-io.git
branch.master.remote=origin
branch.master.merge=refs/heads/master

root@XXXXXX /tmp/commons-io
# uname -a
Linux XXXXXX.internal.pdinc.us 2.6.9-103.ELsmp #1 SMP Fri Dec 9 04:43:08 EST 2011 x86_64 x86_64 x86_64 GNU/Linux

root@XXXXXX /tmp/commons-io
#


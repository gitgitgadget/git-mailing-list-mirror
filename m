Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 348DA1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbcHLP41 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:56:27 -0400
Received: from crazybrake.spb.ru ([188.134.13.200]:60920 "HELO ddg.spb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752535AbcHLP40 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 11:56:26 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Aug 2016 11:56:26 EDT
Received: (qmail 13498 invoked from network); 12 Aug 2016 15:49:43 -0000
Received: from mail.metrotek.spb.ru (HELO srv3.metrotek.spb.ru) (89.110.34.174)
  by ddg.spb.ru with SMTP; 12 Aug 2016 15:49:43 -0000
Received: (qmail 10347 invoked from network); 12 Aug 2016 15:49:42 -0000
Received: from workplace.ddg (192.168.222.74)
  by srv3.ddg with SMTP; 12 Aug 2016 15:49:41 -0000
Received: (qmail 27306 invoked by uid 65618); 12 Aug 2016 15:49:42 -0000
Date:	Fri, 12 Aug 2016 18:49:42 +0300
From:	Ivan Oleynikov <io@metrotek.spb.ru>
To:	git@vger.kernel.org
Cc:	dvh@metrotek.spb.ru, apenwarr@gmail.com
Subject: [PATCH] git-subtree: compare file names by absolute paths
Message-ID: <20160812154942.GA27294@metrotek.spb.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Organization: STC Metrotek, St.Petersburg
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This commit removes false positive assertion fails of `git subtree split` when
the --prefix argument is not in a particular form produced by `git ls-tree`.

For example, typical usage of the command could be:

  git subtree split -b split --prefix=some/relative/path

But

  git subtree split -b split --prefix=./some/relative/path

Would fail with multiple assertion errors. This commit makes the latter command
work without errors.

Signed-off-by: Ivan Oleynikov <io@metrotek.spb.ru>
---

Notes:
    The bug fixed by this commit can be reproduced like this:
    
    $ git init
    Initialized empty Git repository in /tmp/test/.git/
    $ mkdir a b
    $ touch a/file b/file
    $ git add a
    $ git commit -m a
    [master (root-commit) b42584a] a
     1 file changed, 0 insertions($), 0 deletions(-)
     create mode 100644 a/file
    $ git add b
    $ git commit -m b
    [master 5114301] b
     1 file changed, 0 insertions($), 0 deletions(-)
     create mode 100644 b/file
    $ git subtree split -b split_a --prefix=a
    Created branch 'split_a'
    e9f5d81efacb33ab6cf67fe9ff376b33a483a92f
    $ git subtree split -b split_b --prefix=./b
    assertion failed:  [ b = ./b ]
    No new revisions were found
    
    When the commit is applied `git subtree split` works as expected:
    
    $ git init
    Initialized empty Git repository in /tmp/test/.git/
    $ mkdir a b
    $ touch a/file b/file
    $ git add a
    $ git commit -m a
    [master (root-commit) bc80f36] a
     1 file changed, 0 insertions($), 0 deletions(-)
     create mode 100644 a/file
    $ git add b
    $ git commit -m b
    [master e59c446] b
     1 file changed, 0 insertions($), 0 deletions(-)
     create mode 100644 b/file
    $ git subtree split -b split_a --prefix=a
    Created branch 'split_a'
    d542e9cd2de5956dd7ca77b169dba1c8418fa03a
    $ git subtree split -b split_b --prefix=./b
    Created branch 'split_b'
    3ae7854c0c395413c807b2bc4e75b651adc63f8c

 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index b567eae..d9351b9 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -411,7 +411,7 @@ subtree_for_commit()
 	dir="$2"
 	git ls-tree "$commit" -- "$dir" |
 	while read mode type tree name; do
-		assert [ "$name" = "$dir" ]
+		assert [ "$(readlink -f $name)" = "$(readlink -f $dir)" ]
 		assert [ "$type" = "tree" -o "$type" = "commit" ]
 		[ "$type" = "commit" ] && continue  # ignore submodules
 		echo $tree
-- 
2.1.4


-- 
Ivan Oleynikov
STC Metrotek
St.Petersburg

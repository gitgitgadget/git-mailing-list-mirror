Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE6E1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 18:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeL3Sgp (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 13:36:45 -0500
Received: from elephants.elehost.com ([216.66.27.132]:53593 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeL3Sgp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 13:36:45 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBUIafmK047029
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 13:36:41 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [BUG] t0410 2.20.1 fails on NonStop NSX platform
Date:   Sun, 30 Dec 2018 13:36:34 -0500
Message-ID: <000d01d4a06e$9ab18940$d0149bc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdSgbQYj3qvcGT4OSJWx9EE2rFQdxw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a bit of a head-scratcher. There are two NonStop platforms, which
behave essentially the same way. One, NSE, uses ia64, while NSX uses x64.
There are subtle differences in ksh and bash for the platforms based on what
is released when. The NSE platform has no problem running t0410 in Jenkins.
However, NSX fails in a few spots:

This is at 2.20.1. Our last port on this platform variant was 2.16.1, where
there were no unexplained issues.

I am suspecting that the problem is shell related, but I'm just not sure
what the test is supposed to do here. There are 9 other failures that appear
related, with the No such file or directory condition. If I add the -f flag
to rm in delete_object(), all t0410 tests pass except the last (22), but I
don't think that meets the intent of test itself. I wonder whether one of
the authors of the test might chime in on this.

The first, subtest 12 results in:

Initialized empty Git repository in /mypath/git/t/trash
directory.t0410-partial-clone/repo/.git/
[master (root-commit) 7745948] foo
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 foo.t
[master e514b54] bar
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 bar.t
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), done.
Total 1 (delta 0), reused 0 (delta 0)
2b7df34bc09be010087307b898e994ce709c0db1
rm: cannot remove
'repo/.git/objects/2b/7df34bc09be010087307b898e994ce709c0db1': No such file
or directory
not ok 12 - rev-list stops traversal at missing and promised commit
#
#               rm -rf repo &&
#               test_create_repo repo &&
#               test_commit -C repo foo &&
#               test_commit -C repo bar &&
#
#               FOO=$(git -C repo rev-parse foo) &&
#               promise_and_delete "$FOO" &&
#
#               git -C repo config core.repositoryformatversion 1 &&
#               git -C repo config extensions.partialclone "arbitrary
string" &&
#               GIT_TEST_COMMIT_GRAPH=0 git -C repo rev-list
--exclude-promisor-objects --objects bar >out &&
#               grep $(git -C repo rev-parse bar) out &&
#               ! grep $FOO out
#

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.




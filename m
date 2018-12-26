Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C7B211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 16:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeLZQHs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 26 Dec 2018 11:07:48 -0500
Received: from elephants.elehost.com ([216.66.27.132]:61333 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeLZQHr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 11:07:47 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wBQG7jrn081075
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 11:07:45 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'git mailing list'" <git@vger.kernel.org>
Subject: [Bug] t0410 breakages at 2.20.1 on NonStop platform
Date:   Wed, 26 Dec 2018 11:07:40 -0500
Message-ID: <003a01d49d35$23923940$6ab6abc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0030_01D49D0A.2F5AF170";
        charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGI7eb2k8A8nyVQLYdfWp+3qCoHEA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

We’re getting some new breakages in t0410 that I can’t explain easily or
either it is the test itself at commit 0d0ac3826a. 

[Filtered]
*** t0410-partial-clone.sh ***
not ok 5 - missing ref object, but promised, passes fsck
not ok 6 - missing object, but promised, passes fsck
not ok 7 - missing CLI object, but promised, passes fsck
not ok 12 - rev-list stops traversal at missing and promised commit
not ok 13 - missing tree objects with --missing=allow-promisor and
--exclude-promisor-objects
not ok 14 - missing non-root tree object and rev-list
not ok 15 - rev-list stops traversal at missing and promised tree
not ok 16 - rev-list stops traversal at missing and promised blob
not ok 22 - gc stops traversal when a missing but promised object is reached

The first one to fail – which probably would give me a hint on others is:
Initialized empty Git repository in /home/git/git/t/trash
directory.t0410-partial-clone/repo/.git/
[master (root-commit) 6591d03] 1
Author: A U Thor <author@example.com>
1 file changed, 1 insertion(+)
create mode 100644 1.t
[master 5355e57] 2
Author: A U Thor <author@example.com>
1 file changed, 1 insertion(+)
create mode 100644 2.t
[master a3007a6] 3
Author: A U Thor <author@example.com>
1 file changed, 1 insertion(+)
create mode 100644 3.t
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), done.
Total 1 (delta 0), reused 0 (delta 0)
fa10eb4e855a356f0abe9c352b62b71d481918b1
rm: cannot remove
'repo/.git/objects/fa/10eb4e855a356f0abe9c352b62b71d481918b1': No such file
or directory
not ok 6 - missing object, but promised, passes fsck
#
#               rm -rf repo &&
#               test_create_repo repo &&
#               test_commit -C repo 1 &&
#               test_commit -C repo 2 &&
#               test_commit -C repo 3 &&
#               git -C repo tag -a annotated_tag -m "annotated tag" &&
#
#               C=$(git -C repo rev-parse 1) &&
#               T=$(git -C repo rev-parse 2^{tree}) &&
#               B=$(git hash-object repo/3.t) &&
#               AT=$(git -C repo rev-parse annotated_tag) &&
#
#               promise_and_delete "$C" &&
#               promise_and_delete "$T" &&
#               promise_and_delete "$B" &&
#               promise_and_delete "$AT" &&
#
#               git -C repo config core.repositoryformatversion 1 &&
#               git -C repo config extensions.partialclone "arbitrary
string" &&
#               git -C repo fsck
#

The repo/.git contains the following at the time of failure:
.git/objects
.git/objects/info
.git/objects/pack
.git/objects/pack/pack-fa10eb4e855a356f0abe9c352b62b71d481918b1.idx
.git/objects/pack/pack-fa10eb4e855a356f0abe9c352b62b71d481918b1.pack
.git/objects/pack/pack-fa10eb4e855a356f0abe9c352b62b71d481918b1.promisor
.git/refs
.git/refs/heads
.git/refs/heads/master
.git/refs/tags
.git/refs/tags/1
.git/refs/tags/2
.git/refs/tags/3
.git/refs/tags/annotated_tag

Given the contents, I'm not surprised the 'rm' failed. Any help would be
appreciated in tracking down what happened.

Thanks,
Randall

-- Brief whoami:
  NonStop developer since approximately NonStop(211288444200000000)
  UNIX developer since approximately 421664400
-- In my real life, I talk too much.



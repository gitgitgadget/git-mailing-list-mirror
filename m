Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 280FD1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 19:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeDPT6Z convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 16 Apr 2018 15:58:25 -0400
Received: from prvmx04.microfocus.com ([130.57.1.219]:16791 "EHLO
        prvmx04.microfocus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753633AbeDPT6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 15:58:24 -0400
Received: from prvxcaht04.microfocus.com (Not Verified[137.65.248.138]) by prvmx04.microfocus.com with Trustwave SEG (v7,5,8,10121) (using TLS: TLSv1.2, AES256-SHA256)
        id <B5ad5005f0000>; Mon, 16 Apr 2018 13:58:23 -0600
Received: from PRVXMB04.microfocus.com ([137.65.249.213]) by
 prvxcaht04.microfocus.com ([137.65.248.138]) with mapi id 14.03.0339.000;
 Mon, 16 Apr 2018 13:58:23 -0600
From:   Isaac Chou <Isaac.Chou@microfocus.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git fast-export with import marks file omits merge commits
Thread-Topic: Git fast-export with import marks file omits merge commits
Thread-Index: AdPVtTHRi0DsZmJvQeyoGe8DOEQKbQAB88Aw
Date:   Mon, 16 Apr 2018 19:58:22 +0000
Message-ID: <1D42A4F860DBEF4C91D0E09C5CDE20097EC178E8@prvxmb04.microfocus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.70.12.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I came across a change of behavior with Git version 2.15 and later where the fast-export command would omit the merge commits.  The same use case works correctly with Git version 2.14 and older.  Here is the detail of the use case:

0> git --version
git version 2.16.2.windows.1

1> git init
Initialized empty Git repository in c:/./.git/

2> echo 1111 >> file.txt

3> git add file.txt

4> git commit -m "first commit"
[master (root-commit) 711d4d5] first commit
1 file changed, 1 insertion(+)
create mode 100644 file.txt

5> git checkout -b test
Switched to a new branch 'test'

6> echo 2222 >> file.txt

7> git add file.txt

8> git commit -m "commit on test branch"
[test 76d231c] commit on test branch
1 file changed, 1 insertion(+)

9> git checkout master
Switched to branch 'master'

10> echo 3333 >> file.txt

11> git add file.txt

12> git commit -m "commit on master branch"
[master 61c55fd] commit on master branch
1 file changed, 1 insertion(+)

13> git merge test
Auto-merging file.txt
CONFLICT (content): Merge conflict in file.txt
Automatic merge failed; fix conflicts and then commit the result.

14> notepad file.txt

15> git add file.txt

16> git commit -m "merged with test branch"
[master 1442e0e] merged with test branch

17> git log
commit 1442e0ee728c831e74550329e39d27d4188b4422 (HEAD -> master)
Merge: 61c55fd 76d231c
Author: isaac <...>
Date:   Mon Apr 16 15:08:39 2018 -0400

    merged with test branch

commit 61c55fdb883fc403e63c91b49bc11bdade62b3e8
Author: isaac <...>
Date:   Mon Apr 16 15:07:41 2018 -0400

    commit on master branch

commit 76d231cdb12eb84f45abdebede06a56f912613d3 (test)
Author: isaac <...>
Date:   Mon Apr 16 15:07:07 2018 -0400

    commit on test branch

commit 711d4d5781df41924421f8629af040e7c91a8d2e
Author: isaac <...>
Date:   Mon Apr 16 15:06:07 2018 -0400

    first commit

18> echo :1 711d4d5781df41924421f8629af040e7c91a8d2e > git-marks

19> cat git-marks
:1 711d4d5781df41924421f8629af040e7c91a8d2e

20> git fast-export --use-done-feature --import-marks=git-marks refs/heads/master --
feature done
blob
mark :2
data 12
1111
2222

commit refs/heads/master
mark :3
author isaac <...> 1523905627 -0400
committer isaac <...> 1523905627 -0400
data 22
commit on test branch
from :1
M 100644 :2 file.txt

blob
mark :4
data 12
1111
3333

commit refs/heads/master
mark :5
author isaac <...> 1523905661 -0400
committer isaac <...> 1523905661 -0400
data 24
commit on master branch
from :1
M 100644 :4 file.txt

done

Thanks,

Isaac


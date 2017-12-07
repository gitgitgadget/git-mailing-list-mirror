Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 315F420C31
	for <e@80x24.org>; Thu,  7 Dec 2017 09:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751022AbdLGJEG (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 04:04:06 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35434 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdLGJED (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 04:04:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.21/8.16.0.21) with SMTP id vB792FIN079203
        for <git@vger.kernel.org>; Thu, 7 Dec 2017 09:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : from : cc :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=06H3yrCQ5OYx32WFnRn2taUgzbcsTQ6Q96v/XGPqPsU=;
 b=S5oNy4ynW3fhkeR5T6Bj70152GJWRx++EmsMqt/fiFCQhLXwm3ZmH3H1KRstwdQaO2I6
 ApgRenCdcYxQtinCFtk4NRAq1BUL6OeiiRSRPWk8dm8bu6MgMZLTQwHxPPn4lscbawMP
 tIcmcv95zw8P5EP0p7bx2IuC9nfhMfGsGzEFhQ7hyGkWBK1DmahxsmL3TISwSWnyH3Y3
 17562IDrG+UbGNXLY9K6oU9X143ofZY4S7lqtEVAkZRKLXI4xSko3qa7JKq7Z/5r7/W8
 QeTy2BlAR8Xz6n66IxNnz0aIgbU5qETXWcukTKJ49fB9vvUo1wKDd2KNrLHQ6GEAa6D9 2Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2epct9e746-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 09:04:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id vB7941eV028872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 7 Dec 2017 09:04:01 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id vB7940v6013663
        for <git@vger.kernel.org>; Thu, 7 Dec 2017 09:04:01 GMT
Received: from [10.0.2.195] (/213.57.127.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Dec 2017 01:04:00 -0800
To:     Git mailing list <git@vger.kernel.org>
From:   Elazar Leibovich <elazar.leibovich@oracle.com>
Cc:     idan brown <idan.brown@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Eyal Moscovici <eyal.moscovici@oracle.com>,
        nikita.leshchenko@oracle.com
Subject: Unfortunate interaction between git diff-index and fakeroot
Message-ID: <0190ae30-b6c8-2a8b-b1fb-fd9d84e6dfdf@oracle.com>
Date:   Thu, 7 Dec 2017 11:03:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8737 signatures=668643
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1712070139
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We noticed some unexpected behavior of git, when running git commands under
fakeroot, and then running another command without fakeroot.

When running, e.g., git status, or git describe --dirty, git can
update the index file.

This can happen inadvertently by, e.g., running the make install process of
a package under fakeroot, and running "git describe --dirty", or "git
status" to generate package name.

The unexpected result is:

"fakeroot git status" updates the index, and the index now says all files
are owned by uid:0.

"git diff-index --name-only HEAD" is used to test if the git tree is dirty
without fakeroot, concluding all files have changed, since their owner UID
is changed.

You can easily recreate it:

     $ mkdir gitexample;cd gitexample;git init
     Initialized empty Git repository in /home/elazar/gitexample/.git/
     $ touch x; git add x; git commit -m init
      1 file changed, 0 insertions(+), 0 deletions(-)
      create mode 100644 x
     $ git diff-index HEAD # nothing is printed, since working dir clean
     $ fakeroot git diff # index is updated to contain uid:0
     $ git ls-files -s --debug
     100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       x
       ctime: 1512636533:915178157
       mtime: 1512636533:915178157
       dev: 64515    ino: 8523907
       uid: 0        gid: 0
       size: 0       flags: 0
     $ git diff-index --name-only HEAD # x is considered different now
     x

Make sure you do not have a shell prompt that calls git status in
between, like oh-my-zsh, or bash-it.

This is problematic because:

1. File owner is not really tracked by git porcelain, and I'm not sure
    what's the benefit of tracking ownership of files in git diff-index. 
Users
    who expect git diff to return "no changes" after ownership changed, 
expect
    git diff-index to return "no changes" as well.

   This is supported by the manual page who say "Compares the content 
and mode
   of the blobs found in a tree object with the corresponding tracked 
files in
   the working tree", and doesn't mention file ownership.

2. Linux tree uses git diff-index to test if the working tree is dirty. It
    can, and has cause subtle issues when building and packaging different
    parts of the tree to different directories concurrently.

Our proposed solutions:

Make match_stat_data ignore ownership changes.

I searched git source for usage of OWNER_CHANGED bit and found that no one
tests for it. I can't think of a scenario where the fact that the owner have
changed would matter.

I searched for usage of git-diff-index in git tree, and found that
git-stash uses it. This is not relevant since stash would ignore ownership
changes. I saw that merge-octupus and filter-branch uses git-diff-index
but they also don't seem to care if ownership has changed.

I searched for the first commit who tracked file ownership in the index,
it was there from the first commit e83c5163316f89bfbde7d9ab23ca2e25604af290
I found no specific reason given for tracking the owner in related commits.

You can see a change in a similar spirit to what I propose in commit
2cb45e95438c113871fbbea5b4f629f9463034e7 where st_dev is ignored by default
due to similar problem in NFS.

What do you think?

Should the behavior remain, and diff-index should say it tracks "mode and
owner changes"?
Would it be OK to change the actual behavior of diff-index to ignore owner
changes?


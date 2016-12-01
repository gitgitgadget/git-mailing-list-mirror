Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8655B1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbcLAWDo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 1 Dec 2016 17:03:44 -0500
Received: from mx0b-00176a03.pphosted.com ([67.231.157.48]:41840 "EHLO
        mx0a-00176a03.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751895AbcLAWDn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Dec 2016 17:03:43 -0500
Received: from pps.filterd (m0048299.ppops.net [127.0.0.1])
        by m0048299.ppops.net-00176a03. (8.16.0.17/8.16.0.17) with SMTP id uB1Lw1vi016275
        for <git@vger.kernel.org>; Thu, 1 Dec 2016 17:03:37 -0500
From:   "Alfonsogonzalez, Ernesto (GE Digital)" 
        <ernesto.alfonsogonzalez@ge.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: EXT: Re: "Your branch is ahead of 'origin' by X commits"
Thread-Topic: EXT: Re: "Your branch is ahead of 'origin' by X commits"
Thread-Index: AQHSTB7B11MtfUC1okK4vus5mnSkVA==
Date:   Thu, 1 Dec 2016 22:03:33 +0000
Message-ID: <D465DC74.B911%ernesto.alfonsogonzalez@ge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [3.159.19.181]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <99C789C5C2970B4F818FE8CFE22FF5BE@mail.ad.ge.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-12-01_19:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.0.1-1609300000
 definitions=main-1612010356
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

I followed all your steps, but didn¹t find anything.

$ ls -d .git
.git
$ ls .git/master
ls: .git/master: No such file or directory
$ git show HEAD
commit 92d392c37e376db69d61dafdc427b379d860fb5a
Merge: 6be322c 5544904
...
$ git show refs/heads/master
commit 92d392c37e376db69d61dafdc427b379d860fb5a
Merge: 6be322c 5544904
...
$ git rev-parse --symbolic-full-name master
refs/heads/master
$

Then I realized that the message should say,

"Your branch is ahead of Œorigin/master' by X commits"
And not

"Your branch is ahead of 'origin' by X commits²


So I used branch ‹set-upstream and see the expected behavior.

$ git branch --set-upstream-to=origin/master
Branch master set up to track remote branch master from origin.
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Untracked files:
  (use "git add <file>..." to include in what will be committed)

 ...
nothing added to commit but untracked files present (use "git add" to
track)
$ 




I¹m still not sure what it means for the branch upstream to be ³origin²
only.

I do have 2 remotes. A 2nd remote, called ³teamname-origin², is indeed
behind my local master by 108 commits.

So it seems there is a bug. When master¹s upstream is ³origin², it was
actually pointing to ³teamname-origin/master², which is behind by 108
commits.

However, pushing, pulling, rebasing, etc, all work against the correct
remote (³origin²). 

So this could be a bug in git status?

Thanks,

Ernesto


On 12/1/16, 1:47 PM, "Jeff King" <peff@peff.net> wrote:

>On Thu, Dec 01, 2016 at 07:49:40PM +0000, Alfonsogonzalez, Ernesto (GE
>Digital) wrote:
>
>> $ git diff origin/master
>> $ git status
>> On branch master
>> Your branch is ahead of 'origin' by 108 commits.
>>   (use "git push" to publish your local commits)
>> Untracked files:
>>   (use "git add <file>..." to include in what will be committed)
>
>The "master" we are talking about here must always be
>"refs/heads/master", since it will have come from resolving the HEAD
>symbolic ref.
>
>But here:
>
>> $ git show origin/master --oneline
>> 92d392c Merge pull request #21 from org/branch
>> 
>> $ git show master --oneline
>> 92d392c Merge pull request #21 from org/branch
>
>The "master" in the second case could possibly find "master" as another
>name. Is it possible you have a .git/master file (this may have been
>created by accidentally running "git update-ref master" instead of "git
>update-ref refs/heads/master")?
>
>Or other things you could check:
>
>  # see what's on HEAD, which we know points to refs/heads/master
>  git show HEAD
>
>  # or just check refs/heads/master itself
>  git show refs/heads/master
>
>  # or just ask what "master" resolves to
>  git rev-parse --symbolic-full-name master
>
>That last one actually seems to complain that "refname 'master' is
>ambiguous' if you do have .git/master. I think that's a minor bug, as it
>should presumably follow the normal disambiguation rules used for lookup
>(in which .git/master always takes precedence over refs/heads/master).
>
>-Peff


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F95207E4
	for <e@80x24.org>; Sat, 29 Apr 2017 00:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426008AbdD2APM (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 20:15:12 -0400
Received: from avasout07.plus.net ([84.93.230.235]:57188 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426003AbdD2APL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 20:15:11 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id E0F71v0081keHif010F8bx; Sat, 29 Apr 2017 01:15:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=R/pzIZZX c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=Q9fys5e9bTEA:10 a=EBOSESyhAAAA:8 a=ZH4y7VO0930S7YieMSwA:9 a=PUjeQqilurYA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in
 path'
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
 <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com>
 <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a575542a-e5b6-389f-e240-d5ac5a4b4107@ramsayjones.plus.com>
Date:   Sat, 29 Apr 2017 01:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/04/17 20:54, Johannes Sixt wrote:
> Am 28.04.2017 um 05:09 schrieb Junio C Hamano:
>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>
>>> Commit cf9e55f494 ("submodule: prevent backslash expantion in submodule
>>> names", 07-04-2017) added a test which creates a git repository with
>>> some backslash characters in the name. This test cannot work on windows,
>>> since the backslash is used as the directory separator. In order to
>>> suppress this test on cygwin, MinGW and Git for Windows, we add the
>>> BSLASHPSPEC prerequisite. (see also commits 6fd1106aa4 and c51c0da222).
> 
> First, let me say that meaning of BSLASHPSPEC was
> "keeps backslaches in pathspec arguments" originally,
> but it apparently changed meaning since then.

Indeed. I started to give some of the history in the commit message, but
it was nearly 3am, so I punted with the 'see also commits 6fd1106aa4 and
c51c0da222' ... ;-)
 
> t7400.20 does not fail for the MinGW port because the
> test case only operates on the file system, but never
> checks whether an entry 'sub\with\backslash' is present
> in the index.

Ah, OK. I only looked at my (64-bit) MSYS2 build, which fails
exactly the same as cygwin. Hmm, wait, let me just rebuild on
MinGW64 ... indeed it passes (well it passes t7400.20, but it
fails on t7400.11, 61, 63, 87 and 89)!

> 
>>> @@ -273,7 +273,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
>>>      test_cmp empty untracked
>>>  '
>>>
>>> -test_expect_success 'submodule add with \\ in path' '
>>> +test_expect_success BSLASHPSPEC 'submodule add with \\ in path' '
>>>      test_when_finished "rm -rf parent sub\\with\\backslash" &&
>>>
>>>      # Initialize a repo with a backslash in its name
>>
> 
> I assume the test fails right at 'git init' under Cygwin?

Indeed. Also on MSYS2 (exactly as on cygwin):

ramsay@satellite  MSYS $ ./t7400-submodule-basic.sh -i -v

...

ok 19 - submodule add with ./, /.. and // in path

expecting success:
        test_when_finished "rm -rf parent sub\\with\\backslash" &&

        # Initialize a repo with a backslash in its name
        git init sub\\with\\backslash &&
        touch sub\\with\\backslash/empty.file &&
        git -C sub\\with\\backslash add empty.file &&
        git -C sub\\with\\backslash commit -m "Added empty.file" &&

        # Add that repository as a submodule
        git init parent &&
        git -C parent submodule add ../sub\\with\\backslash

fatal: cannot mkdir sub\with\backslash: No such file or directory
not ok 20 - submodule add with \\ in path
#
#               test_when_finished "rm -rf parent sub\\with\\backslash" &&
#
#               # Initialize a repo with a backslash in its name
#               git init sub\\with\\backslash &&
#               touch sub\\with\\backslash/empty.file &&
#               git -C sub\\with\\backslash add empty.file &&
#               git -C sub\\with\\backslash commit -m "Added empty.file" &&
#
#               # Add that repository as a submodule
#               git init parent &&
#               git -C parent submodule add ../sub\\with\\backslash
#
ramsay@satellite  MSYS $

ramsay@satellite  MSYS $ cd trash\ directory.t7400-submodule-basic/

ramsay@satellite  MSYS $ ls
a       addtest/         empty   expect-head   head   head-sha1  untracked
actual  addtest-ignore/  expect  expect-heads  heads  t          z

ramsay@satellite  MSYS $ git init sub\\with\\backslash
fatal: cannot mkdir sub\with\backslash: No such file or directory

ramsay@satellite  MSYS $ mkdir -p sub\\with

ramsay@satellite  MSYS $ git init sub\\with\\backslash
Initialized empty Git repository in /home/ramsay/git/t/trash directory.t7400-submodule-basic/sub/with/backslash/.git/

ramsay@satellite  MSYS $ touch sub\\with\\backslash/empty.file
ramsay@satellite  MSYS $ git -C sub\\with\\backslash add empty.file
ramsay@satellite  MSYS $ git -C sub\\with\\backslash commit -m "Added empty.file"
[master (root-commit) 6fde90b] Added empty.file
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 empty.file

ramsay@satellite  MSYS $ git init parent
Initialized empty Git repository in /home/ramsay/git/t/trash directory.t7400-submodule-basic/parent/.git/

ramsay@satellite  MSYS $ git -C parent submodule add ../sub\\with\\backslash
Cloning into '/home/ramsay/git/t/trash directory.t7400-submodule-basic/parent/sub/with/backslash'...
done.
fatal: Not a git repository: /home/ramsay/git/t/trash directory.t7400-submodule-basic/parent/sub\with\backslash/../.git/modules/sub/with/backslash

ramsay@satellite  MSYS $ echo $?
128
ramsay@satellite  MSYS $

Do you not see this on msys?

> 
> BSLASHPSPEC (with its *new* meaning) would be the
> right prerequisite if the check for the index entry
> were added. Until then, !CYGWIN is more appropriate.

OK, I'll re-roll the patch (tomorrow, it's late again).

Thanks.

ATB,
Ramsay Jones



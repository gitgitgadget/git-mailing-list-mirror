Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13414207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 19:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425146AbdD1TzD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 15:55:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:29684 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423570AbdD1TzB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 15:55:01 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wF4Kb3bLJz5tlB;
        Fri, 28 Apr 2017 21:54:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8868642B7;
        Fri, 28 Apr 2017 21:54:57 +0200 (CEST)
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in
 path'
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com>
 <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org>
Date:   Fri, 28 Apr 2017 21:54:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.04.2017 um 05:09 schrieb Junio C Hamano:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Commit cf9e55f494 ("submodule: prevent backslash expantion in submodule
>> names", 07-04-2017) added a test which creates a git repository with
>> some backslash characters in the name. This test cannot work on windows,
>> since the backslash is used as the directory separator. In order to
>> suppress this test on cygwin, MinGW and Git for Windows, we add the
>> BSLASHPSPEC prerequisite. (see also commits 6fd1106aa4 and c51c0da222).

First, let me say that meaning of BSLASHPSPEC was "keeps backslaches in 
pathspec arguments" originally, but it apparently changed meaning since 
then.

The prerequisite was introduced in 6fd1106aa4 because the MinGW port 
rewrites backslashes in command arguments that undergo the '\'->"/" 
transformation introduced for prefix_filename() in 25fe217b86. It 
destroys the backslashes that could otherwise be used to escape globbing 
characters. t3700 does just that.

Since Cygwin does not do this rewriting, the original CYGWIN section in 
test-lib.sh had the prerequisite, just like the default (POSIX). But it 
was removed by 5b5d53cbe5 (t4135-*.sh: Skip the "backslash" tests on 
cygwin), and that is where BSLASHPSPEC changed meaning. That commit even 
carries my Acked-by (!), even though I can't recall giving it and I 
don't find it in the conversation about the patch:

https://public-inbox.org/git/4D07B977.9010502@ramsay1.demon.co.uk/

>> I built v2.13.0-rc1 and ran the test-suite on cygwin this evening and
>> had an additional failure, over and above the failures reported for
>> v2.13.0-rc0, namely t7400.20. This patch elides that test for cygwin
>> (and MinGW and GfW, so it would be good to hear success reports from
>> both Johannes).

t7400.20 does not fail for the MinGW port because the test case only 
operates on the file system, but never checks whether an entry 
'sub\with\backslash' is present in the index.

>> @@ -273,7 +273,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
>>  	test_cmp empty untracked
>>  '
>>
>> -test_expect_success 'submodule add with \\ in path' '
>> +test_expect_success BSLASHPSPEC 'submodule add with \\ in path' '
>>  	test_when_finished "rm -rf parent sub\\with\\backslash" &&
>>
>>  	# Initialize a repo with a backslash in its name
>

I assume the test fails right at 'git init' under Cygwin?

BSLASHPSPEC (with its *new* meaning) would be the right prerequisite if 
the check for the index entry were added. Until then, !CYGWIN is more 
appropriate.

-- Hannes


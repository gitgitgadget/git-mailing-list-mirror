Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395591F404
	for <e@80x24.org>; Wed, 10 Jan 2018 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeAJSQ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 13:16:28 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:32112 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752785AbeAJSQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 13:16:25 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zGxzD1J1Cz5tlC;
        Wed, 10 Jan 2018 19:16:23 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 49EDA211D;
        Wed, 10 Jan 2018 19:16:23 +0100 (CET)
Subject: Re: [PATCH] Prototype PATH_MAX length detection in tests,
 demonstrated in t0001-init.sh
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, Bill Honaker <bhonaker@xid.com>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>
References: <f08a9506afb73c57751d3d413bfb433a.squirrel@secure.elehost.com>
 <47197839-720f-3c8d-729c-3fcb615aeb36@kdbg.org>
 <005d01d389a7$c55da9f0$5018fdd0$@nexbridge.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f485f647-bff6-e219-2fc5-a2a9410b6d17@kdbg.org>
Date:   Wed, 10 Jan 2018 19:16:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <005d01d389a7$c55da9f0$5018fdd0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2018 um 01:12 schrieb Randall S. Becker:
> On January 9, 2018 6:01 PM, Johannes Sixt wrote:
> I'm encountering strange warnings, while looking into the details of what test t0001 fails in spots. These include:
> #24 warning: templates not found x00000000000000...[lots of 0 deleted...]00000000000000000000
> which exceeds 2K, but that's just content, right, and not causing an apparent breakage.

This warning occurs also on Linux and Windows. I think it is by design
and not something to be fixed.

> 
> # 34. Admittedly it was shorter than 2K, but there is something weird in this path that I can't find, causing a failure out of fts_read from gnulib.
> Initialized empty Git repository in /home/ituglib/randall/git/t/trash directory.t0001-init/123456789abcdef/123456789abcdef/123456789abcdef/123456789abcdef/123456789abcdef/123456789abcdef/123456789abcdef/123456789abcdef/newdir/.git/
> rm: fts_read failed: No such file or directory
> 
> This error is coming from some of shell utilities (in this case rm)
> used in the test rather than git code itself.

So, the problem is not in the git executable. This does not warrant a
change in the build process, yet.

>  While well within the
> supported path length of the operating system/platform (1K), there is
> an acknowledged issue that is causing breakage when paths get large
> enough (even only this large, unfortunately). We're at 221 breaks out
> of 12982-ish, which is good, but have to otherwise visually check
> each breakage until the fts_read problem is resolved - I know what
> the issue is, but I don't have the auth to resolve it, so waiting on
> HPE platform development for that. Of course, manually patching that
> many breaks is equally unwieldy, so I'm willing to tolerate not
> having this patch applied at this time.

Let me propose a different workaround. In my build on Windows, I inject
a few blind spots in the test suite using GIT_SKIP_TESTS for cases where
I do not have time to find a fix. It looks like this:

diff --git a/t/Makefile b/t/Makefile
index 96317a35f4..fd8b18c3c0 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -103,3 +103,19 @@ perf:
 	$(MAKE) -C perf/ all
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf
+
+# see https://public-inbox.org/git/alpine.DEB.2.21.1.1710260008270.37495@virtualbox/
+# the suggested solution is for MSYS2; don't have time to fix this for MSYS
+GIT_SKIP_TESTS += t0021.1[5-9] t0021.2[0-6]
+# special file names
+GIT_SKIP_TESTS += t1300.14[02]
+# GIT_SSH_COMMAND with args forwarded incompletely via git clone to test_fake_ssh
+GIT_SKIP_TESTS += t5601.5[01]
+# unknown failure in shallow submodule test
+GIT_SKIP_TESTS += t7406.46
+# mktemp missing?
+GIT_SKIP_TESTS += t7610.22
+export GIT_SKIP_TESTS
+
+NO_SVN_TESTS=SkipThem
+export NO_SVN_TESTS
-- 

Build the list of test cases that do not pass, until the test suite runs
through. Then start fixing the cases.

It is not foolproof, but very effective in keeping the focus on new
cases. You have to run tests with 'make' so that the variable is picked
up. Also, when somebody adds new tests in front of the mentioned cases,
the numbers must be adjusted.

-- Hannes

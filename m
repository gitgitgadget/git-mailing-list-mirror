Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9BEC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347473AbiDKOuh convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 11 Apr 2022 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiDKOue (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 10:50:34 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 07:48:14 PDT
Received: from dia.uberspace.de (dia.uberspace.de [185.26.156.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2BE222BA
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 07:48:14 -0700 (PDT)
Received: (qmail 2772 invoked by uid 989); 11 Apr 2022 14:41:32 -0000
Authentication-Results: dia.uberspace.de;
        auth=pass (plain)
From:   Christoph Groth <christoph@grothesque.org>
To:     git@vger.kernel.org
Subject: git-bisect behaves differently when started in equivalent ways
Date:   Mon, 11 Apr 2022 16:41:28 +0200
Message-ID: <878rsbof6v.fsf@drac>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Bar: --
X-Rspamd-Report: MIME_GOOD(-0.1) MID_RHS_NOT_FQDN(0.5) BAYES_HAM(-2.996749)
X-Rspamd-Score: -2.596749
Received: from unknown (HELO unkown) (::1)
        by dia.uberspace.de (Haraka/2.8.28) with ESMTPSA; Mon, 11 Apr 2022 16:41:32 +0200
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I found a puzzling behavior with git-bisect for which I was unable to
find any explanation.  Since this might be a bug, I report it here.

cheers
Christoph


What did you do before the bug happened? (Steps to reproduce your issue)

While bisecting a regression caused by a backwards-incompatible change
in the sympy project, I noticed that “git bisect” can behave
differently when started in different but supposedly equivalent ways.

The following complete log demonstrates the issue.

For the first run, I clone the “sympy” repository and start bisect with
“git bisect start” (as shown in the first example of the git bisect
manpage).  I declare a good and a bad commit and am asked to estimate
a specific commit.  I declare this one to be good (which it is for my
particular problem), but this causes git to remark that a commit is
“both good and bad”.

For the second run, I provide the bad and the good commit to git-bisect
start right away.  I am asked to examine the same commit as before to
which I give the same assessment.  This time, git-bisect accepts this.

# Preparation
/tmp% git clone https://github.com/sympy/sympy.git
Cloning into 'sympy'...
(...)
/tmp% cd sympy 
/tmp/sympy% git checkout sympy-1.7.1
Note: switching to 'sympy-1.7.1'.
(...)
HEAD is now at 9e8f62e059 Merge pull request #20592 from oscarbenjamin/pr_latex_filename

# First run
/tmp/sympy% git bisect start
/tmp/sympy% git bisect good
/tmp/sympy% git bisect bad sympy-1.10.1
Bisecting: a merge base must be tested
[da03c3227771953b0dd175b5b2ef65ebb937b0df] Merge pull request #20228 from sidhu1012/perf
/tmp/sympy% git describe
sympy-1.6-2010-gda03c32277
/tmp/sympy% git bisect good
f5bba2a7147ef8a6980ff043e93dd038c14bb9bc was both good and bad

# Second run
/tmp/sympy% git bisect reset
Previous HEAD position was da03c32277 Merge pull request #20228 from sidhu1012/perf
HEAD is now at 9e8f62e059 Merge pull request #20592 from oscarbenjamin/pr_latex_filename
/tmp/sympy% git bisect start sympy-1.10.1 sympy-1.7.1
Bisecting: a merge base must be tested
[da03c3227771953b0dd175b5b2ef65ebb937b0df] Merge pull request #20228 from sidhu1012/perf
/tmp/sympy% git describe
sympy-1.6-2010-gda03c32277
/tmp/sympy% git bisect good
Bisecting: 2606 revisions left to test after this (roughly 11 steps)
[b335cf582f4a789b725cc37822d6eed42c8d9e71] add test and fix space

What did you expect to happen? (Expected behavior)

I expected git-bisect to behave in the same way both times.

What happened instead? (Actual behavior)

One time it complains that a commit is “both good and bad”, one time it
does not.

Anything else you want to add:

I could not find any explanation for the difference.  If it is
intentional I suggest documenting it more clearly.


[System Info]
git version:
git version 2.30.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.10.0-13-amd64 #1 SMP Debian 5.10.106-1 (2022-03-17) x86_64
compiler info: gnuc: 10.2
libc info: glibc: 2.31
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

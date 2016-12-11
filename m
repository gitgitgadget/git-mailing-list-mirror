Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ED6F1FF7F
	for <e@80x24.org>; Sun, 11 Dec 2016 11:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbcLKLQ7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 06:16:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:63812 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751795AbcLKLQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 06:16:57 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MS5QA-1c5d4T2PGs-00THDs; Sun, 11
 Dec 2016 12:16:51 +0100
Date:   Sun, 11 Dec 2016 12:16:49 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 0/1] Fix a long-standing isatty() problem on Windows
Message-ID: <cover.1481454992.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:8WVkLmYCrb/uopppkfHZOkHYgjbquJic9Nvpr8xnd0uco/dlG0M
 pSWGKAGJlT03KINlEqPncCsRqzWuDHM6A1CXpl7tOfrMucMxixt0vHR88PJ9s5+yaZvWNRG
 vD/F1Q0+q7cNm0YELpTdl+G8xA7Z6Gt4IKkB1WSdXZEm1RRRKqfPC9ZM4Ufp6OXx9Vf2z3v
 GXQSLnNLKMP+SJTgsHo/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vXHGFgGQ51c=:fTgWACgLWrXlupCQhltmmr
 h4UCwBCH50LJdKroELGr9UdpSAL35YNdPX1etweAdGxNWm94zibtAk/MlbD4fUC4nnlNlzsXF
 HlMsvoemBBXn7euGPRhcfHRRqNfAPr57Jd2nytvdqYPybd2ECocnmwH3YNhC93w12NLE8jZrm
 MQfSlfVheh3y7Sn+7pYTzWnyI/lFnDSkW5mY38hIuRoDqOfLSs30S9eA8t5/kfU7xqoS8L8X2
 wBZLiJ+WeIaHdsa5Uo/aHzAWJF3GgTfe/fDaCFWGaQ8LwvzTETp+i82yZwItfSZlnmxLjsXND
 guU3jMoTb5g3Ox6DOQYuQwdVKcGyM1RWDEVn1LK/yBYKjmiP14xokndDsJ48dNOG6j6M+/Jp2
 BamZKPlSKUbDlw07ER62QXFgKpBezkh/0tF9pt7clJjSEoTscFGFCilC8HsYksAIPq0G6+6aA
 Jy439Hy6DnFnakzPEs2Unqv42VvBaqMHGJyVX/dJFY+mCVAXzbOsBzY3b9F1lUzxrFQ84eb/5
 67jWJ5aWvPTd/nN7aSCtuH8+bB/y/ZAFFiQDWaWP4CpitwbwaX+q/HtfOD4GpCsTMpN1MO52P
 LVHKp7Y7Iv6cN2K69jpCgMUCMy5RxYTdtXZmmwsHV+RUc8q0lTtWblHJy5ywS8f1T/T56mzYw
 9/I+m34RbkTwUp+thYajpbpZ5wpkKzuePvIKwZuvFao0Ka+1I0+Ukc/9Ql/a/OZPObI7ywW6c
 Ej0OVyjFy8ZegZ79XqJKxiLsW5ZeHRXLN6wfeCkPzFbDuRjd1UTgO4m/yPChWBy99VZiFI5Us
 6H9KSRx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I finally got a chance to debug the problems with the ever-timing-out
test runs of `pu` on Windows. Turns out that pb/bisect uncovered a
really old, really bad bug: on Windows, isatty() does not do what Git
expects, at least not completely: it detects interactive terminals *and
character devices*.

Why is this such a big deal?

One such character device is NUL, Windows' equivalent of /dev/null. And
guess what happens when the new tests of the bisect--helper run, with
stdin redirected from /dev/null? Precisely. Git asks "the user" for
reassurance that it may really continue, waiting forever. Or for Ctrl+C.

As we know what Git's source code wants, we have to make extra certain
to test whether isatty() reports success for a Console. The common way
to do this is to run GetConsoleMode() for input file descriptors, and
GetConsoleScreenBufferInfo() for output file descriptors.

One additional note: the new winansi_isatty() function was put into this
particular spot not only because it vaguely makes sense to put
tty-related stuff into compat/winansi.c, but with required future
changes in mind:

The current way in which Git for Windows makes sure that isatty()
returns non-zero for Git Bash (which runs in a terminal emulator called
MinTTY that does *not* have any Windows Console associated with it, and
therefore Windows' _isatty() would actually return 0 if it was not for
our detect_msys_tty() function) is hacky and needs to be fixed properly.

It is hacky because it relies on internals of the MSVC runtime that do
not hold true for the new Universal runtimes, which are used when
compiling with Visual C.

We already have experimental code to future-proof this method, and we
use that already when compiling Git for Windows in Visual Studio.

The place in which winansi_isatty() now lives will hopefully make it
possible to unify the code paths again, so that both GCC and Visual C
use detect_msys_tty() through winansi_isatty().

This will also fix a bug where current Visual C-built Git may misdetect
a reopened stdin to be connected to an interactive terminal.


Johannes Schindelin (1):
  mingw: intercept isatty() to handle /dev/null as Git expects it

 compat/mingw.h   |  3 +++
 compat/winansi.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)


base-commit: 8d7a455ed52e2a96debc080dfc011b6bb00db5d2
Published-As: https://github.com/dscho/git/releases/tag/mingw-isatty-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-isatty-v1

-- 
2.11.0.rc3.windows.1


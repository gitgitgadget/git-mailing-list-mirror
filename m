Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7CE11FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 17:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761887AbcLVRJH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 12:09:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:57739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755550AbcLVRJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 12:09:06 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ltr89-1cjvdJ3uGz-011EIm; Thu, 22
 Dec 2016 18:08:53 +0100
Date:   Thu, 22 Dec 2016 18:08:51 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 0/3] Really fix the isatty() problem on Windows
In-Reply-To: <cover.1482342791.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1482426497.git.johannes.schindelin@gmx.de>
References: <cover.1482342791.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Z8fgCyWrWniXip7pYGOTXkcAnyZ6rWa1rKBZYw/s7Rh5B64WMuS
 0eezzJx/01NmnIGyF7vQEn83M6lVzE+2FeMYAjOxtp6Uct5Ptga4B6JpIMStpdNAPwLN6JO
 vboLcgxDvSK3veuWsjfFPjkAWOEaN0q5Tucy3BXAahKVp1rCNXsWCQkszx00s5SbsoJZoU1
 dyDI3G0nlrrK2wj6ICnnQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HYCp19liC0k=:Nx8NwISWHuRYm1J/+v9VmZ
 g0V18QnFldhLurUYxq0wQFKSSreglyYYqw3Lg7alvVEd/tIfEBhfGAlXM1cyG05TyXud5tkT5
 aEd8ORfZpO4hyNLZHGoCVdSYTvE+QAw4M0f7ZvvDlBpNdc0chJcVZIvAOZCIrn+wCsJcFddvE
 OQcHm762kZvEcBYDoFL0UGAB2M+ZSMQ/hwkUeUaQMPX4Ncb3U3Tsc4CyWe5Q5BlyAzrUiCRp4
 8Mj0i22vrKuRzrkg98oEEU8RvKF6AITSFjtGS/2XaANvHX4vs4f1hdigdx1K6zSi0xoD1vk1+
 1COp+4/U9gGKTeofR9DDSKS0DNB7DEV5QcOW4R4isa5nEtrZXMGp2IV7DdyFkKV6U4VYqO6fg
 WGmYE3/hlZSsTBoMCR2MPEwWHsOjvVy9dzUL1CLxUamyvrZu6sDyNW2KlxsfQ09W5Oy01LyCd
 MpuYO1ny0g5fu9IGijRGl/sSvmhCC79gxLWIfrnee/OuLIkDAMe4Lp6UDH+2SK7/728q9WGPj
 IKfiB1lodJOPOfXzAHTdFHENbraQYEe4ksDpU2qZOWeUJgR+Yu+lUCCHPzuA5X4R09rGhLyrp
 BSeP3WnEpFNGGQ2nv93Fd5dO6GUOC+pdHS4cQDTUWkttuPKepiKi9xzQUS4KOPahVu0i1slZj
 bxTE82cFO2O8KXhVOi0gqcuWDr+ea8Qj/mqDsasVLXCBIMiDyYmzUEdq0e5hQMMuFvaQ4Fy7O
 M39MxKfhLLk4jTB76+6KYXPW8ND7RG4VOy4+6oUqCqc0vG8BG0s4s6Qr1QzVyqb4vGUBFN8so
 XkTl8yx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My previous fix may have fixed running the new
t/t6030-bisect-porcelain.sh script that tested the new bisect--helper,
which in turn used isatty() to determine whether it was running
interactively and was fooled by being redirected to /dev/null.

But it not only broke paging when running in a CMD window, due to
testing in the wrong worktree I also missed that it broke paging in Git
for Windows 2.x' Git Bash (i.e. a MinTTY terminal emulator).

Let's use this opportunity to actually clean up the entire isatty() mess
once and for all, as part of the problem was introduced by a clever hack
that messes with internals of the Microsoft C runtime, and which changed
recently, so it was not such a clever hack to begin with.

Happily, one of my colleagues had to address that latter problem
recently when he was tasked to make Git compile with Microsoft Visual C
(the rationale: debugging facilities of Visual Studio are really
outstanding, try them if you get a chance).

And incidentally, replacing the previous hack with the clean, new
solution, which specifies explicitly for the file descriptors 0, 1 and 2
whether we detected an MSYS2 pseudo-tty, whether we detected a real
Win32 Console, and whether we had to swap out a real Win32 Console for a
pipe to allow child processes to inherit it.

While at it (or, actually, more like: as I already made this part of v1
by mistake), upstream the patch carried in Git for Windows that supports
color when running Git for Windows in Cygwin terminals.

Changes since v1:

- rebased onto master

- unsquashed 2/3 which was improperly snuck in before,

- noted that Beat Bolli tested this (see
  https://github.com/git-for-windows/git/issues/997#issuecomment-268764693)

- fixed the confusing commit message by using Junio's suggested
  replacement

- added the missing white space between ">=" and "0"


Alan Davies (1):
  mingw: fix colourization on Cygwin pseudo terminals

Jeff Hostetler (1):
  mingw: replace isatty() hack

Johannes Schindelin (1):
  mingw: adjust is_console() to work with stdin

 compat/winansi.c | 198 +++++++++++++++++++++++--------------------------------
 1 file changed, 84 insertions(+), 114 deletions(-)


base-commit: 1d1bdafd64266e5ee3bd46c6965228f32e4022ea
Published-As: https://github.com/dscho/git/releases/tag/mingw-isatty-fixup-v2
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-isatty-fixup-v2

Interdiff vs v1:

 diff --git a/compat/winansi.c b/compat/winansi.c
 index f51a2856d2..477209fce7 100644
 --- a/compat/winansi.c
 +++ b/compat/winansi.c
 @@ -108,7 +108,7 @@ static int is_console(int fd)
  	} else if (!GetConsoleScreenBufferInfo(hcon, &sbi))
  		return 0;
  
 -	if (fd >=0 && fd <= 2)
 +	if (fd >= 0 && fd <= 2)
  		fd_is_interactive[fd] |= FD_CONSOLE;
  
  	/* initialize attributes */
 @@ -555,7 +555,8 @@ static void detect_msys_tty(int fd)
  
  #endif
  
 -/* Wrapper for isatty().  Most calls in the main git code
 +/*
 + * Wrapper for isatty().  Most calls in the main git code
   * call isatty(1 or 2) to see if the instance is interactive
   * and should: be colored, show progress, paginate output.
   * We lie and give results for what the descriptor WAS at
 @@ -565,7 +566,7 @@ static void detect_msys_tty(int fd)
  #undef isatty
  int winansi_isatty(int fd)
  {
 -	if (fd >=0 && fd <= 2)
 +	if (fd >= 0 && fd <= 2)
  		return fd_is_interactive[fd] != 0;
  	return isatty(fd);
  }

-- 
2.11.0.rc3.windows.1


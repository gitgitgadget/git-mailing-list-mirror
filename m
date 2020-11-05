Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50192C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C977820724
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GXs/OIyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgKEVBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:01:15 -0500
Received: from avasout03.plus.net ([84.93.230.244]:33817 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:01:14 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amNYkLsqh99nqamNZkhVd7; Thu, 05 Nov 2020 21:01:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610072; bh=TLpMwEtooOTHtQbEzOU+isAkeYOLCChjlIbObarnGFI=;
        h=To:Cc:From:Subject:Date;
        b=GXs/OIyLVdAJKjNzuotQikk06zoUelZPIuQyF/pk+rYer5arTMKcUNgJPzNyQ6kjB
         hUUrR4kERPWyANw4LP9qS6INEXYk7yIqlvcLBu3CbW/DYwSpKoeHJpmp7007gw+10x
         zbz20twJnoyuzBm5DI+qgyCIs3nbxG9Se0sGlJIUKqQgsMIRVxIjCJXMUZm0u9+yNh
         moO1NmSLCG2L1S7ricBfYzSxx2rREj4ov/Ltoy3BvqbNJERokAxatLMi68409AagKf
         rF6insyhzqOX13TzejpJNYYyNFFLUL2DGoM/+cXtm530SSKLCEp79Gi9mfyifja0sP
         a6bZ3plYrEWYQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=HhZDRCh-LNhyYaZsegQA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH 0/8] speed up 'make clean'
Message-ID: <e1d218bb-7658-565e-0931-2411efbb561c@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:01:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMyFqFup8Qz/a/KFwjN5OYugocmL/DtIbQ8cH1QPbrtrrLhWL88LgLT5WM9urgdpN6j8/xSMTeJSV9eNG4tHf1mDwxkRJZIBdal8jOEpa9wEHjCM8enq
 Rq8Bh6HxHvArT4fpg4217/n2mlPYJXfPxEMiTUv0aUCpdjmhTVM+fZRfmbjpouzgHaT3bLNGMgOfAw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Approximately five years ago, I stopped building the documentation
locally and instead started using the 'pre-built' documentation repos
from git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git.
I placed them next to the git repository (ie. as siblings) and wrote
a script (mk-dist-doc.sh) to reproduce the effect of 'make dist-doc',
using git-archive, to place the distribution tarballs at the top of
the git repo worktree.

[During the creation of these patches, I actually did a 'make' in
the Documentation directory and was surprised that it succeeded!
However, it reminded me why I stopped building the docs! :-P ]

This meant that the Documentation directory was essentially unused
for build purposes, so that a 'make clean' should have nothing to
do in that directory.  However, on cygwin, I noticed a long pause
during a 'make clean' in that directory and, further, it seemed to
be GEN-erating some files!  I put an item on my TODO list to take a
look at that - during the v2.28.0 cycle, I finally found time to look
at this issue! :-D

This patch series is the result. Note that this was mainly about
speeding up 'make clean' on cygwin (and the performance numbers
in the patches reflect use on cygwin). Tonight, I did some timings
on Linux as well, so that I could show this table:

              CYGWIN              LINUX
v2.29.0   23.339s              1.709s
Patch #1  12.364s  -47.02%     0.877s  -48.68%
Patch #2  10.361s  -16.20%     0.805s   -8.21%
Patch #3   8.430s  -18.64%     0.672s  -16.52%
Patch #4   6.454s  -23.44%     0.484s  -27.98%
Patch #5   6.428s   -0.40%     0.503s   +3.93%
Patch #6   6.440s   +0.19%     0.517s   +2.78%
Patch #7   6.430s   -0.16%     0.515s   -0.39%
Patch #8   4.064s  -36.80%     0.322s  -37.48%

         23.339/4.064 = 5.74   1.709/0.322 = 5.31 

Note that patches 5-7 are just preparatory patches for the final
patch, and are not expected to show any improvement.

This series is marked RFC because I forgot that 'git-gui' patches
need to be separately submitted to Pratyush Yadav, the git-gui
maintainer. So, I need to drop patch #4 from this series and
submit that to Pratyush (the commit message needs to be re-written
as well). Unfortunately, this means that the following commit
messages will need to be re-written (and timings re-done).

Also, since this series is based on v2.29.0, I had anticipated some
conflicts with the 'rs/dist-doc-with-git-archive' branch when merging
this with the 'master', 'next' and 'seen' branches. I have just done
a trial merge with each branch and, to my surprise, there were no
conflicts and they (auto) merged clean. ;)

However, I can certainly rebase these onto the 'master' branch, if that
would be easier to deal with. (There has to be a v2 anyway, so ...)

I should note here that the main idea used in these patches, to use
the $(MAKECMDGOALS) variable to conditionally include some files, can
be defeated by invoking make with multiple goals. For example, if you
were to do 'make clean all', then $(MAKECMDGOALS) would be 'clean all'
and not 'clean'.

However, doing so with the top-level Makefile would only negate the
effect of the last patch, since all of the sub-makes are issued as
'make -C <dir> clean'. So, all of the conditional includes in patches
#1-4 will work as intended (and show the noted improvement).

[Yes, 'cd Documentation; make clean all' will be slower that a doing
separate 'make clean; make', but the extra 10s, or so, will be swamped
by the documentation build time! ;-) ]

ATB,
Ramsay Jones

Ramsay Jones (8):
  Documentation/Makefile: conditionally include doc.dep
  Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
  gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
  git-gui/Makefile: conditionally include GIT-VERSION-FILE
  Makefile: don't try to clean old debian build product
  Makefile: don't use a versioned temp distribution directory
  Makefile: don't delete dist tarballs directly by name
  Makefile: conditionally include GIT-VERSION-FILE

 .gitignore             |  1 +
 Documentation/Makefile |  4 ++++
 Makefile               | 28 +++++++++++++++++++---------
 git-gui/Makefile       |  2 ++
 gitweb/Makefile        |  2 ++
 5 files changed, 28 insertions(+), 9 deletions(-)

-- 
2.29.0

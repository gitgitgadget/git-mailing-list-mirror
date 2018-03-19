Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCCF1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965790AbeCSRx7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:53:59 -0400
Received: from avasout04.plus.net ([212.159.14.19]:52823 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965705AbeCSRxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:53:12 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id xyy5eXQKasD7bxyy6e8N2K; Mon, 19 Mar 2018 17:53:11 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=U7UbAiMzAAAA:8 a=pGLkceISAAAA:8
 a=HGvT6j9Jkyo9zbXFXrUA:9 a=MnGkznKOSU9rGe1e:21 a=KF9yD4ePQQqPdYqJ:21
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=cNtvukwP7kaFzDVqf0Q5:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] -Wuninitialized
Message-ID: <8f6d8e2e-aba4-128c-f17c-6c1b9c12436c@ramsayjones.plus.com>
Date:   Mon, 19 Mar 2018 17:53:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfOeX9a7Vo1b2bp+I+x22hMpCL68pYQud/o3z8VGMX6eBLMg9OC15rvzpIJCxzkB57LnU0uUa2piIu1JOSPv37Udb4W2w6U7fZMKjn+lkGzkrpY76CEpf
 PwiU7cvuqOVq1OcTevXrD38BnEZtgs4DwYjp3q4yNCCOm/PzIXUBQDaOcX7huUsnhKhgtIMoppF88A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This series removes all 'self-initialised' variables (ie. <type> var = var;).
This construct has been used to silence gcc '-W[maybe-]uninitialized' warnings
in the past [1]. Unfortunately, this construct causes warnings to be issued by
MSVC [2], along with clang static analysis complaining about an 'Assigned value
is garbage or undefined'. The number of these constructs has dropped over the
years (eg. see [3] and [4]), so there are currently only 6 remaining in the
current codebase. As demonstrated below, 5 of these no longer cause gcc to
issue warnings.

These patches were developed on v2.16.0, but a test merge to current 'master',
'next' and 'pu' branches complete without conflict.

If you add '-Winit-self' to CFLAGS and compile v2.16.0, then:

  $ vim config.mak # add -Winit-self to CFLAGS
  $ make >g.out-warn-init 2>&1
  $ grep warning g.out-warn-init
  merge-recursive.c:2064:15: warning: ‘mrtree’ is used uninitialized in this function [-Wuninitialized]
  read-cache.c:2107:6: warning: ‘saved_namelen’ is used uninitialized in this function [-Wuninitialized]
  fast-import.c:3006:23: warning: ‘oe’ is used uninitialized in this function [-Wuninitialized]
  fast-import.c:3023:23: warning: ‘oe’ is used uninitialized in this function [-Wuninitialized]
  $ 

This misses the self-initialization of the 'reaches' and 'all' symbols in
builtin/rev-list.c, which is somewhat surprising! ;-)

The commits in which these self-initializations were introduced are noted
below:

  a. builtin/rev-list.c: 'reaches' and 'all', see commit 457f08a030
     ("git-rev-list: add --bisect-vars option.", 2007-03-21).

  b. merge-recursive.c:2064 'mrtree', see commit f120ae2a8e ("merge-
     recursive.c: mrtree in merge() is not used before set", 2007-10-29).

  c. fast-import.c:3023 'oe', see commit 85c62395b1 ("fast-import: let
     importers retrieve blobs", 2010-11-28).

  d. read-cache.c:2107 'saved_namelen', see commit b3c96fb158 ("split-index:
     strip pathname of on-disk replaced entries", 2014-06-13).

  e. fast-import.c:3006 'oe', see commit 28c7b1f7b7 ("fast-import: add a
     get-mark command", 2015-07-01).

Clang static analysis marks the self-initialization as a 'Logic error' with
the name 'Assigned value is garbage or undefined'. clang 3.8.0 notes b,c,d
and e, but not a. clang 5.0.1 notes a(reaches),b,c,d and e, but not a(all).

If we now add a patch to remove all self-initialization, which would be the
first patch plus the obvious change to 'saved_namelen' in read-cache.c, then
note the warnings issued by various compilers at various optimization levels
on several different platforms [5]:

                    O0      O1      O2      O3      Os       Og
 1) gcc 4.8.3   |   -      1,20     1    1,18-19  1-4,21-23  1,5-17
 2) gcc 4.8.4   |   -      1,20     1       1     1-4,21-23  1,5-8,10-13,15-16 
 3) clang 3.4   |   -       -       -       -        -       n/a 
 4) gcc 5.4.0   |   -       1       1       1     1,3-4,21   1,5-8,10-13,16-16
 5) clang 3.8.0 |   -       -       -       -        -       n/a 
 6) gcc 5.4.0   |   -       1       1       1       1-4     1,5-17 
 7) clang 3.8.0 |   -       -       -       -        -       n/a 
 8) gcc 6.4.0   |   -       1       1    1,18-19    1,4     1,5-17
 9) clang 5.0.1 |   -       -       -       -        -        -
10) gcc 7.2.1   |   -       1       1       1       1,4     1,5-17

[Not -Wmaybe-uninitialized table]
 1) gcc 4.8.3   |   27      27      27      27       27       27
 3) clang 3.4   |   26      26      26      26       26      n/a 
 5) clang 3.8.0 | 24-26   24-26   24-26   24-26    24-26     n/a 

[clang 3.4 and 3.8.0 do not support -Og, but clang 5.0.1 does.]
[warnings 18-19 issued on cygwin since it builds with NO_REGEX.]

Compiler/Platforms:
  1: 32-bit Windows XP - Cygwin 1.7.30 2014-05-23 i686, Core2 Duo T2050
2,3: 32-bit Linux Mint 17.3, i686, Intel Core2 Duo T2050
4,5: 32-bit Linux Mint 18.3, i686, Virtual Box VM
6,7: 64-bit Linux Mint 18.3, x86_64, Intel Core i5-4200M
8,9: 64-bit Windows 10 - Cygwin 2.10.0 2018-02-02 x86_64, Intel Core i5-4200M
 10: 64-bit Fedora Linux 27, x86_64, Virtual Box VM

Note that warnings 1-23 [6] are all -Wmaybe-uninitialized, and 24-27 do not
concern us here [7]. Outside of -Os and -Og, the only warnings are 1, 18
and 19. Warnings 18 and 19 are only issued against the compat regex routines
while building with NO_REGEX set. Warning 1 is suppressed by applying the
second patch in this series.

So, as noted above, with the exception of the 'saved_namelen' symbol, none
of the 'self-initialised' variables cause gcc to complain. Thus the first
patch does not make any difference to the table(s) above. The second patch
removes the warning #1 from the above table(s).

Notes:
[1] My memory is not what it was, but my recollection is that, circa 2007,
these warnings were -Wuninitialized. I suspect that, due to too many false
positives, many have been moved to -Wmaybe-uninitialized. ;-)

[2] At least it used to cause (actually linker) warnings, but maybe more
up-to-date versions of MSVC no longer complain? I haven't tried compiling
with MSVC for many years (I haven't had an MSVC installation for at least
6 years now).

[3] https://public-inbox.org/git/4CFA8D4D.2020500@ramsay1.demon.co.uk/

[4] https://public-inbox.org/git/d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com/#r 

[5] I installed fedora 27 so that I could get a more up-to-date compiler,
since I tend to stick with conservative distros that are based on an LTS
base (e.g. Linux Mint). (I also found that sparse was totaly useless on
fedora - something else for my TODO list)!

[6] I have not studied the warnings 1-23. I have only briefly looked at a
few of these warnings, but they all look (at first blush) to be false
positives. (Also, note that this is not a clang problem)! ;-)

[7] A patch has already been sent for warning 27. I am preparing a patch for
warnings 24-25 (call imaxabs() rather than labs()). As for warning 26, well
yes, I agree! ;-)


warnings:
 1. read-cache.c:2154:18: warning: ‘saved_namelen’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 2. config.c:904:9: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 3. config.c:928:9: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 4. fast-import.c:2378:8: warning: ‘mode’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 5. connect.c:126:3: warning: ‘arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 6. diff.c:2938:9: warning: ‘orig_size’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 7. fetch-pack.c:283:3: warning: ‘arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 8. fetch-pack.c:427:9: warning: ‘arg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 9. list-objects-filter-options.c:64:39: warning: ‘v0’ may be used uninitialized in this function [-Wmaybe-uninitialized]
10. refs/packed-backend.c:638:3: warning: ‘p’ may be used uninitialized in this function [-Wmaybe-uninitialized]
11. trailer.c:560:3: warning: ‘type’ may be used uninitialized in this function [-Wmaybe-uninitialized]
12. git-compat-util.h:483:18: warning: ‘data’ may be used uninitialized in this function [-Wmaybe-uninitialized]
13. fast-import.c:2876:4: warning: ‘from’ may be used uninitialized in this function [-Wmaybe-uninitialized]
14. http-backend.c:261:8: warning: ‘svc_name’ may be used uninitialized in this function [-Wmaybe-uninitialized]
15. git-compat-util.h:535:23: warning: ‘tail’ may be used uninitialized in this function [-Wmaybe-uninitialized]
16. remote-curl.c:875:5: warning: ‘p’ may be used uninitialized in this function [-Wmaybe-uninitialized]
17. t/helper/test-ref-store.c:46:16: warning: ‘gitdir’ may be used uninitialized in this function [-Wmaybe-uninitialized]
18. compat/regex/regcomp.c:2634:6: warning: ‘end_elem’ may be used uninitialized in this function [-Wmaybe-uninitialized]
19. compat/regex/regcomp.c:3138:41: warning: ‘start_elem’ may be used uninitialized in this function [-Wmaybe-uninitialized]
20. fsck.c:768:5: warning: ‘err’ may be used uninitialized in this function [-Wmaybe-uninitialized]
21. config.c:912:9: warning: ‘ret’ may be used uninitialized in this function [-Wmaybe-uninitialized]
22. diff.c:1729:56: warning: ‘j’ may be used uninitialized in this function [-Wmaybe-uninitialized]
23. builtin/update-index.c:853:19: warning: ‘mode’ may be used uninitialized in this function [-Wmaybe-uninitialized]
24. config.c:788:10: warning: absolute value function 'labs' given an argument of type 'intmax_t' (aka 'long long') but has parameter of type 'long' which may cause truncation of value [-Wabsolute-value]
25. config.c:790:21: warning: absolute value function 'labs' given an argument of type 'intmax_t' (aka 'long long') but has parameter of type 'long' which may cause truncation of value [-Wabsolute-value]
26. remote-curl.c:536:10: warning: comparison of constant 9223372036854775807 with expression of type 'ssize_t' (aka 'int') is always false [-Wtautological-constant-out-of-range-compare]
27. http.c:77:20: warning: ‘curl_no_proxy’ defined but not used [-Wunused-variable]



Ramsay Jones (2):
  -Wuninitialized: remove some 'init-self' workarounds
  read-cache: fix an -Wmaybe-uninitialized warning

 builtin/rev-list.c | 2 +-
 fast-import.c      | 4 ++--
 merge-recursive.c  | 2 +-
 read-cache.c       | 6 ++++--
 4 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.16.0

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F35C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2380238EE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgLHWa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:30:56 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60696 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729034AbgLHWaz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:30:55 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlUkkHHYy0K1OmlUlkvn7A; Tue, 08 Dec 2020 22:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466608; bh=gVnAxmjo/bv0IRwN5Jd9dMoKNMoz9m381gnxc02J4yY=;
        h=To:Cc:From:Subject:Date;
        b=WxTxjOU/5nYUebb3hExdtl6n46qVKWw7vML/H1qic6GfOhKJx6SjkpxtyxHeZ28LH
         q35uan1QdiNIUvL/TW3N1NYkzATeo9DOfD1nTmZzQE1/QnXADE7PyjIEiJPFjwroo8
         DIgvVNtph8J6pkYbJVyVfJCU1CyxdrUILic309DOSToevgx/wiKzpXHHtJjv/UplCC
         DNPcVwQ+wXuOPfnj+xJh9Y+gMc5tv6wfxjWURGaAB4CCPyw9/FI497gMnps5o2Wisv
         lynjW7lJ22HO07pc4Uk6XlA57Vjs7uLawLoRb+RhL7tENwVcFRM5Ie2tHyrxuuk995
         2tkKfcKS6PWaw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=vZxbLtyPAAAA:8 a=AUZ_-V6PeF_3qbiQh7UA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=YIznc7gRMHvxYRuyG5Sm:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 0/5] speed up 'make clean'
Message-ID: <e52b82b1-9a8d-4700-d44e-84aada2e3a33@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:30:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEyDP+2xWe1ECXFc+sJWlXeUtXI+o+USvGThDw+PzAKUo2OcS2LvZwVO5AdZ513d6Wyxvjcdjl5aSKFkCp4d3w8pjSWXRKeHB16MaUy7iWc65462Zgfx
 z8JnSBZxs/4Af/8qTqXC0LpI91UHZlrbEe7UirannnKi5FhR/Ax+5eSC5gG0gc4BVZ6c6YbnGx/UbQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


cover letter for v1
-------------------

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

Changes in v2
-------------

Unfortunately, immediately after submitting the v1/RFC version of this
series, I got rather busy with other commitments until this evening.
So, I have not had time to look into the 'alternate' patch #8 (I will
get back to that soon, along with some others). Given that I started
this series late in the v2.27 cycle, it would be nice to get some
benefit from this series sooner, rather than later. So, I decided to
go all conservative:

  - remove patch #4 and send a 'standalone' patch to Pratyush (as
    required).
  - remove the controversial patches #7, and #8

I didn't redo the timings, but looking at the table above, we should
see the times on cygwin go from 23.339s to 8.430s (or there abouts)
for this revised series. Also, if Pratyush agrees to apply the new
patch #4, then we should see approximately another 2s saving.

Changes in v3
-------------

The following changes are in response to comments from Junio[1] and
Felipe [2][3] about the commit messages of the first three patches
(along with a small typo):

  - typo: s/on/an/ in commit message for patches #1->#3.
  - patch #1: refer to the content of 'doc.dep' (as make targets and
    prerequisites) and the fact that they don't affect target execution.
  - patch #2,#3: stress that update of GIT-VERSION-FILE/$(GIT_VERSION)
    does not affect 'clean' target execution.

Thanks to Junio and Felipe.

See the range-diff against v2 below.

Thanks!

ATB,
Ramsay Jones

[1] https://lore.kernel.org/git/xmqq360icb5x.fsf@gitster.c.googlers.com/T/#mf3f0ffbaf4cfc81e55fdd7e9e1e585425bc4ac95
[2] https://lore.kernel.org/git/xmqq360icb5x.fsf@gitster.c.googlers.com/T/#ma7efd62ca9c783c23bab20b8a617c412f97f5cb9
[3] https://lore.kernel.org/git/xmqqy2iaawk8.fsf@gitster.c.googlers.com/T/#m77e36048def91f1e4916cd04f6ce01398dd5a448


Ramsay Jones (5):
  Documentation/Makefile: conditionally include doc.dep
  Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
  gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
  Makefile: don't try to clean old debian build product
  Makefile: don't use a versioned temp distribution directory

 Documentation/Makefile |  4 ++++
 Makefile               | 17 +++++++++--------
 gitweb/Makefile        |  2 ++
 3 files changed, 15 insertions(+), 8 deletions(-)

range-diff against v2:
1:  c48e0fbaf4 ! 1:  f5b58cac1e Documentation/Makefile: conditionally include doc.dep
    @@ Commit message
           ...
           $
     
    -    has been timed at 23.339s, using git v2.29.0, on my laptop (on old core
    +    has been timed at 23.339s, using git v2.29.0, on my laptop (an old core
         i5-4200M @ 2.50GHz, 8GB RAM, 1TB HDD).
     
         Notice that, since the 'doc.dep' file does not exist, make takes the
    @@ Commit message
         and, if that file now exists, throw away all its internal data and
         re-read and re-parse the Makefile). Having spent the time to include
         the 'doc.dep' file, the 'clean' target immediately deletes those files.
    +    The document dependencies specified in the 'doc.dep' include file,
    +    expressed as make targets and prerequisites, do not affect what the
    +    'clean' target removes. Therefore, the time spent in generating the
    +    dependencies is completely wasted effort.
     
         In order to eliminate such wasted effort, use the value of the internal
         $(MAKECMDGOALS) variable to only '-include doc.dep' when the target is
2:  08c08f44ad ! 2:  6c26d16d04 Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
    @@ Commit message
           ...
           $
     
    -    has been timed at 12.364s on my laptop (on old core i5-4200M @ 2.50GHz,
    +    has been timed at 12.364s on my laptop (an old core i5-4200M @ 2.50GHz,
         8GB RAM, 1TB HDD).
     
         Notice that the 'clean' target is making a nested call to the parent
    @@ Commit message
         the previous patch, there would have been _two_ such invocations).
         This is to ensure that the $(GIT_VERSION) make variable is set, once
         that file had been included.  However, the 'clean' target does not use
    -    the $(GIT_VERSION) variable, so this is wasted effort.
    +    the $(GIT_VERSION) variable, directly or indirectly, so it does not
    +    have any affect on what the target removes. Therefore, the time spent
    +    on ensuring an up to date GIT-VERSION-FILE is wasted effort.
     
         In order to eliminate such wasted effort, use the value of the internal
         $(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
3:  f1b6ef23ae ! 3:  835c47993b gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
    @@ Commit message
           ...
           $
     
    -    has been timed at 10.361s on my laptop (on old core i5-4200M @ 2.50GHz,
    +    has been timed at 10.361s on my laptop (an old core i5-4200M @ 2.50GHz,
         8GB RAM, 1TB HDD).
     
         Notice that the 'clean' target is making a nested call to the parent
         Makefile to ensure that the GIT-VERSION-FILE is up-to-date. This is to
         ensure that the $(GIT_VERSION) make variable is set, once that file had
         been included. However, the 'clean' target does not use the $(GIT_VERSION)
    -    variable, so this is wasted effort.
    +    variable, directly or indirectly, so it does not have any affect on what
    +    the target removes. Therefore, the time spent on ensuring an up to date
    +    GIT-VERSION-FILE is wasted effort.
     
         In order to eliminate such wasted effort, use the value of the internal
         $(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
4:  e8eb7f1668 = 4:  c965bb2b2e Makefile: don't try to clean old debian build product
5:  aad82c5116 = 5:  e8705064cb Makefile: don't use a versioned temp distribution directory
-- 
2.29.0

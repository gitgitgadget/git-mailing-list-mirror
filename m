Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C5AC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAB922509
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgLGAb1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:31:27 -0500
Received: from avasout01.plus.net ([84.93.230.227]:33380 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGAb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:31:27 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id m4QBkwQQOn8O7m4QCkbbPP; Mon, 07 Dec 2020 00:30:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607301040; bh=PQI2AZphSAXatNQbYu3KE14jmG3hd1lXzctGNo6VC2A=;
        h=To:Cc:From:Subject:Date;
        b=btW56T3QJLRJxQcIEeRs+iRKO8nMQqcBKJXl98h3oOfrhTXQ/AtKcPuu2s9M9dkUP
         ocKvNsdXAgDGvd5mnTS802Ju0ySdFI1yh5JbrTt/QFXllXX6cFf4ZbKnWp7+O/YBRh
         RTM0eB9xHRX+mszdv1nPTm2BjcCJY6tvdvg3WX3gh96bfH1Kepro3HzDUr0YVMgYwb
         YapPAlDbAtEe2mvgiZtMHRi37nYQl9f2D/R1Cg9pbg9gAvhPakilJaWumDcaBsxPGi
         87fOG2QtCsh8ivK8KNx0APxGIH9L1qej/DZh3TQDxkKaHbFCDf67Q+HsZiLqgxt7gZ
         0RPAWEfqXySKA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=NUAguaOKSIVTEf6g9YkA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 0/5] speed up 'make clean'
Message-ID: <a5f59bcf-9ae6-b3a8-7073-5797971d286f@ramsayjones.plus.com>
Date:   Mon, 7 Dec 2020 00:30:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBBO8dL/gVIBcXjPXxPQRnpWYfi6s24YmQTz4+9m7NpWlPz/dHqcOocBe7Fkkf5Yh5wrF7DeJiPjOXBAjew6mn7Y9/0VY5oFVXz2ZWzZG8FM5PPQHssl
 1pdRnQOY2EBkhdChElEoY58Tzhzwib8E8SyfNX0mNi5nfCztqOqG+WwnPS1DI3CeUfNz0tjhPxM87Q==
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

See the range-diff against v1 below.

Thanks!

ATB,
Ramsay Jones

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


range-diff against v1:
1:  6a0516f3f5 = 1:  c48e0fbaf4 Documentation/Makefile: conditionally include doc.dep
2:  26aecb6c41 = 2:  08c08f44ad Documentation/Makefile: conditionally include ../GIT-VERSION-FILE
3:  91a0bedd37 = 3:  f1b6ef23ae gitweb/Makefile: conditionally include ../GIT-VERSION-FILE
4:  008f1c8892 < -:  ---------- git-gui/Makefile: conditionally include GIT-VERSION-FILE
5:  e5c2414557 = 4:  e8eb7f1668 Makefile: don't try to clean old debian build product
6:  8255a76caf ! 5:  aad82c5116 Makefile: don't use a versioned temp distribution directory
    @@ Commit message
         Makefile: don't use a versioned temp distribution directory
     
         The 'dist' target uses a versioned temp directory, $(GIT_TARNAME), into
    -    which it copies various files added to the distibution tarball. A future
    -    patch requires the 'clean' target not to depend on the $(GIT_VERSION)
    -    variable. However, the $(GIT_TARNAME) variable contains $(GIT_VERSION) in
    -    its definition.
    +    which it copies various files added to the distribution tarball. Should
    +    it be necessary to remove this directory in the 'clean' target, since
    +    the name depends on $(GIT_VERSION), the current HEAD must be positioned
    +    on the same commit as when 'make dist' was issued. Otherwise, the target
    +    will fail to remove that directory.
     
         Create an '.dist-tmp-dir' directory and copy the various files into this
         now un-versioned directory while creating the distribution tarball. Change
7:  273f7f9394 < -:  ---------- Makefile: don't delete dist tarballs directly by name
8:  a04efa056c < -:  ---------- Makefile: conditionally include GIT-VERSION-FILE
-- 
2.29.0

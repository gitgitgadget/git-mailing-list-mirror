Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8B520248
	for <e@80x24.org>; Sun,  3 Mar 2019 21:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCCVaY (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 16:30:24 -0500
Received: from avasout01.plus.net ([84.93.230.227]:39811 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfCCVaY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 16:30:24 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 0YgchJ2iNzxF50YgehvwxU; Sun, 03 Mar 2019 21:30:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=UqFNyd4B c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=fSFNYVjcEZcf3SVcPt0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] Makefile: use `git ls-files` to list header files, if
 possible
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.130.git.gitgitgadget@gmail.com>
 <0b5529406b9458d37f3f5cdf38baa2d6a0a70a65.1551470265.git.gitgitgadget@gmail.com>
 <20190301213619.GA1518@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903022058230.45@tvgsbejvaqbjf.bet>
 <20190303171951.GD23811@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8e4b7966-7a3e-a081-bfc1-9e60303b8eab@ramsayjones.plus.com>
Date:   Sun, 3 Mar 2019 21:30:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190303171951.GD23811@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAuAmrx+84gnR05kf5nL0nb8uS9m7OKHLBoO3HR7RetJEsK4XVW0PfljxGALfvLGoeNsyEAAjZgQBhRjqlBRcnvig4zxZuWhBOm0C+Jdvg4qNsPDVyBd
 DbiG6epLMNLENDGKMsK6Hrsm3ftDeZrWjarg73GUct6gpz1u5bwg8/Ue
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 03/03/2019 17:19, Jeff King wrote:
> On Sat, Mar 02, 2019 at 09:05:24PM +0100, Johannes Schindelin wrote:
> 
>>> That seems reasonable (regardless of whether it is in a script or in the
>>> Makefile). Another option is to use -maxdepth, but that involves
>>> guessing how deep people might actually put header files.
>>
>> It would also fail to work when somebody clones an unrelated repository
>> that contains header files in the top-level directory into the Git
>> worktree. I know somebody like that: me.
> 
> Good point.

[Sorry for the late reply - I have been AWOL this weekend and
I am only just catching up with email! :-D ]

So, tl;dr: soon, I will be submitting a patch to remove the
'hdr-check' target completely, for now anyway.

> By the way, "make hdr-check" already fails for me on master, as I do not have
> libgcrypt installed, and it unconditionally checks sha256/gcrypt.h.

Yep, for me too. There is a similar problem if you build with
NO_CURL and don't have the 'curl/curl.h' header file, etc ...

The first version of the 'hdr-check' target re-introduced a static
list of header files, but I didn't think people would appreciate
having to maintain the list manually, so I gave up on that!

The next version was essentially the same patch that started this
thread from Johannes (ie. the 'git ls-files' patch), given that
the 'tags' targets had found it necessary. However, when I did some
'informal' timing tests (ie 5x 'time make ...' and average), this
did not make any noticeable difference for me (_even_ on cygwin!). ;-)

Of course, I had already made the mistake of trying to re-use
something that was 'handy' (ie. LIB_H) and already there.
However, LIB_H wasn't quite what I wanted - I needed a sub-set
of it.

So, I already have a 'hdr-check-fixup' branch (I think I have
already mentioned it), in which the first commit looks like:

  diff --git a/Makefile b/Makefile
  index c5240942f2..3401d1b9fb 100644
  --- a/Makefile
  +++ b/Makefile
  @@ -2735,9 +2735,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
   .PHONY: sparse $(SP_OBJ)
   sparse: $(SP_OBJ)
   
  +HC_HDRS := $(wildcard *.h negotiator/*.h block-sha1/*.h ppc/*.h ewah/*.h \
  +       sha1dc/*.h refs/*.h vcs-svn/*.h)
   GEN_HDRS := command-list.h unicode-width.h
  -EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
  -CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
  +CHK_HDRS = $(filter-out $(GEN_HDRS),$(HC_HDRS))
   HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
   
   $(HCO): %.hco: %.h FORCE
  

... which drops the use of LIB_H entirely.

Now, I have timed this and, for me, it no faster ... (I suspect
that it would be faster for Johannes, but it would still cause
a problem if you have 'top-level header files from some other
repo ...').

So, if we really need to solve the problem, allowing for some
unrelated headers in your worktree, then we can only use a
static list, or a 'git ls-files' approach.

Anyway, for now, since I seem to be the only person using this
target, I think we should just remove it while I think again.
(I can put it in my config.mak, so there will be no loss for me).

ATB,
Ramsay Jones

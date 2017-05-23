Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 149A820281
	for <e@80x24.org>; Tue, 23 May 2017 20:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161387AbdEWUr7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 16:47:59 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35696 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161321AbdEWUrz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 16:47:55 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout07 with smtp
        id Pwns1v0051keHif01wnt1z; Tue, 23 May 2017 21:47:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=CrLPSjwD c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=cCdah9ibjOc_Lkdyp7wA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
 <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
 <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
 <xmqqh90dpqja.fsf@gitster.mtv.corp.google.com>
 <xmqqd1b1pq1j.fsf@gitster.mtv.corp.google.com>
 <15d73455-6d0e-e67a-7cf3-eb0ae9aa3b0d@ramsayjones.plus.com>
 <xmqqpof0memv.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
Date:   Tue, 23 May 2017 21:47:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqpof0memv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/05/17 04:32, Junio C Hamano wrote:
> Interesting.  One thing that I found somewhat suboptimal is that we
> do not get signalled by non-zero exit.

Warnings don't lead to non-zero exit, but similarly to -Werror, you can
provide a -Wsparse-error to turn warnings into errors:

  $ make builtin/worktree.sp
      SP builtin/worktree.c
  builtin/worktree.c:539:38: warning: Using plain integer as NULL pointer
  $ 
  $ make SPARSE_FLAGS=-Wsparse-error builtin/worktree.sp
      SP builtin/worktree.c
  builtin/worktree.c:539:38: error: Using plain integer as NULL pointer
  Makefile:2370: recipe for target 'builtin/worktree.sp' failed
  make: *** [builtin/worktree.sp] Error 1
  $ 

Unfortunately, that does not help too much because, as I mentioned before,
one warning is actually a sparse problem (and you can't turn it off):

  $ make pack-revindex.sp
      SP pack-revindex.c
  pack-revindex.c:64:23: warning: memset with byte count of 262144
  $ 

This is caused by sparse _unconditionally_ complaining about the byte count
used in calls to memset(), memcpy(), copy_to_user() and copy_from_user().
In addition, the byte count limits are hard-coded (v <= 0 || v > 100000).
About a decade ago, I wrote a patch to enable/set the limit value from the
command line, but didn't get around to sending the patch upstream. :-D
   
[There is actually another problem warning, if you build with NO_REGEX=1].

Since cgcc was intended to be used as proxy for gcc, you might think you
could use CC=cgcc on a regular build, but that has problems of it's own:

  $ make clean >/dev/null 2>&1  # on 'pu' branch, build output in 'pout'
  $ make CC=cgcc >pout1 2>&1
  $ diff pout pout1
  99a100
  > pack-revindex.c:64:23: warning: memset with byte count of 262144
  199a201
  > imap-send.c:1439:9: warning: expression using sizeof on a function
  200a203,207
  > http.c:675:9: warning: expression using sizeof on a function
  > http.c:1676:25: warning: expression using sizeof on a function
  > http.c:1681:25: warning: expression using sizeof on a function
  > http.c:2082:9: warning: expression using sizeof on a function
  > http.c:2249:9: warning: expression using sizeof on a function
  219a227
  > http-walker.c:377:9: warning: expression using sizeof on a function
  222a231,233
  > http-push.c:189:9: warning: expression using sizeof on a function
  > http-push.c:200:9: warning: expression using sizeof on a function
  > http-push.c:202:9: warning: expression using sizeof on a function
  228a240,243
  > remote-curl.c:524:9: warning: expression using sizeof on a function
  > remote-curl.c:605:17: warning: expression using sizeof on a function
  > remote-curl.c:608:17: warning: expression using sizeof on a function
  > remote-curl.c:676:9: warning: expression using sizeof on a function
  374a390
  > builtin/worktree.c:539:38: warning: Using plain integer as NULL pointer
  
  ...

  $ 

See commit 9371322a60 (sparse: suppress some "using sizeof on a function"
warnings, 06-10-2013) for an explanation of the additional warnings.
I chose the SPARSE_FLAGS method to suppress those warnings, precisely
because I don't build git that way. (git grep -n SPARSE_FLAGS).

So, using CC='cgcc -Wsparse-error' as it stands isn't much help:
  
  $ make clean >/dev/null 2>&1
  $ make CC='cgcc -Wsparse-error'
  GIT_VERSION = 2.13.0.530.g896b4ae59
      * new build flags
      CC credential-store.o
      * new link flags
      CC common-main.o
 
  ...
 
      CC pack-objects.o
      CC pack-revindex.o
  pack-revindex.c:64:23: error: memset with byte count of 262144
  Makefile:2036: recipe for target 'pack-revindex.o' failed
  make: *** [pack-revindex.o] Error 1
  $ 

>                                         Otherwise it would make a
> good addition to the "Static Analysis" task in .travis.yml file.

Unfortunately, some additional work required. :-P

ATB,
Ramsay Jones



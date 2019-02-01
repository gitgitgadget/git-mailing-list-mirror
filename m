Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891F41F453
	for <e@80x24.org>; Fri,  1 Feb 2019 21:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfBAVB1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 16:01:27 -0500
Received: from avasout05.plus.net ([84.93.230.250]:35273 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfBAVB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 16:01:27 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id pfw9gdCqOyTttpfwAgCd90; Fri, 01 Feb 2019 21:01:25 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=XuzUx2N9 c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=-VdgHVw7sH1QcY1D4-0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/1] Using sparse in a CI job
Message-ID: <78f85f0b-176f-0b54-2ec8-4c13fd386733@ramsayjones.plus.com>
Date:   Fri, 1 Feb 2019 21:01:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDzVP8MsLk0ilfnTI5vHDg93nOzbZPzuLAFttPO9wcxY2iQz0Ml58uUIkW02bgMEmIcHTzJarFxsq5nOdfr7HSlB2mDZpYom2pxqbm25PKOkNFvVE7aY
 rAlfVHXDx5ibzfxxOU2tqBc7hTyibMKyX6AXaDdYxsK0rdiUXw6Dh6eInH5h4hBSBxII6/1Y4o1L6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I suspect that the Makefile sparse target is not easy to use in a CI
job, since the 'sparse' program (via cgcc -no-compile) does not exit
with a non-zero value, even when issuing errors and warnings.

The way I use sparse, this is not an issue. I run sparse over the
master branch, check that the output file has the no/expected
errors and warnings, then just diff the output files from the
next and pu branches. something like:

  $ make sparse >sp-out 2>&1 # on master branch
  $ vim sp-out # check for errors/warnings
  ...
  $ make sparse >nsp-out 2>&1 # on next branch
  $ diff sp-out nsp-out # any new errors/warnings?
  ...
  $ make sparse >psp-out 2>&1 # on pu branch
  $ diff nsp-out psp-out # any new errors/warnings?

At the moment, on Linux, the sp-out file is free from any sparse errors
or warnings. So are next and pu:

  $ grep error sp-out
  $ grep warning sp-out
  $ diff sp-out nsp-out
  391a392
  >     SP fuzz-commit-graph.c
  $ diff nsp-out psp-out
  170a171,180
  >     SP trace2.c
  >     SP trace2/tr2_cfg.c
  >     SP trace2/tr2_dst.c
  >     SP trace2/tr2_sid.c
  >     SP trace2/tr2_tbuf.c
  >     SP trace2/tr2_tgt_event.c
  >     SP trace2/tr2_tgt_normal.c
  >     SP trace2/tr2_tgt_perf.c
  >     SP trace2/tr2_tls.c
  >     SP trace2/tr2_verb.c
  298a309
  >     SP builtin/stash.c
  375a387
  >     SP t/helper/test-trace2.c
  376a389
  >     SP t/helper/test-xml-encode.c
  $ 

However, if we go back a few days, then the pu branch was not clean:

  $ diff nsp-out psp-out
  18a20,24
  >     SP change-table.c
  > change-table.h:53:24: error: dubious one-bit signed bitfield
  > change-table.h:54:25: error: dubious one-bit signed bitfield
  > change-table.h:55:25: error: dubious one-bit signed bitfield
  > change-table.h:56:26: error: dubious one-bit signed bitfield
  69a76
  >     GEN command-list.h
  93a101,106
  >     SP metacommit.c
  > change-table.h:53:24: error: dubious one-bit signed bitfield
  > change-table.h:54:25: error: dubious one-bit signed bitfield
  > change-table.h:55:25: error: dubious one-bit signed bitfield
  > change-table.h:56:26: error: dubious one-bit signed bitfield
  >     SP metacommit-parser.c
  170a184,193
  >     SP trace2.c
  >     SP trace2/tr2_cfg.c
  >     SP trace2/tr2_dst.c
  >     SP trace2/tr2_sid.c
  >     SP trace2/tr2_tbuf.c
  >     SP trace2/tr2_tgt_event.c
  >     SP trace2/tr2_tgt_normal.c
  >     SP trace2/tr2_tgt_perf.c
  >     SP trace2/tr2_tls.c
  >     SP trace2/tr2_verb.c
  213a237
  >     SP builtin/change.c
  298a323
  >     SP builtin/stash.c
  375a401
  >     SP t/helper/test-trace2.c
  376a403,405
  >     SP t/helper/test-xml-encode.c
  > t/helper/test-xml-encode.c:29:40: warning: Using plain integer as NULL pointer
  > t/helper/test-xml-encode.c:37:40: warning: Using plain integer as NULL pointer
  $ 
 
Note that 'make' does not exit at the first 'error', since the command exit
code is zero (or not non-zero! :) ):
 
  $ make change-table.sp
      SP change-table.c
  change-table.h:53:24: error: dubious one-bit signed bitfield
  change-table.h:54:25: error: dubious one-bit signed bitfield
  change-table.h:55:25: error: dubious one-bit signed bitfield
  change-table.h:56:26: error: dubious one-bit signed bitfield
  $ echo $?
  0
  $ 

We can change that by passing '-Wsparse-error' to 'sparse':

  $ make SPARSE_FLAGS=-Wsparse-error change-table.sp
      SP change-table.c
  change-table.h:53:24: error: dubious one-bit signed bitfield
  change-table.h:54:25: error: dubious one-bit signed bitfield
  change-table.h:55:25: error: dubious one-bit signed bitfield
  change-table.h:56:26: error: dubious one-bit signed bitfield
  Makefile:2729: recipe for target 'change-table.sp' failed
  make: *** [change-table.sp] Error 1
  $ echo $?
  2
  $ 

Note that '-Wsparse-error' not only returns a non-zero exit code (1), but
it also changes a 'warning' into an 'error' (see above):
  
  $ make SPARSE_FLAGS=-Wsparse-error t/helper/test-xml-encode.sp
      SP t/helper/test-xml-encode.c
  t/helper/test-xml-encode.c:29:40: error: Using plain integer as NULL pointer
  t/helper/test-xml-encode.c:37:40: error: Using plain integer as NULL pointer
  Makefile:2729: recipe for target 't/helper/test-xml-encode.sp' failed
  make: *** [t/helper/test-xml-encode.sp] Error 1
  $ echo $?
  2
  $ 

Unfortunately, using SPARSE_FLAGS from the 'make' command-line is not
ideal, since it was not really intended to be used that way. This will
cause problems for those files which have target specific settings for
SPARSE_FLAGS. For example:

  $ make pack-revindex.sp
      SP pack-revindex.c
  $ make SPARSE_FLAGS=-Wsparse-error pack-revindex.sp
      SP pack-revindex.c
  pack-revindex.c:65:23: error: memset with byte count of 262144
  Makefile:2729: recipe for target 'pack-revindex.sp' failed
  make: *** [pack-revindex.sp] Error 1
  $ echo $?
  2
  $ 

So, passing SPARSE_FLAGS on the command-line, effectively nullifies the
target specific settings (making them useless).

This patch splits the duties of SPARSE_FLAGS, by introducing a separate
SP_EXTRA_FLAGS variable, for use with the target specific settings. In
addition, we use a conditional assignment (?=) of the default (empty)
value of SPARSE_FLAGS, to allow setting the value of this variable from
the environment as well as the command-line. So, after this patch:

  $ make SPARSE_FLAGS=-Wsparse-error pack-revindex.sp
      SP pack-revindex.c
  $ echo $?
  0
  $ 

  $ SPARSE_FLAGS=-Wsparse-error make pack-revindex.sp
      SP pack-revindex.c
  $ echo $?
  0
  $ 

Now, we should be able to run the sparse Makefile target in a CI job, and
still find all sparse errors and warnings (now marked as errors also),
using something like this:

  $ SPARSE_FLAGS=-Wsparse-error make -k sparse >sp-out 2>&1

Note that the '-k' argument to 'make' is now required. ;-)


ATB,
Ramsay Jones 

Ramsay Jones (1):
  Makefile: improve SPARSE_FLAGS customisation

 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.20.0

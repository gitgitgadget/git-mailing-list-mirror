Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB60C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0E52086A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHGVWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:22:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:52320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGVWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 17:22:00 -0400
Received: (qmail 2689 invoked by uid 109); 7 Aug 2020 21:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 21:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18648 invoked by uid 111); 7 Aug 2020 21:21:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Aug 2020 17:21:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 Aug 2020 17:21:59 -0400
From:   Jeff King <peff@peff.net>
To:     Nuthan Munaiah <nm6061@rit.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: `git blame` Line Number Off-by-one
Message-ID: <20200807212159.GA1871940@coredump.intra.peff.net>
References: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <emc6590292-832a-4a35-8815-d5707731d605@sanctum>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 07, 2020 at 01:05:51AM +0000, Nuthan Munaiah wrote:

>  * Clone https://github.com/apache/tomcat
>  * Run `git blame --root -leftw -L 21,21 -L 23,23
> 51844327d8613448bb0bf9667e1a61e462e2043c^ --
> modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java`
>
> [...]
> 
> `git blame` shows the last commit that modified lines 21 and 23 of
> `modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java`
> starting at the parent of `51844327d8613448bb0bf9667e1a61e462e2043c`.
>
> [...]
>
> Line 23 is not shown in the `git blame` output. Instead, line 22 is shown.

Thanks for providing an easy reproduction case.

I think the issue is not in the -L input or in the blame algorithm
itself, but in the hunk-coalescing at the end.

As you note, this shows up even with --porcelain:

  $ commit=51844327d8613448bb0bf9667e1a61e462e2043c^
  $ fn=modules/jdbc-pool/java/org/apache/tomcat/jdbc/pool/PoolProperties.java
  $ git blame --porcelain -L 21,21 -L 23,23 $commit -- $fn |
    egrep '^[0-9a-f]{40}'
  c65a429f06f4e4a025a306e377211863d9ff2a0c 21 21 2
  c65a429f06f4e4a025a306e377211863d9ff2a0c 22 22

but if we try --incremental:

  $ git blame --incremental -L 21,21 -L 23,23 $commit -- $fn |
    egrep '^[0-9a-f]{40}'
  c65a429f06f4e4a025a306e377211863d9ff2a0c 21 21 1
  c65a429f06f4e4a025a306e377211863d9ff2a0c 22 23 1

So we do know at the moment we find the line that it was at line 23 in
the final result, but line 22 in the earlier version at c65a429f06.

And indeed, running a non-incremental blame in a debugger, right before
calling blame_coalesce() our entries look like this:

  cmd_blame (argc=3, argv=0x7fffffffe458, prefix=0x0) at builtin/blame.c:1146
  1146		blame_coalesce(&sb);
  (gdb) print *sb->ent 
  $44 = {next = 0x55555596eda0, lno = 20, num_lines = 1, suspect = 0x555555999a30, s_lno = 20, score = 0, ignored = 0, 
    unblamable = 0}
  (gdb) print *sb->ent->next
  $45 = {next = 0x0, lno = 22, num_lines = 1, suspect = 0x555555999a30, s_lno = 21, score = 0, ignored = 0, 
    unblamable = 0}

So we have two one-line entries at lines 21 and 23 ("lno"; note that
internally we zero-index the lines), and we know that the second one is
actually from 22 ("s_lno").

But then after blame_coalesce() returns, we have only one entry with
both lines:

  (gdb) n
  1148		if (!(output_option & (OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR)))
  (gdb) print *sb->ent
  $46 = {next = 0x0, lno = 20, num_lines = 2, suspect = 0x555555999a30, s_lno = 20, score = 0, ignored = 0, 
    unblamable = 0}

Presumably it saw the adjacent lines in the _source_ file and coalesced
them, but that's not the right thing to do. They're distinct hunks in
the output we're going to show, so they have to remain such.

-Peff

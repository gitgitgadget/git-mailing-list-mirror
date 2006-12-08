X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 07 Dec 2006 22:54:39 -0800
Message-ID: <7vzm9ynahc.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	<7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	<20061207221503.GA4990@steel.home>
	<7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
	<20061208052705.GA4318@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 06:54:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33664>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsZd6-0004bg-CG for gcvg-git@gmane.org; Fri, 08 Dec
 2006 07:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424824AbWLHGyl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 01:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424825AbWLHGyl
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 01:54:41 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41762 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424824AbWLHGyk (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 01:54:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208065440.RCFL7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Fri, 8
 Dec 2006 01:54:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id w6uq1V00P1kojtg0000000; Fri, 08 Dec 2006
 01:54:50 -0500
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

fork0@t-online.de (Alex Riesen) writes:

> yes, except that it'll compare the whole trees. Could I make it stop
> at first mismatch? "-q|--quiet" for git-diff-index perhaps?
> It's just not only stat, but also, open, read, mmap (yes, I try to use
> it for packs) and close are really slow here as well.

That sounds like optimizing for a wrong case -- you expect the
index to match HEAD and trying to catch mistakes by detecting
a mismatch, right?

Having said that, I should point out that it is a low hanging
fruit to optimize "diff-index --cached" for cases where index
is expected to mostly match HEAD.

The current code for "diff-index --cached" reads the whole tree
into the index as stage #1 entries (diff-lib.c::run_diff_index),
and then compares stage #0 (from the original index contents)
and stage #1 (the tree parameter from the command line).  Even
if you stop at the first mismatch, you would already have paid
the overhead to open and read all tree objects before even
starting the comparison.

However, this code is from the ancient time before cache-tree
was introduced in the index.  If the index is expected to mostly
match HEAD, most of the cache-tree nodes are up-to-date, and
whole subtree can be skipped with a single comparison between
two tree SHA-1s at a shallower level of the directory tree.

In 'pu' (jc/diff topic), I have a very generic code to walk the
index, working tree and zero or more trees in parallel, taking
advantage of cache-tree.  If somebody is interested to learn the
internals of git, some of the code could be lifted from there
and simplified to walk just the index and a single tree, and I
think that would optimize "diff-index --cached" quite a bit.

A very unscientific test of running in the kernel repository I
just pulled (hot cache) on my box is:

$ /usr/bin/time git diff-index -r --cached --abbrev v2.6.19 >/tmp/1
0.91user 0.20system 0:01.12elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+10949minor)pagefaults 0swaps

while the para-walk to produce the moral equivalent is:

$ /usr/bin/time test-para --no-work v2.6.19 >/tmp/2
0.11user 0.02system 0:00.13elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+4524minor)pagefaults 0swaps

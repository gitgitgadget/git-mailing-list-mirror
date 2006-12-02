X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: using xdl_merge(), was Re: Resolving conflicts
Date: Sat, 2 Dec 2006 11:49:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 10:49:18 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33018>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqSQi-00079P-L4 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 11:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759442AbWLBKtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 05:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759444AbWLBKtJ
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 05:49:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:21166 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1759442AbWLBKtH (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 05:49:07 -0500
Received: (qmail invoked by alias); 02 Dec 2006 10:49:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 02 Dec 2006 11:49:06 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 1 Dec 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > [ Tangentially related.. ]
> >
> > On Thu, 30 Nov 2006, Wink Saville wrote:
> >> 
> >> Earlier had a problem with git wanting merge but didn't have it and
> >> couldn't figure out which package it was in Ubuntu:( So I symlinked merge
> >> to kdiff3 which worked at the time:
> >
> > Btw, what's the status of the xdl_merge() thing in "pu"?
> 
> I haven't looked at the code any further than minimally checking
> its external interface to be able to interface it with
> merge-recursive and no more.  Namely:
> 
>  - I haven't read the algorithm to judge its correctness;

With my track record of blamable patches, that should be done by somebody 
else than me.

>  - I haven't looked for leaks;

Neither have I.

>  - I haven't used the resulting merge-recursive in any real
>    merge; some of our tests do rely on a correctly working
>    merge-recursive, so it is not like the algorithm is always
>    emitting "boo ha ha" and returning no conflicts ;-).

I have. There is a subtle difference to merge, but it might be serious 
enough:

diff --just-made-up orig new1
 Hello world
+This conflicts
 Bye bye world
+This does not conflict

diff --just-made-up orig new2
 Hello world
+This is different in new2
 Bye bye world

If my interpretation of the test is correct, then the last line of new1 
will _not_ conflict with xdl_merg( as is, but with RCS merge. I will fix 
that shortly.

>  - I haven't benched it to see how much performance is gained
>    by bypassing an extra fork+exec.

There is room for improvement, but I get shaky numbers betwen 31% and 
118% (runtime git-merge-recursive xdl_merge() / RCS merge). These are 
extremely ad-hoc generated numbers, so handle with care. My 
gut feeling is that a few improvements in the code will give a rough 
30%-50% in the average case.

These improvements include not parsing orig twice, and compacting the 
merge script before applying it.

> Among the four patches Johannes sent out to the list and Davide,
> one was already in his original patch I have in 'pu', another
> makes the same return value change I did myself when interfacing
> the code with merge-recursive.

Yeah, sorry. When I sent the patches, I did not see xdl_merge() in pu.

> I have queued the remaining two in 'pu', so there should be nothing 
> missing.
> 
> One of them is marked as "fix off by one error" but it was about
> more than off by one (the code walks two arrays using one index
> for each, but the original code incorrectly used the same index
> to access both arrays at one point, which was also fixed).  I
> did mind the lack of explanation and wanted to reword the log
> message, but as I said, I haven't read the algorithm to
> understand what the code is doing enough, so I cannot write
> anything useful there yet X-<, which is one of the reasons why
> it is still queued in 'pu'.

Sorry again. I fixed that bug in the middle of the night, and committed 
the next day, trying to deduct what I fixed.

Again, I do not see the patches in pu, though. I will concoct a nice 
commit message later today, okay?

Linus, you raised the concern that git-cvsserer still relies on 
external merge. I'd just bastardize git-merge-one-file to work as a 
replacement of RCS merge (just like git apply works as a replacement of 
patch), in addition to its original function.

Ciao,
Dscho

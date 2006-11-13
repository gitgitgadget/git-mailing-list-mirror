X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Mon, 13 Nov 2006 13:45:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611131333000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 13 Nov 2006 12:45:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31296>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjbBm-0007ED-RV for gcvg-git@gmane.org; Mon, 13 Nov
 2006 13:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754584AbWKMMpU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 07:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754514AbWKMMpT
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 07:45:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:43488 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1754584AbWKMMpS (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 07:45:18 -0500
Received: (qmail invoked by alias); 13 Nov 2006 12:45:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 13 Nov 2006 13:45:16 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 7 Nov 2006, Alex Riesen wrote:

> For me, it fails even on 332Mb pack:
> 
> $ git reset --hard 61bb7fcb
> fatal: packfile .git/objects/pack/pack-ad37...pack cannot be mapped.
> 
> Instrumenting the code reveals that it fails on 348876870 bytes.
> Strangely enough, a cygwin program which just reads that pack
> many times without freeing the mem goes up to 1395507480 (1330Mb).
> 
> If I replace the malloc (cygwin) with native VirtualAlloc(MEM_COMMIT)
> it reports that "Not enough storage is available to process this command",
> which is just ENOMEM, I think.

This looks to me as if you have NO_MMAP=1 set in your Makefile (which I 
also do automatically when compiling on cygwin).

The old problem: Windows does not have fork.

<digression> And before somebody starts cygwin bashing: don't. It is not 
cygwin's problem, it is Windows'. The cygwin people worked long and hard 
on something truly useful, and it helps me _every_ time I have to work on 
a Windows platform (which _is_ utter crap). Some problems of Windows are 
so unhideable though, that even cygwin cannot work around them. 
</digression>

Cygwin provides a mmap(), which works remarkably well even with the 
emulated fork(), but one thing is not possible: since mmap()ed files 
have to be _reopened_ after a fork(), and git uses the 
open-temp-file-then-delete-it-but-continue-to-use-it paradigm quite often, 
we work around it by setting NO_MMAP=1. Again, this is _not_ Cygwin's 
fault!

And I think that a mmap() of 332MB would not fail.

Long time ago (to be precise, July 18th), Linus suggested (in Message-Id: 
<Pine.LNX.4.64.0607180837260.3386@evo.osdl.org>) to find out which mmap() 
calls are _not_ used before a fork(), and not emulate them by malloc().

I never came around to do that, but maybe others do?

Ciao,
Dscho

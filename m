X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes other than Linux
Date: Tue, 19 Dec 2006 11:00:02 -0800
Message-ID: <7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	<8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191027270.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 19:00:18 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612191027270.18171@xanadu.home> (Nicolas Pitre's
	message of "Tue, 19 Dec 2006 10:53:08 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34840>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwkCB-0005S1-9a for gcvg-git@gmane.org; Tue, 19 Dec
 2006 20:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932897AbWLSTAH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 14:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbWLSTAG
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 14:00:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:55537 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932897AbWLSTAE (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 14:00:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219190003.IECT18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Tue, 19
 Dec 2006 14:00:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 0j0F1W00e1kojtg0000000; Tue, 19 Dec 2006
 14:00:16 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> OK looks like this has been sorted out while I was away.  Good!
>
> This is Linus's patch plus a few cosmetic changes.

Not a complaint but rather a request for free education ;-).

> diff --git a/index-pack.c b/index-pack.c
> index 6d6c92b..e08a687 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -1,3 +1,8 @@
> +#define _XOPEN_SOURCE 500
> +#include <unistd.h>
> +#include <sys/time.h>
> +#include <signal.h>
> +
>  #include "cache.h"
>  #include "delta.h"
>  #include "pack.h"
> @@ -6,8 +11,6 @@
>  #include "commit.h"
>  #include "tag.h"
>  #include "tree.h"
> -#include <sys/time.h>
> -#include <signal.h>

Most of the rest of the sources seem to do our includes first
and source-file specific system includes at the end.  What's the
rationale for this change?

Do we need _XOPEN_SOURCE=500 because pread() is XSI?

Also nobody other than convert-objects.c has _XOPEN_SOURCE level
specified.  If _XOPEN_SOURCE matters I wonder if we should do so
in some central place to make it consistent across source files?

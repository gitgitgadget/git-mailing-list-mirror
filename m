X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid accessing a slow working copy during diffcore operations.
Date: Sat, 16 Dec 2006 05:38:21 -0800
Message-ID: <7v7iwsezaq.fsf@assigned-by-dhcp.cox.net>
References: <20061214111557.GA24297@spearce.org>
	<7vpsakl6mu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612161253080.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 13:38:36 +0000 (UTC)
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612161253080.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 16 Dec 2006 12:54:54 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34616>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvZkG-0004aU-B1 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 14:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753703AbWLPNiX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 08:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbWLPNiX
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 08:38:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62457 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753699AbWLPNiW (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 08:38:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216133822.OROV25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 08:38:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zRdh1V00N1kojtg0000000; Sat, 16 Dec 2006
 08:37:42 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 15 Dec 2006, Junio C Hamano wrote:
>
>> Also I'd prefer doing this without #ifdef;
>> 
>>         if (defined(NO_FAST_WORKING_DIRECTORY) &&
>>         	!want_file && has_sha1_pack(sha1, NULL))
>> 		return 0;
>
> Are you sure? AFAIU it is an OS dependent problem, so it should not be 
> configurable at runtime anyway.

Well, defined(SYMBOL) does not seem to be a valid C X-<, and I
rewrote it in what I committed.  But the point was that the
whole thing:

	if (!FAST_WORKING_DIRECTORY && whatever)
		statement;

when FAST_WORKING_DIRECTORY is a compilation time constant,
would be optimized out for sane platforms with a reasonable
compiler.

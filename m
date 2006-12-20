X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes other than Linux
Date: Wed, 20 Dec 2006 13:52:19 -0800
Message-ID: <7v1wmu8cbw.fsf@assigned-by-dhcp.cox.net>
References: <86y7p57y05.fsf@blue.stonehenge.com>
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
	<7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191409500.18171@xanadu.home>
	<Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
	<4588453A.3060904@garzik.org>
	<7vzm9jo1df.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191640010.6766@woody.osdl.org>
	<7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
	<7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612201243490.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 21:52:29 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34965>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9MO-0004e2-PD for gcvg-git@gmane.org; Wed, 20 Dec
 2006 22:52:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030367AbWLTVwW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 16:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbWLTVwW
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 16:52:22 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58590 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030367AbWLTVwV (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 16:52:21 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220215221.XWHW97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 16:52:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 19re1W01U1kojtg0000000; Wed, 20 Dec 2006
 16:51:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 20 Dec 2006, Junio C Hamano wrote:
>> 
>> I needed to fix the changes to git-compat-util.h a bit from the
>> version I sent earlier to make OpenBSD happy (sys/types.h there
>> did not expose u_int unless _BSD_SOURCE was set, and
>> netinet/in.h was duplicated by mistake).
>
> Please don't use "u_int" in the first place. It's an abomination of a 
> type. It should never be used.

I did not want to touch imported sources in compat/, but 

> The only user in git seems to have been copied from a source that is 
> insane. It does
>
> 	u_int words[NS_IN6ADDRSZ / NS_INT16SZ];
>
> which is just insane. It actually seems to want to use "uint16_t", which 
> at least would make sense, and be a type that has some _point_ to it.

the above argument makes 100% sense.  Will fix.

However, on sane platforms we do not even compile that file.
The problem I observed was that <include/netinet/tcp.h> on
OpenBSD uses u_int wants the source code that uses that header
file to first include <sys/types.h> to get u_int, which in turn
requires __BSD_VISIBLE to be in effect.

Unfortunately I think _BSD_SOURCE needs to stay for this reason.

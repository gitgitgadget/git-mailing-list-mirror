X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on
 many OSes other than Linux
Date: Wed, 20 Dec 2006 12:53:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612201243490.3576@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <86r6uw9azn.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org> <Pine.LNX.4.64.0612181906450.18171@xanadu.home>
 <20061219051108.GA29405@thunk.org> <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
 <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191027270.18171@xanadu.home>
 <7vk60npv7x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191409500.18171@xanadu.home>
 <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org> <4588453A.3060904@garzik.org>
 <7vzm9jo1df.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191640010.6766@woody.osdl.org>
 <7v7iwnnzed.fsf@assigned-by-dhcp.cox.net> <7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 21:00:19 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqlye2zz.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34961>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx8Xx-0002Yp-0I for gcvg-git@gmane.org; Wed, 20 Dec
 2006 22:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965154AbWLTVAM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 16:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030198AbWLTVAM
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 16:00:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38168 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S965154AbWLTVAK
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 16:00:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBKKrC2J005582
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 20
 Dec 2006 12:53:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBKKrAIP006626; Wed, 20 Dec
 2006 12:53:11 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Wed, 20 Dec 2006, Junio C Hamano wrote:
> 
> I needed to fix the changes to git-compat-util.h a bit from the
> version I sent earlier to make OpenBSD happy (sys/types.h there
> did not expose u_int unless _BSD_SOURCE was set, and
> netinet/in.h was duplicated by mistake).

Please don't use "u_int" in the first place. It's an abomination of a 
type. It should never be used.

There's simply no point. It's "unsigned int", and that doesn't need any 
header files at all.

I don't understand why people are lazy, and can't write "unsigned", but 
then introduce a type that requires you to have all kinds of magic. The 
lazyness just results in more work, and is totally nonportable.

So "u_int" (along with its idiotic brethren "u_long", "u_short" and 
"u_char") is just silly.

The only user in git seems to have been copied from a source that is 
insane. It does

	u_int words[NS_IN6ADDRSZ / NS_INT16SZ];

which is just insane. It actually seems to want to use "uint16_t", which 
at least would make sense, and be a type that has some _point_ to it.

So please change the "u_int" to either "unsigned int" or "uint16_t". 
Either is better.


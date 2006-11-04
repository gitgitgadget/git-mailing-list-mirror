X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If I were redoing git from scratch...
Date: Sat, 4 Nov 2006 15:15:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611041509370.25218@g5.osdl.org>
References: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611040829040.25218@g5.osdl.org> <20061104191651.GC2517@spearce.org>
 <200611042329.46556.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0611041436050.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 4 Nov 2006 23:15:51 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611041436050.25218@g5.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30942>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgUjt-0003r8-Bk for gcvg-git@gmane.org; Sun, 05 Nov
 2006 00:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965718AbWKDXPq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965743AbWKDXPq
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 18:15:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43225 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S965718AbWKDXPp (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 18:15:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA4NFRoZ013472
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 4
 Nov 2006 15:15:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA4NFQr9002675; Sat, 4 Nov
 2006 15:15:27 -0800
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org



On Sat, 4 Nov 2006, Linus Torvalds wrote:
> 
> In addition to that, we need one pointer per hash entry, and in order to 
> keep the hash list size down we need that hash array to be about 25% free, 
> so say 1.5 pointers per object: ~6 bytes or ~12 bytes depending on whether 
> it's a 32- or 64-bit architecture.

Btw, one of the things I considered (but rejected as being _too_ far out 
for now) during the memory shrinking thing was to make both 32-bit and 
64-bit entities use a 32-bit hash table entry.

The way to do that would be to instead of using a pointer, use a 32-bit 
integer where the low ~10 bits are an index into the allocation buffer 
(since we batch allocations), and the rest of the bits would be an index 
into which batch-buffer it is.

Exactly because 8 bytes per hash entry is actually right now a big part of 
the object memory allocation overhead on 64-bit architectures, and cutting 
it down to just 4 bytes would help save memory.

I never got around to it, if only because I actually just compile my 
user-land git stuff as 32-bit, even on my ppc64 system. And partly because 
I had shrunk the object allocations enough that I just felt pretty happy 
with it anyway, and the change would have been pretty painful. But on 
64-bit architectures, the hash table right now is about a third of the 
whole memory overhead of the object database, and cutting it down by half 
would actually be noticeable.


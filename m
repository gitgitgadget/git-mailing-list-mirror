X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If I were redoing git from scratch...
Date: Sat, 4 Nov 2006 14:44:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611041436050.25218@g5.osdl.org>
References: <7vpsc3xx65.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611040829040.25218@g5.osdl.org> <20061104191651.GC2517@spearce.org>
 <200611042329.46556.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 4 Nov 2006 22:45:45 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611042329.46556.robin.rosenberg.lists@dewire.com>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30941>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgUGf-00064R-5J for gcvg-git@gmane.org; Sat, 04 Nov
 2006 23:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965728AbWKDWp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 17:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965730AbWKDWp3
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 17:45:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24277 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S965728AbWKDWp2 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 17:45:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA4MiQoZ012033
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 4
 Nov 2006 14:44:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA4MiPUf001930; Sat, 4 Nov
 2006 14:44:26 -0800
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org



On Sat, 4 Nov 2006, Robin Rosenberg wrote:
> 
> The overhead is eigth bytes per object on a 32-bit platform and 16 on a 64-bit 
> platform for Sun's JDK. The granularity is eight bytes in both cases. 

Note that the object structure itself is just 24 bytes (regardless of 
whether we're on a 32-bit or 64-bit architecture).

In addition to that, we need one pointer per hash entry, and in order to 
keep the hash list size down we need that hash array to be about 25% free, 
so say 1.5 pointers per object: ~6 bytes or ~12 bytes depending on whether 
it's a 32- or 64-bit architecture.

So 8 or 16 bytes overhead per object is roughly a 25% or 50% pure 
overhead. In contrast, right now we have pretty much _zero_ overhead (we 
do end up having some malloc cost, but since we batch them, it's on the 
order of a few bytes per _thousand_ objects, so we're talking fractions of 
a percent).

Of course, the memory footprint isn't _just_ the objects, but it's a big 
part of it, for some important apps (not just repack, but git-send-pack 
obviously also has this). So on a git server, keeping the memory use down 
is likely the #1 concern - even if the server might have gigabytes of RAM.


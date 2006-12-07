X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 7 Dec 2006 11:30:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612071121410.3615@woody.osdl.org>
References: <45708A56.3040508@drzeus.cx> <Pine.LNX.4.64.0612011639240.3695@woody.osdl.org>
 <457151A0.8090203@drzeus.cx> <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>
 <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org>
 <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org>
 <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org>
 <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org>
 <457868AA.2030605@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 19:31:47 +0000 (UTC)
Cc: Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457868AA.2030605@zytor.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33612>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOy7-0006m2-A5 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937999AbWLGTbk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938000AbWLGTbk
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:31:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59088 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937999AbWLGTbj
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 14:31:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB7JUUID011754
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 7
 Dec 2006 11:30:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB7JUT0h022691; Thu, 7 Dec
 2006 11:30:30 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
Sender: git-owner@vger.kernel.org



On Thu, 7 Dec 2006, H. Peter Anvin wrote:
> 
> What it could do better is it could prevent multiple identical queries from
> being launched in parallel.  That's the real problem we see; under high load,
> Apache times out so the git query never gets into the cache; but in the
> meantime, the common queries might easily have been launched 20 times in
> parallel.  Unfortunately, the most common queries are also extremely
> expensive.

Ahh. I'd have expected that apache itself had some serialization facility, 
that would kind of go hand-in-hand with any caching.

It really would make more sense to have anything that does caching 
serialize the address that gets cached (think "page cache" layer in the 
kernel: the _cache_ is also the serialization point, and is what 
guarantees that we don't do stupid multiple reads to the same address).

I'm surprised that Apache can't do that. Or maybe it can, and it just 
needs some configuration entry? I don't know apache.. I realize that 
because Apache doesn't know before-hand whether something is cacheable or 
not, it must probably _default_ to running the CGI scripts to the same 
address in parallel, but it would be stupid to not have the option to 
serialize.

That said, from some of the other horrors I've heard about, "stupid" may 
be just scratching at the surface.


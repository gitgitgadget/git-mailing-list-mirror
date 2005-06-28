From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 11:17:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506281111480.19755@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506281251380.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506281019450.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 20:15:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnKbP-0006IJ-OY
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 20:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVF1SVk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 14:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVF1SVk
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 14:21:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261516AbVF1SVh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 14:21:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SIF6jA005750
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 11:15:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SIF0fM017967;
	Tue, 28 Jun 2005 11:15:03 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.58.0506281019450.19755@ppc970.osdl.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Linus Torvalds wrote:
> 
> I can certainly add an option to git-pack-file that disables writing of
> the index file, and just writes the pack-file to stdout.

Done.

>						 I'm not sure I
> want to write the "parse incoming pack-file" thing, but git-unpack-objects
> comes _reasonably_ close (but right now it seeks around using the index
> file to resolve deltas, instead of keeping them in memory and resolving
> them when possible).

I'm still thinking about this one. I think I'll just do it.

One problem here is that since we don't know how big the incoming
pack-file will be, in a streaming input environment the receiver needs to
either make the pack-file reception be the last thing it sees, or it will
have to live with the fact that "git-unpack-objects" will read some more
than it needs before it notices that it got it all...

We can handle the latter either by padding (make the rule be that
git-unpack-file will always read in chunks of 4kB max, and pad the output
with 4kB of zero bytes or something, and then you can execute
git-unpack-objects and continue reading stdin afterwards, removing any
zeroes that git-unpack-file didn't eat), or by having git-unpack-objects 
flush anything after the final SHA1 to _its_ stdout, so that you can get 
the following data/commands in the stream from the unpack-file thing. 
Ugly, in any case.

		Linus

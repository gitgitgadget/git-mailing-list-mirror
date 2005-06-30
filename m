From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 15:26:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 00:17:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do7Ll-0002CD-S3
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 00:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVF3WYx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 18:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVF3WYx
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 18:24:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263045AbVF3WYc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 18:24:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5UMOIjA032634
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 15:24:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5UMOHh0005123;
	Thu, 30 Jun 2005 15:24:18 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C46A3C.1070104@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
> For producing minimum network traffic, I think something like this would 
> work:

In the "minimum traffic", the thing to look at is number of packets, and 
penalize further for anything that requires a synchronous reply.

That's why I'd suggest just letting the client stream out the list of
objects it has - it may appear wasteful to stream out even a thousand
SHA1's, but hey, that's just 20kB worth of data, and especially if there
is no synchronous stuff, that's just 15 ethernet packets.

For the server side, looking up a thousand SHA's is pretty easy (it's
_really_ cheap if the server ends up using a few big packed objects: you
don't even have to look at the pack data itself, it can look at just the
index and say "yup, I've got it")

So I'd go for simple brute force over anything that needs to discuss
things and have a back-and-forth between server/client. And making the
client do the heavy lifting is the right thing to do (the server will have
to create the pack, which can be expensive, but you can tune the delta 
window for how much CPU the server has)

		Linus

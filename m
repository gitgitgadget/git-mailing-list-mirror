From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Fri, 22 Apr 2005 12:24:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221147050.2344@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
 <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504212200400.2344@ppc970.osdl.org>
 <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 21:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP3fn-0006ZX-Vh
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 21:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVDVTXK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 15:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVDVTXK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 15:23:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:29342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262114AbVDVTXE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 15:23:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MJMxs4030075
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 12:23:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MJMwF7008776;
	Fri, 22 Apr 2005 12:22:59 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmvr72j6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 21 Apr 2005, Junio C Hamano wrote:
> 
> The commands I would want to take paths relative to the user cwd
> are quite limited; note that I just want these available to the
> user and I do not care which one, the core or Cogito, groks the
> cwd relative paths:

I've thought about this, and looked at the sources, and it wouldn't be 
horrible.

HOWEVER, the more I thought about it, the less sense it made. The fact is, 
you can do _exactly_ what you are talking about by just wrapping the calls 
in

	( cd $WORKING_DIR && git-cmd )

which simply doesn't have any downsides that I can see. It always does the 
right thing, and it means that the tools will never have to care about 
what the base is. Keeping the core tools is important, because if they 
mess up, you're in serious trouble. In contrast, if higher levels mess up, 
you're not likely to have caused anything irrevocable.

In fact, I probably shouldn't even have done the "--prefix=" stuff for
check-out, since the common "check out in a new directory" case (not the
"prefix file" case can be pretty easily emulated with a fairly trivial 
script, something like

	#!/bin/sh
	CURRENT_DIR=$(pwd)
	GIT_INDEX_FILE=${GIT_INDEX_FILE:-$CURRENT_DIR/.git/index}
	SHA1_FILE_DIRECTORY=${SHA1_FILE_DIRECTORY:-$CURRENT_DIR/.git/objects}
	TARGET=$1
	shift 1
	mkdir $TARGET && cd $TARGET && checkout-cache "$@"

but since it was (a) very easy to add to that particular program, and (b) 
exporting a while directory is pretty fundamental, I'll just leave that 
strange special case around.

So to the core tools, there really _are_ just two special things: the 
index file, and the place where to find the sha1 objects.  The working 
directory is really nothing but "pwd", which can be trivially changed 
before invocation, ie the addition of a new environment variable really 
doesn't _buy_ anything except for complexity.

		Linus

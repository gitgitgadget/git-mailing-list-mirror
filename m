From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Add ".git/config" file parser
Date: Mon, 10 Oct 2005 15:12:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510101456570.14597@g5.osdl.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> <Pine.LNX.4.63.0510100220330.23242@iabervon.org>
 <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510101354520.23242@iabervon.org>
 <Pine.LNX.4.64.0510101120410.14597@g5.osdl.org> <Pine.LNX.4.64.0510101415080.14597@g5.osdl.org>
 <Pine.LNX.4.64.0510101446180.14597@g5.osdl.org> <434AE209.60605@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 11 00:14:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP5su-0004Cr-Tx
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 00:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVJJWMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 18:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVJJWMi
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 18:12:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751287AbVJJWMh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 18:12:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9AMCV4s008095
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 15:12:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9AMCU3a008814;
	Mon, 10 Oct 2005 15:12:31 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434AE209.60605@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9948>



On Mon, 10 Oct 2005, H. Peter Anvin wrote:
> 
> A suggestion: if you make your basic types (integer, string, boolean)
> recognizable by the parser, you can present them in that way.  This pretty
> much means strings will have to always be double-quoted, but that avoids a
> bunch of ambiguities.

Well, the parser is already pretty unambiguous, purely by virtue of being 
stupid as hell.

In particular, the only thing quoting does is to actually make whitespace 
meaningful, and as a way to allow comments inside strings (otherwise a "#" 
or ";" is always a "comment starts here" marker).

Outside of quotes, any whitespace will just collapse to a single space 
(and be removed from beginning and end).

And quite frankly, always keeping the things as strings just makes things 
so much easier and the interfaces very simple. And if/when you want to 
turn the string into a boolean or a regular integer, there are two helper 
functions that do exactly that, so it's not very hard.

I considered using some "smart" parser (ie using something like 
flex/bison), but the thing is, I didn't want smart. I personally think 
it's a lot more important for the file format to be _nice_, and there I 
think it's fine if

	[diff]
		external=/usr/local/bin/gnu-diff

doesn't need quotes, even if it's obviously a string. Simplicity is a 
virtue (both in parsing and in the "language" parsed).

In fact, even the example I had - with a space and an argument - doesn't 
need quotes (since the single space will be collapsed to a single space), 
I just put that as an example.

Side note: the design is meant to allow different programs to share the 
same config file without having to know about each others config 
variables. Anything they don't recognize is just ignored. The downside is 
that if you mistype an option name, nobody will recognize it, and nobody 
will complain either. 

That was one of the reasons for the "scoping". It not only allows grouping 
of variables, but it means that the "git-diff-xyz" family of programs 
might decide that they'll report anything that starts with "diff." but 
that they don't understand as a warning (but preferably not error, since 
it might be a newer option that an older version of git just doesn't 
understand).

		Linus

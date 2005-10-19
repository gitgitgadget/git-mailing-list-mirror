From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: The git protocol and DoS
Date: Wed, 19 Oct 2005 14:31:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510191410570.3369@g5.osdl.org>
References: <4356A5C5.5080905@zytor.com> <7vmzl544f3.fsf@assigned-by-dhcp.cox.net>
 <4356B2C7.601@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 23:33:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESLXR-0001r3-Pq
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 23:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVJSVbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 17:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbVJSVbz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 17:31:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751358AbVJSVby (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 17:31:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JLVnFC006011
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 14:31:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JLVmpq021043;
	Wed, 19 Oct 2005 14:31:48 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4356B2C7.601@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10313>



On Wed, 19 Oct 2005, H. Peter Anvin wrote:
> 
> You mean an option on the *server* to skip the cookie exchange?  If so, how
> would you expect the client to handle it?

Hey guys, I actually planned for the protocol to be extensible.

The client always starts out by sending the "command" first, and if you 
want to add a challenge-response thing, I really think you should make it 
a nice compatible upgrade (and then later on, you can have a server option 
that says "if the client doesn't do the challenge-response version, I 
won't talk to him").

Basically, right now the client sends a

	"git-upload-pack /absolute/pathname/to/repo"

over the protocol, and the whole point of this was that (a) it's 
extensible and (b) the server knows what to expect, and can close the 
socket if it doesn't get a valid packet.

So if you add some extra challenge-response thing, please just do so by 
changing the string. Teach the server to also accept

	"git-upload-pack --challenge /absolute/pathname/to/repo"

for example. Then later, add a "secure server" mode that refuses to do the 
old non-challenge response.

HOWEVER. The server _already_ has some of this logic: if you start it 
outside of inetd, it will start killing its own children when there are 
too many of them, but it will start by sending them a SIGTERM. And the 
git-daemon code is set up so that a SIGTERM will kill any deamon that 
hasn't seen the proper handshake yet.

Once it's seen the proper handshake, the deamon will block SIGTERM. 
Exactly so that if there is a SYN attack, people who use a non-git-aware 
SYN generator will be second-class citizens. So there's not a real 
challenge-response thing, but at least it's set up so that real git 
clients (or something that looks like one) can be recognized, and get 
preferred treatment over people who just open a connection.

Of course, this part doesn't work with the kernel.org setup, since that 
uses inetd, but we could easily add a timeout too, and do the same exact 
thing for SIGALRM (and just do an "alarm(timeout)" at the head of 
"execute()" before we start really trying to read from the socket).

In other words, git-daemon _already_ has support to help fight SYN 
attacks, although it currently only works when stand-alone. It could be 
extended to work with inetd, though.

NOTE! Right now, a git-aware SYN-flooder could send a SYN + 
"git-upload-pack /valid/directory" thing in the proper packed-line format, 
and _then_ just go away. But once you're talking to a git-aware 
SYN-flooder, I don't think a challenge-response makes it any better, since 
a git-aware SYN-flooder would just be written to give the right response.

So unless you actually have _passwords_, and make the response something 
that the other end has to figure out some other way, I don't see what else 
we could do..

			Linus

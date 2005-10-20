From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Revamping the git protocol
Date: Thu, 20 Oct 2005 09:38:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510200924110.3369@g5.osdl.org>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net>
 <20051020091245.GY30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 18:42:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESdQz-0006uR-K4
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbVJTQiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 12:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVJTQiV
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 12:38:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932450AbVJTQiU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2005 12:38:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9KGc9FC016980
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 20 Oct 2005 09:38:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9KGc8st029590;
	Thu, 20 Oct 2005 09:38:08 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051020091245.GY30889@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10368>



On Thu, 20 Oct 2005, Petr Baudis wrote:
> 
> What's wrong with my scheme? That is, _reply_ with challenge to the
> upload-pack command.

Neither your not Peter's scheme seems to be at all worried about backwards 
compatibility, and I just don't see _why_.

Even if you can upgrade all servers (there aren't that many of them), why 
force a client upgrade when the protocol is designed to be extensible?

Especially for somethign that doesn't even _buy_ you anything right now.

In fact, I'm not even sure it buys you anything in the future. The thing 
is, SYN-flooding depends on overwhelming you with lots of simple packets. 
And since in the git protocol, the expense is not in the _packets_ but in 
the server-side packing and data transfer, I don't see the point.

If you want to DoS a git pack server, you open a hundred _real_ git 
connections to it, carefully selected so that they get unique packs (so 
that the server can't cache them). You don't need to have some distributed 
denial-of-service attack with lots of magic packets.

This is why the git daemon already limits the clients to 25 by default or 
something like that - it doesn't want to put too much strain on the 
server.

A much more important thing the git daemon could do is to kill connections 
from the same IP address when there's more than 25 pending ones. The 
daemon actualy has the infrastructure for that - it's why it doesn't just 
count its children, it actually saves child information away (it just 
doesn't _use_ it for anything right now).

Similarly, git-upload-pack can be future-proofed by having it have some 
data transfer timeout: if it doesn't make any progress at all in <n> 
seconds, just kill itself. Things like _that_ are likely to be a lot more 
important, I suspect.

And no, I don't think th egit protocol should do authentication. It's 
hard. If you want to do authentication, you need to do encryption too, and 
then you should do something else (but the git protocol _does_ work fine 
over an encyrpted channel, so the "something else" might be to have some 
secure web interface tunnel protocol or similar, and then just support 
"git over https" or something ;).

			Linus

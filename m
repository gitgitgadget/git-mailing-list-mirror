From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Security problem
Date: Thu, 15 Jun 2006 19:56:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606151948230.5498@g5.osdl.org>
References: <200606151709.22752.lan@academsoft.ru> <7vbqsuc60q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606151831470.5498@g5.osdl.org> <200606160931.29553.lan@academsoft.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 04:57:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr4WR-0005UQ-0H
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 04:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWFPC47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 22:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWFPC47
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 22:56:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4841 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750825AbWFPC46 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 22:56:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5G2upgt004419
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Jun 2006 19:56:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5G2unCT003732;
	Thu, 15 Jun 2006 19:56:50 -0700
To: Alexander Litvinov <lan@academsoft.ru>
In-Reply-To: <200606160931.29553.lan@academsoft.ru>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21927>



On Fri, 16 Jun 2006, Alexander Litvinov wrote:
> 
> I have found the ability to hack git repo. After this hacking people will 
> checkout hacked files from the "trusted" commit. Only git-fsck-objects will 
> complain at this.

Right.

If you can't trust your local filesystem, you are screwed. 

git-fsck-objects will notice when somebody has done something bad, but 

> Why does not git-checkout check if file content match name of the object ?

Why would it? It really just slows things down, and if you don't trust 
your local repo, people can "hack" you much more easily by just generating 
a _proper_ tree with the _proper_ data, and git checkout checking the SHA1 
wouldn't help at all.

The way to security lies in using git-fsck-objects, together with an 
_external_ source of trust. For example, that external source of trust may 
be a signed tag, or, perhaps even more simply, just by saving off the top 
commit name on some trusted medium.

But you do need a "point of trust" to start with. Without that, it's a lot 
easier to "hack" a git repo by doing

	echo 'Hacked file' > a
	git commit --amend a
	git prune

and now the file "a" has changed to "Hacked file", and even 
git-fsck-objects can't tell that anything bad happened.

(Btw, if you want to _hide_ the fact that "a" now contains "Hacked file", 
you do so by faking it in the index. You can have the checked-out copy say 
what it should say - ie "Usual file" - and if you don't want git to show 
you the difference to HEAD, you edit the .git/index file by hand so that 
the timestamp, size and inode matches the real SHA1, even though the 
_contents_ match "Usual file").

See?

You do need to trust something. Normally you'd trust your own filesystem, 
but git certainly supports other forms of trust through either the native 
support for signed certificates in the form of tags, or any other form of 
external trust.

			Linus

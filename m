From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: bug: git-repack -a -d produces broken pack on NFS
Date: Thu, 27 Apr 2006 15:29:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604271526140.3701@g5.osdl.org>
References: <20060427213207.GA6709@steel.home> <Pine.LNX.4.64.0604271500500.3701@g5.osdl.org>
 <7v4q0ek6i3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 00:29:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZEzF-00088s-JM
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWD0W3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbWD0W3X
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:29:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751727AbWD0W3W (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 18:29:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3RMTCtH005234
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Apr 2006 15:29:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3RMTBF7015044;
	Thu, 27 Apr 2006 15:29:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q0ek6i3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19249>



On Thu, 27 Apr 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > That said, the pack-file should all be written with the "sha1write()" 
> > interface, which is very careful indeed.
> >
> > I wonder if the _pack-file_ itself might be ok, and the problem is an 
> > index file corruption. For some reason we check the index file first, 
> > which is insane. We should check that the pack-file matches its _own_ SHA1 
> > first, and check the index file second.
> 
> We need to check both, so I fail to see why the order matters.

It's insane to do any _cross_-file checking before you've even verified 
that the files themselves are valid.

Another way of saying the same thing: checking whether the SHA1 of the 
pack-file matches the index file is pointless before you've verified that 
the SHA1 itself is valid.

Basically, if the pack-file is corrupt, you want to know that. You don't 
want to know that it's SHA1 doesn't match the index file - that's a 
"secondary" issue to the fact that the SHA1 wasn't correct in the first 
place.

Right now, if the pack-file is corrupt, it doesn't actually tell us so. It 
says that it doesn't match the index file. Which is likely wrong - it 
probably _does_ match the index file, but it's been corrupted.

See the difference?

			Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Possible --remove-empty bug
Date: Sun, 12 Mar 2006 14:54:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603121450210.3618@g5.osdl.org>
References: <e5bfff550603120612k555fc7f3v9d8d17b1bd0b9e41@mail.gmail.com>
 <7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 13 00:14:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIZSB-0005TQ-Ag
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 23:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWCLWyU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 17:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCLWyU
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 17:54:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54747 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751239AbWCLWyU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 17:54:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2CMsEDZ031151
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 14:54:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2CMsDOM016852;
	Sun, 12 Mar 2006 14:54:14 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6azz6xx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17528>



On Sun, 12 Mar 2006, Junio C Hamano wrote:
> 
> To be honest, I do not know how --remove-empty is intended to
> work.

It's supposed to stop traversing the tree once a pathname disappears.

> Maybe something like this is closer to what the documentation
> says.

If it is, then the documentation is broken.

The fact that a pathname disappears does _not_ make the commit 
uninteresting. It just means that we should stop traversing that parent.

"uninteresting" has a big side effect: it inherits to parents. So if you 
have

	    a
	   / \
	  b   c
	   \ /
	    d

where the pathname disappeared in "b", you must NOT mark it uninteresting, 
because that would mean that "d" is also uninteresting.

There's a huge difference between saying "I will not traverse down this 
line any more" and "I mark this commit uninteresting". The first one just 
stops adding commits to the commit list (but parents deeper down might 
still be interesting because they are also reached through another 
pathway). The second says "this commit and all of its ancestors are 
deemed worthless".

The "path goes away" case is meant to just stop traversal, not mark all 
parents worthless.

		Linus

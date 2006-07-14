From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Kernel headers git tree
Date: Thu, 13 Jul 2006 18:05:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 03:06:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1C8C-0000Z3-O9
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 03:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWGNBGE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 21:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWGNBGD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 21:06:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9623 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751427AbWGNBGC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 21:06:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6E15mnW011286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Jul 2006 18:05:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6E15l4R022196;
	Thu, 13 Jul 2006 18:05:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23864>



On Thu, 13 Jul 2006, Junio C Hamano wrote:
> 
> I am not sure what function incparent() is trying to do with
> this:
> 
> 	git rev-list --max-count=1 --topo-order $1 -- .

Yeah, that looks strange.

The "--topo-order" in particular looks pointless, and just slows things 
down.

The default ordering from git-rev-list (and all other revision listing 
things, ie "git log" etc) _does_ guarantee that we never show a child 
before _one_ of its parents has been shown (although "parent" in this case 
may be the command line).

As such, "--max-count=1 --topo-order" is pointless if you only give one 
revision, because whether you use --topo-order or not, the first commit 
will always be the parent of all subsequent commits.

So --topo-order just makes things MUCH MUCH slower with no upsides.

But that thing is doubly strange, because it uses "." as a path specifier. 
If this is done in the top-most directory, that should mean "all changes", 
which in turn means that the whole thing should be equivalent to

	git rev-parse "$1^0"

since all commits should make _some_ change, and thus the first revision 
in the list should always be the top commit - the one you passed in as an 
argument.

			Linus

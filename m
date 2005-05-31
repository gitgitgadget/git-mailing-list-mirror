From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Tue, 31 May 2005 08:23:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
 <17052.21846.816147.370354@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 17:22:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd8WK-0001gq-Ko
	for gcvg-git@gmane.org; Tue, 31 May 2005 17:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVEaPVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVEaPVv
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 11:21:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:12168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261895AbVEaPVp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 11:21:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VFLhjA007076
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 08:21:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VFLg7x022392;
	Tue, 31 May 2005 08:21:43 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Linus Torvalds wrote:
> 
> You should never see a parent before a child from git-rev-list.

Actually, I take that back.

A commit that has several children will see _a_ child before the parent is
shown, but while the time-based ordering means that it _likely_ will order
all children before the parent, now that I think about it, that's not
guaranteed to be true. You could have

	      A
	     / \
	    B   |
	     \ /
	      C
	      |
	      D

and if C has a date that is before B, then git-rev-list would traverse the
tree (and show it) in the order A C B.

In fact, even D might be listed before B is (eg, the person who committed
B had a clock that was set to the last century, and so the date on that
was wrong).

The thing is, since B has such an "old" date, the traversal assumes that
it is old and very low down in the tree, and that it's better off parsing
other commits first, so it will never look more closely at B and notice
that it has a parent that has already been parsed.

So I guess you'll have to wait for the end and do the toposort after all. 
Sorry about the confusion on my part.

		Linus

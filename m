From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling renames.
Date: Thu, 14 Apr 2005 11:32:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141124220.7211@ppc970.osdl.org>
References: <1113501260.27227.26.camel@hades.cambridge.redhat.com>
 <20050414181224.GA16126@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@SteelEye.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:28:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM940-00071M-VT
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVDNSbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDNSbA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:31:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:13775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbVDNSas (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 14:30:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3EIUes4028238
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 11:30:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3EIUaaQ011381;
	Thu, 14 Apr 2005 11:30:38 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050414181224.GA16126@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Ingo Molnar wrote:
> 
> there's no redundancy caused by this method: only renames (which are 
> rare) go through the rename_commit redirection. (to speed up the lookup 
> the rename_commit object could cache the offset of the two names within 
> their tree objects.)

Bzzt. Wrong.

ANYTHING you do with games like this will cause the "same directory 
creates different object" crap.

Git doesn't do that. There fundamentally is no history in objects, 
_except_ for the commit object. Two objects with the same name are 
identical, and that means that they are easy to share. 

Any time you break that model, you break the whole point of git. Don't do 
it. You'll be very very sorry if you ever do, because it breaks the clean 
separation of "time" and "space". I guarantee you that your merges will 
become _harder_ rather than easier.

What you can do at an SCM level, is that if you want to track renames, you
track them as a separate commit altogether. Ie if you notice a rename, you
first commit the rename (and you can _see_ it's a rename, since the object
didn't change, and the sha1 stayed the same, which in git-speak means that
it is the same object, ie that _is_ a rename as far as git is concerned),
and then you create the "this is the data that changed" as a _second_
commit.

But don't make it a new kind of commit. It's just a regular commit, 
dammit. No new abstractions. 

Trust me, it's worth it to follow the rules. You don't start making up new 
concepts for every new thing you track. Next you'll want "tag objects". 
That's a totally idiotic idea. What you do is you tag things at a higher 
level than git ever is, and git will _never_ have to know about tag 
objects. 

Some "higher level" thing can add its own rules _on_top_ of git rules. The
same way we have normal applications having their _own_ rules on top of
the kernel. You do abstraction in layers, but for this to work, the base 
you build on top of had better be damn solid, and not have any ugly 
special cases.

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Split up tree diff functions into tree-diff.c library
Date: Fri, 21 Oct 2005 08:19:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510210814310.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510202058030.10477@g5.osdl.org>
 <7v64rr2y4q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 17:21:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESygI-0004nz-9V
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 17:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964980AbVJUPTh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 11:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVJUPTh
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 11:19:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964980AbVJUPTg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 11:19:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9LFJVFC002850
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 21 Oct 2005 08:19:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9LFJU5q007780;
	Fri, 21 Oct 2005 08:19:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64rr2y4q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10435>



On Thu, 20 Oct 2005, Junio C Hamano wrote:
>
> I have not closely studied the user of this change, rev-list,
> but I have a hunch that you might be better off, if you define a
> new diff "format", DIFF_FORMAT_CALLBACK, and hook into
> diff_flush(), instead of hooking into diff_addremove() and
> diff_change().

No, I did that on purpose.

I did _not_ want the library interface users to have to use the flushing 
and all the associated memory management and complexity issues.

The thing is, the only thing rev-list wants to know is whether there was a 
diff at all, and I want to eventually make "opt->change()" and 
"opt->add_remove()" return a possible error code so that the whole diff 
library can just stop on the first change, since once we've seen _any_ 
change, we don't care any more.

Also, by taking it over at this lieve, you don't need to do any of the 
diff setup at all to use the core routines.

Now, if somebody _wants_ to hook into flushing, you can still do so: you 
just do

	opt->add_remove = diff_addremove;
	opt->change = diff_change;

and then you can hook into the higher-level functions if you want to. But 
for a lot of uses, I bet we do _not_ want to. And those higher-level 
routines have had some _serious_ memory use problems etc: by hooking into 
the lower level, we can bypass all of that.

(A memory leak in diff in git-rev-parse would be deadly on big archives).

> Right now, you are only making the parallel tree traversing and
> comparing part from diff-tree available in the library form
> (which is fine), but that way leaves the door open for it to
> also use the rest of the diffcore machinery.

The point is, we don't _want_ to use the rest of the diffcore machinery. 
It's too expensive and fragile.

		Linus

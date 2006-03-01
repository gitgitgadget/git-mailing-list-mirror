From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 09:40:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603010935201.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <4405C6BE.2000706@op5.se> <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
 <200603011814.43573.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 18:42:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVKP-0005Op-4N
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWCARlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWCARlS
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:41:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932494AbWCARlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 12:41:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21HevDZ015597
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 09:40:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21HeurT008541;
	Wed, 1 Mar 2006 09:40:57 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200603011814.43573.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16996>



On Wed, 1 Mar 2006, Josef Weidendorfer wrote:
>
> On Wednesday 01 March 2006 17:24, Linus Torvalds wrote:
> > The thing about it being .git/refs/heads/svn/xyzzy is that then you can do
> > 
> > 	git checkout svn/xyzzy
> > 
> > and start modifying it. Which is exactly against the point: the thing is 
> > _not_ a branch and you must _not_ commit to it.
> > 
> > It's much more like a tag: it's a pointer to the last point of an 
> > svn-import.
> 
> Isn't it the same with tracked branches of a remote git repo?
> With this reasoning, all heads that git-clone clones aside from the
> special "master" should not be under .git/refs/heads, but better
> under .git/refs/remotes/<remoteRepoName>/ ?

Yes, I think that would make tons of sense.

> <remoteRepoName> is "origin" in the case of git-clone, so .git/remotes/origin
> would contain
>  URL: http://host/repo.git
>  Pull: master:remotes/origin/master
> 
> Then there would not be the need for the confusing special branch "origin"
> after cloning, as namespaces are separate.

I think that would make things a lot more flexible, and yes, it sounds 
like a good idea.

HOWEVER.

I think it's not only very common, but quite useful, to do what we do now, 
ie

	git log origin..

to see "what is in origin but not in HEAD".

So there's a big usability issue: I don't think it's good to have to say

	git log remotes/origin/master..

to do the same.

So from a usability standpoint, we'd have to teach "get_sha1()" about 
parsing .git/remotes/* files if it cannot find a branch or a tag with that 
name (which it wouldn't be able to, since even if it were to walk the 
directories udner .git/refs/ recursively, it would be named "master" 
there).

But if somebody does the get_sha1() magic, and Junio agrees, then I think 
it would be a great thing to do.

			Linus

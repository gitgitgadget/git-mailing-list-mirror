X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 16:39:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161623170.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org> <455CFCBD.8040901@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 00:39:33 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455CFCBD.8040901@xs4all.nl>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31647>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkrlJ-0001dI-TW for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424815AbWKQAjS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424817AbWKQAjS
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:39:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59039 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1424815AbWKQAjR (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:39:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAH0dCoZ018539
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 16:39:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAH0dBTV013704; Thu, 16 Nov
 2006 16:39:12 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Fri, 17 Nov 2006, Han-Wen Nienhuys wrote:
> 
> Until that time, it would be good goal to remove all idiosyncrasies,
> all gratuitious asymetries and needless limitations in the commands of
> git, eg.

Well, a lot of the assymmetries aren't actually gratuitous at all.

>  - clone but not a put-clone,

As mentioned, in order to "put-clone", you generally have to "create" 
first, so the "put-clone" really makes no sense.

The _true_ reverse is really your

 - "git init-db" on both sides

 - "git pull" (your workflow ;) on receiving

 - "git push" on sending.

The fact that we can do "git clone" on the _receiving_ side is an 
assymmetry, but it's not gratutous: when receiving we don't need any extra 
permissions or setup to create a new archive. In contrast, when sending, 
you do have to have that "get permission to create new archive" phase.

>  - pull = merge + fetch, but no command for merge + throw

Again, this is not gratuitous, and the reason is very similar: when you 
pull, you're pulling into something that _you_ control and _you_ have 
access to, namely your working directory. In order to merge you have to 
have the ability to fix up conflicts (whether automatically or manually), 
and this is something that you _fundamentally_ can only do when you own 
the repo space.

Again, when you do "push", the reason you can't merge is not a "gratuitous 
assymmetry", but a _fundamental_ assymmetry: by definition, you're pushing 
to a _remote_ thing, and as such you can't merge, because you can't fix up 
any merge problems.

See?

In many ways, if you want _symmetry_, you need to make sure that the 
_cases_ are symmetrical. If you have ssh shell access, you can often do 
that, and the "reverse" of a "git pull" is actually just another "git 
pull" from the other side:

	ssh other-side "cd repo ; git pull back"

Now they really _are_ symmetrical: "git pull" is really in many ways ITS 
OWN reverse operation. 

But "push" and "pull" _fundamentally_ aren't symmetric operations, and you 
simply cannot possibly make them symmetric. Any system that tries would be 
absolutely horrible to use, exactly because it would be either:

 - making local/remote operations totally equivalent

   This sounds like a "good" thing, but from a real user perspective it's 
   actually horribly horribly bad. Knowing the difference between local 
   and remote is what allows a lot of performance optimizations, and a lot 
   of security. Your local repo is _yours_, and nobody can take that away 
   from you, and that's a really fundamental reason for why the symmetry 
   cannot exist, and why local/remote operations MUST NOT be something 
   that you can mix without thinking about them,

 - limit local operations in a way to make them effectively unusable and 
   unscriptable.

   You'd basically have to do everything even _locally_ through some 
   server interface, and you'd not be allowed to ever touch your local 
   checked-out repository directly. Again: local repositories really _are_ 
   special, because you can touch the checked out copy. If you try to 
   suppress that, you're screwed.

>  - clone for getting all branches of a repo, but no command for
>    updating all branches of a repo.  

As in sending? Sure there is: use "git push --all". It will push out every 
branch (and tag) you have. Add "--force" if you want to make sure that it 
also pushed out branches even if the result isn't a strict superset (of 
course, the receiving end may actually end up refusing to take it, there's 
a option for the receiver to say "I will refuse any update that isn't a 
strict superset of what I had").

If you mean as in "receiving new branches", then yeah, you do have to 
script it, with some fairly trivial "git ls-remote" to make sure you get 
the new remotes.


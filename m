X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 14:46:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:47:19 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32825>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpufq-0000Vb-2C for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031605AbWK3Wqb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031606AbWK3Wqa
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:46:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:5778 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031605AbWK3Wqa (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:46:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUMkOjQ017098
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 14:46:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUMkND6022630; Thu, 30 Nov
 2006 14:46:24 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Daniel Barkalow wrote:
> 
> I think the more obvious behavior is to have it record the fact that you 
> want to have the path tracked, but require one of the usual updating 
> mechanisms to get a particular content into the index.

While this certainly matches the git model better than just automatically 
taking whatever state exist at commit time (you instead introduce it as a 
special "empty state" case), I don't think you really want it.

Why? 

Two reasons:

 - you're still left with all the same issues (ie you do need to use "git 
   commit -a" because that is simply fundamental, and if you don't, "git 
   commit" now causes an ERROR, which is just illogical - you just added 
   the data!)

   So it's simply better to just tell people "git add" adds the whole 
   state. Explain to them that git doesn't track "filenames", it tracks 
   state, and when you do a "git add", it really adds the _data_ and the 
   permissions too.

   Really, if you didn't come from years of broken SCM's, you'd think that 
   it's _natural_ that when you add a file for tracking, you add its 
   contents too. It's not that git is surprising or unnatural, it's that 
   CVS is.

 - you generally really don't want to see "git diff" show you the big diff 
   for a new creation. You only think you do, but trust me, you generally 
   don't. It's the same thing as with doing merges - keeping the 
   automerged state in the index is actually nice, because it means that 
   the default "git diff" can just shut the heck up about the things that 
   may be the _bulk_ of the change, but it's not the interesting part.

So I would suggest that if people are irritated with "git diff" for 
example not showing newly added files AT ALL, then the solution to that 
isn't that they should be added as "empty" or "all zeroes". We do have 
other state bits in the index already (we need them for marking things as 
being unmerged etc), and if the problem is that you want to see that you 
have a pending add, it's easy enough to have "git add" always set a bit 
saying "this file is new".

A normal "read tree object" would populate index entries with that bit 
cleared, and so it would be possible to have

	git add file.c
	git diff

show something like

	diff --git a/file.c b/file.c
	added file <mode> <sha1>

rather than show the whole big diff (which I _really_ don't think you want 
to see, and which is actually against the whole point, which is that you 
add _content_ to the index, and "git diff" will always show you the stuff 
that is _not_ added to the index yet).

(Of course, if you _also_ had changed it between the "git add" and the 
"git diff", you'd get both the "added file <mode> <sha1>" _and_ the diff 
that is the diff between the thing you added, and the status it has now).

So showing a real diff after "git add" would really be wrong. The index 
really is important. But if it's _only_ an issue of worrying about seeing 
added files at all, we can add a "people comfort" bit to do that.

(Quite frankly, I don't think it's worthwhile. I really think this is a 
documentation issue. Make people understand that "git add" adds the 
contents too, and that git never tracks filenames on their own at all).

So it is always going to be true that

	git add file
	echo New line >> file
	git commit

must commit the old contents of the file. That really _does_ follow from 
the whole "track contents" model. Anything that doesn't do this is 
fundamnetally broken, and has broken the notion of what "git add" means.


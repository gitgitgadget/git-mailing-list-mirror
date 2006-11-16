X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Thu, 16 Nov 2006 11:01:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 19:01:38 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31618>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkmUN-0005jo-Cx for gcvg-git@gmane.org; Thu, 16 Nov
 2006 20:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424322AbWKPTB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 14:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424363AbWKPTB2
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 14:01:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4239 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1424322AbWKPTB1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 14:01:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGJ1FoZ022704
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 11:01:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGJ1EC9002341; Thu, 16 Nov
 2006 11:01:15 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Linus Torvalds wrote:
> 
> A "fetch" by default won't actually generate a local branch unless you 
> told it to. It just squirrels the end result into the magic FETCH_HEAD 
> name [...]

Btw, the magic heads are probably not all that well documented. They do 
come up in the man-pages, but I don't think there is any central place 
talking about them. We have:

 - "HEAD" itself, which is obviously the default pointer for a lot of 
   operations, and that specifies the current branch (ie it should 
   currently always be a symref, although we've talked about relaxing 
   that)

 - "ORIG_HEAD" is very useful indeed, and it's the head _before_ a merge 
   (or some other operations, like "git rebase" and "git reset": think of 
   it as a "original head before we did some uncontrolled operation 
   where we otherwise can't use HEAD^ or similar")

   I use "gitk ORIG_HEAD.." a lot, and if I don't like something I see 
   when I do it, I end up doing "git reset --hard ORIG_HEAD" to undo a 
   pull I've done. This is important exactly because ORIG_HEAD is _not_ 
   the same as the first parent of a merge, since a merge could have been 
   just a fast-forward.

 - "FETCH_HEAD" as mentioned. Normally you'd only use this in scripting, I 
   suspect, but it's potentially useful if you prefer to do a fetch first 
   and then check out it (perhaps cherry-picking stuff instead of merging, 
   for example).

   So you could do (for example)

	git fetch some-other-repo branch
	gitk ..FETCH_HEAD
	git cherry-pick <some-particular-commit-you-picked>

 - "MERGE_HEAD" is kind of the opposite of "ORIG_HEAD" when you're in 
   the middle of a merge: it's the "other" branch that you're merging.

   It's mainly useful for merge resolution, ie

	git log -p HEAD...MERGE_HEAD -- some/file/with/conflicts

   is a great way to see what happened along both branches (note the 
   _triple_ dot: it's a symmetric difference), to see _why_ the confict 
   happened.

Most of the above are used implicitly in various cases, not just HEAD. The 
"--merge" flag to git-rev-list (and thus git log and friends) is just 
shorthand for the above "HEAD...MERGE_HEAD" behaviour (with the addition 
of also limiting the result to just conflicting files), so

	git log -p --merge

is basically exactly the same as the above (except for _all_ files that 
have conflicts in them rather than just one hand-specified one).

Anyway, maybe somebody didn't know about these, and finds them useful. 
Normally, the only one you would _really_ use is "ORIG_HEAD" (which is 
described in several of the tutorials and examples, so people hopefully 
already know about it). Most of the others tend to mostly be used 
implicitly, not by explicitly naming them - although you _can_.


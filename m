From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 19:14:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org><Pi
 ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org><461D6432.90205@v
 ilain.net>   <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org><461D6858.4090
 007@vilain.net>  <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org><Pine.LNX.4.63
 .0704111600390.28394@qynat.qvtvafvgr.pbz> <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbope-00046g-E2
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbXDLCOj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbXDLCOj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:14:39 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41948 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161473AbXDLCOi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:14:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3C2EWVZ030693
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 19:14:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3C2EVPm020556;
	Wed, 11 Apr 2007 19:14:32 -0700
In-Reply-To: <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44312>



On Wed, 11 Apr 2007, David Lang wrote:
>
> On Wed, 11 Apr 2007, Linus Torvalds wrote:
> > 
> > It can be a nice space optimization, and yes, if there really is a lot of
> > shared state, it can make it much cheaper to do some of the checks, but
> > right now we have absolutely *no* way for fsck to then do the reachability
> > check, because there is no way to tell fsck where all the refs are (since
> > now the refs come in from multiple repositories!)
> 
> this is why I was suggesting a --multiple-project option to let you tell fsck
> about all of the repositories that it needs to look for refs in.

Well, just from a personal observation:
 - I would *personally* actually refuse to share objects with anybody 
   else.

I just find the idea too scary. Somebody doing something bad to their 
object store by mistake (running "git prune" without realizing that there 
are *my* objects there too, or just deciding that they want to play with 
the object directory by hand, or running a new fancy experimental importer 
that has a subtle bug wrt object handling or anything like that).

I'll endorse use "alternates" files, but partly because I know the main 
project is safe (any alternates usage is in the "satellite" clones anyway, 
and they will never write to the alternate object directory), and partly 
because at least for the kernel, we don't have branches that get reset in 
the main project, so there's no reason to fear that a "git repack -a -d" 
will ever screw up any of the satellite repositories even by mistake.

But for git projects, even alternates isn't safe, in case somebody bases 
their own work on a version of "pu" that eventually goes away (even with 
reflogs, pruning *eventually* takes place).

So I tend to think that alternates and shared object directories are 
really for "temporary" stuff, or for *managed* repositories that are at 
git *hosting* sites (eg repo.or.cz), and where there is some other safety 
involved, ie users don't actually access the object directories directly 
in any way.

So I've at least personally come to the conclusion that for a *developer* 
(as opposed to a hosting site!), shared object directories just never make 
sense. The downsides are just too big. Even alternates is something where 
you just need to be fairly careful!

		Linus

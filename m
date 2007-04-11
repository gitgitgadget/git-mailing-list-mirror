From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 08:16:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704110753360.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
 <20070411080641.GF21701@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 17:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbeYp-0007Ps-Ll
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 17:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753010AbXDKPQg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 11:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbXDKPQg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 11:16:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:48546 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbXDKPQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 11:16:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BFGBVZ010927
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 08:16:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BFGAmr006806;
	Wed, 11 Apr 2007 08:16:10 -0700
In-Reply-To: <20070411080641.GF21701@admingilde.org>
X-Spam-Status: No, hits=-0.956 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44241>



On Wed, 11 Apr 2007, Martin Waitz wrote:
> 
> I only had little time to actually have a look at it but the core is
> very similiar to my approach and I'll try to rebase some of my code on
> top of yours in the following days.
> 
> The only thing I disagree with you is in using HEAD of the submodule:

Well, I don't actually see much choice. HEAD is just shorthand for 
"whatever is checked out".

> Always using HEAD of the submodule makes branches in the submodule
> useless.

No. 

Branches in submodules actually in many ways are *more* important than 
branches in supermodules - it's just that with the CVS mentality, you 
would never actually see that, because CVS obviously doesn't really 
support such a notion.

So I'd argue that branches in submodules give you:

 - you can develop the submodule *independently* of the supermodule, but 
   still be able to easily merge back and forth.

   Quite often, the submodule would be developed entirely _outside_ of the 
   supermodule, and the "branch" that gets the most development would thus
   actually be the "vendor branch", entirely outside the supermodule. Call 
   that the "main" branch or whatever, inside the supermodule it would 
   often be something like the remote "remotes/origin/master" branch.

   So inside the supermodule, the HEAD would generally point to something 
   that is *not* necessarily the "main development" branch, because the 
   supermodule maintainer would quite logically and often have his own 
   modifications to the original project on that branch. It migth be a 
   detached branch, or just a local branch inside the submodule.

 - branches inside submodules are *also* very useful even inside the 
   supermodule, ie they again allow topic work to be fetched into the
   submodule *without* having to actually be part of the supermodule,
   or as a way to track a certain experimental branch of the supermodule.

   I suspect that most supermodule usage is as an "integrator" branch, 
   which means that the supermodule tends to follow the "main 
   development", and the whole point of the supermodule is largely to have 
   a collection of "stable things that work together". 

   In contrast, branches within submodules are useful for doing all the 
   development that is *not* yet ready to be committed to the supermodule, 
   exactly because it's not yet been tested in the full "make World" kind 
   of situation.

> Whenever you do a checkout in the supermodule you also have to update
> the submodule and this update has to change the same thing which is read
> above.

I suspect (but will not guarantee) that the right approach is that a 
supermodule checkout usually just uses a "detached HEAD" setup. Within the 
context of the supermodule, only the actual commit SHA1 matters, not what 
branch it was developed on (side note: I haven't decided if we should 
allow the SHA1 to be a signed tag object too - the current patches 
obviously don't care since they never follow the SHA1 anyway, and it might 
be a good idea).

So I strongly suspect (and that is what the patch series embodies) that as 
far as the supermodule is concerned, it should *not* matter at all what 
branch the subproject was on. The subproject can use branches for 
development, and the supermodule really doesn't care what the local 
branchname was when a commit was made - because branch-names are *local* 
things, and a branch that is called "experimental" in one environment 
might be called "master" in another.

So once the commit hits the superproject, the branch identities just go 
away (only as far as the superproject is concerned, of course - the 
subproject still stays with whatever branches it has), and the only thing 
that matters is the commit SHA1.

> Updating the branch which HEAD points to is dangerous.

I would strongly suggest that the *superproject* never really change the 
status of the subproject HEAD, except it updates it for "pull/reset", and 
then it just would use whatever the subproject decided to use.

The subproject HEAD policy would be entirely under the control of the 
subproject. If the subproject wants to use a branch to track the 
superproject, go wild: have a real branch that is called "my-integration" 
and make HEAD a symref to that (and thus any work in the superproject will 
update that branch - something that is visible when you pull directly from 
that subproject!)

But quite often, I suspect that a subproject would just use a detached 
HEAD. The subproject may have branches of its own, of course, but you can 
think of HEAD as not being connected to any of it's "own" branches, but 
simply being the "superproject branch". That's a fairly accurate picture 
of reality, and using "detached HEAD" sounds like a very natural thing to 
do in that situation.

So I really think you can do both, and I think using HEAD inside the 
superproject gives you exactly that flexibility - you can decide on a 
per-subproject basis whether HEAD should track a real local branch in a 
subproject, or whether it should be detached.

(Side note: if you do *not* use detatched HEAD, I suspect the .gitmodules 
file could also contain the branchname to be used for the subproject 
tracking, but I think that's a detail, and quite debatable)

> So my advice is:
> Always read and write one dedicated branch (hardcoded "master" or
> configurable) when the supermodule wants to access a submodule.

So the main reasons I don't think that is a good idea are:

 - it's less flexible: see above on why you might want to use a dedicated 
   branch *or* just detached HEAD, and why you might want to choose your 
   own name for the dedicated branch.

 - it's also going to be quite confusing when the superproject sees 
   something *else* than what is actually checked out. This is an equally 
   strong argument for just using HEAD - when we actually implement a

	 git diff --subproject

   flag that recurses into the subproject, if you don't use HEAD inside 
   the subproject, that suddenly becomes a *very* confusing thing.

In other words, I really think HEAD is absolutely the right thing to use, 
but that said, I obviously wrote "resolve_gitlink_ref()" so that it can 
take any ref-name, and we *can* change that later, or make it a per-module 
config option or whatever.

		Linus

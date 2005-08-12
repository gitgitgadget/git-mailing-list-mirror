From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 23:17:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508112256430.12816@iabervon.org>
References: <42F8D472.3080404@de.bosch.com> <20050811223349.GI25280@pasky.ji.cz>
 <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net> <20050812024552.GO25280@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 05:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Q0L-0006oq-FU
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 05:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVHLDOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 23:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVHLDOm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 23:14:42 -0400
Received: from iabervon.org ([66.92.72.58]:26893 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750773AbVHLDOm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 23:14:42 -0400
Received: (qmail 17053 invoked by uid 1000); 11 Aug 2005 23:17:55 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Aug 2005 23:17:55 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050812024552.GO25280@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 12 Aug 2005, Petr Baudis wrote:

> Dear diary, on Fri, Aug 12, 2005 at 01:21:46AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> told me that...
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > $ git-cat-file commit bf570303153902ec3d85570ed24515bcf8948848 | grep tree
> > > tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> > > $ git-read-tree 41f10531f1799bbb31a1e0f7652363154ce96f45
> > > fatal: failed to unpack tree object 41f10531f1799bbb31a1e0f7652363154ce96f45
> > 
> > > Kaboom. I think the issue might be that the reference dependency tree
> > > building is broken and it should've pulled the other pack as well.
> > 
> > Last time I checked, git-http-pull did not utilize the pack
> > dependency information, which indeed is wrong.  When it decides
> > to fetch a pack instead of an asked-for object, it should check
> > which commits the pack expects to have in your local repository
> > and add them to its list of things to slurp.
> > 
> > A good news is that "git clone" as a whole works fine.
> 
> Yes, but cg-clone doesn't - it naively depended on the core git tools
> actually, er.. working. ;-)
> 
> This became a nightmare to me by now - on two machines I tried to pull
> to over HTTP, that failed miserably, and I got stuck until I applied
> Daniel's patch there (and cleaned up after previous git-http-pulls).
> 
> So I have this packless git-pb repository and suspecting no evil, I pull
> from you (thankfully I have .git/objects/pack there from some historical
> pulls). I do a merge commit:
> 
> 	packed
> 	 ... J
> 	packed \
> 		 > M
> 	       /
> 	 ... P
> 
> Now I want to pull on another machine. That pulls M and then fails since
> I have no .git/objects/pack there, bummer. So I mkdir it, but get no
> further w/o Daniel's patch - for git-*-pull, J is missing and that's it.
> So I apply the patch, and get friendly
> 
> 	error: Unable to determine requirements of type (null) for M
> 
> and only after I delete M from the database, I finally succeed with
> git-http-pull. (That was with --repair.) That's not good since this
> might occur even naturally when the pull is interrupted.

Insufficient testing on my part; patch at the end.

> With git-ssh-pull, the situation is even more vexing - it refuses to
> fetch the packs for some reason yet unknown to me (I will debug it
> tomorrow).

git-ssh-pull doesn't deal in packs; it gets individual objects out of 
packs, which git-ssh-push (on the remote side) should be extracting. 
Perhaps you have a git-ssh-push on the remote side that's before I make 
packs work (it used to need to have the files for objects it was sending). 

At some point, I have to revisit getting git-ssh-* to generate exactly the 
required pack and transfer that, but that's an efficiency issue, not a 
correctness one, and shouldn't be relevant to the problem you're having.

---
[PATCH] Also parse objects we already have

In the case where we don't know from context what type an object is, but
we don't have to fetch it, we need to parse it to determine the type
before processing it.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 pull.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

b8c382e76da25f45ff86176a6a6affdd9a28d60b
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -127,6 +127,7 @@ static int process(unsigned char *sha1, 
 {
 	struct object *obj = lookup_object_type(sha1, type);
 	if (has_sha1_file(sha1)) {
+		parse_object(sha1);
 		/* We already have it, so we should scan it now. */
 		return process_object(obj);
 	}

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 16:39:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> 
 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> 
 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> 
 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Oct 11 01:39:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifl9J-0007uE-1z
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992AbXJJXjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756982AbXJJXjY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:39:24 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45155 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756239AbXJJXjW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2007 19:39:22 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9ANdJx0026519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Oct 2007 16:39:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9ANdJbH031663;
	Wed, 10 Oct 2007 16:39:19 -0700
In-Reply-To: <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com>
X-Spam-Status: No, hits=-2.429 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_24
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60569>



On Wed, 10 Oct 2007, Han-Wen Nienhuys wrote:
> 
> The way I solved that, was to have both repositories pointing to each
> other, using alternates.

Ouch. Double un-good. Not a good idea. Especially not if you do 
development in both and pull and push between them. 

What will happen is that if you do alternates pointing both ways, you 
basically end up having a "shared pool of objects". So it's pretty much 
equivalent to just using a shared object directory, and it has *exactly* 
the same issues with object reachability and references: you have a shared 
pool of objects, but you only ever see *one* set of references, so garbage 
collection cannot work - because it will always see just a subset of the 
real references, while it sees essentially all objects.

> could it be that GC does not handle cyclic alternates correctly?

It's not about cyclic per se: it's about the fact that GC will do garbage 
collection based on reachability with the local references.

Which is normally fine. It's normally fine, because the object tree is 
"local" too. But when doing alternates:

 - the tree that is being used as an alternate *has* to be totally stable. 
   It must *never* have been re-based, or have any GC'able objects in the 
   first place. IOW, doing a "git gc" on it will be safe, because there is 
   no way any objects that the other alternate depends on could be pruned.

 - You definitely must *not* do a two-way alternate, because that violates 
   another rule: the rule that the "alternate base" (which is now *both*
   of the repositories) is self-sufficient. Since they both point to each 
   other, there's no way to know whether they are self-sufficient or not: 
   they may be re-using each others objects *and* packs!

And in the above, the "*and* packs" is important, and probably the cause 
of your problems. Because "git repack -a -d -l" (which is what "git gc" 
does) will always gather up any loose objects even from remote sites, but 
the "-l" means that it will not do so for alternate packed objects.

So what happens is that if one of the repositories can reach some object 
that is in a pack in the other repository, "git gc" will still *leave* it 
dependent on a pack in the other repository. But maybe that object isn't 
even reachable in the other repo any more (for whatever reason - a rebase, 
whatever), then when you repack the other repository, now all the packs 
will be replaced by one new pack - and the one new pack will only contain 
the objects reachable from the other repo.

IOW: alternates are dangerous. A shared object directory is dangerous. You 
should basically only do it under very controlled circumstances, and 
otherwise you should use either hardlinks or if you want added safety, 
totally separate repositories.

Basically, here's an example of badness, with A and B being repos that 
point to each other.

 - do something in A
 - pull it into B - this leaves the objects in A, because of the 
   alternates link.
 - rebase A
 - "git gc" in A: this removes unreachable objects from A, and now B is 
   screwed.

So the rule really is: never *ever* do anything but fast-forward in a repo 
that is an alternate for another one. If you do a circular link, I think 
it's still safe if you follow that rule, but now obviously the rule holds 
for *both* repos (and quite frankly, I'd worry so much that I'd never do 
it even then).

There should be another rule too: git on its own is not a backup system. 
You can use git *as* a backup system, but you need to do so by mirroring 
the whole repository, and not on the same disk.

(ie, for me, git *is* a backup system, but that's only because I push my 
repos to other sites - a single git repo on its own has zero redundancy)

		Linus

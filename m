From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: confused about a conflict during octopus merging
Date: Mon, 8 Oct 2007 18:21:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710081812200.4964@woody.linux-foundation.org>
References: <20071009003156.GA30498@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 09 03:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If3o9-0007cR-Nz
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 03:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbXJIBWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 21:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbXJIBWj
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 21:22:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33956 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751671AbXJIBWi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 21:22:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l991LpEO013283
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2007 18:21:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l991Lpkp028376;
	Mon, 8 Oct 2007 18:21:51 -0700
In-Reply-To: <20071009003156.GA30498@lapse.madduck.net>
X-Spam-Status: No, hits=-2.735 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60349>



On Tue, 9 Oct 2007, martin f krafft wrote:
> 
> I am a little confused why the following yields a conflict:

Octopus merges are special. Don't use them unless you really know what 
you're doing. And generally not even then ;)

> $ git merge master second
> Trying simple merge with bb5f1b4f3a8cbfcbc9dbc97cc823f3ca05db2db1
> Trying simple merge with 7370737ff3aa6540a425db015e194766d2cbda2e
> Simple merge did not work, trying automatic merge.
> Added d in both, but differently.
> error: Could not read .merge_file_mCwa4W
> ERROR: Merge conflict in d
> fatal: merge program failed
> Automatic merge failed; fix conflicts and then commit the result.
> 
> I don't understand why these conflict. I mean, sure, it makes sense:
> after merging master, file d is at d2. Now when merging second, it
> tries to replace d by its ancestor, d1.

Right. It makes total sense, because an octopus merge is simply always 
going to create a whole new merge commit that goes through the sources one 
by one, and merges them in - and if you do that, then you get a conflict 
in "d".

> What I don't understand is why Git does not understand that commit
> d is part of the path of arriving at d2, so when 'second' is merged,
> Git *should* really see that the change to file d in 'second' (d1)
> is an ancestor of the already present d2 commit, and *not* conflict.
> 
> What am I misunderstanding here?

Octopus merges do *not* fast-forward. Maybe they should. But they don't.

So when the octopus merge starts merging in "master" into the "merger" 
branch, it will *not* just fast-forward the branch to "master". Instead, 
if will generate a new tree that is basically the merged state: but that 
new tree is *not* the same as the master commit, it's literally a merge of 
the two branches - which in practice means that it has the same *content* 
as master, but it's not at that commit.

So that first stage of the octopus merge has gone fine, but it didn't 
really do what you expected.

And so now we have a half-way done octopus merge, with the first branch 
added. Now it merges in the second branch ("second"), and it *still* has 
the merge base being the original merge base, namely "merger".

And from that standpoint, it really *is* a conflict. 

I do think that 
 - octopus merges should probably refuse to happen when a branch isn't a 
   "merge" at all, but a fast-forward.
*or*
 - we should make octopus-merges smarter, and for each branch that is a 
   fast-forward, it really just fast-forwards.

but I don't think the current behaviour is "wrong", it's just not what you 
expected.

If you think of octopus merges as a really stupid thing where git will 
mindlessly do a three-way merge based on the *current* state with all the 
branches you name, then you get the current octopus merge. You just 
expected it to be smarter than it is, probably because you compare it to 
the *real* merge.

		Linus

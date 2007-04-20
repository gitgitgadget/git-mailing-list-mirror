From: Steven Grimm <koreth@midwinter.com>
Subject: Using git to bridge two svn repositories: a success story
Date: Thu, 19 Apr 2007 21:12:52 -0700
Message-ID: <46283DC4.7070604@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 20 06:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HekUW-00009Q-1Q
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 06:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbXDTEM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 00:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbXDTEM4
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 00:12:56 -0400
Received: from tater.midwinter.com ([216.32.86.90]:34107 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754393AbXDTEMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 00:12:55 -0400
Received: (qmail 17111 invoked from network); 20 Apr 2007 04:12:55 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Zv4EdA24FQoWqCTzELScowEuvz1kCLuEWC0xZyUjvYmMrcu0LTFqxOhuOkRVRa/Z  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 20 Apr 2007 04:12:55 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45060>

I complain too much of the time on this list, so here's a success story 
I can share for a change. I just used git to merge two separate svn 
repositories: the official repo for an open-source program and an 
internal repo with our locally-modified version of the same program. The 
local copy has been tracking the official one off and on over time; it 
has a bunch of changes that were contributed back to the official code 
base at various points, other changes that weren't, and some directory 
layout changes to accommodate our internal build system.

We had fallen fairly far behind the official version, so yesterday I 
decided to bring us up to date. Not a trivial merge; various of our 
changes had been applied to different branches in the official svn 
repository, which had gotten merged back into their trunk at various 
points. In many cases local change A appeared before remote change B in 
our history but in the opposite order in the official repo since they 
committed our change after the other one.

Obviously svn is nowhere near adequate to the task of normalizing these 
two code bases. So I used git instead, and it worked out great. 
Specifically, here's what I did, minus a few false starts:

1. Made two git-svn repositories, one based on our local code base and 
one based on the official svn repository.

2. Created a git repository and pulled from both of the git-svn repos. 
(I know I could have done this with one repo instead of three, but I 
wanted to make sure I could easily blow away one of the parts of this 
and start over.)

3. Added a couple of .git/info/grafts entries for places where I knew 
the original project had merged branches back into trunk, but where 
git-svn hadn't detected the merge. Probably not git-svn's fault, given 
how brittle merging is in svn and the fact that a couple of the merges 
were split across multiple svn revisions.

4. Found an early point in our history when we had a fairly close to 
unmodified copy of the distribution at the time and created a branch 
from that revision.

5. Renamed the files from our layout back to the distribution's. (I'll 
talk more about this below.)

6. Did a baseless merge with the corresponding revision of the 
distribution's history. Resolved the conflicts, which weren't too severe 
thanks to step 4.

7. Walked through the revision history on both sides merging into my 
integration branch. I was more cautious about this than I probably 
needed to be (though more on that below too); my approach was to merge 
up to a particular change on our side that I knew we'd contributed 
upstream, then merge up to the corresponding revision on the official 
side, repeat until done. In cases where our stuff had been integrated 
into a branch in the official repo, I followed that branch rather than 
trunk for the most part. I ended up walking three branches plus trunk.

8. Once I had merged the last of our local changes, I merged the head of 
the official trunk into my integration branch, picking up a bunch of 
official revs in one step.

9. Renamed everything back to our naming conventions.

This was kind of an iterative process and the main reason I did it 
incrementally at first was mostly to limit the amount of conflict 
resolution at any one step, as well as to make sure that each of our 
contributions had in fact been merged correctly. (I wrote most of the 
code we contributed so I was able to quickly tell if it looked right.)

The gitk display for this repo looks like a ladder; nearly every 
revision of my integration branch is a merge.

Now, about those renames. The major change in structure was to rename 
the source directory from "server" in the official repository to "src" 
which our build system expects. So before I did any merges, I committed 
a revision where I did "git mv src server" (along with a couple other 
similar renames) so there'd be an explicit rename-only revision for 
git's rename detection to use to apply changes to the right files.

Unfortunately, that broke down as soon as I got to a contribution of 
ours that added a new file. I merged the contribution on our side (where 
everything lives in src/), and it correctly applied the modifications to 
the existing files in server/ thanks to the renames in the history. But 
the new files were created in src/. I didn't notice the file missing 
from server/ at first, and merged the revision from the official repo 
that created the same file there. The new file was identical on both 
sides, so I didn't think it was odd that there wasn't a conflict, and 
proceeded to the next rev. It was only after several more revisions 
merged from both sides that I noticed the server/ copy of the file was 
missing changes I'd sworn I'd just merged from our side. Naturally all 
our local changes were getting successfully applied to the copy in src/ 
and all the changes from the official repo were showing up in the 
server/ copy.

So I ended up resetting back to the first revision that created a new 
file in src/, and making sure I stopped at each revision that introduced 
a new file there so I could commit an extra revision after the merge to 
manually rename it into server/. Then the subsequent merge with the 
revision that created the file in server/ would correctly flag any 
differences between the two versions as conflicts, and I could go 
through and do the right thing with them. There were only three or four 
such cases so it wasn't too much extra work.

The only other glitch I ran into was missing one merge from the official 
svn repository when I created my grafts file. That caused me to get a 
bunch of repeat conflicts when I merged the subsequent svn trunk 
revision. But I immediately realized what was happening there; I reset, 
added the missing merge to my grafts file, and did the merge again, and 
the repeat conflicts went away.

Aside from those two minor things, it was a painless exercise, and now I 
have a reasonably coherent (if a bit convoluted) combined history of the 
two versions of the code base without the svn repositories on either 
side being aware of each other. I plan to keep all these git 
repositories around so I can quickly integrate subsequent changes from 
both sides.

So, kudos all around. Without git this would have been a much more 
time-consuming and error-prone exercise!

-Steve

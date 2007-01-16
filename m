From: Steven Grimm <koreth@midwinter.com>
Subject: [RFC] Replace rebase with filtering
Date: Mon, 15 Jan 2007 18:41:33 -0800
Message-ID: <45AC3B5D.6080700@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jan 16 03:42:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6eHA-0008D9-EU
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 03:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbXAPCld (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 21:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbXAPCld
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 21:41:33 -0500
Received: from tater.midwinter.com ([216.32.86.90]:51521 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751436AbXAPClc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 21:41:32 -0500
Received: (qmail 19481 invoked from network); 16 Jan 2007 02:41:31 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=XVsWddKzJhIxL5r2CEXSSE7QxOMjhpdhpG4zP3INddYgoz8a6zeE23NhKBqPjevN  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 16 Jan 2007 02:41:31 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36911>

Blanket request, so I don't have to keep repeating it: Please correct me 
if I'm wrong about anything below. I'm more familiar with git than I was 
a month ago, but still not an expert, so I could be totally off (re)base 
here. With that note of confidence...

We have a setup like this:

    (external)
        |
   local master
        |
   integration
  /     |     \
dev1   dev2  dev3

We pull changes from the external repository (actually a Subversion 
repo) into a local master. The integration repo is a clone of that. 
That's our local setup, but the particulars don't matter here -- I'm 
just using it as an example.

Ideally, we'd rebase the integration area against changes pulled from 
master, then each dev repository would rebase against the changes from 
the integration area. That would keep our histories nice and clean as we 
pull changes down from the external repository.

But of course rebase will get confused and we'll end up re-applying 
changes in the dev sandboxes as soon as there are any existing change in 
the integration repo when we pull changes from master, because rebase 
will turn those existing changes into new revisions that don't match any 
previously known ones in the dev repositories.

So at the moment, as far as I can see, the only option is to use merge 
rather than rebase everywhere but the leaf nodes of our repository tree, 
and just live with the cluttered history. The developers will at least 
have clean *local* histories, but they'll be rebasing onto a cluttered 
history from the integration repo.

However, they may not want to, even if they can: as soon as I rebase, 
unless everyone is very careful, I have just prevented other developers 
from pulling my local commits into their local repositories before I've 
pushed my stuff up to the integration area. Sibling-to-sibling pulls  -- 
which I hope we all agree are a very useful feature of systems like git 
-- have exactly the same rebase problem as parent-to-child pulls: you'll 
end up re-applying the same changes if the target repo had an earlier 
version of a newly-rebased chain of commits. So even in our development 
repos, I suspect we'll want to avoid rebasing unless we're certain we 
won't ever need to share changes directly with each other, and just live 
with the clutter.

All of which made me think, gee, it'd sure be nice if there was a way to 
filter out those excess merges when we view our branch history. I think 
all it would take would be to mark a merge commit as a rebase-ish update 
(rather than an actual integration where the merge itself is an event 
that's important to us) and you could, if the user chose, discard those 
merges from views of the branch history.

And then it occurred to me: if we had that, would we actually need 
rebase at all? As far as I know, rebase is all about aesthetics, not 
functionality; the reason you rebase instead of merge is that you don't 
want to wade through zillions of irrelevant merges when you browse your 
project's history. But if those merges are simply not shown to you, it 
shouldn't matter that they exist. Yes, you will have more objects in 
your index, but with git's delta compression, you might not even notice 
the difference.

Rebase has an interesting undesirable property aside from messing up 
downstream clones when they try to pull your latest changes. Since 
rebase preserves the timestamps on your local commits, you almost always 
end up with a situation where the history says almost all your local 
commits happened before the commit they claim to have been branched 
from. That's not too big a problem in most cases, but it sure isn't very 
clean. The underlying problem is that when you rebase you lose not only 
the history of your intermediate updates, but also the history of your 
original branch creation.

Filtering rather than rewriting history would fix all of that. We could 
easily report that branch XYZ was forked from branch ABC on 01/03/2006 
and is up to date with all of ABC's changes up to 01/18/2006 (i.e., 
display information about the initial branch and the most recent update 
merge, but none of the ones in between.) The timestamps all make sense 
because you haven't lost the history. And if someone has cloned your 
repository, they can keep pulling updates without anything breaking.

It might also, be possible to implement an after-the-fact rebase to 
reduce the number of excess commits: a command that rebases all the 
update merges older than a certain age, on the theory that you can 
usually put an upper bound on how out-of-date someone's clone of your 
repo is allowed to get. That would rewrite just the ancient history, not 
touching anything recent, and would mark the newly-created revisions 
such that pull could skip fetching them if the target already has the 
more recent revisions. (The revision at which you stop rebasing should 
end up with the same revision ID as the one in the actual history, since 
the contents should match.) If that's not clear I can draw a picture. 
Haven't thought that bit through too much so it might not be feasible in 
the end, but it seems like in theory we have all the information we need 
to resolve conflicts, etc.

Comments? Am I fundamentally misunderstanding how rebase works and/or 
why the documentation warns people away from using it in repos that 
might be pulled from?

-Steve

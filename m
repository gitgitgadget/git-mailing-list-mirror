From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: History cleanup/rewriting script for git
Date: Fri, 20 Apr 2007 11:54:46 -0400
Message-ID: <20070420155446.GA11506@delft.aura.cs.cmu.edu>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com> <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <Pine.LNX.4.64.0704191118050.8822@racer.site> <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 18:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HevzU-0008Lm-1J
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 18:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993261AbXDTQ3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 12:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993269AbXDTQ3l
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 12:29:41 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:59791 "EHLO
	delft.aura.cs.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993261AbXDTQ3k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 12:29:40 -0400
X-Greylist: delayed 2089 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Apr 2007 12:29:39 EDT
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1HevRe-00015a-UW; Fri, 20 Apr 2007 11:54:46 -0400
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45114>

On Thu, Apr 19, 2007 at 09:43:50AM -0700, Linus Torvalds wrote:
> On Thu, 19 Apr 2007, Johannes Schindelin wrote:
> > Hmm. However, I have to say that cogito serves/d another purpose quite 
> > well: Look at what came from cogito into git. Loads of useful 
> > enhancements. So, I really have to point to "at this stage", because that 
> > sure was not true 18 months ago.
> 
> Absolutely. I think there are still some pieces of cogito that we might 
> want to migrate into git too, although they're fairly esoteric (ie the 
> whole history rewriting thing). And I think we still have some places 

I actually have a fairly simple history rewriting script (written in python)
that I used when I converted some CVS archives to git. It is really intended
for such an initial import and history cleanup case so it doesn't deal with
reflogs and such.

Basic workflow I used is,

- Import CVS archive into a git repository
- Use gitk + the grafts file to clean up history as much as feasible
- Run git-rewrite-history.py which will
    - write out new commit objects with the corrected set of parents
    - copy existing refs to .git/newrefs, pointing them at the new commits.

- start gitk --all to see the tree before the rewrite.
- mv .git/refs .git/oldrefs ; mv .git/newrefs .git/refs
- start a second gitk --all to see the tree after the rewrite.
- compare gitk output to check if everything matches up.

- run git repack/prune/gc to get rid of the old commits, or clone the repo.

Jan

--8<-----------------------------------------------------------------------

#!/usr/bin/python

import os, sys

def git_write_object(type, blob):
    stdin, stdout = os.popen2("git-hash-object -t %s -w --stdin" % type)
    stdin.write(blob)
    stdin.close()
    return stdout.readline().strip()

def git_commits(branch):
    f = os.popen('git-rev-list --parents --header --topo-order %s' % branch)
    buf = ''
    while 1:
	buf = buf + f.read(4096)
	if not buf: break
	if not '\0' in buf: continue
	commit, buf = buf.split('\0', 1)
	yield Commit(commit)

def git_update_ref(name, hash):
    os.system('git-update-ref "%s" "%s"' % (name, hash))

grafts = []
pending = []
rewriteable = []
remap = {}
todo = 0
class Commit:
    def __init__(self, commit):
	global grafts
	lines = commit.split('\n')
	parts = lines.pop(0).split()
	self.hash, self.parents = parts[0], parts[1:]

	self.tree = lines.pop(0)

	parents = []
	while lines[0][:7] == 'parent ':
	    parents = parents + lines.pop(0).split()[1:]

	if parents != self.parents:
	    grafts.append(self.hash)

	commit = []
	while 1:
	    line = lines.pop(0)
	    commit.append(line)
	    if not line: break

	for line in lines:
	    commit.append(line[4:])
	self.commit = '\n'.join(commit)

	self.wait = 0
	self.children = []

    def mark(self):
	global todo, pending
	self.wait = self.wait + 1
	if self.wait == 1:
	    todo = todo + 1
	    for child in self.children:
		pending.append(child.hash)

    def pick(self):
	global rewriteable
	self.wait = self.wait - 1
	if not self.wait:
	    rewriteable.append(self)

    def fixup(self, old_hash, new_hash):
	i = self.parents.index(old_hash)
	self.parents[i] = new_hash
	self.pick()

    def rehash(self):
	global todo, remap
	todo = todo - 1

	blob = self.tree + '\n'
	for parent in self.parents:
	    blob = blob + 'parent %s\n' % parent
	blob = blob + self.commit

	new_hash = git_write_object('commit', blob)
	remap[self.hash] = new_hash

	for child in self.children:
	    child.fixup(self.hash, new_hash)

print "Reading commits... ",
commits = {}
for commit in git_commits('--all'):
    commits[commit.hash] = commit
print "read %d commits, found %d grafts" % (len(commits), len(grafts))

print "Setting up reverse linkage"
for commit in commits.values():
    for parent in commit.parents:
	commits[parent].children.append(commit)

print "Propagating graft information... ",
# first mark all commits that will have to be rewritten.
for commit in grafts:
    commits[commit].mark()

for commit in pending:
    commits[commit].mark()

# pick those commits that do not depend on any earlier rewrites
for commit in grafts:
    commits[commit].pick()
print "%d commits need to be rewritten" % todo

print "Rewriting commits... "
while rewriteable:
    print "\rrewriting %5d/%5d commits" % (len(rewriteable), todo),
    rewriteable.pop().rehash()
print "done..."

print "Rewriting refs..."
for ref in os.popen('git-for-each-ref'):
    hash, type, name = ref.split()
    if type != 'commit': continue

    if remap.has_key(hash):
	hash = remap[hash]

    # write updated refs to .git/newrefs
    git_update_ref('new' + name, hash)

print "done..."

From: Christopher Li <git@chrisli.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 14:51:22 -0400
Message-ID: <20050414185122.GA25468@64m.dyndns.org>
References: <20050413212546.GA17236@64m.dyndns.org> <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 23:59:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCLg-0004it-87
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 23:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVDNWBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDNWBa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:01:30 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:51853 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261389AbVDNWBX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:01:23 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005041422012201400g64jde>; Thu, 14 Apr 2005 22:01:23 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 1C5E83F1EF; Thu, 14 Apr 2005 14:51:23 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 11:12:35AM -0700, Junio C Hamano wrote:
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> At this moment in the script, we have run "read-tree" the
> ancestor so the dircache has the original.  %tree0 and %tree1
> both did not touch the path ($_ here) so it is the same as
> ancestor.  When '-f' is specified we are populating the output
> working tree with the merge result so that is what that
> 'checkout-cache' is about.  "O - $path" means "we took the
> original".
> 
> The idea is to populate the dircache of merge-temp with the
> merge result and leave uncertain stuff as in the common ancestor
> state, so that the user can fix them starting from there.
> 
> Maybe it is a good time for me to summarize the output somewhere
> in a document.
> 
>     O - $path	Tree-A and tree-B did not touch this; the result
>                 is taken from the ancestor (O for original).
> 
>     A D $path	Only tree-A (or tree-B) deleted this and the other
>     B D $path   branch did not touch this; the result is to delete.
> 
>     A M $path	Only tree-A (or tree-B) modified this and the other
>     B M $path   branch did not touch this; the result is to use one
>                 from tree-A (or tree-B).  This includes file
>                 creation case.
> 
>     *DD $path	Both tree-A and tree-B deleted this; the result
>                 is to delete.
> 
>     *DM $path   Tree-A deleted while tree-B modified this (or
>     *MD $path   vice versa), and manual conflict resolution is
>                 needed; dircache is left as in the ancestor, and
>                 the modified file is saved as $path~A~ in the
>                 working directory.  The user can rename it to $path
>                 and run show-diff to see what Tree-A wanted to do
>                 and decide before running update-cache.
> 
>     *MM $path   Tree-A and tree-B did the exact same
>                 modification; the result is to use that.
> 
>     MRG $path   Tree-A and tree-B have different modifications;
>                 run "merge" and the merge result is left as
>                 $path in the working directory.
> 
> In cases other than *DM, *MD, and MRG, the result is trivial and

I believe there is simpler way to do it as in my demo python script.
I start it easier but you bits me in time. It is a demo script, it
only print the action instead of actually going out to do it.
change that to corresponding os.system("") call leaves to the reader.

Again, this is a demo how it can be done. Not python vs perl thing
I did not chose perl only because I am not good at it.

#!/usr/bin/env python

import re
import sys
import os
from pprint import pprint

def get_tree(commit):
    data = os.popen("cat-file commit %s"%commit).read()
    return re.findall(r"(?m)^tree (\w+)", data)[0]

PREFIX = 0
PATH = -1
SHA = -2
ORIGSHA = -3

def get_difftree(old, new):
    lines = os.popen("diff-tree %s %s"%(old, new)).read().split("\x00")
    patterns = (r"(\*)(\d+)->(\d+)\s(\w+)\s(\w+)->(\w+)\s(.*)",
		r"([+-])(\d+)\s(\w+)\s(\w+)\s(.*)")
    res = {}
    for l in lines:
	if not l: continue
	for p in patterns:
	    m = re.findall(p, l)
	    if m:
		m = m[0]
		res[m[-1]] = m
		break
	else:
	    raise "difftree: unknow line", l
    return res

def analyze(diff1, diff2):
    diff1only = [ diff1[k] for k in diff1 if k not in diff2 ]
    diff2only = [ diff2[k] for k in diff2 if k not in diff1 ]
    both = [ (diff1[k],diff2[k]) for k in diff2 if k in diff1 ]

    action(diff1only)
    action(diff2only)
    action_two(both)

def action(diffs):
    for act in diffs:
	if act[PREFIX] == "*":
	    print "modify", act[PATH], act[SHA]
	elif act[PREFIX] == '-':
	    print "remove", act[PATH], act[SHA]
	elif act[PREFIX] == '+':
	    print "add", "remove", act[PATH], act[SHA]
	else:
	    raise "unknow action"

def action_two(diffs):
    for act1, act2 in diffs:
	if len(act1) == len(act2):	# same kind type
	    if act1[PREFIX] == act2[PREFIX]:
		if act1[SHA] == act2[SHA] or act1[PREFIX] == '-': 
		    return action(act1)
	    	if act1[PREFIX]=='*':
		    print "3way-merge", act1[PATH], act1[ORIGSHA], act1[SHA], act2[SHA]
		    return
	print "unable to handle", act[PATH]
	print "one side wants", act1[PREFIX]
	print "the other side wants", act2[PREFIX]
	
    
args = sys.argv[1:]
trees = map(get_tree, args)
print "check out tree", trees[0]
diff1 = get_difftree(trees[0], trees[1])
diff2 = get_difftree(trees[0], trees[2])
analyze(diff1, diff2)


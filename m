From: Christopher Li <git@chrisli.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 16:37:17 -0400
Message-ID: <20050414203717.GE25468@64m.dyndns.org>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <20050414203013.GD25468@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:44:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DME0K-0008O4-5r
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVDNXre (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbVDNXre
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:47:34 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:7574 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261658AbVDNXrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:47:19 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2005041423471701400hmhvle>; Thu, 14 Apr 2005 23:47:18 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 41E6A3F1EF; Thu, 14 Apr 2005 16:37:17 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050414203013.GD25468@64m.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is that some thing you want to see? Maybe clean up the error printing.


Chris

--- /dev/null	2003-01-30 05:24:37.000000000 -0500
+++ merge.py	2005-04-14 16:34:39.000000000 -0400
@@ -0,0 +1,76 @@
+#!/usr/bin/env python
+
+import re
+import sys
+import os
+from pprint import pprint
+
+def get_tree(commit):
+    data = os.popen("cat-file commit %s"%commit).read()
+    return re.findall(r"(?m)^tree (\w+)", data)[0]
+
+PREFIX = 0
+PATH = -1
+SHA = -2
+ORIGSHA = -3
+
+def get_difftree(old, new):
+    lines = os.popen("diff-tree %s %s"%(old, new)).read().split("\x00")
+    patterns = (r"(\*)(\d+)->(\d+)\s(\w+)\s(\w+)->(\w+)\s(.*)",
+		r"([+-])(\d+)\s(\w+)\s(\w+)\s(.*)")
+    res = {}
+    for l in lines:
+	if not l: continue
+	for p in patterns:
+	    m = re.findall(p, l)
+	    if m:
+		m = m[0]
+		res[m[-1]] = m
+		break
+	else:
+	    raise "difftree: unknow line", l
+    return res
+
+def analyze(diff1, diff2):
+    diff1only = [ diff1[k] for k in diff1 if k not in diff2 ]
+    diff2only = [ diff2[k] for k in diff2 if k not in diff1 ]
+    both = [ (diff1[k],diff2[k]) for k in diff2 if k in diff1 ]
+
+    action(diff1only)
+    action(diff2only)
+    action_two(both)
+
+def action(diffs):
+    for act in diffs:
+	if act[PREFIX] == "*":
+	    print "modify", act[PATH], act[SHA]
+	elif act[PREFIX] == '-':
+	    print "remove", act[PATH], act[SHA]
+	elif act[PREFIX] == '+':
+	    print "add", act[PATH], act[SHA]
+	else:
+	    raise "unknow action"
+
+def action_two(diffs):
+    for act1, act2 in diffs:
+	if len(act1) == len(act2):	# same kind type
+	    if act1[PREFIX] == act2[PREFIX]:
+		if act1[SHA] == act2[SHA] or act1[PREFIX] == '-': 
+		    return action(act1)
+	    	if act1[PREFIX]=='*':
+		    print "do_merge", act1[PATH], act1[ORIGSHA], act1[SHA], act2[SHA]
+		    return
+	print "unable to handle", act[PATH]
+	print "one side wants", act1[PREFIX]
+	print "the other side wants", act2[PREFIX]
+	
+
+args = sys.argv[1:]
+if len(args)!=3:
+    print "Usage merge.py <common> <rev1> <rev2>"
+trees = map(get_tree, args)
+print "checkout-tree", trees[0]
+diff1 = get_difftree(trees[0], trees[1])
+diff2 = get_difftree(trees[0], trees[2])
+analyze(diff1, diff2)
+

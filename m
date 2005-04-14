From: Christopher Li <git@chrisli.org>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 16:50:21 -0400
Message-ID: <20050414205021.GA28082@64m.dyndns.org>
References: <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <20050414203013.GD25468@64m.dyndns.org> <20050414203717.GE25468@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:58:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMEDK-0001L3-9C
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVDOAA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 20:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVDOAA6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 20:00:58 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:7666 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261663AbVDOAAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 20:00:41 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005041500004001200ki6k2e>; Fri, 15 Apr 2005 00:00:40 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id EE89D3F1EF; Thu, 14 Apr 2005 16:50:21 -0400 (EDT)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050414203717.GE25468@64m.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

BTW, I am not competing with Junio script. If that is the way
we all agree on. It is should be very easy for Junio to fix his
perl script. right?

Chris

On Thu, Apr 14, 2005 at 04:37:17PM -0400, Christopher Li wrote:
> Is that some thing you want to see? Maybe clean up the error printing.
> 
> 
> Chris
> 
> --- /dev/null	2003-01-30 05:24:37.000000000 -0500
> +++ merge.py	2005-04-14 16:34:39.000000000 -0400
> @@ -0,0 +1,76 @@
> +#!/usr/bin/env python
> +
> +import re
> +import sys
> +import os
> +from pprint import pprint
> +
> +def get_tree(commit):
> +    data = os.popen("cat-file commit %s"%commit).read()
> +    return re.findall(r"(?m)^tree (\w+)", data)[0]
> +
> +PREFIX = 0
> +PATH = -1
> +SHA = -2
> +ORIGSHA = -3
> +
> +def get_difftree(old, new):
> +    lines = os.popen("diff-tree %s %s"%(old, new)).read().split("\x00")
> +    patterns = (r"(\*)(\d+)->(\d+)\s(\w+)\s(\w+)->(\w+)\s(.*)",
> +		r"([+-])(\d+)\s(\w+)\s(\w+)\s(.*)")
> +    res = {}
> +    for l in lines:
> +	if not l: continue
> +	for p in patterns:
> +	    m = re.findall(p, l)
> +	    if m:
> +		m = m[0]
> +		res[m[-1]] = m
> +		break
> +	else:
> +	    raise "difftree: unknow line", l
> +    return res
> +
> +def analyze(diff1, diff2):
> +    diff1only = [ diff1[k] for k in diff1 if k not in diff2 ]
> +    diff2only = [ diff2[k] for k in diff2 if k not in diff1 ]
> +    both = [ (diff1[k],diff2[k]) for k in diff2 if k in diff1 ]
> +
> +    action(diff1only)
> +    action(diff2only)
> +    action_two(both)
> +
> +def action(diffs):
> +    for act in diffs:
> +	if act[PREFIX] == "*":
> +	    print "modify", act[PATH], act[SHA]
> +	elif act[PREFIX] == '-':
> +	    print "remove", act[PATH], act[SHA]
> +	elif act[PREFIX] == '+':
> +	    print "add", act[PATH], act[SHA]
> +	else:
> +	    raise "unknow action"
> +
> +def action_two(diffs):
> +    for act1, act2 in diffs:
> +	if len(act1) == len(act2):	# same kind type
> +	    if act1[PREFIX] == act2[PREFIX]:
> +		if act1[SHA] == act2[SHA] or act1[PREFIX] == '-': 
> +		    return action(act1)
> +	    	if act1[PREFIX]=='*':
> +		    print "do_merge", act1[PATH], act1[ORIGSHA], act1[SHA], act2[SHA]
> +		    return
> +	print "unable to handle", act[PATH]
> +	print "one side wants", act1[PREFIX]
> +	print "the other side wants", act2[PREFIX]
> +	
> +
> +args = sys.argv[1:]
> +if len(args)!=3:
> +    print "Usage merge.py <common> <rev1> <rev2>"
> +trees = map(get_tree, args)
> +print "checkout-tree", trees[0]
> +diff1 = get_difftree(trees[0], trees[1])
> +diff2 = get_difftree(trees[0], trees[2])
> +analyze(diff1, diff2)
> +
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

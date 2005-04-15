From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 11:02:10 +0100
Message-ID: <1113559330.12012.292.camel@baythorne.infradead.org>
References: <20050414002902.GU25711@pasky.ji.cz>
	 <20050413212546.GA17236@64m.dyndns.org>
	 <20050414004504.GW25711@pasky.ji.cz>
	 <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	 <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 11:59:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMNbP-0007Tg-SB
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 11:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDOKCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 06:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVDOKCY
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 06:02:24 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:48016 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261451AbVDOKCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 06:02:16 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by baythorne.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMNeN-0002BK-Je; Fri, 15 Apr 2005 11:02:11 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-14 at 17:42 -0700, Linus Torvalds wrote:
> I've not even been convinved that renames are worth it. Nobody has
> really given a good reason why.
> 
> There are two reasons for renames I can think of:
> 
>  - space efficiency in delta-based trees.
>  - "annotate".

Neither of those were my motivation for looking at renames. The reasons
I wanted to track renames were:
   - Per-file revision history which doesn't stop dead at a rename.
   - Merging where files have been renamed in one branch and modified in
     another. Which is basically a special case of the above; we need to
     see the per-file revision history.

>    So I'd seriously suggest that instead of worryign about renames, people 
>    think about global diffs that aren't per-file. Git is good at limiting 
>    the changes to a set of objects, and it should be entirely possible to 
>    think of diffs as ways of moving lines _between_ objects and not just
>    within objects. It's quite common to move a function from one file to 
>    another - certainly more so than renaming the whole file.
>
>    In other words, I really believe renames are just a meaningless special 
>    case of a much more interesting problem. Which is just one reason why 
>    I'm not at all interested in bothering with them other than as a "data 
>    moved" thing, which git already handles very well indeed.

Git doesn't handle 'data moved' except at a whole-tree level. For each
commit, it says "these are the old trees; this is the new tree".

Git doesn't actually look hard into the contents of tree; certainly it
has no business looking at the contents of individual files; that is
something that the SCM or possibly only the user should do. The storage
of 'rename' information in the commit object is another kind of 'xattr'
storage which git would provides but not directly interpret.

And you're right; it shouldn't have to be for renames only. There's no
need for us to limit it to one "source" and one "destination"; the SCM
can use it to track content as it sees fit.

As I said, the main aim of this is to track revision history of given
content, for displaying to the user and for performing merges. So when a
file is split up, or a function is moved from it to another file, a
'rename' xattr can be included to mark that files 'foo' and 'bar' in the
new tree are both associated with file 'wibble' in the parent.

That's as much as we need to provide for content tracking, and it _does_
handle the general case as well as we should be attempting to. We don't
want to get into dealing with file contents ourselves; we just want to
store the hint for the SCM or the user that "your data went thataway".

-- 
dwmw2



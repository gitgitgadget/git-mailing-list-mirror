From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 22:02:11 +0100
Message-ID: <20051108210211.GA23265@c165.ib.student.liu.se>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org> <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Nov 08 22:03:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZabq-0001r6-B5
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 22:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVKHVCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 16:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965194AbVKHVCX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 16:02:23 -0500
Received: from [85.8.31.11] ([85.8.31.11]:36751 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965171AbVKHVCW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 16:02:22 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id D8AA440FF; Tue,  8 Nov 2005 22:10:34 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EZabb-00065K-00; Tue, 08 Nov 2005 22:02:11 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11355>

On Tue, Nov 08, 2005 at 12:58:50PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 7 Nov 2005, Linus Torvalds wrote:
> 
> > Is the recursive thing noticeably slower for the "easy" cases (ie things 
> > that the old regular resolve strategy does well)?
> 
> IIRC recursive does nothing else than recursively merging the merge-bases 
> (granted, in a clever way). So if there is only one merge-base, the only 
> slow-down would be the startup of python (which is probably worth it, 
> anyway).
> 

I haven't done any real measurements but my feeling is that the
recursive strategy is at least not very much slower than the resolve
strategy.

In the single-common-ancestor case I can think of the following things
which may make a difference speed wise:

* The recursive strategy is written in Python
* The code for finding common ancestors is also written in Python and
  is probably a bit slower than git-merge-base.
* git-diff-tree -M --diff-filter=R <common ancestor> <branch> is
  executed twice, once for each branch.

On the positive side the code which corresponds to git-merge-one-file
in the git-resolve case is also written in python, we can therefore
avoid some forks and execs.

> > It's certainly an option to just do what I just did, namely use the 
> > default one until it breaks, and then just do "git reset --hard" and re-do 
> > the pull with "-s recursive". A bit sad, and it would be good to have 
> > coverage on the recursive strategy..
> 
> We already have a fallback list: after really-trivial, try automatic, ...,
> try resolve. Why not just add recursive? So, if even resolve failed, just 
> try once more, with recursive.
> 

I don't think this is a very good idea for two reasons. The first one
is that there are some merge scenarios involving renames which should
be conflicts but are cleanly merged by git-resolve.

The second reason is that with the fall back list the recursive
strategy will only be used in the strange corner cases and will thus
not get nearly the same amount of testing it would get if it was the
first choice (or directly after the really-trivial merge).

- Fredrik

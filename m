From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-annotate bug report
Date: Mon, 7 Aug 2006 04:50:01 -0700
Message-ID: <20060807115000.GC15477@h4x0r5.com>
References: <20060803203848.GA15121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ryan@michonline.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 13:51:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA3da-0004k3-NF
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 13:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWHGLvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 07:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWHGLvK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 07:51:10 -0400
Received: from h4x0r5.com ([70.85.31.202]:35333 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1750746AbWHGLvJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 07:51:09 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1GA3cP-00039v-9L; Mon, 07 Aug 2006 04:50:01 -0700
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060803203848.GA15121@coredump.intra.peff.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25007>

On Thu, Aug 03, 2006 at 04:38:48PM -0400, Jeff King wrote:
> git-annotate on the tip of master seems to be broken for some files (but
> not for others):

Well, I think I've found a few bugs here tonight, basically all are
related to handling merges correctly.

First, a trivial one:

git diff-tree -M --name-status -z outputs the sha1 without honoring the
-z.  Patch following this email.

Second, one I don't know how to fix, at the moment:

git annotate uses the automatic tree simplification that git rev-list
does.  So, when it sees a commit with 1 parent, it assumes that it
really only has one parent.  git diff-tree -c doesn't know about this
same tree simplification, and, in the case of a merge commit, will still
output the -c format patch.

That particular case is trivial, simply remove the -c from commits where
I *know* there is only parent, and ask for the exact diff I need, from
the parent to the current rev.

There is, unfortunately, another situation, that of an octopus merge.
In the case of read-tree.c (after the rename is followed), the commit
7bd1527d2d8c80a6e9a0f8583082a5aee5428c68 is problematic.  In it we have
a 4-way merge, yet only 3 paths affected read-tree.c.  The diff-parsing
in annotate constructs a regular expression to find the diff header and
read out the line number to work on, and also to construct some regular
expressions from which to tell which lines affect which parents.

For example, it looks for a line like:
+ ++Line added in 3 parents
with dynamically generated regular expressions.  These, of course, need
to know how many parents there are.  The fact that diff-tree uses a
different number of parents makes the parsing fail, and then, the fact
that there isn't a great way to figure out which of the real parents
corresponds to the pseudo parents, makes this whole thing very
messy to fix.

So, the solution I've settled on is to use git merge-base to perform
some analysis and create a pseudo-parent list that is the same size as
the actual parent list, but consisting mostly of the fake parents
git-rev-list gives me.

If anyone else is confused by this email, it's probably because I
stopped and fixed a bug in the middle of writing it.

Patches as followups to this.


-- 

Ryan Anderson
  sometimes Pug Majere

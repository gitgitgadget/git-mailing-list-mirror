From: Paul Mackerras <paulus@samba.org>
Subject: Rewriting boundary parents when path-limiting
Date: Sat, 16 Feb 2008 23:10:21 +1100
Message-ID: <18358.53933.747911.449078@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: torvalds@linux-foundation.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 16 13:11:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQLsm-0006mD-Vz
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 13:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbYBPMKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 07:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbYBPMKa
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 07:10:30 -0500
Received: from ozlabs.org ([203.10.76.45]:43020 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbYBPMKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 07:10:30 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id D7FA9DDEC1; Sat, 16 Feb 2008 23:10:28 +1100 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74040>

When using both path and commit limiting, git log --parents --boundary
rewrites the parents that are actually in the graph but doesn't
rewrite the parents on the boundary, that is, the boundary parents may
be commits that don't modify any of the specified paths.  I'm
wondering if there is a way to get the boundary parents rewritten too.

The reason is this.  One of the nice things about the dev branch of
gitk is that updating the graph is really quick, because the git log
that gitk does when updating excludes all the commits that gitk has
already seen, using commit limiting.

Without path limiting, that works nicely, and the boundary of the new
set consists of commits that are already in the graph, so gitk can
join the new graph into the old.  But if path limiting is being used,
the boundary commits of the new set aren't necessarily commits that
are already in the graph, so gitk can't (at present) join the new
graph to the old properly.

Here's an example: suppose the repository looks like this:

HEAD ->	c	modifies file x
	|
	b	modifies file y
	|
	a	modifies file x

Suppose you run "gitk -- x", so gitk will display:

	c
	|
	a

Then suppose commit c gets amended, and still modifies file x, so the
HEAD is now commit c', whose parent is b.  Then if you do "Update" in
gitk (or press F5), gitk will do

	git log HEAD ^c -- x

and it will get one entry, which is c', with b listed as its parent.
So then gitk ends up displaying:

	c'
	|
	b

	c
	|
	a

because it doesn't realize that the parent of c' in the path-limited
graph should be a.

So can anyone suggest a good way for gitk to know that the parent of
c' should be a in this situation?

Paul.

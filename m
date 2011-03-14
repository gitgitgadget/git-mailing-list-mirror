From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Document 'git bisect fix'.
Date: Mon, 14 Mar 2011 22:00:01 +0100
Organization: Institute for Numerical Simulation, University of Bonn
Message-ID: <20110314210001.GE4586@gmx.de>
References: <20110311165802.GA3508@intel.com>
 <4D7A64670200007800035F4C@vpn.id2.novell.com>
 <AANLkTikG8wa1Em0bEUddbYpYs2TzFFTDb95qWFJ3xSbv@mail.gmail.com>
 <4D7DE39302000078000362E6@vpn.id2.novell.com>
 <20110314095534.GB18058@elte.hu>
 <20110314104131.GG6275@bubble.grove.modra.org>
 <20110314122342.GA26825@elte.hu>
 <20110314131623.119020@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Beulich <JBeulich@novell.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 22:00:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzEsB-0005M2-FI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 22:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250Ab1CNVAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 17:00:08 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:53608 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757133Ab1CNVAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 17:00:07 -0400
Received: (qmail invoked by alias); 14 Mar 2011 21:00:04 -0000
Received: from xdsl-89-0-183-21.netcologne.de (EHLO localhost.localdomain) [89.0.183.21]
  by mail.gmx.net (mp057) with SMTP; 14 Mar 2011 22:00:04 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX19RAUwGw6JRvfOBKbVtdnKK8Moqke6aF+N5zAAYK6
	4GAz+/FuS/Di4i
Received: from ralf by localhost.localdomain with local (Exim 4.72)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1PzErx-0001QM-GI; Mon, 14 Mar 2011 22:00:01 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	Jan Beulich <JBeulich@novell.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20110314131623.119020@gmx.net>
User-Agent: Mutt/1.5.20 (2010-08-04)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169026>

git bisect is sometimes less effective than it could be in projects
with long-lived but simple bugs (e.g., little-tested configurations).
Rather than skipping vast revision ranges, it might be easier to fix
them up from known bugfix branches.

'git bisect fix' teaches bisect about when some known bug was
introduced and when it was fixed, so that bisect can merge in
the fix when needed into new test candidates.
---

* Ralf Wildenhues wrote on Mon, Mar 14, 2011 at 02:16:23PM CET:
> it would be very helpful if 'git bisect' made it easy to denote
> "when going back, you might also need some of these changes".

Merging in a set of bugfix branches (branches with minimal fixes, based
right off of commits introducing some bug) before testing a particular
contender would be a good start.  Of course we don't want some bugfix
branch to be merged in if the known bug isn't yet in the current
contender, so as to not merge unrelated changes.

Cherry-pick things is another option, but the above seems a bit more
gittish to me, and works well with bugfix branches.  Also, data like
"bugzilla X was introduced by C1 and fixed by C2" is helpful (and
already available in some projects) anyway in a semi-automatic fashion.
You might even want to version it, or keep it in project meta-data.

If some bug was fixed by a merge only, the more general notation
"f_1 ^b_1 ^b_1' ..." could apply.

Here's a balloon doc patch to show what I mean.  Comments?
Is this too unlike how bisect works today?  Too dangerous?

Thanks, and please keep me in Cc:,
Ralf

 Documentation/git-bisect.txt |   20 ++++++++++++++++++++
 git-bisect.sh                |    4 +++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c39d957..9074cb3 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -25,6 +25,7 @@ on the subcommand:
  git bisect replay <logfile>
  git bisect log
  git bisect run <cmd>...
+ git bisect fix [(<range>|<rev>)...]
 
 This command uses 'git rev-list --bisect' to help drive the
 binary search process to find which change introduced a bug, given an
@@ -198,6 +199,25 @@ $ git bisect skip v2.5 v2.5..v2.6
 This tells the bisect process that the commits between `v2.5` included
 and `v2.6` included should be skipped.
 
+Fixing up known bugs
+~~~~~~~~~~~~~~~~~~~~
+
+If many revisions are broken due to some unrelated but known issue that
+is easily fixed, you might want to prefer fixing it up temporarily.
+If `<commit1>` introduces a bug fixed by `<commit2>`, instruct bisect
+to merge the latter before testing a commit that contains the former:
+
+------------
+$ git bisect fix <commit1>..<commit2>
+------------
+
+A single `<commit>` acts as if `<commit>^..<commit>` was specified.
+Fix statements can be repeated for every known bug, and are valid until
+the bisection state is cleaned up with reset.
+
+Any bisect action that causes a new commit to be chosen will try to merge
+the needed fixes and fail if they do not merge cleanly.
+
 
 Cutting down bisection by giving more parameters to bisect start
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..2b137f0 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[help|start|bad|good|skip|next|reset|visualize|replay|log|run]'
+USAGE='[help|start|bad|good|skip|fix|next|reset|visualize|replay|log|run]'
 LONG_USAGE='git bisect help
         print this long help message.
 git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
@@ -11,6 +11,8 @@ git bisect good [<rev>...]
         mark <rev>... known-good revisions.
 git bisect skip [(<rev>|<range>)...]
         mark <rev>... untestable revisions.
+git bisect fix [(<c1>..<c2>|<rev>)...]
+        mark descendants of <c1>/<rev^> as needing fixes <c2>/<rev>.
 git bisect next
         find next bisection to test and check it out.
 git bisect reset [<commit>]
-- 
1.7.4.1.231.ge4ce

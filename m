From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH] Documentation: teach stash/pop workflow instead of stash/apply
Date: Thu, 28 May 2009 11:40:15 +0200
Message-ID: <ef178b42f4db36811e07f1bca4436ed79e550957.1243502202.git.trast@student.ethz.ch>
References: <20090515021105.GA19241@coredump.intra.peff.net>
Cc: Jeff King <peff@peff.net>,
	Daniel Trstenjak <Daniel.Trstenjak@science-computing.de>,
	Junio C Hamano <gitster@pobox.com>, spearce@spearce.org,
	John Tapsell <johnflux@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 11:40:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9c6A-0002vr-0K
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 11:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZE1JkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 05:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbZE1JkS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 05:40:18 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:55318 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbZE1JkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 05:40:17 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 11:40:16 +0200
Received: from localhost.localdomain ([129.132.153.233]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 May 2009 11:40:16 +0200
X-Mailer: git-send-email 1.6.3.1.276.gb65cd
In-Reply-To: <20090515021105.GA19241@coredump.intra.peff.net>
X-OriginalArrivalTime: 28 May 2009 09:40:16.0445 (UTC) FILETIME=[4E9866D0:01C9DF78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120178>

Recent discussion on the list showed some comments in favour of a
stash/pop workflow:

  http://marc.info/?l=git&m=124234911423358&w=2
  http://marc.info/?l=git&m=124235348327711&w=2

Change the stash documentation and examples to document pop in its own
right (and apply in terms of pop), and use stash/pop in the examples.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I meant to write this for a while now, but never got around to it.

Jeff King wrote:
> On Fri, May 15, 2009 at 09:57:20AM +0900, Miles Bader wrote:
> > I don't understand why you say this -- sure "drop" is dangerous, but
> > that's exactly why you should use "pop" instead, because it makes sure
> > the changes are _somewhere_.  I found with the old (pre-"pop") stash,
> > I'd often end up in a situation where I'd lose track of whether I had
> > done a stash apply or not, and the risk of inadvertently doing a drop
> > _without_ a corresponding apply was very real.
> 
> "pop" doesn't always succeed. If you have conflicts in applying, then
> you end up with conflict markers, and the stash remains. You then fix up
> and commit as you see fit, but your stash is still there. So this bash
> prompt will nag you, which I think is what Thomas was complaining about
> (but perhaps the nagging would then convince you to keep a cleaner stash
> area by dropping the resolved stash).

Actually I was mostly concerned about dropping the stashes at all.
But I guess if you treat the stash as a short-term stack that holds a
change or two while you're working on something else, stash/pop fits
better.

I'd still prefer some configurability in the original patch, as I
think nagging the user into discarding data is a bad thing, even
though I now agree that if the 'pop' actually went through, it's not
really discarded.  (Also, ISTR a discussion about automatic gc'ing of
the stash reflog where a few people said they expect to hit any
reasonably short time limit in some of their repos and thus risk
losing work; regardless of cleanup disclipline, they would also have
the prompt on all the time).


By the way, why doesn't gmane find these mails?  I tried things like

  http://search.gmane.org/?query=stash&group=gmane.comp.version-control.git&author=miles@gnu.org

but the entire thread seems to be missing from gmane.



 Documentation/git-stash.txt   |   30 ++++++++++++++++--------------
 Documentation/user-manual.txt |    4 ++--
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 051f94d..1cc24cc 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -75,14 +75,22 @@ show [<stash>]::
 	it will accept any format known to 'git-diff' (e.g., `git stash show
 	-p stash@\{1}` to view the second most recent stash in patch form).
 
-apply [--index] [<stash>]::
+pop [<stash>]::
 
-	Restore the changes recorded in the stash on top of the current
-	working tree state.  When no `<stash>` is given, applies the latest
-	one.  The working directory must match the index.
+	Remove a single stashed state from the stash list and apply it
+	on top of the current working tree state, i.e., do the inverse
+	operation of `git stash save`. The working directory must
+	match the index.
 +
-This operation can fail with conflicts; you need to resolve them
-by hand in the working tree.
+Applying the state can fail with conflicts; in this case, it is not
+removed from the stash list. You need to resolve the conflicts by hand
+and call `git stash drop` manually afterwards.
++
+When no `<stash>` is given, `stash@\{0}` is assumed. See also `apply`.
+
+apply [--index] [<stash>]::
+
+	Like `pop`, but do not remove the state from the stash list.
 +
 If the `--index` option is used, then tries to reinstate not only the working
 tree's changes, but also the index's ones. However, this can fail, when you
@@ -112,12 +120,6 @@ drop [<stash>]::
 	Remove a single stashed state from the stash list. When no `<stash>`
 	is given, it removes the latest one. i.e. `stash@\{0}`
 
-pop [<stash>]::
-
-	Remove a single stashed state from the stash list and apply on top
-	of the current working tree state. When no `<stash>` is given,
-	`stash@\{0}` is assumed. See also `apply`.
-
 create::
 
 	Create a stash (which is a regular commit object) and return its
@@ -163,7 +165,7 @@ $ git pull
 file foobar not up to date, cannot merge.
 $ git stash
 $ git pull
-$ git stash apply
+$ git stash pop
 ----------------------------------------------------------------
 
 Interrupted workflow::
@@ -192,7 +194,7 @@ You can use 'git-stash' to simplify the above, like this:
 $ git stash
 $ edit emergency fix
 $ git commit -a -m "Fix in a hurry"
-$ git stash apply
+$ git stash pop
 # ... continue hacking ...
 ----------------------------------------------------------------
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index dbbeb7e..0b88a51 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1520,10 +1520,10 @@ $ git commit -a -m "blorpl: typofix"
 ------------------------------------------------
 
 After that, you can go back to what you were working on with
-`git stash apply`:
+`git stash pop`:
 
 ------------------------------------------------
-$ git stash apply
+$ git stash pop
 ------------------------------------------------
 
 
-- 
1.6.3.1.276.gb65cd

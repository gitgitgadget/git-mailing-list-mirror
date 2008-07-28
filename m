From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v3] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 22:46:43 -0700
Message-ID: <7vzlo2v9vg.fsf@gitster.siamese.dyndns.org>
References: <20080728065023.743930d6.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLaK-0000h8-9N
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbYG1Fqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbYG1Fqw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:46:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYG1Fqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:46:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6818F3F16D;
	Mon, 28 Jul 2008 01:46:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0915F3F16C; Mon, 28 Jul 2008 01:46:44 -0400 (EDT)
In-Reply-To: <20080728065023.743930d6.chriscool@tuxfamily.org> (Christian
 Couder's message of "Mon, 28 Jul 2008 06:50:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93A10D9C-5C68-11DD-95D3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90408>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch "git merge-base" accepted only 2 arguments, so
> only merge bases between 2 references could be computed.
>
> The purpose of this patch is to make "git merge-base" accept more
> than 2 arguments, so that the merge bases between the first given
> reference and all the other references can be computed.

After thinking about this a bit more, I think that saying "we now allow
computing merge base between more than 2" is misleading.

I ended up rewriting almost all the lines.  The points are:

 * The command is still about computing merge-bases between two commits,
   and one of these two commits is the first command line argument as
   before.  With more than one remaining commits on the command line, you
   can specify a hypothetical commit that is a merge between all of them.

 * We did not formally define what a merge-base is.  Define it.

 * With a proper definition of merge-base as "best common ancestors", with
   the definition of "good/better/best" between common ancestors, we do
   not have to say anything redundant about --all.  It outputs all merge
   bases, as opposed to one chosen at random.

 * Have definition and give illustrations in a new Discussion section.

---
 Documentation/git-merge-base.txt |   77 ++++++++++++++++++++++++++++++++-----
 1 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 1a7ecbf..fd4b5c9 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,26 +8,81 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
-'git merge-base' [--all] <commit> <commit>
+'git merge-base' [--all] <commit> <commit>...
 
 DESCRIPTION
 -----------
 
-'git-merge-base' finds as good a common ancestor as possible between
-the two commits. That is, given two commits A and B, `git merge-base A
-B` will output a commit which is reachable from both A and B through
-the parent relationship.
+'git-merge-base' finds best common ancestor(s) between two commits to use
+in a three-way merge.  One common ancestor is 'better' than another common
+ancestor if the latter is an ancestor of the former.  A common ancestor
+that does not have any better common ancestor than it is a 'best common
+ancestor', i.e. a 'merge base'.  Note that there can be more than one
+merge bases between two commits.
 
-Given a selection of equally good common ancestors it should not be
-relied on to decide in any particular way.
-
-The 'git-merge-base' algorithm is still in flux - use the source...
+Among the two commits to compute their merge bases, one is specified by
+the first commit argument on the command line; the other commit is a
+(possibly hypothetical) commit that is a merge across all the remaining
+commits on the command line.  As the most common special case, giving only
+two commits from the command line means computing the merge base between
+the given two commits.
 
 OPTIONS
 -------
 --all::
-	Output all common ancestors for the two commits instead of
-	just one.
+	Output all merge bases for the commits, instead of just one.
+
+DISCUSSION
+----------
+
+Given two commits 'A' and 'B', `git merge-base A B` will output a commit
+which is reachable from both 'A' and 'B' through the parent relationship.
+
+For example, with this topology:
+
+                 o---o---o---B
+                /
+        ---o---1---o---o---o---A
+
+the merge base between 'A' and 'B' is '1'.
+
+Given three commits 'A', 'B' and 'C', `git merge-base A B C` will compute the
+merge base between 'A' and an hypothetical commit 'M', which is a merge
+between 'B' and 'C'.  For example, with this topology:
+
+               o---o---o---o---C
+              /
+             /   o---o---o---B
+            /   /
+        ---2---1---o---o---o---A
+
+the result of `git merge-base A B C` is '1'.  This is because the
+equivalent topology with a merge commit 'M' between 'B' and 'C' is:
+
+
+               o---o---o---o---o
+              /                 \
+             /   o---o---o---o---M
+            /   /
+        ---2---1---o---o---o---A
+
+and the result of `git merge-base A M` is '1'.  Commit '2' is also a
+common ancestor between 'A' and 'M', but '1' is a better common ancestor,
+because '2' is an ancestor of '1'.  Hence, '2' is not a merge base.
+
+When the history involves criss-cross merges, there can be more than one
+'best' common ancestors between two commits.  For example, with this
+topology:
+
+       ---1---o---A
+	   \ /
+	    X
+	   / \
+       ---2---o---o---B
+
+both '1' and '2' are merge-base of A and B.  Neither one is better than
+the other (both are 'best' merge base).  When `--all` option is not given,
+it is unspecified which best one is output.
 
 Author
 ------

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] revision walker: include a detached HEAD in --all
Date: Fri, 16 Jan 2009 13:52:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901161351460.3586@pacific.mpi-cbg.de>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de> <200901151500.01876.trast@student.ethz.ch> <alpine.DEB.1.00.0901151508540.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901151517190.3586@pacific.mpi-cbg.de> <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 13:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNoCi-0007sg-AP
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 13:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761172AbZAPMwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 07:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760707AbZAPMwD
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 07:52:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:48539 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752662AbZAPMwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 07:52:00 -0500
Received: (qmail invoked by alias); 16 Jan 2009 12:51:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 16 Jan 2009 13:51:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tgQFuJYLtITHh9ADUXbTd9wDTjPD803DbMXeTjE
	RJzqgt6DmWUUHo
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhc40s50t.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105949>


When HEAD is detached, --all should list it, too, logically, as a
detached HEAD is by definition a temporary, unnamed branch.

It is especially necessary to list it when garbage collecting, as
the detached HEAD would be trashed.

Noticed by Thomas Rast.

Note that this affects creating bundles with --all; I contend that it
is a good change to add the HEAD, so that cloning from such a bundle
will give you a current branch.  However, I had to fix t5701 as it
assumed that --all does not imply HEAD.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 15 Jan 2009, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > On Thu, 15 Jan 2009, Johannes Schindelin wrote:
	> >
	> >> [PATCH] pack-objects --all: include HEAD, which could be 
	> >> detached
	> >
	> > In hind sight, it would probably be better to add this to 
	> > revision.c.
	> 
	> If you mean that "git log --all" should also include a possibly 
	> detached HEAD in its traversal, and a patch that implements such a fix 
	> would automatically fix "repack -a" without the patch you are 
	> responding to, I think I agree 100%.

	Here it is.  (Sorry for the delay, it was due to some 
	well-deserved inebriation.)

 revision.c              |    1 +
 t/t5701-clone-local.sh  |    4 ++--
 t/t6014-rev-list-all.sh |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)
 create mode 100755 t/t6014-rev-list-all.sh

diff --git a/revision.c b/revision.c
index db60f06..b065184 100644
--- a/revision.c
+++ b/revision.c
@@ -1263,6 +1263,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 			if (!strcmp(arg, "--all")) {
 				handle_refs(revs, flags, for_each_ref);
+				handle_refs(revs, flags, head_ref);
 				continue;
 			}
 			if (!strcmp(arg, "--branches")) {
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 8dfaaa4..14413f8 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -11,8 +11,8 @@ test_expect_success 'preparing origin repository' '
 	git clone --bare . x &&
 	test "$(GIT_CONFIG=a.git/config git config --bool core.bare)" = true &&
 	test "$(GIT_CONFIG=x/config git config --bool core.bare)" = true
-	git bundle create b1.bundle --all HEAD &&
-	git bundle create b2.bundle --all &&
+	git bundle create b1.bundle master HEAD &&
+	git bundle create b2.bundle master &&
 	mkdir dir &&
 	cp b1.bundle dir/b3
 	cp b1.bundle b4
diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
new file mode 100755
index 0000000..991ab4a
--- /dev/null
+++ b/t/t6014-rev-list-all.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='--all includes detached HEADs'
+
+. ./test-lib.sh
+
+
+commit () {
+	test_tick &&
+	echo $1 > foo &&
+	git add foo &&
+	git commit -m "$1"
+}
+
+test_expect_success 'setup' '
+
+	commit one &&
+	commit two &&
+	git checkout HEAD^ &&
+	commit detached
+
+'
+
+test_expect_success 'rev-list --all lists detached HEAD' '
+
+	test 3 = $(git rev-list --all | wc -l)
+
+'
+
+test_expect_success 'repack does not lose detached HEAD' '
+
+	git gc &&
+	git prune --expire=now &&
+	git show HEAD
+
+'
+
+test_done
-- 
1.6.1.299.gfdbb

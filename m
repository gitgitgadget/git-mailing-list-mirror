From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Move MERGE_RR from .git/rr-cache/ into .git/
Date: Sat, 12 Jul 2008 15:56:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807121553120.8950@racer>
References: <87skufmjg4.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, spearce@spearce.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jul 12 16:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHgXG-00083H-9u
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 16:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842AbYGLO4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 10:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYGLO4U
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 10:56:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:60205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754777AbYGLO4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 10:56:19 -0400
Received: (qmail invoked by alias); 12 Jul 2008 14:56:17 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp004) with SMTP; 12 Jul 2008 16:56:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pNLUe5K0pzGJvGhHHkW5RIWCUpn+xT3js9z3Gzh
	1vPzcD6xVrzIpy
X-X-Sender: gene099@racer
In-Reply-To: <87skufmjg4.fsf@Astalo.kon.iki.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88243>


If you want to reuse the rerere cache in another repository, and set
a symbolic link to it, you do not want to have the two repositories
interfer with each other by accessing the _same_ MERGE_RR.

For example, if you use contrib/git-new-workdir to set up a second
working directory, and you have a conflict in one working directory,
but commit in the other working directory first, the wrong "resolution"
will be recorded.

The easy solution is to move MERGE_RR out of the rr-cache/ directory,
which also corresponds with the notion that rr-cache/ contains cached
resolutions, not some intermediate temporary states.

Noticed by Kalle Olavi Niemitalo.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Shawn, I Cc:ed you because of 2/2.

	On Sat, 12 Jul 2008, Kalle Olavi Niemitalo wrote:

	> I don't see any way to modify the symlinks made by 
	> git-new-workdir so that new SHA-1 directories in .git/rr-cache
	> would be shared but .git/rr-cache/MERGE_RR would not.  On IRC, 
	> "gitte" suggested changing Git to use $GIT_DIR/MERGE_RR instead of 
	> $GIT_DIR/rr-cache/MERGE_RR.

	"gitte" actually expected that a patch would not be that hard.

	> I suppose compatibility with people's existing repositories 
	> would require the modified Git to keep reading 
	> $GIT_DIR/rr-cache/MERGE_RR too, so that Git could be painlessly 
	> upgraded during a merge, but it is not obvious to me how lock files 
	> should then work.

	"rerere" is not perfect.  Thus, I suspect that we can just leave 
	an existing MERGE_RR alone, and the user just has to record the 
	resolution another time.  Too bad.

 branch.c          |    2 +-
 builtin-rerere.c  |    2 +-
 t/t4200-rerere.sh |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index 56e9492..b1e59f2 100644
--- a/branch.c
+++ b/branch.c
@@ -166,7 +166,7 @@ void create_branch(const char *head,
 void remove_branch_state(void)
 {
 	unlink(git_path("MERGE_HEAD"));
-	unlink(git_path("rr-cache/MERGE_RR"));
+	unlink(git_path("MERGE_RR"));
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("SQUASH_MSG"));
 }
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 69c3a52..1db2e0c 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -429,7 +429,7 @@ static int setup_rerere(struct path_list *merge_rr)
 	if (!is_rerere_enabled())
 		return -1;
 
-	merge_rr_path = xstrdup(git_path("rr-cache/MERGE_RR"));
+	merge_rr_path = xstrdup(git_path("MERGE_RR"));
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
 	read_rr(merge_rr);
 	return fd;
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index cf10557..b5a4202 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
 	! git merge first
 '
 
-sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)
+sha1=$(sed -e 's/	.*//' .git/MERGE_RR)
 rr=.git/rr-cache/$sha1
 test_expect_success 'recorded preimage' "grep ^=======$ $rr/preimage"
 
@@ -143,7 +143,7 @@ test_expect_success 'rerere kicked in' "! grep ^=======$ a1"
 test_expect_success 'rerere prefers first change' 'test_cmp a1 expect'
 
 rm $rr/postimage
-echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/rr-cache/MERGE_RR
+echo "$sha1	a1" | perl -pe 'y/\012/\000/' > .git/MERGE_RR
 
 test_expect_success 'rerere clear' 'git rerere clear'
 
@@ -190,7 +190,7 @@ test_expect_success 'file2 added differently in two branches' '
 	git add file2 &&
 	git commit -m version2 &&
 	! git merge fourth &&
-	sha1=$(sed -e "s/	.*//" .git/rr-cache/MERGE_RR) &&
+	sha1=$(sed -e "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	echo Cello > file2 &&
 	git add file2 &&
-- 
1.5.6.2.511.ge432a

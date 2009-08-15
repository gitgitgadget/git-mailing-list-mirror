From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Simplify '--prett=xyz' options
Date: Sat, 15 Aug 2009 14:39:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908151434250.3162@localhost.localdomain>
References: <alpine.LFD.2.01.0908151156510.3162@localhost.localdomain> <200908152119.56606.trast@student.ethz.ch> <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Aug 15 23:41:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McQzk-00043V-Ky
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 23:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbZHOVkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 17:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbZHOVkv
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 17:40:51 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57309 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318AbZHOVkv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 17:40:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FLdx7I013726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Aug 2009 14:40:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7FLdwfQ009660;
	Sat, 15 Aug 2009 14:39:59 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908151236250.3162@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126032>



On Sat, 15 Aug 2009, Linus Torvalds wrote:
> 
> I would like to also make "--pretty=oneline" have the same abbrev-commit 
> semantics as "--oneline" has, but I didn't actually do that change.

Here's a patch if anybody cares.

It basically replaces the tests that do

	cut -b42-

or

	sed -e "s/^.\{41\}//"

(to get just the subject) with

	sed -e "s/^[0-9a-f]* //"

instead (which is an already pre-existing pattern that some other tests 
used).

The patch itself was trivial. The only question is whether the semantic 
change is ok (it certainly makes _sense_, it's just silly how "--oneline" 
is different from "--pretty=oneline"). 

This patch obviously depends on the previous one, since it just removes 
the special-casing of "--oneline" (it now falls out automatically from the 
"if you can't recognize the flag, see if it's a format flag" logic, and is 
no longer a special case).

The 'format/tformat' misdesigns I've not touched.

		Linus

---
 pretty.c                      |    4 +++-
 revision.c                    |    4 ----
 t/t3413-rebase-hook.sh        |    2 +-
 t/t5510-fetch.sh              |    2 +-
 t/t6009-rev-list-parent.sh    |    2 +-
 t/t9108-git-svn-glob.sh       |    4 ++--
 t/t9109-git-svn-multi-glob.sh |    6 +++---
 7 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/pretty.c b/pretty.c
index 1a76320..6d0fa60 100644
--- a/pretty.c
+++ b/pretty.c
@@ -52,8 +52,10 @@ int try_get_commit_format(const char *arg, struct rev_info *rev)
 	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
 		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
 		    !strncmp(arg, cmt_fmts[i].n, strlen(arg))) {
-			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
+			if (cmt_fmts[i].v == CMIT_FMT_ONELINE) {
 				rev->use_terminator = 1;
+				rev->abbrev_commit = 1;
+			}
 			rev->commit_format = cmt_fmts[i].v;
 			return 1;
 		}
diff --git a/revision.c b/revision.c
index bdace8b..b7f047a 100644
--- a/revision.c
+++ b/revision.c
@@ -1126,10 +1126,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "--pretty=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
-	} else if (!strcmp(arg, "--oneline")) {
-		revs->verbose_header = 1;
-		get_commit_format("oneline", revs);
-		revs->abbrev_commit = 1;
 	} else if (!strcmp(arg, "--graph")) {
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
diff --git a/t/t3413-rebase-hook.sh b/t/t3413-rebase-hook.sh
index 098b755..2f14c5c 100755
--- a/t/t3413-rebase-hook.sh
+++ b/t/t3413-rebase-hook.sh
@@ -19,7 +19,7 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m side &&
 	git checkout master &&
-	git log --pretty=oneline --abbrev-commit --graph --all &&
+	git log --oneline --graph --all &&
 	git branch test side
 '
 
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d13c806..62a45c0 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -168,7 +168,7 @@ test_expect_success 'bundle 1 has only 3 files ' '
 test_expect_success 'unbundle 2' '
 	cd "$D/bundle" &&
 	git fetch ../bundle2 master:master &&
-	test "tip" = "$(git log -1 --pretty=oneline master | cut -b42-)"
+	test "tip" = "$(git log -1 --pretty=oneline master | sed 's/^[0-9a-f]* //')"
 '
 
 test_expect_success 'bundle does not prerequisite objects' '
diff --git a/t/t6009-rev-list-parent.sh b/t/t6009-rev-list-parent.sh
index c8a96a9..9a90ce8 100755
--- a/t/t6009-rev-list-parent.sh
+++ b/t/t6009-rev-list-parent.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	commit three &&
 	commit four &&
 
-	git log --pretty=oneline --abbrev-commit
+	git log --oneline
 '
 
 test_expect_success 'one is ancestor of others and should not be shown' '
diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index d732d31..4d386f2 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -48,7 +48,7 @@ test_expect_success 'test refspec globbing' '
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.end &&
+	    sed -e "s/^[0-9a-f]* //" > output.end &&
 	test_cmp expect.end output.end &&
 	test "`git rev-parse refs/remotes/tags/end~1`" = \
 		"`git rev-parse refs/remotes/branches/start`" &&
@@ -82,7 +82,7 @@ test_expect_success 'test left-hand-side only globbing' '
 	test `git rev-parse refs/remotes/two/tags/end~3` = \
 	     `git rev-parse refs/remotes/two/branches/start` &&
 	git log --pretty=oneline refs/remotes/two/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.two &&
+	    sed -e "s/^[0-9a-f]* //" > output.two &&
 	test_cmp expect.two output.two
 	'
 
diff --git a/t/t9109-git-svn-multi-glob.sh b/t/t9109-git-svn-multi-glob.sh
index c318f9f..da93cf1 100755
--- a/t/t9109-git-svn-multi-glob.sh
+++ b/t/t9109-git-svn-multi-glob.sh
@@ -48,7 +48,7 @@ test_expect_success 'test refspec globbing' '
 	                 "tags/*/src/a:refs/remotes/tags/*" &&
 	git svn multi-fetch &&
 	git log --pretty=oneline refs/remotes/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.end &&
+	    sed -e "s/^[0-9a-f]* //" > output.end &&
 	test_cmp expect.end output.end &&
 	test "`git rev-parse refs/remotes/tags/end~1`" = \
 		"`git rev-parse refs/remotes/branches/v1/start`" &&
@@ -82,7 +82,7 @@ test_expect_success 'test left-hand-side only globbing' '
 	test `git rev-parse refs/remotes/two/tags/end~3` = \
 	     `git rev-parse refs/remotes/two/branches/v1/start` &&
 	git log --pretty=oneline refs/remotes/two/tags/end | \
-	    sed -e "s/^.\{41\}//" > output.two &&
+	    sed -e "s/^[0-9a-f]* //" > output.two &&
 	test_cmp expect.two output.two
 	'
 cat > expect.four <<EOF
@@ -131,7 +131,7 @@ test_expect_success 'test another branch' '
 	test `git rev-parse refs/remotes/four/tags/next~2` = \
 	     `git rev-parse refs/remotes/four/branches/v2/start` &&
 	git log --pretty=oneline refs/remotes/four/tags/next | \
-	    sed -e "s/^.\{41\}//" > output.four &&
+	    sed -e "s/^[0-9a-f]* //" > output.four &&
 	test_cmp expect.four output.four
 	'
 

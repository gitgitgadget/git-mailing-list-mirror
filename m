From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] stash pop: remove 'apply' options during 'drop' invocation
Date: Mon, 15 Feb 2010 17:01:57 +0100
Message-ID: <2927b3dc67ab0b9067d4fe849e85654125706b91.1266249586.git.trast@student.ethz.ch>
References: <201002151641.19694.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Boyd <bebarino@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steve Folly <steve@spfweb.co.uk>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 17:02:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh3Ox-0006Cv-Vk
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 17:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993Ab0BOQCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 11:02:19 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:42864 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab0BOQCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 11:02:18 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 17:02:17 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 15 Feb
 2010 17:01:56 +0100
X-Mailer: git-send-email 1.7.0.225.g2927b
In-Reply-To: <201002151641.19694.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140016>

The 'git stash pop' option parsing used to remove the first argument
in --index mode.  At the time this was implemented, this first
argument was always --index.  However, since the invention of the -q
option in fcdd0e9 (stash: teach quiet option, 2009-06-17) 'git stash
pop') you can cause an internal invocation of

  git stash drop --index

by running

  git stash pop -q --index

which then of course fails because drop doesn't know --index.

To handle this, instead let 'git stash apply' decide what the future
argument to 'drop' should be.

Warning: this means that 'git stash apply' must parse all options that
'drop' can take, and deal with them in the same way.  This is
currently true for its only option -q.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Noticed this while whipping up the draft patch.  I'm trading one
maintainability problem (that bit us) for another (that hasn't...
yet), but I'm scared to try properly filtering the arguments in sh.


 git-stash.sh     |    7 +++++--
 t/t3903-stash.sh |    9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 3a0685f..2d69196 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -221,6 +221,7 @@ show_stash () {
 }
 
 apply_stash () {
+	applied_stash=
 	unstash_index=
 
 	while test $# != 0
@@ -242,6 +243,9 @@ apply_stash () {
 	if test $# = 0
 	then
 		have_stash || die 'Nothing to apply'
+		applied_stash="$ref_stash@{0}"
+	else
+		applied_stash="$*"
 	fi
 
 	# stash records the work tree, and is a merge between the
@@ -415,8 +419,7 @@ pop)
 	shift
 	if apply_stash "$@"
 	then
-		test -z "$unstash_index" || shift
-		drop_stash "$@"
+		drop_stash "$applied_stash"
 	fi
 	;;
 branch)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5514f74..476e5ec 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -194,6 +194,15 @@ test_expect_success 'pop -q is quiet' '
 	test ! -s output.out
 '
 
+test_expect_success 'pop -q --index works and is quiet' '
+	echo foo > file &&
+	git add file &&
+	git stash save --quiet &&
+	git stash pop -q --index > output.out 2>&1 &&
+	test foo = "$(git show :file)" &&
+	test ! -s output.out
+'
+
 test_expect_success 'drop -q is quiet' '
 	git stash &&
 	git stash drop -q > output.out 2>&1 &&
-- 
1.7.0.225.g2927b

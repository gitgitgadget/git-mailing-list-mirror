From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/2] filter-branch: use git-sh-setup's ident parsing
 functions
Date: Thu, 18 Oct 2012 06:33:02 -0400
Message-ID: <20121018103301.GA28453@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
 <20121018072535.GB9999@sigill.intra.peff.net>
 <507FB470.2060404@viscovery.net>
 <20121018075429.GD9999@sigill.intra.peff.net>
 <20121018102217.GA17332@sigill.intra.peff.net>
 <20121018102627.GA17543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:33:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOnPi-0002Ud-T6
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 12:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab2JRKdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 06:33:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37717 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027Ab2JRKdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 06:33:06 -0400
Received: (qmail 4813 invoked by uid 107); 18 Oct 2012 10:33:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 06:33:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 06:33:02 -0400
Content-Disposition: inline
In-Reply-To: <20121018102627.GA17543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207994>

This saves us some code, but it also reduces the number of
processes we start for each filtered commit. Since we can
parse both author and committer in the same sed invocation,
we save one process. And since the new interface avoids tr,
we save 4 processes.

It also avoids using "tr", which has had some odd
portability problems reported with from Solaris's xpg6
version.

We also tweak one of the tests in t7003 to double-check that
we are properly exporting the variables (because test-lib.sh
exports GIT_AUTHOR_NAME, it will be automatically exported
in subprograms. We override this to make sure that
filter-branch handles it properly itself).

Signed-off-by: Jeff King <peff@peff.net>
---
This fixes the missing exports from v1. There's no changes needed to
patch 1.

 git-filter-branch.sh     | 46 +++++++++++++---------------------------------
 t/t7003-filter-branch.sh |  5 +++--
 2 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 178e453..5314249 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -64,37 +64,19 @@ set_ident () {
 
 eval "$functions"
 
-# When piped a commit, output a script to set the ident of either
-# "author" or "committer
+finish_ident() {
+	# Ensure non-empty id name.
+	echo "case \"\$GIT_$1_NAME\" in \"\") GIT_$1_NAME=\"\${GIT_$1_EMAIL%%@*}\" && export GIT_$1_NAME;; esac"
+	# And make sure everything is exported.
+	echo "export GIT_$1_NAME"
+	echo "export GIT_$1_EMAIL"
+	echo "export GIT_$1_DATE"
+}
 
 set_ident () {
-	lid="$(echo "$1" | tr "[A-Z]" "[a-z]")"
-	uid="$(echo "$1" | tr "[a-z]" "[A-Z]")"
-	pick_id_script='
-		/^'$lid' /{
-			s/'\''/'\''\\'\'\''/g
-			h
-			s/^'$lid' \([^<]*\) <[^>]*> .*$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_'$uid'_NAME='\''&'\''; export GIT_'$uid'_NAME/p
-
-			g
-			s/^'$lid' [^<]* <\([^>]*\)> .*$/\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_'$uid'_EMAIL='\''&'\''; export GIT_'$uid'_EMAIL/p
-
-			g
-			s/^'$lid' [^<]* <[^>]*> \(.*\)$/@\1/
-			s/'\''/'\''\'\'\''/g
-			s/.*/GIT_'$uid'_DATE='\''&'\''; export GIT_'$uid'_DATE/p
-
-			q
-		}
-	'
-
-	LANG=C LC_ALL=C sed -ne "$pick_id_script"
-	# Ensure non-empty id name.
-	echo "case \"\$GIT_${uid}_NAME\" in \"\") GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\" && export GIT_${uid}_NAME;; esac"
+	parse_ident_from_commit author AUTHOR committer COMMITTER
+	finish_ident AUTHOR
+	finish_ident COMMITTER
 }
 
 USAGE="[--env-filter <command>] [--tree-filter <command>]
@@ -320,10 +302,8 @@ while read commit parents; do
 	git cat-file commit "$commit" >../commit ||
 		die "Cannot read commit $commit"
 
-	eval "$(set_ident AUTHOR <../commit)" ||
-		die "setting author failed for commit $commit"
-	eval "$(set_ident COMMITTER <../commit)" ||
-		die "setting committer failed for commit $commit"
+	eval "$(set_ident <../commit)" ||
+		die "setting author/committer failed for commit $commit"
 	eval "$filter_env" < /dev/null ||
 		die "env filter failed: $filter_env"
 
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 4d13e10..1e7a209 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -167,10 +167,11 @@ test_expect_success 'author information is preserved' '
 	test_tick &&
 	GIT_AUTHOR_NAME="B V Uips" git commit -m bvuips &&
 	git branch preserved-author &&
-	git filter-branch -f --msg-filter "cat; \
+	(sane_unset GIT_AUTHOR_NAME &&
+	 git filter-branch -f --msg-filter "cat; \
 			test \$GIT_COMMIT != $(git rev-parse master) || \
 			echo Hallo" \
-		preserved-author &&
+		preserved-author) &&
 	test 1 = $(git rev-list --author="B V Uips" preserved-author | wc -l)
 '
 
-- 
1.8.0.rc3.3.gba630e1

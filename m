From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] filter-branch: use git-sh-setup's ident parsing functions
Date: Thu, 18 Oct 2012 03:25:35 -0400
Message-ID: <20121018072535.GB9999@sigill.intra.peff.net>
References: <20121018072207.GA1605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ilya Basin <basinilya@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 09:25:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOkUI-0003M4-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 09:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab2JRHZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 03:25:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37532 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272Ab2JRHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 03:25:38 -0400
Received: (qmail 2579 invoked by uid 107); 18 Oct 2012 07:26:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 03:26:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 03:25:35 -0400
Content-Disposition: inline
In-Reply-To: <20121018072207.GA1605@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207973>

This saves us some code, but it also reduces the number of
processes we start for each filtered commit. Since we can
parse both author and committer in the same sed invocation,
we save one process. And since the new interface avoids tr,
we save 4 processes.

It also avoids using "tr", which has had some odd
portability problems reported with from Solaris's xpg6
version.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-filter-branch.sh | 42 +++++++++---------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 178e453..69406ae 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -64,37 +64,15 @@ set_ident () {
 
 eval "$functions"
 
-# When piped a commit, output a script to set the ident of either
-# "author" or "committer
+# Ensure non-empty id name.
+fallback_name() {
+	echo "case \"\$GIT_$1_NAME\" in \"\") GIT_$1_NAME=\"\${GIT_$1_EMAIL%%@*}\" && export GIT_$1_NAME;; esac"
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
+	fallback_name AUTHOR
+	fallback_name COMMITTER
 }
 
 USAGE="[--env-filter <command>] [--tree-filter <command>]
@@ -320,10 +298,8 @@ while read commit parents; do
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
 
-- 
1.8.0.rc3.3.gba630e1

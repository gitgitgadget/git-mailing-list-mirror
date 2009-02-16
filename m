From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/2] bash completion: refactor common log, shortlog and gitk options
Date: Mon, 16 Feb 2009 17:34:56 +0100
Message-ID: <c1564dd75592c6e4c3ce97c6187eedbe03d03bc7.1234801852.git.trast@student.ethz.ch>
References: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 17:37:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6Sa-0000Iq-PH
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbZBPQfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbZBPQfM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:35:12 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:15235 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbZBPQfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:35:10 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 17:35:09 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 16 Feb 2009 17:35:08 +0100
X-Mailer: git-send-email 1.6.2.rc0.328.g2c702
In-Reply-To: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
X-OriginalArrivalTime: 16 Feb 2009 16:35:08.0431 (UTC) FILETIME=[87A749F0:01C99054]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110202>

Refactor options that are useful for more than one of them into a
variable used by the relevant completions.  This has the effect of
adding the following options to git-log:

  --branches --tags --remotes --first-parent --dense --sparse
  --simplify-merges --simplify-by-decoration --first-parent
  --no-merges

The following to git-shortlog:

  --branches --tags --remotes --first-parent

And the following to gitk:

  --branches --tags --remotes --first-parent --no-merges --max-count=
  --max-age= --since= --after= --min-age= --until= --before= --dense
  --sparse --full-history --simplify-merges --simplify-by-decoration
  --left-right

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 contrib/completion/git-completion.bash |   49 ++++++++++++++++++++++----------
 1 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 412d2c0..a5b3bf3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -975,6 +975,27 @@ _git_ls_tree ()
 	__git_complete_file
 }
 
+# Options that go well for log, shortlog and gitk
+__git_log_common_options="
+	--not --all
+	--branches --tags --remotes
+	--first-parent --no-merges
+	--max-count=
+	--max-age= --since= --after=
+	--min-age= --until= --before=
+"
+# Options that go well for log and gitk (not shortlog)
+__git_log_gitk_options="
+	--dense --sparse --full-history
+	--simplify-merges --simplify-by-decoration
+	--left-right
+"
+# Options that go well for log and shortlog (not gitk)
+__git_log_shortlog_options="
+	--author= --committer= --grep=
+	--all-match
+"
+
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
 
 _git_log ()
@@ -996,21 +1017,19 @@ _git_log ()
 		;;
 	--*)
 		__gitcomp "
-			--max-count= --max-age= --since= --after=
-			--min-age= --before= --until=
+			$__git_log_common_options
+			$__git_log_shortlog_options
+			$__git_log_gitk_options
 			--root --topo-order --date-order --reverse
-			--no-merges --follow
+			--follow
 			--abbrev-commit --abbrev=
 			--relative-date --date=
-			--author= --committer= --grep=
-			--all-match
 			--pretty=
-			--not --all
-			--left-right --cherry-pick
+			--cherry-pick
 			--graph
 			--decorate
 			--walk-reflogs
-			--parents --children --full-history
+			--parents --children
 			--merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
@@ -1495,12 +1514,8 @@ _git_shortlog ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--max-count= --max-age= --since= --after=
-			--min-age= --before= --until=
-			--no-merges
-			--author= --committer= --grep=
-			--all-match
-			--not --all
+			$__git_log_common_options
+			$__git_log_shortlog_options
 			--numbered --summary
 			"
 		return
@@ -1808,7 +1823,11 @@ _gitk ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "--not --all $merge"
+		__gitcomp "
+			$__git_log_common_options
+			$__git_log_gitk_options
+			$merge
+			"
 		return
 		;;
 	esac
-- 
1.6.2.rc0.328.g2c702

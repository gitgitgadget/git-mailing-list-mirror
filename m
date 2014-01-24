From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 9/9] pull: add the --gpg-sign option.
Date: Fri, 24 Jan 2014 00:51:06 +0000
Message-ID: <1390524666-51274-10-git-send-email-sandals@crustytoothpaste.net>
References: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Nicolas Vigier <boklm@mars-attacks.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 01:51:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6Uzd-0001gn-5Z
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 01:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818AbaAXAvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 19:51:25 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51348 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753836AbaAXAvX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 19:51:23 -0500
Received: from vauxhall.elevennetworks.com (unknown [209.118.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9655B2807A;
	Fri, 24 Jan 2014 00:51:22 +0000 (UTC)
X-Mailer: git-send-email 1.9.rc0.1002.gd081c64.dirty
In-Reply-To: <1390524666-51274-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240985>

git merge already allows us to sign commits, and git rebase has recently
learned how to do so as well.  Teach git pull to parse the -S/--gpg-sign
option and pass this along to merge or rebase, as appropriate.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 git-pull.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-pull.sh b/git-pull.sh
index 0a5aa2c..4164dac 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -138,6 +138,15 @@ do
 	--no-verify-signatures)
 		verify_signatures=--no-verify-signatures
 		;;
+	--gpg-sign|-S)
+		gpg_sign_args=-S
+		;;
+	--gpg-sign=*)
+		gpg_sign_args="-S${1#--gpg-sign=}"
+		;;
+	-S*)
+		gpg_sign_args="-S${1#-S}"
+		;;
 	--d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
 		dry_run=--dry-run
 		;;
@@ -305,11 +314,13 @@ merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$rebase" in
 true)
 	eval="git-rebase $diffstat $strategy_args $merge_args $rebase_args $verbosity"
+	eval="$eval $gpg_sign_args"
 	eval="$eval --onto $merge_head ${oldremoteref:-$merge_head}"
 	;;
 *)
 	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
-	eval="$eval  $log_arg $strategy_args $merge_args $verbosity $progress"
+	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
+	eval="$eval $gpg_sign_args"
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
 esac
-- 
1.9.rc0.1002.gd081c64.dirty

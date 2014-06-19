From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 5/7] rebase -i: Do not die in do_pick
Date: Thu, 19 Jun 2014 05:28:41 +0200
Message-ID: <53A258E9.7030909@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:28:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT1v-0003AX-Cp
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756959AbaFSD2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:46 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:64943 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaFSD2o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:44 -0400
Received: by mail-wi0-f177.google.com with SMTP id r20so2107408wiv.16
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=SC4m5eIRAGz3qXew/zxGyjO5cu6SBaq+zSbMRJTORxU=;
        b=y4i5COqKa3Z2odBUAB/lqocHEqSAhvTGB6FlWEWNygqm7U7MWFt/ux/SyVNFuu4Vom
         3ZHSCfSs/xojJL/3avl6W4P2raI+O8YNzuQebSQGRCmAIBgmCOg45Y4t/BjY0uXlWHhU
         PlbHCaYEgWL4aDNhyhi6v1YxXstRc7eElfhFsV4FQQGQoyQw4W0klYCB4NJNe3me18oH
         fmM5DRZJhzhewTRCFP42N6yetZ6ePHEhRuSxKwQTBzJJq0FHMnRiR/tlmCEyVmbjfwow
         nNr5+oPyanYmhDQGwQtFRyRYbRAzrK+rjn9Y1W658yeCmpy+/GZlP5J+ClzB++WXJ/SC
         uAHw==
X-Received: by 10.194.87.170 with SMTP id az10mr1903840wjb.1.1403148523669;
        Wed, 18 Jun 2014 20:28:43 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id um7sm5792453wjc.12.2014.06.18.20.28.42
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1403146774.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252093>

Since `do_pick` might be executed in a sub-shell (a modified author
environment for instance), calling `die` in `do_pick` has no effect but
exiting the sub-shell with a failure exit status. Moreover, if `do_pick`
is called while a squash or fixup is happening, `die_with_patch` will
discard `$squash_msg` as commit message. Indicate an error in `do_pick`
using return statements and properly kill the script at the call sites.
Remove unused commit message title argument from `do_pick`'s signature.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f903599..e4992dc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -493,14 +493,10 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--edit] <commit> <title>
+# do_pick [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
-# <title>
-#     The commit message title of <commit>. Used for information
-#     purposes only.
-#
 # <commit>
 #     The commit to cherry-pick.
 #
@@ -508,6 +504,12 @@ record_in_rewritten() {
 #     After picking <commit>, open an editor and let the user edit the
 #     commit message. The editor contents becomes the commit message of
 #     the new head.
+#
+# The return value is 1 if applying the changes resulted in a conflict
+# and 2 if the specified arguments were incorrect. If the changes could
+# be applied successfully but creating the commit failed, a value
+# greater than 2 is returned. No commit is created in either case and
+# the index is left with the (conflicting) changes in place.
 do_pick () {
 	rewrite=
 	rewrite_amend=
@@ -528,7 +530,11 @@ do_pick () {
 		esac
 		shift
 	done
-	test $# -ne 2 && die "do_pick: wrong number of arguments"
+	if test $# -ne 1
+	then
+		warn "do_pick: wrong number of arguments"
+		return 2
+	fi
 
 	if test "$(git rev-parse HEAD)" = "$squash_onto"
 	then
@@ -545,11 +551,9 @@ do_pick () {
 		# rebase --continue.
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
-			pick_one -n $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+			pick_one -n $1 || return 1
 	else
-		pick_one ${rewrite:+-n} $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+		pick_one ${rewrite:+-n} $1 || return 1
 	fi
 
 	if test -n "$rewrite"
@@ -557,8 +561,7 @@ do_pick () {
 		git commit --allow-empty --no-post-rewrite -n -q \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
-			   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
-			die_with_patch $1 "Could not rewrite commit after successfully picking $1... $2"
+			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
 
@@ -573,21 +576,21 @@ do_next () {
 		comment_for_reflog pick
 
 		mark_action_done
-		do_pick $sha1 "$rest"
+		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	reword|r)
 		comment_for_reflog reword
 
 		mark_action_done
-		do_pick --edit $sha1 "$rest"
+		do_pick --edit $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
 		record_in_rewritten $sha1
 		;;
 	edit|e)
 		comment_for_reflog edit
 
 		mark_action_done
-		do_pick $sha1 "$rest"
+		do_pick $sha1 || die_with_patch $sha1 "Could not apply $sha1... $rest"
 		warn "Stopped at $sha1... $rest"
 		exit_with_patch $sha1 0
 		;;
-- 
2.0.0

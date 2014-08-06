From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 21/23] rebase -i: teach do_pick the option --reset-author
Date: Thu,  7 Aug 2014 01:59:28 +0200
Message-ID: <cebc51133186e31f3d46edbbd42d60d61b5b6c7b.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB91-0004eT-3i
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612AbaHGABM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:12 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:48726 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbaHGABA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:01:00 -0400
Received: by mail-qa0-f44.google.com with SMTP id f12so3211227qad.17
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jh0FQNui9AES/LJu3zrq39e9p5SeSRcdyc0ldnAHjfQ=;
        b=kcE7hqBx3MybJn/bDWIGuGnPIF9GGgM997cBMiNjzvRgBalPfWgrCCZ8PtxmnLld4k
         B9cSP4CyWhzlbGat3Yv1XykOZ2GXUErOiTCh+UoF8w/9YdpsgFYcsvhn1diwOxc4nxwq
         WWC6bp2scddYFniGNZUnE8bOWG06vpuOfcjrj6xClDxwLrTfGRb4ALwPhiSyrvnv22+f
         Ctc+KAGkG9mO+EfDfI+NQ2ElAv0rCdLnGEacHFLV8BdmgVVTBvHx1tyLh+B7NrsD2nS9
         eNMvl08gZ7rRQ7eXXQZAs/MElhoWpdMUQzTHnB1sJQASoctBmXRSGwwOBqRR/UfDagj3
         VW4Q==
X-Received: by 10.224.21.9 with SMTP id h9mr21202799qab.67.1407369659537;
        Wed, 06 Aug 2014 17:00:59 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254935>

`do_pick` is the git-cherry-pick wrapper in git-rebase--interactive
that is used to implement many of the to-do list commands.
Eventually, the complete `do_pick` interface will be exposed to the
user in some form or another and those commands will become simple
aliases for the `do_pick` options now used to implement them.

Add the git-commit option `--reset-author` to the options pool of
`do_pick`. It rewrites the author date and name of the picked commit
to match the committer date and name.

If `--reset-author` is passed to `do_pick`, set the `rewrite` flag
and relay the option to the git-commit command line which creates the
final commit. If `--amend` is not passed as well, the fresh
authorship effect is achieved by the mere fact that we are creating a
new commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index da435cb..d6c99ea 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -464,10 +464,18 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--amend] [--file <file>] [--edit] <commit>
+# do_pick [--reset-author] [--amend] [--file <file>] [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
+# --reset-author
+#     Pretend the changes were made for the first time. Declare that the
+#     authorship of the resulting commit now belongs to the committer.
+#     This also renews the author timestamp. This creates a fresh
+#     commit.
+#
+#     _This is not a git-cherry-pick option._
+#
 # --amend
 #     After picking <commit>, replace the current head commit with a new
 #     commit that also introduces the changes of <commit>.
@@ -502,6 +510,10 @@ do_pick () {
 	while test $# -gt 0
 	do
 		case "$1" in
+		--reset-author)
+			rewrite=y
+			rewrite_author=y
+			;;
 		--amend)
 			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse -q --verify HEAD >/dev/null
 			then
@@ -564,6 +576,14 @@ do_pick () {
 		pick_one ${rewrite:+-n} $1 || return 1
 	fi
 
+	if test -n "$rewrite_author" && test -z "$rewrite_amend"
+	then
+		# keep rewrite flag to create a new commit, rewrite
+		# without --reset-author though because it can only be
+		# used with -C, -c or --amend
+		rewrite_author=
+	fi
+
 	if test -n "$rewrite"
 	then
 		output git commit --allow-empty --no-post-rewrite -n --no-edit \
@@ -571,6 +591,7 @@ do_pick () {
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit --commit-msg} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
+			   ${rewrite_author:+--reset-author} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
-- 
2.0.1

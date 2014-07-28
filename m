From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 11/19] rebase -i: teach do_pick the option --amend
Date: Tue, 29 Jul 2014 01:18:11 +0200
Message-ID: <c9bd9a9361db275c12310c970811384c1a9935e7.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEK-0006Li-Tr
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaG1XU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:59 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:48970 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbaG1XUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:55 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so7844486wgh.21
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fn7UddJRP+T9ORKuW15/1Qqmrx6W4T5tZDuEMqb/ZZA=;
        b=WJJm1WoBGvsir9gSZgZ2AoYFMxKVLBkAoxz1AmaRK2GmsBlGBvh2039EYg+J2K6uys
         VXaaZRNtXRMTyjq2GYo0SJqopSipMvQf8zzc16hIsO13sNHJf+YG7q2G1CvfXASPSYwg
         luLDKMknNtabWkyeT4qO5vWfcvlvIilhfUnfNDVmxKlG1LuJ8oRYU3XavbpCDhUNWqVb
         4XNE2GmCLeb1WySU1t4mn/A04vu480khzi3Rz1DVXLsERE+ACDreVZRGdgkrhBt8tZSx
         00WwqmbPchObRx/H1jUo6Oti39R+OssxcPHnX1PGHug2d3AzSuwLHbnnXDGJJXcgvXJY
         KFLg==
X-Received: by 10.194.87.97 with SMTP id w1mr54633777wjz.42.1406589652663;
        Mon, 28 Jul 2014 16:20:52 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254372>

`do_pick` is the git-cherry-pick wrapper in git-rebase--interactive
that is used to implement the to-do list commands `pick`, `reword`
and `edit`. To cater for the different pick behaviours (like
`squash`), `do_pick` accepts several options not only from the
git-cherry-pick but also the git-commit interface.

Add the option `--amend` from the git-commit interface to the options
pool of `do_pick`. It creates a new commit for the changes introduced
by the picked commit and the previous one. The previous commit is
then replaced with the new commit. If no other options are specified,
the log message of the previous commit is used.

Be careful when `--amend` is used to pick a root commit because HEAD
might point to the sentinel commit but there is still nothing to
amend. Be sure to initialize `amend` so that commits are squashed
even when git-rebase--interactive is interrupted for resolving
conflicts. It is not a mistake to do the initialization regardless of
any conflicts because `amend` is always cleared before the next to-do
item is processed.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9f08f1b..22a8f7b 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -464,10 +464,16 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--edit] <commit>
+# do_pick [--amend] [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
+# --amend
+#     After picking <commit>, replace the current head commit with a new
+#     commit that also introduces the changes of <commit>.
+#
+#     _This is not a git-cherry-pick option._
+#
 # -e, --edit
 #     After picking <commit>, open an editor and let the user edit the
 #     commit message. The editor contents becomes the commit message of
@@ -489,6 +495,16 @@ do_pick () {
 	while test $# -gt 0
 	do
 		case "$1" in
+		--amend)
+			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse --verify HEAD
+			then
+				warn "do_pick: nothing to amend"
+				return 2
+			fi
+			rewrite=y
+			rewrite_amend=y
+			git rev-parse --verify HEAD >"$amend"
+			;;
 		-e|--edit)
 			rewrite=y
 			rewrite_edit=y
-- 
2.0.1

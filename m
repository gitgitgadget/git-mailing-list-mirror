From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 11/19] rebase -i: Teach do_pick the option --amend
Date: Wed,  2 Jul 2014 19:48:03 +0200
Message-ID: <def85097bcd50006ad39dc274f900f33ecc010e5.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:51:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgU-0007cA-Mo
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbaGBRuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:01 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:48292 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbaGBRt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:56 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so11753077wes.13
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ucr2YnoIn9RC5M4sDS8mpQzR6q7KKcYrNnQ8cfDwVc8=;
        b=vhivfzwBub67rabacdQCh6JvWwNy6R+JXKMcK+UGg0va9LtaJSyI1UAB3vyg3qJ5Dh
         bwBfrhngskdZyWnR9lACon1XBYzt4WTMIAbxboUGgcsRTkCq0CzrymU/M6AMJGajl2/c
         TnqJInK5PaRxLSSMuC6BbyuL+DKSJyzbGb3B7krrErVzzuf+KGGaKaKPs/eIwDg6iLAw
         i/u/bhbDfRVyzC9c0p14ZALnI7/ne4GPfva8NPFoO7G+adSomIOw8VA9Z1mJ+6o5tMky
         c4seA3NbTGD1z8QqzMDNvbZoehwonb4/aIHm5xInx3QblcLBfo+coIX9yrZK9acc+Qaf
         tO1A==
X-Received: by 10.194.243.200 with SMTP id xa8mr12324558wjc.97.1404323395692;
        Wed, 02 Jul 2014 10:49:55 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252820>

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
index 0070b3e..046d358 100644
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
@@ -488,6 +494,16 @@ do_pick () {
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
2.0.0

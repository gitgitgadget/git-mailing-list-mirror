From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 16/27] rebase -i: teach do_pick the option --amend
Date: Mon, 18 Aug 2014 23:22:59 +0200
Message-ID: <cebade19be37aeea66f823ac4a4289c916f04d6c.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPe-0000aA-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbaHRVYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:14 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46656 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbaHRVYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:10 -0400
Received: by mail-lb0-f174.google.com with SMTP id c11so4637029lbj.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cNtFW7BO2PoChgwiePj1Vgm+Bfp8r91kJwGNe01/ucY=;
        b=08Pzw0C7cKBlWQotTzhttdwHAdGCMPvPZvhgadfCAW+wb9CcM/bxfrztVSWv6GAv1a
         qSIHtjwS8EoKI77on+w872/um71n85eX6wCMtHzLbjo391lByg9JmM9ibJ9gL9fcOjeW
         wYdVm8krRf2yPJNPqNFzKyoy+Jgc6XfxvX1y4dTOtjAi7jqhccFHEFBFLeLSZq4izgsW
         AO2oGX/3a6AwE2GPng/kuAUCJ0n2HsC0EQ03nj9kLCnV0V0tqGhJlhRxH5PzriTPsPFa
         Sjj6mZZZFubCy31Wy+Pd3OCVON1YSxYLbxZJdRfvy32w29Hk3BELuQpLK0ylpdCp+/j4
         3aIg==
X-Received: by 10.152.203.232 with SMTP id kt8mr31550730lac.27.1408397049369;
        Mon, 18 Aug 2014 14:24:09 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255419>

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
index a5a8aa3..20a637a 100644
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
+			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse -q --verify HEAD >/dev/null
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

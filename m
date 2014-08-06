From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 15/23] rebase -i: teach do_pick the option --amend
Date: Thu,  7 Aug 2014 01:59:22 +0200
Message-ID: <6621ca6a43bda212653ba63e7ca0cbc1d5d3a3c5.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8j-0004DU-R2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754500AbaHGAAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:52 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:51311 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444AbaHGAAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:50 -0400
Received: by mail-qa0-f52.google.com with SMTP id j15so3186399qaq.25
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6XB7xN8+M9WokUKsut8Z/rYO958V7VZW895zTV6JbE=;
        b=KXujDtBQDfnBGFpbAli7X1ARXL1/yVsbZerWjQkBmpjWDwhBo+qki4qRZhCLz4uyUW
         8nZaC+2GTgPMGcIt4mUVYngmGZ+gxmmDGdXKayO940RJnw8z2U4KiU+yPyxa2Y2Ugcor
         kwFdcAo55NIcDKO1F3Lj6oPrYO+p5/3a02Blgz1GCMEuwmogWfx7wrabRcgQzUH55EOm
         BeFrmvGJ+WN6Dyn5nKLQEOUqbk39SOA+2T6rcw6rrsEqjNLDw4pKjDOwXIY7mB+tU8Le
         ERBV8ADB5bqFKvI9f3hj10xG3f/ndVvxKze9QWiP4/6D+R0S21WL07hob9g62uUjMLUX
         Ha7g==
X-Received: by 10.140.36.118 with SMTP id o109mr12348081qgo.25.1407369649765;
        Wed, 06 Aug 2014 17:00:49 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:49 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254930>

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
index d812bad..0871302 100644
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

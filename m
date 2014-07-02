From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 12/19] rebase -i: Teach do_pick the option --file
Date: Wed,  2 Jul 2014 19:48:04 +0200
Message-ID: <b9979c769e293d032cf7a3c173ec06f87f8fc8e8.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:51:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgT-0007cA-5F
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756771AbaGBRuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:02 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51322 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741AbaGBRt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:59 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so10049085wib.11
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gYNuUXIj/AIZItVGcgtF7YVgR1t4C5UeZZhmIuDG9FU=;
        b=jTJlEglWag0WFREtjjU+PuSgE18ieDW3UA5nwZwzqw0u2F+0bXuPP0eCiOshN4WH56
         5T4OiaxE2oY+iZzlyFuPnMCJWRRXKCU9KiTuo+mNhTBHmKW0f/zfycuHUIIQJf1Tp3Fw
         3ChREpPcwWFhq/ryc9cPjIuWDX6hk04fdL/vqS0c31/0nWVbcjAJCKaF5h2hsM1hEhWr
         Fs/CNLIEEFTZpvBSgjb95yf5VqUnXJBNtj+3sXMeaSYCBV9NPgu6mQo+O1I7fomAfD54
         6C76Nb1Qpet2bYsW7fo9yEqi/611vpZXAPmunxtTk0rMJSSAE2TPLUqJHg99APFOBGHk
         yUyQ==
X-Received: by 10.180.94.5 with SMTP id cy5mr5654764wib.11.1404323397890;
        Wed, 02 Jul 2014 10:49:57 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:57 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252823>

`do_pick` is the git-cherry-pick wrapper in git-rebase--interactive
that is used to implement the to-do list command `pick`, `reword` and
`edit`. To cater for the different pick behaviours (like `squash`),
`do_pick` accepts several options not only from the git-cherry-pick
but also the git-commit interface.

Add the option `--file` from the git-commit interface to the options
pool of `do_pick`. It expects an argument itself which is interpreted
as a file path and takes the commit message from the given file. If
`--file` is passed to `do_pick`, assign the given file path to the
local variable `rewrite_message` and relay the option

    --file "$rewrite_message"

to the git-commit command line which creates the commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 046d358..47e3edf 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -464,7 +464,7 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--amend] [--edit] <commit>
+# do_pick [--amend] [--file <file>] [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
@@ -474,6 +474,12 @@ record_in_rewritten() {
 #
 #     _This is not a git-cherry-pick option._
 #
+# -F <file>, --file <file>
+#     Take the commit message from the given file. This creates a fresh
+#     commit.
+#
+#     _This is not a git-cherry-pick option._
+#
 # -e, --edit
 #     After picking <commit>, open an editor and let the user edit the
 #     commit message. The editor contents becomes the commit message of
@@ -491,6 +497,7 @@ do_pick () {
 	rewrite=
 	rewrite_amend=
 	rewrite_edit=
+	rewrite_message=
 	while test $# -gt 0
 	do
 		case "$1" in
@@ -504,6 +511,16 @@ do_pick () {
 			rewrite_amend=y
 			git rev-parse --verify HEAD >"$amend"
 			;;
+		-F|--file)
+			if test $# -eq 0
+			then
+				warn "do_pick: option --file specified but no <file> given"
+				return 2
+			fi
+			rewrite=y
+			rewrite_message=$2
+			shift
+			;;
 		-e|--edit)
 			rewrite=y
 			rewrite_edit=y
@@ -550,6 +567,7 @@ do_pick () {
 		git commit --allow-empty --no-post-rewrite -n --no-edit \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
+			   ${rewrite_message:+--file "$rewrite_message"} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 
-- 
2.0.0

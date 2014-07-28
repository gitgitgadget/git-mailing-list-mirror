From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 12/19] rebase -i: teach do_pick the option --file
Date: Tue, 29 Jul 2014 01:18:12 +0200
Message-ID: <584f7f377f7fff75dae6fc91089383188820ed82.1406589435.git.bafain@gmail.com>
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
	id 1XBuEK-0006Li-Da
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbaG1XU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:20:58 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:60223 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbaG1XUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:20:55 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so8025033wes.18
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s/kMNAWyiZT/LaYxxpgpy/nKYOJJ0rQnfUelznDrE8E=;
        b=kdxjnJvv/TVBHi6RDpiASBDkLiugHMZo938ZfpFAHnB8N4wkLG2+XlrtH4Li/QGv0r
         lMO5eQ1ALOGyeEiRGLoPD1uT1L/clFzsdBtKQxNWhwPJyIGqiWC6QEZS9i/jY4oouySj
         63Um6Ix7uZ4HUTMjp4UR+KrBGj99iZx5JCPFOgypcfEw04BLIwdtxXjjN6ASibZMa30g
         DIAC2YdA4GkjJnS9FRWNvKFPFAwpJNwR42O/vt/L8NrhMmn4gu4MfU9Hi2EpDuEPBBBG
         Y8ltQ2vkQyAKWG3yZP54zrTbWs6RUlwwQvn7JYdy/xOOu6DhIXYTV4WJgQLEkKC3QDpN
         ayXw==
X-Received: by 10.194.191.131 with SMTP id gy3mr55196994wjc.108.1406589654056;
        Mon, 28 Jul 2014 16:20:54 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:20:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254370>

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
index 22a8f7b..5df1086 100644
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
@@ -492,6 +498,7 @@ do_pick () {
 	rewrite=
 	rewrite_amend=
 	rewrite_edit=
+	rewrite_message=
 	while test $# -gt 0
 	do
 		case "$1" in
@@ -505,6 +512,16 @@ do_pick () {
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
@@ -553,6 +570,7 @@ do_pick () {
 			   ${allow_empty_message:+--allow-empty-message} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
+			   ${rewrite_message:+--file "$rewrite_message"} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 
-- 
2.0.1

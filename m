From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 17/27] rebase -i: teach do_pick the option --file
Date: Mon, 18 Aug 2014 23:23:00 +0200
Message-ID: <7fde59a391dea9474eb9b2ad07667fe528086922.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPe-0000aA-Qz
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbaHRVYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:19 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36239 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbaHRVYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:12 -0400
Received: by mail-la0-f43.google.com with SMTP id gi9so2616164lab.16
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+gu7COCrevXHBsE3LqtjnAvWl0lpI7uTf1vsmkRcQeU=;
        b=VI6FJX3UTnTctybJhulkFbEM4ZGDqQzooNG8l1nz/iyT9TvLB1bsS6fqJG4OvD3V/X
         EZAjfmtWZVH/X7T8ghT80sl0PvI1jvEnm1SpVoBdrvvfYq1lfEdHqHRh2jj4WjrVgtZb
         eUGxW9rKufg22asqennaHmMTmj/A3JZd3a5nr+p6y+iubp4xuOjqwynrX/b6JsQ04Ta5
         fC8E+ZnWiYn07Gnf8jMOWJbDhmzFazUBn+EvxdLBsO1+TbJhPvL4t8pEnn7FlHBC90FT
         HuatmLO/YCYTDiGWeaqs5d26VmvZN+iBj9e6tHs8jOc6L7+8nr1uRB+UX7ewInAadbTu
         3zzw==
X-Received: by 10.153.6.7 with SMTP id cq7mr32348650lad.9.1408397051102;
        Mon, 18 Aug 2014 14:24:11 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255422>

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
index 20a637a..f8be238 100644
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
@@ -555,6 +572,7 @@ do_pick () {
 			   ${allow_empty_message:+--allow-empty-message} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit --commit-msg} \
+			   ${rewrite_message:+--file "$rewrite_message"} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
-- 
2.0.1

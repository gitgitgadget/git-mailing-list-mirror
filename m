From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 16/23] rebase -i: teach do_pick the option --file
Date: Thu,  7 Aug 2014 01:59:23 +0200
Message-ID: <c5314115f5b9e32b38821dfff9c8549ee8d77e87.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8k-0004DU-Ak
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbaHGAAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:53 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:33877 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbaHGAAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:52 -0400
Received: by mail-qg0-f54.google.com with SMTP id z60so3562925qgd.41
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9oTOMB3BX83kEswqsLsWSzHagwdZ/YaVGk4UQE08b24=;
        b=hHwgYUtvMhS9JUn87DdWeYN1gBV7vhaXjdukXKZVKXfOBuyz58mCEDDwEHFJ6uf+pm
         3RWBSDT5tmZJrvGGqSKYNqNszsvKX6OE1umFnyqLAn1MO7ll11TsbBL1wo161YLr/B7k
         qCnLuAoHTXe9hzF8d+oLGeiso8pYtB35G3ckR84assMedYXgvAufPkj3aE/6YcVV29tM
         v7yaaAHo4fTKZ4EpzpFFJ+XCWXc5TCh56ByBucmCQUauwoBTXt1x//d7C6MuiHYiBtWK
         6chh6EZAlJXvNYzK6dKQKGC1YkWH6++mGyOhdD7nlKf8aGBYROO4z6oxOW42qXuXaOkD
         jAPg==
X-Received: by 10.140.40.84 with SMTP id w78mr8001628qgw.87.1407369651448;
        Wed, 06 Aug 2014 17:00:51 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:50 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254931>

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
index 0871302..0fbf773 100644
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
 			   ${rewrite_edit:+--edit --commit-msg} \
+			   ${rewrite_message:+--file "$rewrite_message"} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 }
-- 
2.0.1

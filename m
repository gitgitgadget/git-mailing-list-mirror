From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 17/19] rebase -i: teach do_pick the option --reset-author
Date: Tue, 29 Jul 2014 01:18:17 +0200
Message-ID: <8bca331f9a5caa7d9667eaedb67f1e1d0eb4ea1e.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEM-0006Li-E6
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbaG1XVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:06 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:40989 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbaG1XVC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:21:02 -0400
Received: by mail-wi0-f181.google.com with SMTP id bs8so89599wib.8
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OoATqixNeEp0NL7kowTXGHMvuaBqsMULGdMJMSLZL3A=;
        b=EzA8uRyE28hYkeUldSy7nOC4fox2hb5dcVWBc5DClRDZ9jpJg39HowVntZrnlDgkJm
         zrpakmtB/O22QyTwszoczgrW8rnysN4dUqzRYzKIBDa2COYpB2+ffUJpy0wtMFnXA3oN
         VWCq3t13bja2CJi9p0MAmvxdskrj66aZIp+8Xiv43B9UTfgkaOigHuoV6NLyob2dCBhE
         KHE6MYD8ZYO6JHb4XBiz3WPAu6JFAJGvyw4Av9tT3SFHG14A2sq+yHFCIHg5heskKQAZ
         VIxuJU8UXeKcqhRHMUrJae6jc0EARosgY03c1dzuTaasX/wttwKlhbV/TIVLO5Yssj/Q
         J6tg==
X-Received: by 10.180.80.70 with SMTP id p6mr36219837wix.22.1406589661173;
        Mon, 28 Jul 2014 16:21:01 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.20.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:21:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254378>

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
index ff4ba7f..3886a80 100644
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
 			if test "$(git rev-parse HEAD)" = "$squash_onto" || ! git rev-parse --verify HEAD
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
 		git commit --allow-empty --no-post-rewrite -n --no-edit \
@@ -571,6 +591,7 @@ do_pick () {
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
+			   ${rewrite_author:+--reset-author} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 
-- 
2.0.1

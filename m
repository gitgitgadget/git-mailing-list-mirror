From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 17/19] rebase -i: Teach do_pick the option --reset-author
Date: Wed,  2 Jul 2014 19:48:09 +0200
Message-ID: <baceb6e5770c530d938f497dd07ebb37efd518e1.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgB-0007LI-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbaGBRuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:12 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:46576 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756693AbaGBRuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:50:09 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so11842672wes.12
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5sbcgBafWH4wnovPM17s55OJ2FBO9ORbIkRkE2BejnU=;
        b=OzfZoV7K+1Iq2YpCddd2y4X0cxJZLOgv0rQ9oK2f6EeXiXdeZ01u57yhlz3v8QtmOB
         6Vh+1pFw3TxVxdw7nqvKKDHare+1sjugDjys4YrZEjz+KOzbPoPYJfLf5DQo30ldAGUn
         jbkpOwSdbF821juGQByksCrGtBo8+33AkklQ+EjOvMQ+DhzualicL40004tj/lnuRl7x
         ODXfDIjiJ8iZ/J3oaG8UIgayHd3E1y4koJ7HvMiUJShuM4hPXWyMBTTnmY4auFHNBAB/
         AWvF8ABxEYU3l412PB3eoamIqRhKzJWAtYj9sfqhjcvTNyex6ejH7Ii0btbpi/GapRpU
         GfjA==
X-Received: by 10.194.63.77 with SMTP id e13mr5151316wjs.104.1404323408633;
        Wed, 02 Jul 2014 10:50:08 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.50.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:50:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252817>

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
index 2119d00..a9fcb76 100644
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
@@ -501,6 +509,10 @@ do_pick () {
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
@@ -562,12 +574,21 @@ do_pick () {
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
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
+			   ${rewrite_author:+--reset-author} \
 			   ${gpg_sign_opt:+"$gpg_sign_opt"} || return 3
 	fi
 
-- 
2.0.0

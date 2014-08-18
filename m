From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v3 24/27] rebase -i: teach do_pick the option --signoff
Date: Mon, 18 Aug 2014 23:23:07 +0200
Message-ID: <e6224211727d9a1f3edfb00f417f4ac9e385b9f3.1408396036.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1408396036.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 23:24:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJUPt-0000iP-2G
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 23:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428AbaHRVY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 17:24:28 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34946 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbaHRVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 17:24:25 -0400
Received: by mail-lb0-f171.google.com with SMTP id l4so4767656lbv.16
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7LVvdbq0gwwFK6pOYx9GVOZsxA11PFrqkqCc5fotmfM=;
        b=F7vLGI0njQRkwAxEEjljVoTl3T+vAQf0R7NiOHxu+n69w33WT3t4S+VK+Ky8b1snag
         NjSm5UDQq25IfpmxZMgNWnKDOUCeBj6KgLkWWYojG7ZNjqS71pCkzttcNelsVDLWnJfG
         KifLWaPuLjpAb/YQJjc7iktSWue+wAmWmG4XVxfBWvX5o4NaNhgJLr1xwKf0EIegCAeo
         Pygt5Za02AL9H54kBuSiX0vrGboRqvhT2HeR45rWWT/X5YzT8NscmvMJ3jL0QWXJdskE
         rs+dfZdW30mG6E0pmBtoaxzULkqCZJO0hBWa8XqvopnUkJ2QowvSsNVWFOw7MW2yj/bU
         4joA==
X-Received: by 10.152.5.194 with SMTP id u2mr15212066lau.68.1408397064063;
        Mon, 18 Aug 2014 14:24:24 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id m9sm28852273lbd.28.2014.08.18.14.24.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Aug 2014 14:24:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1408396036.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255427>

`do_pick` is the git-cherry-pick wrapper in git-rebase--interactive
that is currently used to implement most of the to-do list commands
and offers additional options that will eventually find their way
onto to-do lists.

To extend the repertoire of available options, add the git-commit and
git-cherry-pick option `--signoff` to the `do_pick` interface. It
appends a Signed-off-by: line using the committer identity to the log
message of the picked commit.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6c75bc5..73c97a1 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -464,10 +464,15 @@ record_in_rewritten() {
 
 # Apply the changes introduced by the given commit to the current head.
 #
-# do_pick [--reset-author] [--amend] [--file <file>] [--edit] <commit>
+# do_pick [--signoff] [--reset-author] [--amend] [--file <file>]
+#         [--edit] <commit>
 #
 # Wrapper around git-cherry-pick.
 #
+# -s, --signoff
+#     Insert a Signed-off-by: line using the committer identity at the
+#     end of the commit log message. This creates a fresh commit.
+#
 # --reset-author
 #     Pretend the changes were made for the first time. Declare that the
 #     authorship of the resulting commit now belongs to the committer.
@@ -504,6 +509,7 @@ record_in_rewritten() {
 do_pick () {
 	allow_empty_message=y
 	rewrite=
+	rewrite_signoff=
 	rewrite_reset_author=
 	rewrite_amend=
 	rewrite_edit=
@@ -511,6 +517,10 @@ do_pick () {
 	while test $# -gt 0
 	do
 		case "$1" in
+		-s|--signoff)
+			rewrite=y
+			rewrite_signoff=y
+			;;
 		--reset-author)
 			rewrite=y
 			rewrite_reset_author=y
@@ -588,6 +598,7 @@ do_pick () {
 		$do_with_author output git commit \
 			   --allow-empty --no-post-rewrite -n --no-edit \
 			   ${allow_empty_message:+--allow-empty-message} \
+			   ${rewrite_signoff:+--signoff} \
 			   ${rewrite_amend:+--amend ${rewrite_reset_author:+--reset-author}} \
 			   ${rewrite_edit:+--edit --commit-msg} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
-- 
2.0.1

From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1 18/19] rebase -i: teach do_pick the option --signoff
Date: Tue, 29 Jul 2014 01:18:18 +0200
Message-ID: <c0443c7c2b1367868593baf52a49fc5f8d15b476.1406589435.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1406589435.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 01:21:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBuEL-0006Li-UG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 01:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbaG1XVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 19:21:05 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38375 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaG1XVD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 19:21:03 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so86581wiv.13
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 16:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wzQ2EQCsO6TPcy1/XiRb38nMgLNViEipnu7Xzp0wX+w=;
        b=YoisieD0Qznu7nMuNuAkLmlWkL9h+pr2MisdL7Our5eEPGEqHRFeIpAALjjv9tMxg7
         Wg/bMBuKqyHBKX3FHrEszQJHkDwWTxi+jxKcI8Hdx2lGm97MGIJqWL/TA9kvYPsQEYUY
         ddMGancAeEAPh+AzsOk1dWO9ce0jONIsHtCvPz1pmNk+PwGtEZ6C+/xLiit926H3aLWv
         KA78hsajQHOTJU1RvcVTHm4edNATbCLwz44Uqnd8SmVco74/z8BFmvjXYOUtCqbu43jK
         AkMDx90W6KQIOcag0CecxKixvMd8q8nXcdZ36X2ViZREP3RTYv1QyiQNNGOKeaPWGqcw
         ibQw==
X-Received: by 10.180.214.103 with SMTP id nz7mr968099wic.0.1406589662574;
        Mon, 28 Jul 2014 16:21:02 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id pj6sm52914690wjb.21.2014.07.28.16.21.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jul 2014 16:21:01 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254374>

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
 git-rebase--interactive.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 3886a80..9324ed3 100644
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
@@ -510,6 +515,10 @@ do_pick () {
 	while test $# -gt 0
 	do
 		case "$1" in
+		-s|--signoff)
+			rewrite=y
+			rewrite_signoff=y
+			;;
 		--reset-author)
 			rewrite=y
 			rewrite_author=y
@@ -588,6 +597,7 @@ do_pick () {
 	then
 		git commit --allow-empty --no-post-rewrite -n --no-edit \
 			   ${allow_empty_message:+--allow-empty-message} \
+			   ${rewrite_signoff:+--signoff} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
-- 
2.0.1

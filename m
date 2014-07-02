From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 18/19] rebase -i: Teach do_pick the option --signoff
Date: Wed,  2 Jul 2014 19:48:10 +0200
Message-ID: <b55f924521f19fbdc0b2d9525b2929a4422893ea.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OgC-0007LI-7j
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbaGBRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:50:44 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:35404 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbaGBRuM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:50:12 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so11753400wes.13
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=83W0hj3HFVlOKzCw2voAG2YXe4LkM4cCUfScAnC2bto=;
        b=PA/B3rAs1Qb00MJOc0lA6QImeR6p0tUbA9ClPuYjPpvPLAlPyyYg6R3UrDADAla78h
         Qwk40fkLQhHwYUEKSpn9V2UopqauBYqnwBxVpj+5lNAqLBBU/E7sL6j9+8Z08fLCDvNe
         WtsKgGhQ2ZdX5cc60LvOAJdJVGvrtHpTjvTkY40nnW1lAowhWif678AwH7UImQp1LfeP
         gc+rM72rfo3+ZZNpbreJcEJx3VQ+1mYIHuLvS5FyhNeq03r5c2/1MJjsRXuJgWusnUYo
         roJLToWru5ScC/3gzuVjPMDHSVDf+09Mn8nSSvMtZfWsOaHO8XU+DyG3yPJEvR4gbS8y
         nDAw==
X-Received: by 10.195.13.102 with SMTP id ex6mr59189246wjd.48.1404323410942;
        Wed, 02 Jul 2014 10:50:10 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.50.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:50:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252818>

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
index a9fcb76..bb258bb 100644
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
@@ -509,6 +514,10 @@ do_pick () {
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
@@ -585,6 +594,7 @@ do_pick () {
 	if test -n "$rewrite"
 	then
 		git commit --allow-empty --no-post-rewrite -n --no-edit \
+			   ${rewrite_signoff:+--signoff} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
-- 
2.0.0

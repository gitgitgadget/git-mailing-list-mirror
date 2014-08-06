From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 22/23] rebase -i: teach do_pick the option --signoff
Date: Thu,  7 Aug 2014 01:59:29 +0200
Message-ID: <334ed52a4b3a27944c9d616c087b15e31fa439d3.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8m-0004DU-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595AbaHGABD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:01:03 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:33623 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754579AbaHGABC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:01:02 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so3566271qgf.7
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oW+otzY6dVdw3I0JEgnb3Inysw/Xp/QpBOOb62cj898=;
        b=AmjjkT17ZoI72zvea80ZvRvTJ6H91rxvJXedgYaZTgmTASuM6YuTenHFI7p0TJ6sxd
         KHD0RVbjGIAKEkMJgL2tgUGLk96LKENRr/lLB4lDP+ixJl9A0+m7ha2cfSdYuYDovxpE
         0Tmv8w/aattm9i8AX5oTWeLEsjA70rqzj56Wb35go/NRq5qALvpkymZwsZ67+kKn+PnA
         F5W0liUacaYSJz1NmWe7LUJ/+xAuR37ift1FidwSPmKhwXd1jvbvbSmv81+ZcyVPZ8x6
         Of4wdaOQu75RE2WzMy06OyiFkABtxNnZVDXRQj2hxyZnS3i/ShVZbpWQES3THa9etrQx
         XHHg==
X-Received: by 10.224.79.139 with SMTP id p11mr21050577qak.93.1407369661137;
        Wed, 06 Aug 2014 17:01:01 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:01:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254934>

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
index d6c99ea..a22459f 100644
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
 		output git commit --allow-empty --no-post-rewrite -n --no-edit \
 			   ${allow_empty_message:+--allow-empty-message} \
+			   ${rewrite_signoff:+--signoff} \
 			   ${rewrite_amend:+--amend} \
 			   ${rewrite_edit:+--edit --commit-msg} \
 			   ${rewrite_message:+--file "$rewrite_message"} \
-- 
2.0.1

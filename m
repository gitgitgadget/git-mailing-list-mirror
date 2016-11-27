Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01151FF6D
	for <e@80x24.org>; Sun, 27 Nov 2016 21:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbcK0Vb1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 16:31:27 -0500
Received: from zeus.kcolford.com ([45.79.167.181]:58874 "EHLO
        zeus.kcolford.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbcK0VbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 16:31:25 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Nov 2016 16:31:25 EST
Received: from prometheus.kcolford.com (unknown [IPv6:2607:fea8:959f:fb1c::b])
        by zeus.kcolford.com (Postfix) with ESMTPSA id 2511321FA3;
        Sun, 27 Nov 2016 21:22:07 +0000 (UTC)
From:   Kieran Colford <kieran@kcolford.com>
To:     git@vger.kernel.org
Cc:     Kieran Colford <kieran@kcolford.com>
Subject: [PATCH] contrib/subtree: added --no-show-signature to git log invocation
Date:   Sun, 27 Nov 2016 16:21:59 -0500
Message-Id: <20161127212159.30233-1-kieran@kcolford.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When having log.showSignature enabled by default (as is good practice
with signed commits), it still shows the signature when git-subtree
passes custom format specifiers to git-log.  This causes an error when
trying to push a subtree when signed commits are involved.

Adding this command line flag fixes the above bug.  The command line
flag was added to all invocations of git-log so that it would behave
as expected by the original developers.

The flag could be more judiciously applied, but that requires a deeper
understanding of the code.  It may be more desirable to disable
--show-signature when any custom format specifier is given, but that
change has far more wide reaching consequences, as well as a change to
the documentation.

Signed-off-by: Kieran Colford <kieran@kcolford.com>
---
 contrib/subtree/git-subtree.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a..d9e89d1 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,7 +296,7 @@ find_latest_squash () {
 	sq=
 	main=
 	sub=
-	git log --grep="^git-subtree-dir: $dir/*\$" \
+	git log --no-show-signature --grep="^git-subtree-dir: $dir/*\$" \
 		--pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
 	while read a b junk
 	do
@@ -340,7 +340,7 @@ find_existing_splits () {
 	revs="$2"
 	main=
 	sub=
-	git log --grep="^git-subtree-dir: $dir/*\$" \
+	git log --no-show-signature --grep="^git-subtree-dir: $dir/*\$" \
 		--pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
 	while read a b junk
 	do
@@ -382,7 +382,7 @@ copy_commit () {
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
-	git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
+	git log --no-show-signature -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL
@@ -462,8 +462,8 @@ squash_msg () {
 		oldsub_short=$(git rev-parse --short "$oldsub")
 		echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
 		echo
-		git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
-		git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
+		git log --no-show-signature --pretty=tformat:'%h %s' "$oldsub..$newsub"
+		git log --no-show-signature --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
 	else
 		echo "Squashed '$dir/' content from commit $newsub_short"
 	fi
@@ -475,7 +475,7 @@ squash_msg () {
 
 toptree_for_commit () {
 	commit="$1"
-	git log -1 --pretty=format:'%T' "$commit" -- || exit $?
+	git log --no-show-signature -1 --pretty=format:'%T' "$commit" -- || exit $?
 }
 
 subtree_for_commit () {
-- 
2.10.2


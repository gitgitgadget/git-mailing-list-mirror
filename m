From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH RFC v2 06/19] rebase -i: Stop on root commits with empty log messages
Date: Wed,  2 Jul 2014 19:47:58 +0200
Message-ID: <00ca9dc0d1750301aa22c2bb78976b141233cef3.1404323078.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1404323078.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 19:50:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2OfU-0006lZ-MW
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 19:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbaGBRtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 13:49:49 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:39764 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932209AbaGBRtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 13:49:46 -0400
Received: by mail-we0-f176.google.com with SMTP id u56so11683630wes.7
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 10:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=khcORhIOSYU6mVCC/Z/PRqa44gJBb7zjwVrfyiz+s7I=;
        b=CP+6w+05w2/bwGylSslLPwKbDdVswJ8ARwgywIo3yNPP/MXUEA+NNGKXvvtBZdflhK
         ePX8mYpa+6kSsjRTIKZ0fh7l3puVj1U0xQkIoIC/+D+XfTbnlL+jeAcHiYXR7V/z3Nn2
         uw2l6aHfZAHahFuWlXv84/3V7CRBG0QaGBEG4o3ggTYBCLCxXdk3lm6zOzyc4QG0Q/4f
         JnuxaMu3Vi0SgQ8x8onaKQHn7W4Jrlv24N/m3XG5l1/PDIKF9OouVBirEVBYmkoasn8E
         X068Y8ffa0GW1ptEtfZD35xdIep+ymO53l+2qGSOnUDEXo+ublDK2a3cBD3gU+83jlAE
         kxZQ==
X-Received: by 10.194.63.77 with SMTP id e13mr5149455wjs.104.1404323385022;
        Wed, 02 Jul 2014 10:49:45 -0700 (PDT)
Received: from puffy.de (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id eo4sm57503504wid.4.2014.07.02.10.49.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Jul 2014 10:49:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <cover.1404323078.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252811>

The command line used to recreate root commits specifies the
erroneous option `--allow-empty-message`. If the root commit has an
empty log message, the replay of this commit should fail and the
rebase should be interrupted like for any other commit that is on the
to-do list and has an empty commit message. Remove the option.

The option might have been introduced by copy-and-paste of the first
part of the command line which initializes the authorship of the
sentinel commit. Indeed, the sentinel commit has an empty log message
and this should not trigger a failure, which is why the option
`--allow-empty-message` is correctly specified here.

Add test.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh |  2 +-
 t/t3412-rebase-root.sh     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4c875d5..0af96f2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -510,7 +510,7 @@ do_pick () {
 		git commit --allow-empty --allow-empty-message --amend \
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
-			git commit --allow-empty --allow-empty-message \
+			git commit --allow-empty \
 				   --amend --no-post-rewrite -n -q -C $1 \
 				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
 			die_with_patch $1 "Could not apply $1... $2"
diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
index 0b52105..9867705 100755
--- a/t/t3412-rebase-root.sh
+++ b/t/t3412-rebase-root.sh
@@ -278,4 +278,43 @@ test_expect_success 'rebase -i -p --root with conflict (second part)' '
 	test_cmp expect-conflict-p out
 '
 
+test_expect_success 'stop rebase --root on empty root log message' '
+	# create a root commit with a non-empty tree so that rebase does
+	# not fail because of an empty commit, and an empty log message
+	echo root-commit >file &&
+	git add file &&
+	tree=$(git write-tree) &&
+	root=$(git commit-tree $tree </dev/null) &&
+	git checkout -b no-message-root-commit $root &&
+	# do not ff because otherwise neither the patch nor the message
+	# are looked at and checked for emptiness
+	test_when_finished git rebase --abort &&
+	test_must_fail env EDITOR=true git rebase -i --force-rebase --root &&
+	echo root-commit >file.expected &&
+	test_cmp file.expected file
+'
+
+test_expect_success 'stop rebase --root on empty child log message' '
+	# create a root commit with a non-empty tree and provide a log
+	# message so that rebase does not fail until the root commit is
+	# successfully replayed
+	echo root-commit >file &&
+	git add file &&
+	tree=$(git write-tree) &&
+	root=$(git commit-tree $tree -m root-commit) &&
+	git checkout -b no-message-child-commit $root &&
+	# create a child commit with a non-empty patch so that rebase
+	# does not fail because of an empty commit, but an empty log
+	# message
+	echo child-commit >file &&
+	git add file &&
+	git commit --allow-empty-message --no-edit &&
+	# do not ff because otherwise neither the patch nor the message
+	# are looked at and checked for emptiness
+	test_when_finished git rebase --abort &&
+	test_must_fail env EDITOR=true git rebase -i --force-rebase --root &&
+	echo child-commit >file.expected &&
+	test_cmp file.expected file
+'
+
 test_done
-- 
2.0.0

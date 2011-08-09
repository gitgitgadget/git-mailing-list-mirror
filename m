From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 1/1] bisect: add support for bisecting bare repositories
Date: Tue,  9 Aug 2011 12:11:54 +1000
Message-ID: <1312855914-610-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:12:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqbng-0003Ns-Ac
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 04:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab1HICMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 22:12:07 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:34569 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1HICMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 22:12:06 -0400
Received: by pzk37 with SMTP id 37so9271602pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 19:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=zFHbfqUBNNiHSNzcIcA5gDqRZ4ujWiMtnE3vtOyb13s=;
        b=fV/H4YqZYZMCJy+3yEEM68mhYwnRp8Lfpr85yDrGhF/K9zg07a5SJwuZ3lXwASXXH7
         A81u33axBbonQP5oN5UtC5BE/Jp5EvN0QiF7whXuMmo9WcwIcH+wz3QhEzDs/9ideZrB
         biEsc50BRHErYRGNQuHar9PCWr+wPQtEyUWC0=
Received: by 10.142.240.9 with SMTP id n9mr5591012wfh.104.1312855924934;
        Mon, 08 Aug 2011 19:12:04 -0700 (PDT)
Received: from localhost.localdomain (bh02i525f01.au.ibm.com [202.81.18.30])
        by mx.google.com with ESMTPS id 14sm2794990wfl.5.2011.08.08.19.12.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Aug 2011 19:12:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.523.g2ad34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179018>

This extension to js/bisect-no-checkout adds support for bisecting bare repositories.

It does this by relaxing the requirement that git bisect is invoked in a repository with a working tree and by defaulting to --no-checkout in the case of a bare repository.

Two tests are included to demonstrate this behaviour.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-bisect.txt |    2 ++
 git-bisect.sh                |    8 ++++++--
 git.c                        |    2 +-
 t/t6030-bisect-porcelain.sh  |   31 +++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

v3: squashed entire series.

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 41e6ca8..e4f46bc 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -273,6 +273,8 @@ it point to the commit that should be tested.
 +
 This option may be useful when the test you would perform in each step
 does not require a checked out tree.
++
+If the repository is bare, `--no-checkout` is assumed.
 
 EXAMPLES
 --------
diff --git a/git-bisect.sh b/git-bisect.sh
index 22c4da5..e0ca3fb 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -29,7 +29,6 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 . git-sh-i18n
-require_work_tree
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
@@ -79,7 +78,12 @@ bisect_start() {
 	orig_args=$(git rev-parse --sq-quote "$@")
 	bad_seen=0
 	eval=''
-	mode=''
+	if test "z$(git rev-parse --is-bare-repository)" != zfalse
+	then
+		mode=--no-checkout
+	else
+		mode=''
+	fi
 	while [ $# -gt 0 ]; do
 		arg="$1"
 		case "$arg" in
diff --git a/git.c b/git.c
index 8828c18..7fdcab2 100644
--- a/git.c
+++ b/git.c
@@ -320,7 +320,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "annotate", cmd_annotate, RUN_SETUP },
 		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive },
-		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE },
+		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 		{ "blame", cmd_blame, RUN_SETUP },
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle, RUN_SETUP_GENTLY },
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 4fb7d11..62125ec 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -592,6 +592,37 @@ test_expect_success 'erroring out when using bad path parameters' '
 	grep "bad path parameters" error.txt
 '
 
+test_expect_success 'test bisection on bare repo - --no-checkout specified' '
+	git clone --bare . bare.nocheckout &&
+	(
+		cd bare.nocheckout &&
+		git bisect start --no-checkout &&
+		git bisect good $HASH1 &&
+		git bisect bad $HASH4 &&
+		git bisect run eval \
+			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
+			>../nocheckout.log &&
+		git bisect reset
+	) &&
+	grep "$HASH3 is the first bad commit" nocheckout.log
+'
+
+
+test_expect_success 'test bisection on bare repo - --no-checkout defaulted' '
+	git clone --bare . bare.defaulted &&
+	(
+		cd bare.defaulted &&
+		git bisect start &&
+		git bisect good $HASH1 &&
+		git bisect bad $HASH4 &&
+		git bisect run eval \
+			"test \$(git rev-list BISECT_HEAD ^$HASH2 --max-count=1 | wc -l) = 0" \
+			>../defaulted.log &&
+		git bisect reset
+	) &&
+	grep "$HASH3 is the first bad commit" defaulted.log
+'
+
 #
 # This creates a broken branch which cannot be checked out because
 # the tree created has been deleted.
-- 
1.7.6.523.g2ad34

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] pull: add merge-ff-only option
Date: Mon,  2 Sep 2013 17:17:58 -0500
Message-ID: <1378160278-14872-7-git-send-email-felipe.contreras@gmail.com>
References: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 00:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcWc-00015U-5e
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759136Ab3IBWXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:23:07 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57506 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759124Ab3IBWXF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:23:05 -0400
Received: by mail-oa0-f45.google.com with SMTP id m6so1873370oag.4
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X7vGQl83b+k2cP15xA6YlCMhlhQ9YUz09Tq5iVVS5w8=;
        b=bpzPzffZ1CKSFTNIwTfy4QathOiGORBGAaG5kUW4o0QcFaSpoI8YWWoyNpgQOIKiri
         VFtb3BB4SN4xx70e6ujGGAJFYrkQGMLPmayszI5cF5g7R6oSrz2uYxfnmlRtxtJx9I3T
         dlKbWW5Cs5sdgNbUGp0UnMmi+lKybRHvtBC9x0qoJWFTolTidy9NjAhw1UcUtfRhTTug
         Zt8JnJYTqvZ85QGOtOceY3Ga3i0xJZGKfrU3Bz3vkkirrS5DUk/ccjbLDrUSp740LQbC
         wzYEyMu16nYNoygePVys0ifRKHRKmLir96JT/T9vJbJkT8MpuiGPIhJDturJkxB87cq4
         cyrg==
X-Received: by 10.182.106.4 with SMTP id gq4mr18612671obb.4.1378160585551;
        Mon, 02 Sep 2013 15:23:05 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id uz16sm15179723obc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:23:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233669>

It is very typical for Git newcomers to inadvertently create merges and
worst, inadvertently pushing them. This is one of the reasons many
experienced users prefer to avoid 'git pull', and recommend newcomers to
avoid it as well.

To avoid these problems and keep 'git pull' useful it has been suggested
that 'git pull' barfs by default if the merge is non-fast-forward, which
unfortunately would break backwards compatibility.

This patch leaves everything in place to enable this new mode, but it
only gets enabled if the user specifically configures it; pull.mode =
merge-ff-only.

Later on this mode can be enabled by default (e.g. in v2.0).

For the full discussion you can read:

http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=225305

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt |  8 +++++---
 builtin/merge.c          |  9 ++++++++-
 git-pull.sh              |  7 +++++++
 t/t5520-pull.sh          | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9489a59..13635e0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1822,9 +1822,11 @@ pretty.<name>::
 
 pull.mode::
 	When "git pull" is run, this determines if it would either merge or
-	rebase the fetched branch. The possible values are 'merge' and
-	'rebase'. See "branch.<name>.pullmode" for doing this in a non
-	branch-specific manner.
+	rebase the fetched branch. The possible values are 'merge',
+	'rebase', and 'merge-ff-only'. If 'merge-ff-only' is specified, the
+	merge will only succeed if it's fast-forward. See
+	"branch.<name>.pullmode" for doing this in a non branch-specific
+	manner.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/builtin/merge.c b/builtin/merge.c
index da9fc08..97b4205 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1437,8 +1437,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (fast_forward == FF_ONLY)
+	if (fast_forward == FF_ONLY) {
+		const char *msg = getenv("GIT_MERGE_FF_ONLY_HELP");
+		if (msg) {
+			fprintf(stderr, "%s\n", msg);
+			ret = 1;
+			goto done;
+		}
 		die(_("Not possible to fast-forward, aborting."));
+	}
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/git-pull.sh b/git-pull.sh
index fbb8a9b..a9cf7ac 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -62,6 +62,7 @@ then
 		echo "Please use pull.mode and branch.<name>.pullmode instead."
 	fi
 fi
+test -z "$mode" && mode=merge
 dry_run=
 while :
 do
@@ -307,6 +308,12 @@ then
 	fi
 fi
 
+if test "$mode" = merge-ff-only -a -z "$no_ff$ff_only${squash#--no-squash}"
+then
+	ff_only=--ff-only
+	export GIT_MERGE_FF_ONLY_HELP="The pull was not fast-forward, please either merge or rebase."
+fi
+
 merge_name=$(git fmt-merge-msg $log_arg <"$GIT_DIR/FETCH_HEAD") || exit
 case "$mode" in
 rebase)
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 978a3c1..798ae2f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -310,4 +310,40 @@ test_expect_success 'branch.to-rebase.pullmode should override pull.mode' '
 	test new = $(git show HEAD:file2)
 '
 
+test_expect_success 'git pull fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull
+'
+
+test_expect_success 'git pull non-fast-forward' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	test_must_fail git pull
+'
+
+test_expect_success 'git pull non-fast-forward (merge)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	test_config pull.mode merge-ff-only &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull --merge
+'
+
 test_done
-- 
1.8.4-338-gefd7fa6

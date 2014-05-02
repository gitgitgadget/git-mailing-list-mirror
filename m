From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 6/7] pull: add warning on non-ff merges
Date: Thu,  1 May 2014 19:00:07 -0500
Message-ID: <1398988808-29678-7-git-send-email-felipe.contreras@gmail.com>
References: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	"Brian M. Carlson" <sandals@crustytoothpaste.net>,
	"W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 02:11:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg14c-00015g-4G
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbaEBALV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:11:21 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:61506 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbaEBALU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:11:20 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so4433322obc.29
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V2NDYlBndZ0sb13uwYq0lo4WKB2UYrUaXNx8F7I/32U=;
        b=cQPFZcCTswwe+BEkEIekpgx60TC4BeYMebLP3SdKxWtckSKo5Mj2cUzYIgRFCbC+iN
         XRA+v+hmQCtANr3R1TWgrDgD5e8XWrliJiUA9OaK7EHJEdJTXPO7cWXVItrmgCwy0s5b
         2Eq0Gz875ypVtEyXJsjJddzHIoZKSIgh1OuBPATIcKHIXCTNq3gk1GIJ+SaT4P2tl1BP
         kAL+aXUO0lb6yQbeLFnCkXKB4AhHxE8RUPUIkKLX+GPVi2rSomIkex0vLStSWBP32uWZ
         H+4qk/9J39zT6pEKonHNnTuKsMxPJsHScqKP4z9I75VqqobjyRmyMEOmNfIrehf2vhDR
         1dMw==
X-Received: by 10.60.141.9 with SMTP id rk9mr14005191oeb.12.1398989479725;
        Thu, 01 May 2014 17:11:19 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id rt4sm62659927obb.12.2014.05.01.17.11.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:11:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.19.g85b6256
In-Reply-To: <1398988808-29678-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247906>

To prepare our uses for the upcoming changes we should warn them and let
them know that they will need to specify a merge or a rebase in the
future (when a non-fast-forward situation arises). Also, let them know
we fallback to 'git pull --merge', so when the obsoletion of this mode
comes, they know what to type without interrupting or changing their
workflow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 18 ++++++++++++++++++
 git-pull.sh                | 15 ++++++++++++---
 t/t5520-pull.sh            | 14 ++++++++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 767bca3..fe3d15d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -23,6 +23,7 @@ More precisely, 'git pull' runs 'git fetch' with the given
 parameters and calls 'git merge' to merge the retrieved branch
 heads into the current branch.
 With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+With `--merge`, it forces the merge, even if it's non-fast forward.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
@@ -41,11 +42,28 @@ Assume the following history exists and the current branch is
 ------------
 	  A---B---C master on origin
 	 /
+    D---E master
+------------
+
+Then `git pull` will merge in a fast-foward way up to the new master.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-foward case looks very different.
+
+------------
+	  A---B---C master on origin
+	 /
     D---E---F---G master
 	^
 	origin/master in your repository
 ------------
 
+By default `git pull` will warn about these situations, however, most likely
+you would want to force a merge, which you can do with `git pull --merge`.
+
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
 until its current commit (`C`) on top of `master` and record the
diff --git a/git-pull.sh b/git-pull.sh
index 2446417..c4a0b08 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -78,7 +78,7 @@ then
 		rebase=$(bool_or_string_config pull.rebase)
 	fi
 fi
-test -z "$mode" && mode=merge
+test -z "$mode" && mode=default
 dry_run=
 while :
 do
@@ -317,13 +317,22 @@ case "$merge_head" in
 *)
 	# check if a non-fast-foward merge would be needed
 	merge_head=${merge_head% }
-	if test "$mode" = 'ff-only' && test -z "$no_ff$ff_only${squash#--no-squash}" &&
+	if test -z "$no_ff$ff_only${squash#--no-squash}" &&
 		test -n "$orig_head" &&
 		! git merge-base --is-ancestor "$orig_head" "$merge_head" &&
 		! git merge-base --is-ancestor "$merge_head" "$orig_head"
 	then
-		die "$(gettext "The pull was not fast-forward, please either merge or rebase.
+		case "$mode" in
+		ff-only)
+			die "$(gettext "The pull was not fast-forward, please either merge or rebase.
 If unsure, run 'git pull --merge'.")"
+			;;
+		default)
+			warn "$(gettext "the pull was not fast-forward, in the future you would have to choose
+a merge or a rebase, falling back to old style for now (git pull --merge).
+Read 'git pull --help' for more information.")" >&2
+			;;
+		esac
 	fi
 	;;
 esac
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index a548c1b..c96834e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -401,4 +401,18 @@ test_expect_success 'git pull non-fast-forward with merge (ff-only)' '
 	git pull --merge
 '
 
+test_expect_success 'git pull non-fast-forward (default)' '
+	test_when_finished "git checkout master && git branch -D other test" &&
+	git checkout -b other master^ &&
+	>new &&
+	git add new &&
+	git commit -m new &&
+	git checkout -b test -t other &&
+	git reset --hard master &&
+	git pull 2> error &&
+	cat error &&
+	grep -q "the pull was not fast-forward" error &&
+	grep -q "in the future you would have to choose" error
+'
+
 test_done
-- 
1.9.2+fc1.19.g85b6256

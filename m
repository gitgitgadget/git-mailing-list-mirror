From: Pierre Penninckx <ibizapeanut@gmail.com>
Subject: [PATCH] subtree: add squash handling for split and push
Date: Sat, 23 Nov 2013 21:18:56 +0100
Message-ID: <C3EF61D4-5274-4A10-9594-4E631D75C3F4@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: greened@obbligato.org, amdmi3@amdmi3.ru, john@keeping.me.uk,
	git@cryptocrack.de, techlivezheng@gmail.com, apenwarr@gmail.com,
	cstanfield@antifusion.net, jakub.suder@gmail.com,
	jesse.greenwald@gmail.com, pelle@kodfabrik.se, treese@acm.org,
	wayne@tickzoom.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 23 21:19:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkJfV-00005D-7A
	for gcvg-git-2@plane.gmane.org; Sat, 23 Nov 2013 21:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab3KWUTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 15:19:01 -0500
Received: from mail-we0-f175.google.com ([74.125.82.175]:36872 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab3KWUTA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Nov 2013 15:19:00 -0500
Received: by mail-we0-f175.google.com with SMTP id p61so2395242wes.20
        for <git@vger.kernel.org>; Sat, 23 Nov 2013 12:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version;
        bh=CiLQcMwi/4ioo2/7XUUcLft8+YY+RsoAMlvG5VmKa8s=;
        b=Tn2XstgQbjhk/3c/GgZT1P6Kh5KEyJdv1V0DZPp/SE8Q2o6/PMAx+SdTHfw1W33Pcq
         c/qe/zgJfCu5dJ7ozwj1UZBbERxJgTkoYiO9kNcXisKyUPtZhHfqlOrv1RF7YI3o7cDh
         NXPX1UTuMdBIdNdbO9GFPJnUXbPA0uX82+yytkxpr+1io32eep097FcBoAike5cugbqA
         Lob0SzTJQPtZLqZkG/5lFCWQuyit5FCKW7S55U7ihiJvXTmdjkbJVBNCOFhvrkKYn9Lf
         wyLYhCfDRn+9ZIuKoE1an2wOQv2riH0i7N0TMxMU7X2ojnnn4sX3zGCdfs9KQNqTpax0
         tymA==
X-Received: by 10.194.89.233 with SMTP id br9mr15608311wjb.15.1385237938751;
        Sat, 23 Nov 2013 12:18:58 -0800 (PST)
Received: from [10.118.12.101] ([109.129.140.117])
        by mx.google.com with ESMTPSA id e10sm7593835wiy.7.2013.11.23.12.18.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Nov 2013 12:18:58 -0800 (PST)
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238244>

>From 2763be1fe68d07af60945762178b8494228eb45f Mon Sep 17 00:00:00 2001
From: Pierre Penninckx <ibizapeanut@gmail.com>
Date: Sat, 23 Nov 2013 20:03:20 +0100
Subject: [PATCH] subtree: add squash handling for split and push

The documentation of subtree says that the --squash option can be used
for add, merge, split and push subtree commands but only add and merge
is implemented.

cmd_push() simply forwards the --squash argument to subtree split. All
the job is done by cmd_split().

cmd_split() first lets split do it's job: finding which commits need to
be extracted. Now we remember which commit is the parent of the first
extracted commit. When this step is done, cmd_split() generates a squash
of the new commits, starting from the aforementioned parent to the last
extracted commit. This new commit's sha1 is then used for the rest of
the script.

Tests verify that `git subtree split/push --squash` makes only one
commit where `git subtree split/push` without squash makes two.
---
 contrib/subtree/git-subtree.sh     | 20 ++++++++++++++++++-
 contrib/subtree/t/t7900-subtree.sh | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 7d7af03..76eb136 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -183,6 +183,7 @@ cache_set()
 	newrev="$2"
 	if [ "$oldrev" != "latest_old" \
 	     -a "$oldrev" != "latest_new" \
+	     -a "$oldrev" != "firstnewparents" \
 	     -a -e "$cachedir/$oldrev" ]; then
 		die "cache for $oldrev already exists!"
 	fi
@@ -603,6 +604,10 @@ cmd_split()
 		debug "  parents: $parents"
 		newparents=$(cache_get $parents)
 		debug "  newparents: $newparents"
+		if [ -z "$(cache_get firstnewparents)" ]; then
+			cache_set firstnewparents $newparents
+			debug "  firstnewparents: $(cache_get firstnewparents)"
+		fi

 		tree=$(subtree_for_commit $rev "$dir")
 		debug "  tree is: $tree"
@@ -625,11 +630,18 @@ cmd_split()
 		cache_set latest_new $newrev
 		cache_set latest_old $rev
 	done || exit $?
+
 	latest_new=$(cache_get latest_new)
 	if [ -z "$latest_new" ]; then
 		die "No new revisions were found"
 	fi

+	if [ -n "$squash" ]; then
+		from=$(cache_get firstnewparents)
+		latest_new=$(new_squash_commit "$from" "$from" "$latest_new") || exit $?
+		debug "New squash commit: $latest_new"
+	fi
+
 	if [ -n "$rejoin" ]; then
 		debug "Merging split branch into HEAD..."
 		latest_old=$(cache_get latest_old)
@@ -711,11 +723,17 @@ cmd_push()
 	if [ $# -ne 2 ]; then
 	    die "You must provide <repository> <refspec>"
 	fi
+
+	squash_cmd=
+	if [ -n "$squash" ]; then
+	    squash_cmd="--squash"
+	fi
+
 	if [ -e "$dir" ]; then
 	    repository=$1
 	    refspec=$2
 	    echo "git push using: " $repository $refspec
-	    localrev=$(git subtree split --prefix="$prefix") || die
+	    localrev=$(git subtree split --prefix="$prefix" $squash_cmd) || die
 	    git push $repository $localrev:refs/heads/$refspec
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 66ce4b0..04eea94 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -31,6 +31,16 @@ check_equal()
 	fi
 }

+check_not_equal()
+{
+        check_equal "$1" "$2"
+        if [ $? -eq 0 ]; then
+                return 1
+        else
+                return 0
+        fi
+}
+
 fixnl()
 {
 	t=""
@@ -161,6 +171,36 @@ test_expect_success 'fetch new subproj history' '
         git branch sub2 FETCH_HEAD
 '

+test_expect_success 'check that split and split --squash produce different commits' '
+        split=$(git subtree split --prefix=subdir) &&
+        split_squash=$(git subtree split --prefix=subdir --squash) &&
+        check_not_equal "$split" "$split_squash"
+'
+
+test_expect_success 'check that split and split --squash produce same diff' '
+        split=$(git subtree split --prefix=subdir) &&
+        split_squash=$(git subtree split --prefix=subdir --squash) &&
+        split_diff=$(git diff sub1 $split) &&
+        split_squash_diff=$(git diff sub1 $split_squash) &&
+        check_equal "$split_diff" "$split_squash_diff"
+'
+
+test_expect_success 'check that push introduces two commits in subproj' '
+        git subtree push --prefix=subdir subproj mainline &&
+        cd subproj &&
+        check_equal "$(git rev-parse mainline~2)" "$(git rev-parse sub1)" &&
+        git branch -D mainline &&
+        cd ..
+'
+
+test_expect_success 'check that push --squash introduces only one commit in subproj' '
+        git subtree push --prefix=subdir subproj mainline --squash &&
+        cd subproj &&
+        check_equal "$(git rev-parse mainline^)" "$(git rev-parse sub1)" &&
+        git branch -D mainline &&
+        cd ..
+'
+
 test_expect_success 'check if --message works for merge' '
         git subtree merge --prefix=subdir -m "Merged changes from subproject" sub2 &&
         check_equal ''"$(last_commit_message)"'' "Merged changes from subproject" &&

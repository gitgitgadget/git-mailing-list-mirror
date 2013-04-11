From: Robert Luberda <robert@debian.org>
Subject: BUG: git filter-branch does not make tree replacements permanent
Date: Thu, 11 Apr 2013 23:08:16 +0200
Message-ID: <20130411210816.GA15810@vox.robbo.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 23:27:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQP1X-0003N9-RC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747Ab3DKV1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:27:07 -0400
Received: from master.debian.org ([82.195.75.110]:52951 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935355Ab3DKV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:27:05 -0400
X-Greylist: delayed 1118 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Apr 2013 17:27:05 EDT
Received: from localhost ([::1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.80)
	(envelope-from <robert@debian.org>)
	id 1UQOjJ-0001Pi-RO
	for git@vger.kernel.org; Thu, 11 Apr 2013 21:08:25 +0000
Received: by vox.robbo.home (Postfix, from userid 1000)
	id 19BB5E429D; Thu, 11 Apr 2013 23:08:16 +0200 (CEST)
Content-Disposition: inline
X-Operating-System: Linux
X-Best-Team: Mutt & Vim
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220931>


Hi,

The git filter-branch man page states:

  NOTE: This command honors .git/info/grafts and .git/refs/replace/. 
        If you have any grafts or replacement refs defined, running 
        this command will make them permanent.

However the command  does not seem to honor tree (or blob) objects
replacements. The bug can be reproduced (with both git 1.7.10 and 
1.8.2.1.342.gfa7285d) in the following simple steps:


1. Setup:
	git init
	for i in a b c d; do echo $i >> f; git add f; git commit -m "$i"; done
	git diff HEAD~2..HEAD~1  # the output is non-empty
2. Add replacement for some tree object
	git replace `git log --format=raw | sed -ne 's/^tree //p' | sed -n 2,3p | tac`
	git diff HEAD~2..HEAD~1  # the output is now empty
3. Run filter-branch:
	git filter-branch
4. Verify that unfortunatelly it did nothing:
	git replace | xargs git replace -d
	git diff HEAD~2..HEAD~1  # the output is still not empty



The following work-around works for me for tree objects replacements,
but I don't think it is suitable for inclusion in git sources. Most
probably git write-tree should be changed instead to take both the blob
and tree replacements into account.

 
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ac2a005..68064f2 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -276,6 +276,16 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 # Rewrite the commits
 
+write_tree_func()
+{
+ m="$(git write-tree "$@")"
+ if [ -e "$ORIG_GIT_DIR/refs/replace/$m" ] ; then
+   n="$(cat "$ORIG_GIT_DIR/refs/replace/$m")"
+   echo "Replaced tree $m with $n" >&2
+   m="$n"
+ fi
+ echo "$m"
+}
 git_filter_branch__commit_count=0
 while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
@@ -342,8 +352,8 @@ while read commit parents; do
 	sed -e '1,/^$/d' <../commit | \
 		eval "$filter_msg" > ../message ||
 			die "msg filter failed: $filter_msg"
-	workdir=$workdir @SHELL_PATH@ -c "$filter_commit" "git commit-tree" \
-		$(git write-tree) $parentstr < ../message > ../map/$commit ||
+	workdir=$workdir /bin/sh -c "$filter_commit" "git commit-tree" \
+		$(write_tree_func) $parentstr < ../message > ../map/$commit ||
 			die "could not write rewritten commit"
 done <../revs

Regards,
robert
 

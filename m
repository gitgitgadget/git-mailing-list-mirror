From: Nicolas Morey-Chaisemartin <nicolas.morey@free.fr>
Subject: [PATCH v2] submodule: process conflicting submodules only once
Date: Wed, 30 Mar 2011 07:20:02 +0200
Message-ID: <4D92BD82.6040301@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 30 07:26:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4nvg-0003je-RJ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 07:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892Ab1C3F0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 01:26:47 -0400
Received: from 30.mail-out.ovh.net ([213.186.62.213]:60146 "HELO
	30.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751508Ab1C3F0q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 01:26:46 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Mar 2011 01:26:45 EDT
Received: (qmail 23321 invoked by uid 503); 30 Mar 2011 05:09:38 -0000
Received: from b9.ovh.net (HELO mail417.ha.ovh.net) (213.186.33.59)
  by 30.mail-out.ovh.net with SMTP; 30 Mar 2011 05:09:38 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 30 Mar 2011 07:20:04 +0200
Received: from mut38-4-82-233-116-185.fbx.proxad.net (HELO uranus.nicolas.morey-chaisemartin.com) (nicolas@morey-chaisemartin.com@82.233.116.185)
  by ns0.ovh.net with SMTP; 30 Mar 2011 07:20:03 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.9
X-Enigmail-Version: 1.1.1
X-Ovh-Tracer-Id: 13655758496621702110
X-Ovh-Remote: 82.233.116.185 (mut38-4-82-233-116-185.fbx.proxad.net)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170355>

During a merge module_list returns conflicting submodules several times
(stage 1,2,3) which caused the submodules to be used multiple times in
git submodule init, sync, update and status command.

There are 5 callers of module_list; they all read (mode, sha1, stage,
path) tuple, and most of them care only about path.  As a first level
approximation, it should be Ok (in the sense that it does not make things
worse than it currently is) to filter the duplicate paths from module_list
output.

"update" should not touch the submodule repository in such a case.
"status" might want to recurse into the submodule repository, but there is
no information at the superproject level to compare the submodule status
against, so we should at least skip that part for submodule entries that
are unmerged in the superproject.

The idea is to notice the higher-stage entries, and emit only one record
from module_list, but while doing so, mark the entry with "U" (not [0-3])
in $stage field and null out the SHA-1 part, as the object name for the
lowest stage does not give any useful information to the caller, and this
way any caller that uses the object name would hopefully barf.

After this patch:
 - The command called by foreach may want to do whatever it wants to do
   by noticing the merged status in the superproject itself, so I made
   no change to the function;

 - Init and Sync are an unlikely thing to do, but as long as a submodule
   is there in $path, there is no point skipping it. It might however
   want to take the merged status of .gitmodules into account, but that
   is outside of the scope of this topic;

 - Update skip the conflicting submodules and do not recurse into them.

 - Status report the conflicting submodules as 'U000...000' and do not
   recurse into them.

Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 Documentation/git-submodule.txt |    5 ++-
 git-submodule.sh                |   29 +++++++++++++++++++-
 t/t7405-submodule-merge.sh      |   58 +++++++++++++++++++++++++++++++++++----
 3 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3a5aa01..1a16ff6 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -101,9 +101,10 @@ status::
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of 'git describe' for the
 	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
-	initialized and `+` if the currently checked out submodule commit
+	initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
-	repository. This command is the default command for 'git submodule'.
+	repository and `U` if the submodule has merge conflicts.
+	This command is the default command for 'git submodule'.
 +
 If '--recursive' is specified, this command will recurse into nested
 submodules, and show their status as well.
diff --git a/git-submodule.sh b/git-submodule.sh
index 3a13397..7f6b3cf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -72,7 +72,24 @@ resolve_relative_url ()
 #
 module_list()
 {
-	git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
+	git ls-files --error-unmatch --stage -- "$@" |
+	perl -e '
+	my %unmerged = ();
+	my ($null_sha1) = ("0" x 40);
+	while (<STDIN>) {
+		chomp;
+		my ($mode, $sha1, $stage, $path) =
+			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
+		next unless $mode eq "160000";
+		if ($stage ne "0") {
+			if (!$unmerged{$path}++) {
+				print "$mode $null_sha1 U\t$path\n";
+			}
+			next;
+		}
+		print "$_\n";
+	}
+	'
 }
 
 #
@@ -427,6 +444,11 @@ cmd_update()
 	module_list "$@" |
 	while read mode sha1 stage path
 	do
+		if test "$stage" = U
+		then
+			echo >&2 "Skipping unmerged submodule $path"
+			continue
+		fi
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		update_module=$(git config submodule."$name".update)
@@ -770,6 +792,11 @@ cmd_status()
 		name=$(module_name "$path") || exit
 		url=$(git config submodule."$name".url)
 		displaypath="$prefix$path"
+		if test "$stage" = U
+		then
+			say "U$sha1 $displaypath"
+			continue
+		fi
 		if test -z "$url" || ! test -d "$path"/.git -o -f "$path"/.git
 		then
 			say "-$sha1 $displaypath"
diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 7e2e258..af5a4b5 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -56,11 +56,11 @@ test_expect_success setup '
 
 # History setup
 #
-#      b
-#    /   \
-#   a     d
-#    \   /
-#      c
+#             b
+#           /   \
+#  init -- a     d
+#    \      \   /
+#     g       c
 #
 # a in the main repository records to sub-a in the submodule and
 # analogous b and c. d should be automatically found by merging c into
@@ -76,6 +76,8 @@ test_expect_success 'setup for merge search' '
 	 git add file-a &&
 	 git commit -m "sub-a" &&
 	 git branch sub-a) &&
+	git commit --allow-empty -m init &&
+	git branch init &&
 	git add sub &&
 	git commit -m "a" &&
 	git branch a &&
@@ -101,7 +103,13 @@ test_expect_success 'setup for merge search' '
 	 git checkout -b sub-d sub-b &&
 	 git merge sub-c) &&
 	git commit -a -m "d" &&
-	git branch test b)
+	git branch test b &&
+
+	git checkout -b g init &&
+	(cd sub &&
+	 git checkout -b sub-g sub-c) &&
+	git add sub &&
+	git commit -a -m "g")
 '
 
 test_expect_success 'merge with one side as a fast-forward of the other' '
@@ -176,6 +184,44 @@ test_expect_success 'merging should fail for changes that are backwards' '
 	test_must_fail git merge f)
 '
 
+
+# Check that the conflicting submodule is detected when it is
+# in the common ancestor. status should be 'U00...00"
+test_expect_success 'git submodule status should display the merge conflict properly with merge base' '
+       (cd merge-search &&
+       cat >.gitmodules <<EOF &&
+[submodule "sub"]
+       path = sub
+       url = $TRASH_DIRECTORY/sub
+EOF
+       cat >expect <<EOF &&
+U0000000000000000000000000000000000000000 sub
+EOF
+       git submodule status > actual &&
+       test_cmp expect actual &&
+	git reset --hard)
+'
+
+# Check that the conflicting submodule is detected when it is
+# not in the common ancestor. status should be 'U00...00"
+test_expect_success 'git submodule status should display the merge conflict properly without merge-base' '
+       (cd merge-search &&
+	git checkout -b test-no-merge-base g &&
+	test_must_fail git merge b &&	
+       cat >.gitmodules <<EOF &&
+[submodule "sub"]
+       path = sub
+       url = $TRASH_DIRECTORY/sub
+EOF
+       cat >expect <<EOF &&
+U0000000000000000000000000000000000000000 sub
+EOF
+       git submodule status > actual &&
+       test_cmp expect actual &&
+       git reset --hard)
+'
+
+
 test_expect_success 'merging with a modify/modify conflict between merge bases' '
 	git reset --hard HEAD &&
 	git checkout -b test2 c &&
-- 
1.7.4.2.407.gd18fa.dirty

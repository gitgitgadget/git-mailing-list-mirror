From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 2/2] mergetools/p4merge: create a base if none available
Date: Sun, 24 Mar 2013 13:54:58 +0200
Message-ID: <1364126098-10788-2-git-send-email-kevin@bracey.fi>
References: <1363137142-18606-1-git-send-email-kevin@bracey.fi>
 <1364126098-10788-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 15:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJlo5-0005mV-AV
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 15:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab3CXOVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 10:21:30 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:42492 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753974Ab3CXOV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 10:21:29 -0400
Received: from mail643.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 69FE7104DE8F
	for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:06:51 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Mar 2013 13:54:29 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 24 Mar 2013 13:54:27 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.21.g744ac65
In-Reply-To: <1364126098-10788-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 16821789035197927647
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218958>

Originally, with no base, Git gave P4Merge $LOCAL as a dummy base:

   p4merge "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"

Commit 0a0ec7bd changed this to:

   p4merge "empty file" "$LOCAL" "$REMOTE" "$MERGED"

to avoid the problem of being unable to save in some circumstances with
similar inputs.

Unfortunately this approach produces much worse results on differing
inputs. P4Merge really regards the blank file as the base, and once you
have just a couple of differences between the two branches you end up
with one a massive full-file conflict. The 3-way diff is not readable,
and you have to invoke "difftool MERGE_HEAD HEAD" manually to get a
useful view.

The original approach appears to have invoked special 2-way merge
behaviour in P4Merge that occurs only if the base filename is "" or
equal to the left input.  You get a good visual comparison, and it does
not auto-resolve differences. (Normally if one branch matched the base,
it would autoresolve to the other branch).

But there appears to be no way of getting this 2-way behaviour and being
able to reliably save. Having base==left appears to be triggering other
assumptions. There are tricks the user can use to force the save icon
on, but it's not intuitive.

So we now follow a suggestion given in the original patch's discussion:
generate a virtual base, consisting of the lines common to the two
branches. This is the same as the technique used in resolve and octopus
merges, so we relocate that code to a shared function.

Note that if there are no differences at the same location, this
technique can lead to automatic resolution without conflict, combining
everything from the 2 files.  As with the other merges using this
technique, we assume the user will inspect the result before saving.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
Reviewed-by: David Aguilar <davvid@gmail.com>
---
Minor change from v3: that version moved initialisation of src1 higher up,
detaching it from its associated comment. This move was only required by
earlier versions, so v4 leaves src1 in its original position.

Added Reviewed-by footer.

 Documentation/git-sh-setup.txt |  6 ++++++
 git-merge-one-file.sh          | 18 +++++-------------
 git-sh-setup.sh                | 12 ++++++++++++
 mergetools/p4merge             |  6 +++++-
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 6a9f66d..5d709d0 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -82,6 +82,12 @@ get_author_ident_from_commit::
 	outputs code for use with eval to set the GIT_AUTHOR_NAME,
 	GIT_AUTHOR_EMAIL and GIT_AUTHOR_DATE variables for a given commit.
 
+create_virtual_base::
+	modifies the first file so only lines in common with the
+	second file remain. If there is insufficient common material,
+	then the first file is left empty. The result is suitable
+	as a virtual base input for a 3-way merge.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 3373c04..255c07a 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -104,30 +104,22 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	src2=`git-unpack-file $3`
+	src2=$(git-unpack-file $3)
 	case "$1" in
 	'')
 		echo "Added $4 in both, but differently."
-		# This extracts OUR file in $orig, and uses git apply to
-		# remove lines that are unique to ours.
-		orig=`git-unpack-file $2`
-		sz0=`wc -c <"$orig"`
-		@@DIFF@@ -u -La/$orig -Lb/$orig $orig $src2 | git apply --no-add
-		sz1=`wc -c <"$orig"`
-
-		# If we do not have enough common material, it is not
-		# worth trying two-file merge using common subsections.
-		expr $sz0 \< $sz1 \* 2 >/dev/null || : >$orig
+		orig=$(git-unpack-file $2)
+		create_virtual_base "$orig" "$src2"
 		;;
 	*)
 		echo "Auto-merging $4"
-		orig=`git-unpack-file $1`
+		orig=$(git-unpack-file $1)
 		;;
 	esac
 
 	# Be careful for funny filename such as "-L" in "$4", which
 	# would confuse "merge" greatly.
-	src1=`git-unpack-file $2`
+	src1=$(git-unpack-file $2)
 	git merge-file "$src1" "$orig" "$src2"
 	ret=$?
 	msg=
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9cfbe7f..2f78359 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -249,6 +249,18 @@ clear_local_git_env() {
 	unset $(git rev-parse --local-env-vars)
 }
 
+# Generate a virtual base file for a two-file merge. Uses git apply to
+# remove lines from $1 that are not in $2, leaving only common lines.
+create_virtual_base() {
+	sz0=$(wc -c <"$1")
+	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
+	sz1=$(wc -c <"$1")
+
+	# If we do not have enough common material, it is not
+	# worth trying two-file merge using common subsections.
+	expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$1"
+}
+
 
 # Platform specific tweaks to work around some commands
 case $(uname -s) in
diff --git a/mergetools/p4merge b/mergetools/p4merge
index 46b3a5a..5a608ab 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -21,7 +21,11 @@ diff_cmd () {
 
 merge_cmd () {
 	touch "$BACKUP"
-	$base_present || >"$BASE"
+	if ! $base_present
+	then
+		cp -- "$LOCAL" "$BASE"
+		create_virtual_base "$BASE" "$REMOTE"
+	fi
 	"$merge_tool_path" "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
 	check_unchanged
 }
-- 
1.8.2.rc3.21.g744ac65

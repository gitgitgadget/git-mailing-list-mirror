From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: more RCS tests
Date: Sat, 11 Feb 2012 18:44:38 -0500
Message-ID: <20120211234438.GB16691@padd.com>
References: <1328829442-12550-1-git-send-email-luke@diamand.org>
 <1328829442-12550-3-git-send-email-luke@diamand.org>
 <20120211234248.GA16691@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:44:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwMcc-00013J-Ot
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab2BKXoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 18:44:46 -0500
Received: from honk.padd.com ([74.3.171.149]:45036 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755038Ab2BKXop (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 18:44:45 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id EFB85E8B;
	Sat, 11 Feb 2012 15:44:44 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id CA7C15EC5E; Sat, 11 Feb 2012 18:44:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120211234248.GA16691@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190545>

Add a few smaller test cases.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9810-git-p4-rcs.sh |  201 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 196 insertions(+), 5 deletions(-)

diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index a235913..013a951 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -8,6 +8,198 @@ test_expect_success 'start p4d' '
 	start_p4d
 '
 
+#
+# Make one file with keyword lines at the top, and
+# enough plain text to be able to test modifications
+# far away from the keywords.
+#
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		cat <<-\EOF >filek &&
+		$Id$
+		/* $Revision$ */
+		# $Change$
+		line4
+		line5
+		line6
+		line7
+		line8
+		EOF
+		cp filek fileko &&
+		sed -i "s/Revision/Revision: do not scrub me/" fileko
+		cp fileko file_text &&
+		sed -i "s/Id/Id: do not scrub me/" file_text
+		p4 add -t text+k filek &&
+		p4 submit -d "filek" &&
+		p4 add -t text+ko fileko &&
+		p4 submit -d "fileko" &&
+		p4 add -t text file_text &&
+		p4 submit -d "file_text"
+	)
+'
+
+#
+# Generate these in a function to make it easy to use single quote marks.
+#
+write_scrub_scripts() {
+	cat >"$TRASH_DIRECTORY/scrub_k.py" <<-\EOF &&
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', sys.stdin.read()))
+	EOF
+	cat >"$TRASH_DIRECTORY/scrub_ko.py" <<-\EOF
+	import re, sys
+	sys.stdout.write(re.sub(r'(?i)\$(Id|Header):[^$]*\$', r'$\1$', sys.stdin.read()))
+	EOF
+}
+
+test_expect_success 'scrub scripts' '
+	write_scrub_scripts
+'
+
+#
+# Compare $cli/file to its scrubbed version, should be different.
+# Compare scrubbed $cli/file to $git/file, should be same.
+#
+scrub_k_check() {
+	file=$1 &&
+	scrub="$TRASH_DIRECTORY/$file" &&
+	"$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_k.py" <"$git/$file" >"$scrub" &&
+	! test_cmp "$cli/$file" "$scrub" &&
+	test_cmp "$git/$file" "$scrub" &&
+	rm "$scrub"
+}
+scrub_ko_check() {
+	file=$1 &&
+	scrub="$TRASH_DIRECTORY/$file" &&
+	"$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_ko.py" <"$git/$file" >"$scrub" &&
+	! test_cmp "$cli/$file" "$scrub" &&
+	test_cmp "$git/$file" "$scrub" &&
+	rm "$scrub"
+}
+
+#
+# Modify far away from keywords.  If no RCS lines show up
+# in the diff, there is no conflict.
+#
+test_expect_success 'edit far away from RCS lines' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		sed -i "s/^line7/line7 edit/" filek &&
+		git commit -m "filek line7 edit" filek &&
+		"$GITP4" submit &&
+		scrub_k_check filek
+	)
+'
+
+#
+# Modify near the keywords.  This will require RCS scrubbing.
+#
+test_expect_success 'edit near RCS lines' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "s/^line4/line4 edit/" filek &&
+		git commit -m "filek line4 edit" filek &&
+		"$GITP4" submit &&
+		scrub_k_check filek
+	)
+'
+
+#
+# Modify the keywords themselves.  This also will require RCS scrubbing.
+#
+test_expect_success 'edit keyword lines' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "/Revision/d" filek &&
+		git commit -m "filek remove Revision line" filek &&
+		"$GITP4" submit &&
+		scrub_k_check filek
+	)
+'
+
+#
+# Scrubbing text+ko files should not alter all keywords, just Id, Header.
+#
+test_expect_failure 'scrub ko files differently' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "s/^line4/line4 edit/" fileko &&
+		git commit -m "fileko line4 edit" fileko &&
+		"$GITP4" submit &&
+		scrub_ko_check fileko &&
+		! scrub_k_check fileko
+	)
+'
+
+# hack; git-p4 submit should do it on its own
+test_expect_success 'cleanup after failure' '
+	(
+		cd "$cli" &&
+		p4 revert ...
+	)
+'
+
+#
+# Do not scrub anything but +k or +ko files.  Sneak a change into
+# the cli file so that submit will get a conflict.  Make sure that
+# scrubbing doesn't make a mess of things.
+#
+# Assumes that git-p4 exits leaving the p4 file open, with the
+# conflict-generating patch unapplied.
+#
+# This might happen only if the git repo is behind the p4 repo at
+# submit time, and there is a conflict.
+#
+test_expect_failure 'do not scrub plain text' '
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEdit true &&
+		git config git-p4.attemptRCSCleanup true &&
+		sed -i "s/^line4/line4 edit/" file_text &&
+		git commit -m "file_text line4 edit" file_text &&
+		(
+			cd "$cli" &&
+			p4 open file_text &&
+			sed -i "s/^line5/line5 p4 edit/" file_text &&
+			p4 submit -d "file5 p4 edit"
+		) &&
+		! "$GITP4" submit &&
+		(
+			# exepct something like:
+			#    file_text - file(s) not opened on this client
+			# but not copious diff output
+			cd "$cli" &&
+			p4 diff file_text >wc &&
+			test_line_count = 1 wc
+		)
+	)
+'
+
+# hack; git-p4 submit should do it on its own
+test_expect_success 'cleanup after failure 2' '
+	(
+		cd "$cli" &&
+		p4 revert ...
+	)
+'
 create_kw_file () {
 	cat <<\EOF >"$1"
 /* A file
@@ -21,12 +213,12 @@ int main(int argc, const char **argv) {
 EOF
 }
 
-test_expect_success 'init depot' '
+test_expect_success 'add kwfile' '
 	(
 		cd "$cli" &&
 		echo file1 >file1 &&
 		p4 add file1 &&
-		p4 submit -d "change 1" &&
+		p4 submit -d "file1" &&
 		create_kw_file kwfile1.c &&
 		p4 add kwfile1.c &&
 		p4 submit -d "Add rcw kw file" kwfile1.c
@@ -45,6 +237,7 @@ p4_append_to_file () {
 # results in a merge conflict if we touch the RCS kw lines,
 # even though the change itself would otherwise apply cleanly.
 test_expect_failure 'cope with rcs keyword expansion damage' '
+	test_when_finished cleanup_git &&
 	"$GITP4" clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
@@ -69,11 +262,9 @@ test_expect_failure 'cope with rcs keyword expansion damage' '
 		git commit -m "Add line in git at the top" kwfile1.c &&
 		"$GITP4" rebase &&
 		"$GITP4" submit
-	) &&
-	rm -rf "$git" && mkdir "$git"
+	)
 '
 
-
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.9.213.g57e99

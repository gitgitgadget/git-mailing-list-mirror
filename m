From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/5] git-p4: add tests demonstrating spec overlay ambiguities
Date: Wed, 11 Jan 2012 18:31:10 -0500
Message-ID: <1326324670-15967-6-git-send-email-pw@padd.com>
References: <1326324670-15967-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:33:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7fE-0006jy-OX
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab2AKXc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:32:59 -0500
Received: from honk.padd.com ([74.3.171.149]:34126 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2AKXc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:32:59 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 76A7C20D2;
	Wed, 11 Jan 2012 15:32:58 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7845A31442; Wed, 11 Jan 2012 18:32:51 -0500 (EST)
X-Mailer: git-send-email 1.7.9.rc0.47.gc9457
In-Reply-To: <1326324670-15967-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188403>

Introduce new tests that look more closely at overlay situations
when there are conflicting files.  Five of these are broken.
Document the brokenness.

This is a fundamental problem with how git-p4 only "borrows" a
client spec.  At some sync operation, a new change can contain
a file which is already in the repo or explicitly deleted through
another mapping.  To sort this out would involve listing all the
files in the client spec to find one with a higher priority.
While this is not too hard for the initial import, subsequent
sync operations would be very costly.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt      |    5 +
 t/t9809-git-p4-client-view.sh |  387 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 392 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 78938b2..8b92cc0 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -314,6 +314,11 @@ around whitespace.  Of the possible wildcards, git-p4 only handles
 '...', and only when it is at the end of the path.  Git-p4 will complain
 if it encounters an unhandled wildcard.
 
+Bugs in the implementation of overlap mappings exist.  If multiple depot
+paths map through overlays to the same location in the repository,
+git-p4 can choose the wrong one.  This is hard to solve without
+dedicating a client spec just for git-p4.
+
 The name of the client can be given to git-p4 in multiple ways.  The
 variable 'git-p4.client' takes precedence if it exists.  Otherwise,
 normal p4 mechanisms of determining the client are used:  environment
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 54204af..ae9145e 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -247,6 +247,393 @@ test_expect_success 'quotes on rhs only' '
 '
 
 #
+# What happens when two files of the same name are overlayed together?
+# The last-listed file should take preference.
+#
+# //depot
+#   - dir1
+#     - file11
+#     - file12
+#     - filecollide
+#   - dir2
+#     - file21
+#     - file22
+#     - filecollide
+#
+test_expect_success 'overlay collision setup' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir1/filecollide >dir1/filecollide &&
+		p4 add dir1/filecollide &&
+		p4 submit -d dir1/filecollide &&
+		echo dir2/filecollide >dir2/filecollide &&
+		p4 add dir2/filecollide &&
+		p4 submit -d dir2/filecollide
+	)
+'
+
+test_expect_success 'overlay collision 1 to 2' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22 filecollide" &&
+	echo dir2/filecollide >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/filecollide &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files &&
+	test_cmp actual "$git"/filecollide
+'
+
+test_expect_failure 'overlay collision 2 to 1' '
+	client_view "//depot/dir2/... //client/..." \
+		    "+//depot/dir1/... //client/..." &&
+	files="file11 file12 file21 file22 filecollide" &&
+	echo dir1/filecollide >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/filecollide &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files &&
+	test_cmp actual "$git"/filecollide
+'
+
+test_expect_success 'overlay collision delete 2' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 delete dir2/filecollide &&
+		p4 submit -d "remove dir2/filecollide"
+	)
+'
+
+# no filecollide, got deleted with dir2
+test_expect_failure 'overlay collision 1 to 2, but 2 deleted' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_success 'overlay collision update 1' '
+	client_view "//depot/dir1/... //client/dir1/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 open dir1/filecollide &&
+		echo dir1/filecollide update >dir1/filecollide &&
+		p4 submit -d "update dir1/filecollide"
+	)
+'
+
+# still no filecollide, dir2 still wins with the deletion even though the
+# change to dir1 is more recent
+test_expect_failure 'overlay collision 1 to 2, but 2 deleted, then 1 updated' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files
+'
+
+test_expect_success 'overlay collision delete filecollides' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 delete dir1/filecollide dir2/filecollide &&
+		p4 submit -d "remove filecollides"
+	)
+'
+
+#
+# Overlays as part of sync, rather than initial checkout:
+#   1.  add a file in dir1
+#   2.  sync to include it
+#   3.  add same file in dir2
+#   4.  sync, make sure content switches as dir2 has priority
+#   5.  add another file in dir1
+#   6.  sync
+#   7.  add/delete same file in dir2
+#   8.  sync, make sure it disappears, again dir2 wins
+#   9.  cleanup
+#
+# //depot
+#   - dir1
+#     - file11
+#     - file12
+#     - colA
+#     - colB
+#   - dir2
+#     - file21
+#     - file22
+#     - colA
+#     - colB
+#
+test_expect_success 'overlay sync: add colA in dir1' '
+	client_view "//depot/dir1/... //client/dir1/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir1/colA >dir1/colA &&
+		p4 add dir1/colA &&
+		p4 submit -d dir1/colA
+	)
+'
+
+test_expect_success 'overlay sync: initial git checkout' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22 colA" &&
+	echo dir1/colA >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colA &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files &&
+	test_cmp actual "$git"/colA
+'
+
+test_expect_success 'overlay sync: add colA in dir2' '
+	client_view "//depot/dir2/... //client/dir2/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir2/colA >dir2/colA &&
+		p4 add dir2/colA &&
+		p4 submit -d dir2/colA
+	)
+'
+
+test_expect_success 'overlay sync: colA content switch' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22 colA" &&
+	echo dir2/colA >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colA &&
+	(
+		cd "$git" &&
+		"$GITP4" sync --use-client-spec &&
+		git merge --ff-only p4/master
+	) &&
+	git_verify $files &&
+	test_cmp actual "$git"/colA
+'
+
+test_expect_success 'overlay sync: add colB in dir1' '
+	client_view "//depot/dir1/... //client/dir1/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir1/colB >dir1/colB &&
+		p4 add dir1/colB &&
+		p4 submit -d dir1/colB
+	)
+'
+
+test_expect_success 'overlay sync: colB appears' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22 colA colB" &&
+	echo dir1/colB >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colB &&
+	(
+		cd "$git" &&
+		"$GITP4" sync --use-client-spec &&
+		git merge --ff-only p4/master
+	) &&
+	git_verify $files &&
+	test_cmp actual "$git"/colB
+'
+
+test_expect_success 'overlay sync: add/delete colB in dir2' '
+	client_view "//depot/dir2/... //client/dir2/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir2/colB >dir2/colB &&
+		p4 add dir2/colB &&
+		p4 submit -d dir2/colB &&
+		p4 delete dir2/colB &&
+		p4 submit -d "delete dir2/colB"
+	)
+'
+
+test_expect_success 'overlay sync: colB disappears' '
+	client_view "//depot/dir1/... //client/..." \
+		    "+//depot/dir2/... //client/..." &&
+	files="file11 file12 file21 file22 colA" &&
+	client_verify $files &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		"$GITP4" sync --use-client-spec &&
+		git merge --ff-only p4/master
+	) &&
+	git_verify $files
+'
+
+test_expect_success 'overlay sync: cleanup' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 delete dir1/colA dir2/colA dir1/colB &&
+		p4 submit -d "remove overlay sync files"
+	)
+'
+
+#
+# Overlay tests again, but swapped so dir1 has priority.
+#   1.  add a file in dir1
+#   2.  sync to include it
+#   3.  add same file in dir2
+#   4.  sync, make sure content does not switch
+#   5.  add another file in dir1
+#   6.  sync
+#   7.  add/delete same file in dir2
+#   8.  sync, make sure it is still there
+#   9.  cleanup
+#
+# //depot
+#   - dir1
+#     - file11
+#     - file12
+#     - colA
+#     - colB
+#   - dir2
+#     - file21
+#     - file22
+#     - colA
+#     - colB
+#
+test_expect_success 'overlay sync swap: add colA in dir1' '
+	client_view "//depot/dir1/... //client/dir1/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir1/colA >dir1/colA &&
+		p4 add dir1/colA &&
+		p4 submit -d dir1/colA
+	)
+'
+
+test_expect_success 'overlay sync swap: initial git checkout' '
+	client_view "//depot/dir2/... //client/..." \
+		    "+//depot/dir1/... //client/..." &&
+	files="file11 file12 file21 file22 colA" &&
+	echo dir1/colA >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colA &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	git_verify $files &&
+	test_cmp actual "$git"/colA
+'
+
+test_expect_success 'overlay sync swap: add colA in dir2' '
+	client_view "//depot/dir2/... //client/dir2/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir2/colA >dir2/colA &&
+		p4 add dir2/colA &&
+		p4 submit -d dir2/colA
+	)
+'
+
+test_expect_failure 'overlay sync swap: colA no content switch' '
+	client_view "//depot/dir2/... //client/..." \
+		    "+//depot/dir1/... //client/..." &&
+	files="file11 file12 file21 file22 colA" &&
+	echo dir1/colA >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colA &&
+	(
+		cd "$git" &&
+		"$GITP4" sync --use-client-spec &&
+		git merge --ff-only p4/master
+	) &&
+	git_verify $files &&
+	test_cmp actual "$git"/colA
+'
+
+test_expect_success 'overlay sync swap: add colB in dir1' '
+	client_view "//depot/dir1/... //client/dir1/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir1/colB >dir1/colB &&
+		p4 add dir1/colB &&
+		p4 submit -d dir1/colB
+	)
+'
+
+test_expect_success 'overlay sync swap: colB appears' '
+	client_view "//depot/dir2/... //client/..." \
+		    "+//depot/dir1/... //client/..." &&
+	files="file11 file12 file21 file22 colA colB" &&
+	echo dir1/colB >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colB &&
+	(
+		cd "$git" &&
+		"$GITP4" sync --use-client-spec &&
+		git merge --ff-only p4/master
+	) &&
+	git_verify $files &&
+	test_cmp actual "$git"/colB
+'
+
+test_expect_success 'overlay sync swap: add/delete colB in dir2' '
+	client_view "//depot/dir2/... //client/dir2/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		echo dir2/colB >dir2/colB &&
+		p4 add dir2/colB &&
+		p4 submit -d dir2/colB &&
+		p4 delete dir2/colB &&
+		p4 submit -d "delete dir2/colB"
+	)
+'
+
+test_expect_failure 'overlay sync swap: colB no change' '
+	client_view "//depot/dir2/... //client/..." \
+		    "+//depot/dir1/... //client/..." &&
+	files="file11 file12 file21 file22 colA colB" &&
+	echo dir1/colB >actual &&
+	client_verify $files &&
+	test_cmp actual "$cli"/colB &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		"$GITP4" sync --use-client-spec &&
+		git merge --ff-only p4/master
+	) &&
+	git_verify $files &&
+	test_cmp actual "$cli"/colB
+'
+
+test_expect_success 'overlay sync swap: cleanup' '
+	client_view "//depot/... //client/..." &&
+	(
+		cd "$cli" &&
+		p4 sync &&
+		p4 delete dir1/colA dir2/colA dir1/colB &&
+		p4 submit -d "remove overlay sync files"
+	)
+'
+
+#
 # Rename directories to test quoting in depot-side mappings
 # //depot
 #    - "dir 1"
-- 
1.7.8.1.409.g3e338.dirty

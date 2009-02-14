From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 4/4] notes: refuse to edit notes outside refs/notes/
Date: Sat, 14 Feb 2009 20:15:06 +0100
Message-ID: <ac3c2ce272e8e7f3000349f682a5a4843aea34e6.1234638466.git.trast@student.ethz.ch>
References: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 14 20:17:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQ0a-0008VK-U6
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbZBNTPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZBNTPX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:15:23 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:20714 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZBNTPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:15:20 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:15 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 20:15:14 +0100
X-Mailer: git-send-email 1.6.2.rc0.288.g6852b
In-Reply-To: <b36bbe2f7f0ede6a2caa47190ada868dd4c0099c.1234638466.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 19:15:14.0897 (UTC) FILETIME=[90BA2C10:01C98ED8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109899>

The current git-notes has no safety valves whatsoever, and will
happily edit notes in, e.g., refs/remotes/.  This is dangerous, as
they will be overwritten during the next fetch of the remote they
belong to.

Since it is supposed to be a plumbing frontend for the notes feature,
simply forbid editing notes with GIT_NOTES_REF pointing anywhere but
refs/notes/*.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is the only patch of substance in this series :-)

I'm not sure if anyone uses a notes ref outside of refs/notes/ yet, so
this may actually break some people's setups already.  But now that we
(at least me :-) offer notes for download in public repos, I can see
people accidentally edit a remote notes ref.


 git-notes.sh     |    4 ++++
 t/t3301-notes.sh |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-notes.sh b/git-notes.sh
index 6859470..6ec33c9 100755
--- a/git-notes.sh
+++ b/git-notes.sh
@@ -16,6 +16,10 @@ die "Invalid commit: $@"
 
 case "$ACTION" in
 edit)
+	if [ "${GIT_NOTES_REF#refs/notes/}" = "$GIT_NOTES_REF" ]; then
+		die "Refusing to edit notes in $GIT_NOTES_REF (outside of refs/notes/)"
+	fi
+
 	MESSAGE="$GIT_DIR"/new-notes-$COMMIT
 	trap '
 		test -f "$MESSAGE" && rm "$MESSAGE"
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index b99271e..1503e79 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -35,6 +35,14 @@ test_expect_success 'need valid notes ref' '
 	! GIT_NOTES_REF=/ git notes show
 '
 
+test_expect_success 'refusing to edit in refs/heads/' '
+	! MSG=1 GIT_NOTES_REF=refs/heads/bogus git notes edit
+'
+
+test_expect_success 'refusing to edit in refs/remotes/' '
+	! MSG=1 GIT_NOTES_REF=refs/remotes/bogus git notes edit
+'
+
 # 1 indicates caught gracefully by die, 128 means git-show barked
 test_expect_success 'handle empty notes gracefully' '
 	git notes show ; test 1 = $?
-- 
1.6.2.rc0.288.g6852b

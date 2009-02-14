From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 5/5] notes: refuse to edit notes outside refs/notes/
Date: Sat, 14 Feb 2009 21:23:25 +0100
Message-ID: <aecacfd80a8b68dfe3090b303c95b42fa1169e76.1234642638.git.trast@student.ethz.ch>
References: <200902142056.42198.trast@student.ethz.ch>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:25:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYR4s-0004S2-A3
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZBNUXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZBNUXq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:23:46 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:27331 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbZBNUXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:23:43 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:35 +0100
Received: from localhost.localdomain ([77.56.223.244]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 14 Feb 2009 21:23:34 +0100
X-Mailer: git-send-email 1.6.2.rc0.296.ge2122
In-Reply-To: <200902142056.42198.trast@student.ethz.ch>
X-OriginalArrivalTime: 14 Feb 2009 20:23:34.0131 (UTC) FILETIME=[1C0FA430:01C98EE2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109921>

The current git-notes has no safety valves whatsoever, and will
happily edit notes in, e.g., refs/remotes/.  This is dangerous, as
they will be overwritten during the next fetch of the remote they
belong to.

Since it is supposed to be a porcelain frontend for the notes feature,
simply forbid editing notes with GIT_NOTES_REF pointing anywhere but
refs/notes/*.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

Same as v1, except for s/plumbing/porcelain/ in the commit message.

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
index 764fad5..f68d8ee 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -35,6 +35,14 @@ test_expect_success 'need valid notes ref' '
 	MSG=2 GIT_NOTES_REF=/ test_must_fail git notes show
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
1.6.2.rc0.296.ge2122

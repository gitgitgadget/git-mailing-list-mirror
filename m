From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git gui: use apply --unidiff-zero when staging hunks
	without context
Date: Sat, 30 Aug 2008 18:56:00 +0200
Message-ID: <20080830165600.GB25370@localhost>
References: <20080830164527.GA25370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 19:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZTo8-0006FU-2q
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 19:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbYH3Qzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 12:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbYH3Qzt
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 12:55:49 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:21140 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYH3Qzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 12:55:48 -0400
Received: from darc.dyndns.org ([84.154.72.105]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 Aug 2008 18:55:46 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KZTk0-0007QO-Nl; Sat, 30 Aug 2008 18:56:00 +0200
Content-Disposition: inline
In-Reply-To: <20080830164527.GA25370@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 Aug 2008 16:55:46.0752 (UTC) FILETIME=[3F869400:01C90AC1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94388>

git apply does not work correctly with zero-context patches. It does a
little better with --unidiff-zero.
---

This appears to fix staging hunks with zero context lines in the majority of
cases. Staging individual lines still is a problem frequently.

In any case, it's easy enough to break zero-context diff & patch like this:

echo a > victim
git add victim
echo b >> victim
git diff -U0 | git apply --cached --unidiff-zero
git diff

So before delving into this problem to deeply, I'd like to find out who
needs fixing exactly. Is there documentation defining how zero-context git
diff output should look like? Or is git apply the culprit in the bug above?

Or do we even want to support applying zero-context patches? If not, we
should detect and fail such attempts.

Clemens

 git-gui/lib/diff.tcl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 52b79e4..78c1b56 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -302,12 +302,15 @@ proc read_diff {fd scroll_pos} {
 
 proc apply_hunk {x y} {
 	global current_diff_path current_diff_header current_diff_side
-	global ui_diff ui_index file_states
+	global ui_diff ui_index file_states repo_config
 
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
 	set apply_cmd {apply --cached --whitespace=nowarn}
+	if {$repo_config(gui.diffcontext) eq 0} {
+		lappend apply_cmd --unidiff-zero
+	}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
 		set failed_msg [mc "Failed to unstage selected hunk."]
@@ -375,12 +378,15 @@ proc apply_hunk {x y} {
 
 proc apply_line {x y} {
 	global current_diff_path current_diff_header current_diff_side
-	global ui_diff ui_index file_states
+	global ui_diff ui_index file_states repo_config
 
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
 	set apply_cmd {apply --cached --whitespace=nowarn}
+	if {$repo_config(gui.diffcontext) eq 0} {
+		lappend apply_cmd --unidiff-zero
+	}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
 		set failed_msg [mc "Failed to unstage selected line."]
-- 
1.6.0

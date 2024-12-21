Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708052E64A
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734789177; cv=none; b=eLmC58ZWmWZiGrGoa2rlHa5JS6seKnbUKe3SGb2RZMuvs5cUxszykYqLkMsl44WLRHJYZiJCcX5Ca1uv7MwBoSLFnRidCJTfyU/YBQTH9HS/N15Va03GqotFngKYfG/3QU82vn9VnFrUcrfgfnWA/k2D5LkfIa7/QeAom4SD2Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734789177; c=relaxed/simple;
	bh=gjmIJSWIM9Dm82uYbeNJQOMXLCXPgnyns+mSH1z4+Qc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uqVvX40/pguyFndNRipT9cPtzO6QPWZFEvY4DE+vaHt06lA93noZTbKJSiY9JDk7KXK0oXAXkV8RF3YMHe85CUr0TbYFsnPdqLJfbs536CcsC6QPI7/9oo1b2soRuL2Utf1M2cd1OjrU/Dtmtcmsn1MATY6pEORMJtXUd987ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4YFkzR0zCvz7QZWs
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 14:05:23 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YFkzG5wx5zRq1m;
	Sat, 21 Dec 2024 14:05:14 +0100 (CET)
Message-ID: <8fbaa0d6-b7f5-4799-a579-ee9fa72a743d@kdbg.org>
Date: Sat, 21 Dec 2024 14:05:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Git GUI "No differences detected"
From: Johannes Sixt <j6t@kdbg.org>
To: Steve <steves.sk@gmail.com>
Cc: git@vger.kernel.org
References: <CAAQS9UL14d_LxTKFMghGvQQWS6dfj1RhTJYyKsz0PKoFot8v5w@mail.gmail.com>
 <2d7d6b38-b3f1-45f5-a6f0-54bd8a0d64d0@kdbg.org>
Content-Language: en-US
In-Reply-To: <2d7d6b38-b3f1-45f5-a6f0-54bd8a0d64d0@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.07.24 um 21:27 schrieb Johannes Sixt:
> Am 25.07.24 um 12:37 schrieb Steve:
>> Problem:
>> Git GUI shows a "No differences detected" popup when clicking on a
>> file, and it returns back to the same state after closing the popup.
>> When I do `git status`, the file is listed there, but `git diff` (with
>> any line-ending-related switches inspired by stackoverflow) doesn't
>> show anything for the file.

> I suggest the following changes to Git GUI:
> 
> 1. Remove the popup.
> 
> 2. Write a message in the diff pane when the diff is empty saying that
> no differences where found and that the file should be staged to remove
> it from the unstaged file list.
> 
> 3. If the option "trust file modification times" is set, extend the
> message with an hyperlink that, when clicked, runs the --refresh stage,
> i.e., the action that currently happens when the popup is dismissed.

Just these days I stumbled over a similar case of 'no differences
detect' while I was operating a Git GUI that has the below patch, and it
worked very well for me. I'll include it in the next release.

---- 8< ----
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] git-gui: Remove forced rescan of stat-dirty files.

It is possible that stat information of tracked files is modified without
actually modifying the content. Plumbing commands would detect such files
as modified, so that Git GUI runs `git update-info --refresh` in order to
synchronize the cached stat info with the reality. However, this can be
an expensive operation in large repositories. As remediation,
e534f3a88676 (git-gui: Allow the user to disable update-index --refresh
during rescan, 2006-11-07) introduced an option to skip the expensive
part.

The option was named "trust file modification timestamp". But the catch
is that sometimes file timestamps can't be trusted. In this case, a file
would remain listed in Unstaged Changes although there are no changes.
So 16403d0b1f9d (git-gui: Refresh a file if it has an empty diff,
2006-11-11) introduced a popup message informing the user about the
situation and then removed the file from the Unstaged Changes list.

Now users had to click away the message box for every file that was
stat-dirty. Under the assumption that a file in such a state is not
the only one, 124355d32c06 (git-gui: Always start a rescan on an empty
diff, 2007-01-22) introduced a forced (potentially expensive) refresh
that would de-list all stat-dirty files after the first notification was
dismissed.

Along came 6c510bee2013 (Lazy man's auto-CRLF, 2007-02-13) in Git. It
introduced a new case where a file in the worktree can have no essential
differences to the staged version, but still be detected as modified by
plumbing commands. This time, however, the index cannot be synchronized
fully by `git update-index --refresh`, so that the file remains listed
in Unstaged Changes until it is staged manually.

Needless to say that the message box now becomes an annoyance, because
it must be dismissed every time an affected file is selected, and the
file remains listed nevertheless.

Remove the message box. Write the notice that no differences were found
in the diff panel instead. Also include a link that, when clicked,
initiates the rescan. With this scheme, the rescan does not happen
automatically anymore, but requires an additional click. (This is now
two clicks in total for users who encounter stat-dirty files after
enabling the "trust file modification timestamps" option.) However,
users whom the rescan does not help (autocrlf-related dirty files) save
half the clicks because there is no message box to dismiss.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-gui.sh   |  3 ++-
 lib/diff.tcl | 26 ++++++--------------------
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8fe7538..887d6d5 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1357,7 +1357,6 @@ set current_diff_path {}
 set is_3way_diff 0
 set is_submodule_diff 0
 set is_conflict_diff 0
-set diff_empty_count 0
 set last_revert {}
 set last_revert_enc {}
 
@@ -3594,6 +3593,8 @@ $ui_diff tag configure clr1 -font font_diffbold
 $ui_diff tag configure clr4 -underline 1
 
 $ui_diff tag conf d_info -foreground blue -font font_diffbold
+$ui_diff tag conf d_rescan -foreground blue -underline 1 -font font_diffbold
+$ui_diff tag bind d_rescan <Button-1> { clear_diff; rescan ui_ready 0 }
 
 $ui_diff tag conf d_cr -elide true
 $ui_diff tag conf d_@ -font font_diffbold
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 871ad48..d657bfe 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -63,28 +63,17 @@ proc force_diff_encoding {enc} {
 }
 
 proc handle_empty_diff {} {
-	global current_diff_path file_states file_lists
-	global diff_empty_count
+	global current_diff_path file_states
+	global ui_diff
 
 	set path $current_diff_path
 	set s $file_states($path)
 	if {[lindex $s 0] ne {_M} || [has_textconv $path]} return
 
-	# Prevent infinite rescan loops
-	incr diff_empty_count
-	if {$diff_empty_count > 1} return
-
-	info_popup [mc "No differences detected.
-
-%s has no changes.
-
-The modification date of this file was updated by another application, but the content within the file was not changed.
-
-A rescan will be automatically started to find other files which may have the same state." [short_path $path]]
-
-	clear_diff
-	display_file $path __
-	rescan ui_ready 0
+	$ui_diff conf -state normal
+	$ui_diff insert end [mc "* No differences detected; stage the file to de-list it from Unstaged Changes.\n"] d_info
+	$ui_diff insert end [mc "* Click to find other files that may have the same state.\n"] d_rescan
+	$ui_diff conf -state disabled
 }
 
 proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
@@ -387,7 +376,6 @@ proc read_diff {fd conflict_size cont_info} {
 	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
-	global diff_empty_count
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -559,8 +547,6 @@ proc read_diff {fd conflict_size cont_info} {
 
 		if {[$ui_diff index end] eq {2.0}} {
 			handle_empty_diff
-		} else {
-			set diff_empty_count 0
 		}
 
 		set callback [lindex $cont_info 1]
-- 
2.48.0.rc0.201.g092d4fe2cc


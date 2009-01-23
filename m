From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH (GIT-GUI/CORE BUG)] git-gui: Avoid an infinite rescan loop in handle_empty_diff.
Date: Sat, 24 Jan 2009 00:52:57 +0300
Organization: HOME
Message-ID: <200901240052.58259.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Andy Davey <as.davey@gmail.com>,
	kbro <kevin.broadey@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 22:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQTy2-00017e-NL
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 22:53:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755665AbZAWVwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 16:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbZAWVwL
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 16:52:11 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:41545 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427AbZAWVwK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 16:52:10 -0500
Received: by mu-out-0910.google.com with SMTP id g7so3035030muf.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 13:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=UjwL1zLe6SscAtJm7omRfT+cHoZd0lxs+5TbTYmQzV4=;
        b=bUiGhUJr5dkHlL9xtbP5sYD7hC49Z0TWyW9cD//Igi2U31MOL0q0IWsrKPOqQNUMwm
         ZfrkJ/I+tUBYhXonhFXyzmhVVvpmlq0mpkfM3FeuaEC/TRg6fXJBHmLN/n5Qe1uFp9e4
         9WUaavq2q7eHnL1x6v3UH7sMBA6wkm+uzBk9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=N2Su56Ljix4eSo/oAp8ZOLsHvu1QfCZYd/PioLHWMwG5HS/zhnVteBpr+etXEOGElH
         BJcjyb+QHVGAhjZbONUVfVunfBhc+nPeNTlhEwfSjT7NKMd2YMC4EYrByxiYai3+pvw8
         qkOI0kbsi2aUBv94c1WjvpS++Tnguc2HiqVdE=
Received: by 10.181.201.18 with SMTP id d18mr1228259bkq.72.1232747527835;
        Fri, 23 Jan 2009 13:52:07 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 28sm18762817fkx.17.2009.01.23.13.52.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jan 2009 13:52:07 -0800 (PST)
User-Agent: KMail/1.10.4 (Linux/2.6.27.9-159.fc10.i686; KDE/4.1.4; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106920>

If the index update machinery and git diff happen to disagree
on whether a particular file is modified, it may cause git-gui
to enter an infinite index rescan loop, where an empty diff
starts a rescan, which finds the same set of files modified,
and tries to display the diff for the first one, which happens
to be the empty one. A current example of a possible disagreement
point is the autocrlf filter.

This patch breaks the loop by using a global variable to track
the auto-rescans. The variable is reset whenever a non-empty
diff is displayed. As a way to work around the malfunctioning
index rescan command, it resurrects the pre-0.6.0 code that
directly updates only the affected file.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

    Note that if the file is actually modified, and the bug is
    either in git-diff or the way git-gui calls it, this patch
    will stage the file without displaying it in the UI. Thus, it
    may be better to simply do nothing if the loop prevention
    logic triggers.


    On Jan 22, 11:31 pm, kbro <kevin.broa...@googlemail.com> wrote:
    > However, for me it was worse as the "No differences" message popped up
    > as soon as I opened git-gui, and the dialog said it would run a rescan
    > to find all files in a similar state.  The rescan caused the same
    > error to be detected again, so I could never get the dialog box to go
    > away.

    On Friday 23 January 2009 02:56:23 Andy Davey wrote:
    > I had the exact same problem you described running git-1.6.1-
    > preview20081227 on Windows XP as well. (the endless loop of dialog box
    > is very frustrating).


P.S. Steps to reproduce the autocrlf handling mismatch on Linux:

    $ git init
    $ echo > foo
    $ git add foo && git commit -m init
    $ unix2dos -o foo
    $ git config core.autocrlf true
    $ git status
    # On branch master
    # Changed but not updated:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   foo
    #
    no changes added to commit (use "git add" and/or "git commit -a")
    $ git diff foo
    diff --git a/foo b/foo

    It happens because git-status assumes that a change in
    file size always means that the file contents have changed.
    Content filters like autocrlf may invalidate this assumption.


 lib/diff.tcl |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index bbbf15c..e5abb49 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -51,6 +51,7 @@ proc force_diff_encoding {enc} {
 
 proc handle_empty_diff {} {
 	global current_diff_path file_states file_lists
+	global last_empty_diff
 
 	set path $current_diff_path
 	set s $file_states($path)
@@ -66,7 +67,17 @@ A rescan will be automatically started to find other files which may have the sa
 
 	clear_diff
 	display_file $path __
-	rescan ui_ready 0
+
+	if {![info exists last_empty_diff]} {
+		set last_empty_diff $path
+		rescan ui_ready 0
+	} else {
+		# We already tried rescanning recently, and it failed,
+		# so resort to updating this particular file.
+		if {[catch {git update-index -- $path} err]} {
+			error_popup [mc "Failed to refresh index:\n\n%s" $err]
+		}
+	}
 }
 
 proc show_diff {path w {lno {}} {scroll_pos {}} {callback {}}} {
@@ -310,6 +321,7 @@ proc read_diff {fd cont_info} {
 	global ui_diff diff_active
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
+	global last_empty_diff
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -415,6 +427,8 @@ proc read_diff {fd cont_info} {
 
 		if {[$ui_diff index end] eq {2.0}} {
 			handle_empty_diff
+		} else {
+			catch { unset last_empty_diff }
 		}
 		set callback [lindex $cont_info 1]
 		if {$callback ne {}} {
-- 
1.6.1.63.g950db

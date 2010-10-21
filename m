From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: apply color information from git diff
Date: Thu, 21 Oct 2010 16:22:40 +0100
Message-ID: <87eibje5zs.fsf_-_@fox.patthoyts.tk>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	<87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
	<7vy69stop2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 20:50:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90DQ-0002pX-VC
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab0JUSuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:50:09 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:59867 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753188Ab0JUSuH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 14:50:07 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P90DF-0003DC-DJ; Thu, 21 Oct 2010 19:50:05 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P90CO-0001JC-8Y; Thu, 21 Oct 2010 19:49:12 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 88E03219BB; Thu, 21 Oct 2010 19:49:11 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
In-Reply-To: <7vy69stop2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Oct 2010 16:43:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159537>

This patch extracts the ansi color sequences from git diff output and
applies these to the diff view window. This ensures that the gui view
makes use of the current git configuration for whitespace display.

Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Junio C Hamano <gitster@pobox.com> writes:
>Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>
>> This is a rather more complete implementation of whitespace highlighting
>> according to the core.whitespace setting. The diff view whitespace
>> highlights should match what you see with 'git diff' when color is
>> enabled for all the whitespace rules except cr-at-eol where there is
>> currently a rule to hide these.
>>
>> Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
>> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
>> ---
>
>This might be a very stupid question, but isn't it an easier-to-maintain
>option to let underlying "git diff" color its output and convert the ANSI
>coloring to whatever Tcl wants to use, especially in the long run, instead
>of trying to replicate the logic to check whitespace breakages here?

Seems like a fine plan. Here is an implementation to try out.

 git-gui.sh   |    7 ++++++-
 lib/diff.tcl |   27 ++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5e8378f..8fba57c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3322,8 +3322,13 @@ pack $ui_diff -side left -fill both -expand 1
 pack .vpane.lower.diff.header -side top -fill x
 pack .vpane.lower.diff.body -side bottom -fill both -expand 1
 
+foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 grey60} {
+	$ui_diff tag configure clr4$n -background $c
+	$ui_diff tag configure clr3$n -foreground $c
+}
+
 $ui_diff tag conf d_cr -elide true
-$ui_diff tag conf d_@ -foreground blue -font font_diffbold
+$ui_diff tag conf d_@ -font font_diffbold
 $ui_diff tag conf d_+ -foreground {#00a000}
 $ui_diff tag conf d_- -foreground red
 
diff --git a/lib/diff.tcl b/lib/diff.tcl
index c628750..7625cb8 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -294,7 +294,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	lappend cmd -p
-	lappend cmd --no-color
+	lappend cmd --color
 	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
 	}
@@ -332,6 +332,21 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	fileevent $fd readable [list read_diff $fd $cont_info]
 }
 
+proc parse_color_line {line} {
+	set start 0
+	set result ""
+	set markup [list]
+	while {[regexp -indices -start $start "\033\\\[(\\d+)?m" $line match code]} {
+		foreach {begin end} $match break
+		append result [string range $line $start [expr {$begin - 1}]]
+		lappend markup [string length $result] [eval [linsert $code 0 string range $line]]
+		set start [incr end]
+	}
+	append result [string range $line $start end]
+	if {[llength $markup] < 4} {set markup {}}
+	return [list $result $markup]
+}
+
 proc read_diff {fd cont_info} {
 	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
@@ -340,6 +355,9 @@ proc read_diff {fd cont_info} {
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
+		foreach {line markup} [parse_color_line $line] break
+		set line [string map {\033 ^} $line]
+
 		# -- Cleanup uninteresting diff header lines.
 		#
 		if {$::current_diff_inheader} {
@@ -434,11 +452,18 @@ proc read_diff {fd cont_info} {
 			}
 			}
 		}
+		set mark [$ui_diff index "end - 1 line linestart"]
 		$ui_diff insert end $line $tags
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}
 		$ui_diff insert end "\n" $tags
+
+		foreach {posbegin colbegin posend colend} $markup {
+			set a "$mark linestart + $posbegin chars"
+			set b "$mark linestart + $posend chars"
+			catch {$ui_diff tag add clr$colbegin $a $b}
+		}
 	}
 	$ui_diff conf -state disabled
 
-- 
1.7.3.1.msysgit.0

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCHv2 1/2] git-gui: respect conflict marker size
Date: Fri, 19 Nov 2010 11:20:35 +0000
Message-ID: <87k4k9h858.fsf@fox.patthoyts.tk>
References: <1289893762-28567-1-git-send-email-bert.wesarg@googlemail.com>
	<1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 12:20:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJP1L-0003ML-GO
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 12:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab0KSLUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 06:20:42 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:40193 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752929Ab0KSLUl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 06:20:41 -0500
Received: from [172.23.144.248] (helo=asmtp-out4.blueyonder.co.uk)
	by smtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PJP1B-00032l-31; Fri, 19 Nov 2010 11:20:37 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PJP1A-0008Qv-Uq; Fri, 19 Nov 2010 11:20:37 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 0E4EB200C5; Fri, 19 Nov 2010 11:20:35 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Tue, 16 Nov 2010 10:21:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161736>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>Respect the conflict-marker-size attribute on paths when detecting merge
>conflicts.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
>---
>
>v2 fixes the tags selection and also the regexp to match always exactly the
>desired number of markers.
>
>Bert
>
> git-gui/git-gui.sh   |    6 +++---
> git-gui/lib/diff.tcl |   22 ++++++++++++++++++----
> 2 files changed, 21 insertions(+), 7 deletions(-)
>
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index d3acf0d..38362fa 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -3351,13 +3351,13 @@ $ui_diff tag conf d_s- \
> 	-foreground red \
> 	-background ivory1
> 
>-$ui_diff tag conf d<<<<<<< \
>+$ui_diff tag conf d< \
> 	-foreground orange \
> 	-font font_diffbold
>-$ui_diff tag conf d======= \
>+$ui_diff tag conf d= \
> 	-foreground orange \
> 	-font font_diffbold
>-$ui_diff tag conf d>>>>>>> \
>+$ui_diff tag conf d> \
> 	-foreground orange \
> 	-font font_diffbold
> 
>diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
>index dcf0711..d4e2ce3 100644
>--- a/git-gui/lib/diff.tcl
>+++ b/git-gui/lib/diff.tcl
>@@ -253,6 +253,19 @@ proc show_other_diff {path w m cont_info} {
> 	}
> }
> 
>+proc get_conflict_marker_size {path} {
>+	set size 7
>+	catch {
>+		set fd_rc [eval [list git_read check-attr "conflict-marker-size" -- $path]]
>+		set ret [gets $fd_rc line]
>+		close $fd_rc
>+		if {$ret > 0} {
>+			regexp {.*: conflict-marker-size: (\d+)$} $line line size
>+		}
>+	}
>+	return $size
>+}
>+
> proc start_show_diff {cont_info {add_opts {}}} {
> 	global file_states file_lists
> 	global is_3way_diff is_submodule_diff diff_active repo_config
>@@ -268,6 +281,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
> 	set is_submodule_diff 0
> 	set diff_active 1
> 	set current_diff_header {}
>+	set conflict_size [get_conflict_marker_size $path]
> 
> 	set cmd [list]
> 	if {$w eq $ui_index} {
>@@ -329,7 +343,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
> 		-blocking 0 \
> 		-encoding [get_path_encoding $path] \
> 		-translation lf
>-	fileevent $fd readable [list read_diff $fd $cont_info]
>+	fileevent $fd readable [list read_diff $fd $conflict_size $cont_info]
> }
> 
> proc parse_color_line {line} {
>@@ -349,7 +363,7 @@ proc parse_color_line {line} {
> 	return [list $result $markup]
> }
> 
>-proc read_diff {fd cont_info} {
>+proc read_diff {fd conflict_size cont_info} {
> 	global ui_diff diff_active is_submodule_diff
> 	global is_3way_diff is_conflict_diff current_diff_header
> 	global current_diff_queue
>@@ -402,7 +416,7 @@ proc read_diff {fd cont_info} {
> 			{- } {set tags d_-s}
> 			{--} {set tags d_--}
> 			{++} {
>-				if {[regexp {^\+\+([<>]{7} |={7})} $line _g op]} {
>+				if {[regexp {^\+\+([<>=]){$conflict_size}(?: |$)} $line _g op]} {
> 					set is_conflict_diff 1
> 					set line [string replace $line 0 1 {  }]
> 					set tags d$op
>@@ -441,7 +455,7 @@ proc read_diff {fd cont_info} {
> 			{@} {set tags d_@}
> 			{-} {set tags d_-}
> 			{+} {
>-				if {[regexp {^\+([<>]{7} |={7})} $line _g op]} {
>+				if {[regexp {^\+([<>=]){$conflict_size}(?: |$)} $line _g op]} {
> 					set is_conflict_diff 1
> 					set tags d$op
> 				} else {

Tcl doesn't expand variables in curly-braced expressions so the
$conflict_size is left in there verbatim.

Either 
  set regexp [string map [list %conflict_size $conflict_size]\
      {^\+([<>=]){%conflict_size}(?: |$)}]
which substitutes in the expanded value or double-quotes with care to
protect anything that Tcl would expand in the regexp. The string map
style is often easier to read.
  regexp "^\\+(\[<>=\]){$conflict_size}(?: |\$)" $line _g op

I've squashed in a fix using string map on this one. With that it
appears to work fine. I never noticed this attribute before.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

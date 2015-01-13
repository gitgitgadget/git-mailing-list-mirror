From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v2] git-gui: fix problem with gui.maxfilesdisplayed
Date: Tue, 13 Jan 2015 00:32:43 +0000
Message-ID: <87siffmses.fsf@red.patthoyts.tk>
References: <54490495.2010200@disi.unitn.it> <548F0058.9090701@disi.unitn.it>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Csaba Kiraly <kiraly@fbk.eu>
To: Csaba Kiraly <kiraly@disi.unitn.it>
X-From: git-owner@vger.kernel.org Tue Jan 13 01:41:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YApXi-0000wL-Iw
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 01:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbbAMAlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 19:41:05 -0500
Received: from know-smtprelay-omc-7.server.virginmedia.net ([80.0.253.71]:57640
	"EHLO know-smtprelay-omc-7.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbbAMAlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 19:41:03 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2015 19:41:03 EST
Received: from red.patthoyts.tk ([82.45.42.101])
	by know-smtprelay-7-imp with bizsmtp
	id fCYk1p00q2AxhvW01CYkyN; Tue, 13 Jan 2015 00:32:45 +0000
X-Originating-IP: [82.45.42.101]
X-Spam: 0
X-Authority: v=2.1 cv=cpwVkjIi c=1 sm=1 tr=0 a=FEdcR8KTC/yDun0iFnNZnw==:117
 a=FEdcR8KTC/yDun0iFnNZnw==:17 a=6gpmbu8EOFEA:10 a=xqWC_Br6kY4A:10
 a=FP58Ms26AAAA:8 a=YNv0rlydsVwA:10 a=Rf460ibiAAAA:8 a=OW3lbr68Y7xtuf9Cf58A:9
 a=AkUkIWUyXwcA:10 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (red.patthoyts.tk [IPv6:2a01:348:2be::2])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id 3DA261961BB7;
	Tue, 13 Jan 2015 00:32:44 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <548F0058.9090701@disi.unitn.it> (Csaba Kiraly's message of "Mon,
	15 Dec 2014 16:38:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262311>

Csaba Kiraly <kiraly@disi.unitn.it> writes:

>gui.maxfilesdisplayed (added in dd6451f9c7c5a36d3006231b618ac6da06c7c7b4)
>was applied brute force on the file list in alphabetic order. As a result,
>files that had modifications might not be displayed by git-gui. Even
>worse, files that are already in the index might not be displayed, which
>makes git-gui hard to use in some workflows.
>
>This fix changes the meaning of gui.maxfilesdisplayed, making it a soft
>limit that only applies to "_O" files, i.e. files that are "Untracked,
>not staged".
>
>Signed-off-by: Csaba Kiraly <kiraly@disi.unitn.it>
>---
> git-gui.sh | 21 ++++++++++++---------
> 1 file changed, 12 insertions(+), 9 deletions(-)
>
>diff --git a/git-gui.sh b/git-gui.sh
>index 27ce0e3..0e4b05a 100755
>--- a/git-gui.sh
>+++ b/git-gui.sh
>@@ -1965,20 +1965,22 @@ proc display_all_files {} {
> 
> 	set to_display [lsort [array names file_states]]
> 	set display_limit [get_config gui.maxfilesdisplayed]
>-	if {[llength $to_display] > $display_limit} {
>-		if {!$files_warning} {
>-			# do not repeatedly warn:
>-			set files_warning 1
>-			info_popup [mc "Displaying only %s of %s files." \
>-				$display_limit [llength $to_display]]
>-		}
>-		set to_display [lrange $to_display 0 [expr {$display_limit-1}]]
>-	}
>+	set displayed 0
> 	foreach path $to_display {
> 		set s $file_states($path)
> 		set m [lindex $s 0]
> 		set icon_name [lindex $s 1]
> 
>+		if {$displayed > $display_limit && [string index $m 1] eq {O} } {
>+			if {!$files_warning} {
>+				# do not repeatedly warn:
>+				set files_warning 1
>+				info_popup [mc "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files." \
>+					$display_limit [llength $to_display]]
>+			}
>+			continue
>+		}
>+
> 		set s [string index $m 0]
> 		if {$s ne {U} && $s ne {_}} {
> 			display_all_files_helper $ui_index $path \
>@@ -1993,6 +1995,7 @@ proc display_all_files {} {
> 		if {$s ne {_}} {
> 			display_all_files_helper $ui_workdir $path \
> 				$icon_name $s
>+			incr displayed
> 		}
> 	}

I found a way to test this and it seems fine. The message box points out
the new controlling config variable which is good. Applied to the master
branch.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

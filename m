From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 1/8] git-gui: rework handling of diff header
Date: Fri, 28 Jan 2011 09:43:36 +0000
Message-ID: <87r5bx5po7.fsf@fox.patthoyts.tk>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 10:43:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piks1-00030k-4Y
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 10:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab1A1Jnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 04:43:52 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:51685 "EHLO
	smtp-out4.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751529Ab1A1Jnv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 04:43:51 -0500
Received: from [172.23.170.145] (helo=anti-virus03-08)
	by smtp-out4.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Pikrs-0007rY-NL; Fri, 28 Jan 2011 09:43:48 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Pikrg-00088y-R6; Fri, 28 Jan 2011 09:43:36 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id D4A1530254; Fri, 28 Jan 2011 09:43:36 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Thu, 9 Dec 2010 21:47:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165607>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>The fix in ca53c3f (Fix diff parsing for lines starting with "--" or "++",
>2008-09-05) got a bug report from Johannes Sixt, that new files in the
>index now looks like:
>
>new file mode 100644
>--- /dev/null
>+++ b/foo
>@@ -0,0 +1 @@
>+foo

Inlining this in the commit comment causes 'git am' to terminate the
comment text early. You should add some leading space when putting text
that looks like patch header into this section.
>
>The introduced problem was that the 'in-diff-header'-flag was unconditially
>disabled. Now it is only disabled when a hunk line is detected. And also
>re-enabled when we encounter a new diff header.
>
>The second part solves also the issue reported by me for diffs with file
>type changes (i.e. the ''error: Unhandled 2 way diff marker: {d}"', which
>comes from the second 'diff --git' line).
>
>Reported-by: Johannes Sixt <j.sixt@viscovery.net>
>Reported-by: Bert Wesarg <bert.wesarg@googlemail.com>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
>---
>
>Cc: Johannes Sixt <j.sixt@viscovery.net>
>---
> foo          |    1 +
> lib/diff.tcl |   18 +++++++++++++++---
> 2 files changed, 16 insertions(+), 3 deletions(-)
> create mode 100644 foo
>
>diff --git a/foo b/foo
>new file mode 100644
>index 0000000..257cc56
>--- /dev/null
>+++ b/foo
>@@ -0,0 +1 @@
>+foo

We don't need a 'foo' file :)

>diff --git a/lib/diff.tcl b/lib/diff.tcl
>index 9d0dc07..dae6ca6 100644
>--- a/lib/diff.tcl
>+++ b/lib/diff.tcl
>@@ -382,23 +382,35 @@ proc read_diff {fd conflict_size cont_info} {
> 		foreach {line markup} [parse_color_line $line] break
> 		set line [string map {\033 ^} $line]
> 
>-		# -- Cleanup uninteresting diff header lines.
>+		# -- Check for start of diff header.
>+		if {   [string match {diff --git *}      $line]
>+		    || [string match {diff --cc *}       $line]
>+		    || [string match {diff --combined *} $line]} {
>+			set ::current_diff_inheader 1
>+		}
>+
>+		# -- Check for end of diff header (any hunk line will do this).
> 		#
>+		if {[regexp {^@@+ } $line]} {set ::current_diff_inheader 0}
>+
> 		if {$::current_diff_inheader} {
>+			append current_diff_header $line "\n"
>+
>+			# -- Cleanup uninteresting diff header lines.
>+			#
> 			if {   [string match {diff --git *}      $line]
> 			    || [string match {diff --cc *}       $line]
> 			    || [string match {diff --combined *} $line]
> 			    || [string match {--- *}             $line]
> 			    || [string match {+++ *}             $line]} {
>-				append current_diff_header $line "\n"
> 				continue
> 			}
> 		}
>+
> 		if {[string match {index *} $line]} continue
> 		if {$line eq {deleted file mode 120000}} {
> 			set line "deleted symlink"
> 		}
>-		set ::current_diff_inheader 0
> 
> 		# -- Automatically detect if this is a 3 way diff.
> 		#

The patch series 1 to 8 are fine. I've taken them without the foo file
mentioned above and adding some spaces to the commit comment as noted
above. This replaces a couple of tentative patches we've discussed
previously for errors on stderr when symlinks replace files.
Thank you - applying to master.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD

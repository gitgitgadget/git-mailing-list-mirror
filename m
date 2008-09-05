From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Gui does not want to work on chunk level
Date: Thu, 4 Sep 2008 21:53:27 -0700
Message-ID: <20080905045327.GA31166@spearce.org>
References: <c6c947f60808270216k2feb8f9ar765cdee1fc3910ee@mail.gmail.com> <c6c947f60809031223i575ca3fdya357588610bb72e8@mail.gmail.com> <20080903230814.GJ28315@spearce.org> <c6c947f60809040220t589e65bfkbd693fd335792069@mail.gmail.com> <20080904143723.GB23708@spearce.org> <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-users@googlegroups.com, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 06:54:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbTLC-00061U-26
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 06:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYIEEx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 00:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbYIEEx3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 00:53:29 -0400
Received: from george.spearce.org ([209.20.77.23]:38560 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYIEEx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 00:53:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B5F4D38353; Fri,  5 Sep 2008 04:53:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c6c947f60809040754g34e60633lcd5f872ac5e80158@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94989>

Alexander Gladysh <agladysh@gmail.com> wrote:
> 
> Aha! Thank you! That "--" is a comment in Lua (that is commented line
> that was removed in diff). First dash is from diff, next two came from
> file itself.
> 
> Steps to reproduce the bug:
...

So that was an awesome reproduction case.  I have committed the
following fix and will push it out in a few minutes:

--8<--
git-gui: Fix diff parsing for lines starting with "--" or "++"

Languages like Lua and SQL use "--" to mark a line as commented out.
If this appears at column 0 and is part of the pre-image we may see
"--- foo" in the diff, indicating that the line whose content is
 "-- foo" has been removed from the new version.

git-gui was incorrectly parsing "--- foo" as the old file name
in the file header, causing it to generate a bad patch file when
the user tried to stage or unstage a hunk or the selected line.
We need to keep track of where we are in the parsing so that we do
not misread a deletion or addition record as part of the header.

Reported-by: Alexander Gladysh <agladysh@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 lib/diff.tcl |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 4a7138b..1970b60 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -192,6 +192,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 		return
 	}
 
+	set ::current_diff_inheader 1
 	fconfigure $fd \
 		-blocking 0 \
 		-encoding binary \
@@ -207,18 +208,21 @@ proc read_diff {fd scroll_pos} {
 	while {[gets $fd line] >= 0} {
 		# -- Cleanup uninteresting diff header lines.
 		#
-		if {   [string match {diff --git *}      $line]
-			|| [string match {diff --cc *}       $line]
-			|| [string match {diff --combined *} $line]
-			|| [string match {--- *}             $line]
-			|| [string match {+++ *}             $line]} {
-			append current_diff_header $line "\n"
-			continue
+		if {$::current_diff_inheader} {
+			if {   [string match {diff --git *}      $line]
+			    || [string match {diff --cc *}       $line]
+			    || [string match {diff --combined *} $line]
+			    || [string match {--- *}             $line]
+			    || [string match {+++ *}             $line]} {
+				append current_diff_header $line "\n"
+				continue
+			}
 		}
 		if {[string match {index *} $line]} continue
 		if {$line eq {deleted file mode 120000}} {
 			set line "deleted symlink"
 		}
+		set ::current_diff_inheader 0
 
 		# -- Automatically detect if this is a 3 way diff.
 		#
-- 
1.6.0.1.274.g007e4


-- 
Shawn.

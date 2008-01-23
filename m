From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC/PATCH] git-gui: Use gitattribute "encoding" for file content display
Date: Wed, 23 Jan 2008 00:47:09 -0500
Message-ID: <20080123054709.GA13166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Michele Ballabio <barra_cuda@katamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 06:47:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHYSq-0004tU-Rl
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 06:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbYAWFr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 00:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbYAWFr0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 00:47:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47176 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYAWFrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 00:47:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JHYS7-0006ei-DE; Wed, 23 Jan 2008 00:47:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9DABE20FBAE; Wed, 23 Jan 2008 00:47:09 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71511>

I've got the following change in my "pu" right now and am considering
adding it to git-gui 0.9.2, which would be in git 1.5.4.

I've CC'd a number of people who have emailed me in the past
about git-gui's diff or blame failing to display a non US-ASCII
file content correctly and I am interested to hear if this would
resolve the issue for you.  Its configurable on a per-path basis
by an "encoding" attribute in .gitattributes (see git-gui's own
example below).

If we go this route we'll also want to have core Git document in
its gitattributes manpage what this "encoding" attribute is for...


--8>--
git-gui: Use gitattribute "encoding" for file content display

Most folks using git-gui on internationalized files have complained
that it doesn't recognize UTF-8 correctly.  In the past we have just
ignored the problem and showed the file contents as binary/US-ASCII,
which is wrong no matter how you look at it.

This really should be a per-file attribute, managed by .gitattributes,
so we now pull the "encoding" attribute data for the given path from
the .gitattributes (if available) and use that, falling back to UTF-8
if the attributes are unavailable, git-check-attr is broken, or an
encoding for this path not specified.

We apply the encoding anytime we show file content, which currently
is limited to only the diff viewer and the blame viewer.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitattributes |    3 +++
 git-gui.sh     |   13 +++++++++++++
 lib/blame.tcl  |    5 ++++-
 lib/diff.tcl   |    9 ++++++---
 4 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..f96112d
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1,3 @@
+*           encoding=US-ASCII
+git-gui.sh  encoding=UTF-8
+/po/*.po    encoding=UTF-8
diff --git a/git-gui.sh b/git-gui.sh
index f42e461..adc25d0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -466,6 +466,19 @@ proc githook_read {hook_name args} {
 	return {}
 }
 
+proc gitattr {path attr default} {
+	if {[catch {set r [git check-attr $attr -- $path]}]} {
+		set r unspecified
+	} else {
+		set r [join [lrange [split $r :] 2 end] :]
+		regsub {^ } $r {} r
+	}
+	if {$r eq {unspecified}} {
+		return $default
+	}
+	return $r
+}
+
 proc sq {value} {
 	regsub -all ' $value "'\\''" value
 	return "'$value'"
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 00ecf21..f33d48f 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -374,7 +374,10 @@ method _load {jump} {
 	} else {
 		set fd [git_read cat-file blob "$commit:$path"]
 	}
-	fconfigure $fd -blocking 0 -translation lf -encoding binary
+	fconfigure $fd \
+		-blocking 0 \
+		-translation lf \
+		-encoding [tcl_encoding [gitattr $path encoding UTF-8]]
 	fileevent $fd readable [cb _read_file $fd $jump]
 	set current_fd $fd
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index d04f6db..0f030e3 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -98,8 +98,11 @@ proc show_diff {path w {lno {}}} {
 					set sz [string length $content]
 				}
 				file {
+					set enc [gitattr $path encoding UTF-8]
 					set fd [open $path r]
-					fconfigure $fd -eofchar {}
+					fconfigure $fd \
+						-eofchar {} \
+						-encoding [tcl_encoding $enc]
 					set content [read $fd $max_sz]
 					close $fd
 					set sz [file size $path]
@@ -188,8 +191,8 @@ proc show_diff {path w {lno {}}} {
 
 	fconfigure $fd \
 		-blocking 0 \
-		-encoding binary \
-		-translation binary
+		-encoding [tcl_encoding [gitattr $path encoding UTF-8]] \
+		-translation lf
 	fileevent $fd readable [list read_diff $fd]
 }
 
-- 
1.5.4.rc4.1130.g9ad85

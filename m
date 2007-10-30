From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GIT-GUI PATCH 3/3] po2msg: actually output statistics
Date: Tue, 30 Oct 2007 11:25:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301124590.4362@racer.site>
References: <Pine.LNX.4.64.0710301122300.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: stimming@tuhh.de, spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 12:26:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImpEo-0008UN-1V
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 12:26:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbXJ3L0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 07:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbXJ3L0M
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 07:26:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:39170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752539AbXJ3L0L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 07:26:11 -0400
Received: (qmail invoked by alias); 30 Oct 2007 11:26:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 30 Oct 2007 12:26:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196N4kGWRh603uDaePdx4gO1zQx8eerYH3leZQYnA
	Wk36TvE0Ziz3eE
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710301122300.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


The "--statistics" option was ignored so far; no longer.  Now we have
a message similar to that of msgfmt.  (Untranslated, though ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/po2msg.sh |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/po/po2msg.sh b/po/po2msg.sh
index 91d420b..78e49cc 100644
--- a/po/po2msg.sh
+++ b/po/po2msg.sh
@@ -26,11 +26,17 @@ proc u2a {s} {
 set output_directory "."
 set lang "dummy"
 set files [list]
+set show_statistics 0
 
 # parse options
-for {set i 1} {$i < $argc} {incr i} {
+for {set i 0} {$i < $argc} {incr i} {
 	set arg [lindex $argv $i]
-	if {$arg == "--statistics" || $arg == "--tcl"} {
+	if {$arg == "--statistics"} {
+		incr show_statistics
+		continue
+	}
+	if {$arg == "--tcl"} {
+		# we know
 		continue
 	}
 	if {$arg == "-l"} {
@@ -49,12 +55,14 @@ for {set i 1} {$i < $argc} {incr i} {
 
 proc flush_msg {} {
 	global msgid msgstr mode lang out fuzzy
+	global translated_count fuzzy_count not_translated_count
 
 	if {![info exists msgid] || $mode == ""} {
 		return
 	}
 	set mode ""
 	if {$fuzzy == 1} {
+		incr fuzzy_count
 		set fuzzy 0
 		return
 	}
@@ -63,15 +71,20 @@ proc flush_msg {} {
 		set prefix "set ::msgcat::header"
 	} else {
 		if {$msgstr == ""} {
+			incr not_translated_count
 			return
 		}
 		set prefix "::msgcat::mcset $lang \"[u2a $msgid]\""
+		incr translated_count
 	}
 
 	puts $out "$prefix \"[u2a $msgstr]\""
 }
 
 set fuzzy 0
+set translated_count 0
+set fuzzy_count 0
+set not_translated_count 0
 foreach file $files {
 	regsub "^.*/\(\[^/\]*\)\.po$" $file "$output_directory\\1.msg" outfile
 	set in [open $file "r"]
@@ -113,3 +126,9 @@ foreach file $files {
 	close $out
 }
 
+puts $show_statistics
+if {$show_statistics} {
+	puts [concat "$translated_count translated messages, " \
+		"$fuzzy_count fuzzy ones, " \
+		"$not_translated_count untranslated ones."]
+}
-- 
1.5.3.4.1423.g7c7a7

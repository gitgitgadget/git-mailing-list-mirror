From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
Subject: [PATCH] gitk: read and write a repository specific configuration file
Date: Sun,  2 Dec 2012 22:29:26 +0100
Message-ID: <1354483766-13925-1-git-send-email-stlman@poczta.fm>
References: <50BBC760.7030208@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: paulus@samba.org, gitster@pobox.com,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 02 22:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfH6r-0008Ex-G6
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 22:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab2LBV3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 16:29:40 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:40857 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab2LBV3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 16:29:40 -0500
Received: from localhost (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sun,  2 Dec 2012 22:29:34 +0100 (CET)
X-Mailer: git-send-email 1.7.8.6
In-Reply-To: <50BBC760.7030208@poczta.fm>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1354483779;
	bh=yW14b3AW2zuwbf50khNVcFGF495FL9JMhfTYXRZEE0A=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Interia-Antivirus;
	b=pRwE6ogNHvYhnMszV7npPTsgoy8UsV2scJQTCw2IYZWTXK//kC2xauPyEyJ/7wti3
	 hURGdarPaAF78tADALzXQ6AdDk2p/XqGqJDvhIcISHe31ElabaeId0lUEssiHvaIR+
	 n5hVZ2mghdUGQYacmRU7iA2BOuWbfDr/QzKHVy3w=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211021>

Enable gitk read and write repository specific configuration
file: ".git/k" if the file exists. To make gitk use the local
file simply create one, e.g. with the touch(1) command.

This is very useful if one uses different views for different
repositories. Now there is no need to store all of them in
~/.gitk and make the views list needlesly long.

Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
---
 gitk-git/gitk |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..60cf4cd 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2696,7 +2696,7 @@ proc doprogupdate {} {
=20
 proc savestuff {w} {
     global canv canv2 canv3 mainfont textfont uifont tabstop
-    global stuffsaved findmergefiles maxgraphpct
+    global stuffsaved findmergefiles maxgraphpct gitdir
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnu=
m
     global cmitmode wrapcomment datetimeformat limitdiffs
@@ -2707,10 +2707,12 @@ proc savestuff {w} {
     if {$stuffsaved} return
     if {![winfo viewable .]} return
     catch {
-	if {[file exists ~/.gitk-new]} {file delete -force ~/.gitk-new}
-	set f [open "~/.gitk-new" w]
+	set fn [expr [file exists [file join $gitdir k]] ? \
+		{[file join $gitdir k-new]} : {"~/.gitk-new"}]
+	if {[file exists $fn]} {file delete -force $fn}
+	set f [open $fn  w]
 	if {$::tcl_platform(platform) eq {windows}} {
-	    file attributes "~/.gitk-new" -hidden true
+	    catch {file attributes "~/.gitk-new" -hidden true}
 	}
 	puts $f [list set mainfont $mainfont]
 	puts $f [list set textfont $textfont]
@@ -2762,7 +2764,7 @@ proc savestuff {w} {
 	}
 	puts $f "}"
 	close $f
-	file rename -force "~/.gitk-new" "~/.gitk"
+	file rename -force $fn [regsub {\-new$} $fn {}]
     }
     set stuffsaved 1
 }
@@ -11663,7 +11665,14 @@ namespace import ::msgcat::mc
 ## And eventually load the actual message catalog
 ::msgcat::mcload $gitk_msgsdir
=20
+# check that we can find a .git directory somewhere...
+if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
+    show_error {} . [mc "Cannot find a git repository here."]
+    exit 1
+}
+
 catch {source ~/.gitk}
+catch {source [file join $gitdir k]}
=20
 parsefont mainfont $mainfont
 eval font create mainfont [fontflags mainfont]
@@ -11680,12 +11689,6 @@ setui $uicolor
=20
 setoptions
=20
-# check that we can find a .git directory somewhere...
-if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
-    show_error {} . [mc "Cannot find a git repository here."]
-    exit 1
-}
-
 set selecthead {}
 set selectheadid {}
=20
--=20
1.7.8.6

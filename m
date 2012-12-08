From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
Subject: [PATCH] gitk: read and write a repository specific configuration file
Date: Sat,  8 Dec 2012 12:27:47 +0100
Message-ID: <1354966067-2865-1-git-send-email-stlman@poczta.fm>
References: <50BF6629.8050806@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mbranchaud@xiplink.com, paulus@samba.org, gitster@pobox.com,
	=?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 08 12:28:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ThIa1-00053y-Up
	for gcvg-git-2@plane.gmane.org; Sat, 08 Dec 2012 12:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab2LHL2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2012 06:28:09 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:45905 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932634Ab2LHL2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2012 06:28:07 -0500
Received: from localhost (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Sat,  8 Dec 2012 12:27:59 +0100 (CET)
X-Mailer: git-send-email 1.7.8.6
In-Reply-To: <50BF6629.8050806@xiplink.com>
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1354966082;
	bh=5Gh8CYmNXjs8Mwiu+EwFPq5KjPJApYLs9FxHA44ppQc=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Interia-Antivirus;
	b=C4KXRXoGfLEbBrmnxluFt5MaozrtY/QTUYadqYin6JXuYhgZiGLpqAPai/7qFn+uY
	 mMd1gMp3z9GbvmsXc07sm/AkG49K1T6OcfXDLG5dlpZRt7vwVFN6wsRb2/YelM5ACw
	 xpM2LoidaW0AyDyxDc06KfDyiUHbcg7h4uwZmxm0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211211>

Enable gitk read and write repository specific configuration
file: ".git/k" if the file exists. To make gitk use the local
file simply create one, e.g. with the touch(1) command.

This is very useful if one uses different views for different
repositories. Now there is no need to store all of them in
~/.gitk and make the views list needlessly long.

Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
---
 gitk |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/gitk b/gitk
index 379582a..c6b7dc3 100755
--- a/gitk
+++ b/gitk
@@ -2703,7 +2703,7 @@ proc doprogupdate {} {
=20
 proc savestuff {w} {
     global canv canv2 canv3 mainfont textfont uifont tabstop
-    global stuffsaved findmergefiles maxgraphpct
+    global stuffsaved findmergefiles maxgraphpct gitdir
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewargscmd viewperm nextviewnu=
m
     global cmitmode wrapcomment datetimeformat limitdiffs
@@ -2714,10 +2714,12 @@ proc savestuff {w} {
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
@@ -2769,7 +2771,7 @@ proc savestuff {w} {
 	}
 	puts $f "}"
 	close $f
-	file rename -force "~/.gitk-new" "~/.gitk"
+	file rename -force $fn [regsub {\-new$} $fn {}]
     }
     set stuffsaved 1
 }
@@ -11723,7 +11725,14 @@ namespace import ::msgcat::mc
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
@@ -11740,12 +11749,6 @@ setui $uicolor
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

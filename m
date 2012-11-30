From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
Subject: [PATCH] gitk: add a checkbox to control the visibility of tags
Date: Fri, 30 Nov 2012 22:08:57 +0100
Message-ID: <1354309737-4280-1-git-send-email-stlman@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 30 22:29:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeY8z-0000K2-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 22:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab2K3V2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2012 16:28:53 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.205]:51731 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab2K3V2w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 16:28:52 -0500
X-Greylist: delayed 1173 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Nov 2012 16:28:52 EST
Received: from localhost (87-207-152-6.dynamic.chello.pl [87.207.152.6])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTPSA;
	Fri, 30 Nov 2012 22:09:11 +0100 (CET)
X-Mailer: git-send-email 1.7.8.6
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
	s=biztos; t=1354309753;
	bh=esfLeXHBRpooGuhXdtMKPofPekfqAkw1LTRvGgx+hhc=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Interia-Antivirus;
	b=icOyVSBRRScyD80a/2oQ02Zs269hTJJwMEiWyr3YhoANzluwtxOuE1+ykMeokEMeX
	 Dt5C/ZEEeMhgjSk22n7hyDnFo2qyDQSxDrmqgibYfswoUn28M7dXnRHNsdToNSuA3V
	 tgxaCLwniMZU8pFYcuudUPTn1RcMnSFZk+LajbSI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210946>

Enable hiding of tags displayed in the tree as yellow labels.
If a repository is used together with a system like Gerrit
there may be quite a lot of tags used to control building
and there may be hardly any place left for commit subjects.

Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
---
 gitk-git/gitk |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d93bd99..274b46b 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1754,7 +1754,7 @@ proc readrefs {} {
     global tagids idtags headids idheads tagobjid
     global otherrefids idotherrefs mainhead mainheadid
     global selecthead selectheadid
-    global hideremotes
+    global hideremotes hidetags
=20
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} =
{
 	catch {unset $v}
@@ -1776,6 +1776,7 @@ proc readrefs {} {
 	    set headids($name) $id
 	    lappend idheads($id) $name
 	} elseif {[string match "tags/*" $name]} {
+	    if {$hidetags} continue
 	    # this lets refs/tags/foo^{} overwrite refs/tags/foo,
 	    # which is what we want since the former is the commit ID
 	    set name [string range $name 5 end]
@@ -2702,7 +2703,7 @@ proc savestuff {w} {
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors uicolor bgcolor fgcolor diffcolors diffcontext selec=
tbgcolor
     global autoselect autosellen extdifftool perfile_attrs markbgcolor=
 use_ttk
-    global hideremotes want_ttk
+    global hideremotes hidetags want_ttk
=20
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -2725,6 +2726,7 @@ proc savestuff {w} {
 	puts $f [list set autosellen $autosellen]
 	puts $f [list set showneartags $showneartags]
 	puts $f [list set hideremotes $hideremotes]
+	puts $f [list set hidetags $hidetags]
 	puts $f [list set showlocalchanges $showlocalchanges]
 	puts $f [list set datetimeformat $datetimeformat]
 	puts $f [list set limitdiffs $limitdiffs]
@@ -10864,7 +10866,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfil=
e_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes hidetags want_ttk have_ttk
=20
     set page [create_prefs_page $notebook.general]
=20
@@ -10887,6 +10889,9 @@ proc prefspage_general {notebook} {
     ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"]=
 \
 	-variable hideremotes
     grid x $page.hideremotes -sticky w
+    ${NS}::checkbutton $page.hidetags -text [mc "Hide tag labels"] \
+	-variable hidetags
+    grid x $page.hidetags -sticky w
=20
     ${NS}::label $page.ddisp -text [mc "Diff display options"]
     grid $page.ddisp - -sticky w -pady 10
@@ -10988,7 +10993,7 @@ proc doprefs {} {
     global oldprefs prefstop showneartags showlocalchanges
     global uicolor bgcolor fgcolor ctext diffcolors selectbgcolor mark=
bgcolor
     global tabstop limitdiffs autoselect autosellen extdifftool perfil=
e_attrs
-    global hideremotes want_ttk have_ttk
+    global hideremotes hidetags want_ttk have_ttk
=20
     set top .gitkprefs
     set prefstop $top
@@ -10997,7 +11002,7 @@ proc doprefs {} {
 	return
     }
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+		   limitdiffs tabstop perfile_attrs hideremotes hidetags want_ttk} {
 	set oldprefs($v) [set $v]
     }
     ttk_toplevel $top
@@ -11117,7 +11122,7 @@ proc prefscan {} {
     global oldprefs prefstop
=20
     foreach v {maxwidth maxgraphpct showneartags showlocalchanges \
-		   limitdiffs tabstop perfile_attrs hideremotes want_ttk} {
+		   limitdiffs tabstop perfile_attrs hideremotes hidetags want_ttk} {
 	global $v
 	set $v $oldprefs($v)
     }
@@ -11131,7 +11136,7 @@ proc prefsok {} {
     global oldprefs prefstop showneartags showlocalchanges
     global fontpref mainfont textfont uifont
     global limitdiffs treediffs perfile_attrs
-    global hideremotes
+    global hideremotes hidetags
=20
     catch {destroy $prefstop}
     unset prefstop
@@ -11177,7 +11182,8 @@ proc prefsok {} {
 	  $limitdiffs !=3D $oldprefs(limitdiffs)} {
 	reselectline
     }
-    if {$hideremotes !=3D $oldprefs(hideremotes)} {
+    if {$hideremotes !=3D $oldprefs(hideremotes) ||
+        $hidetags !=3D $oldprefs(hidetags)} {
 	rereadrefs
     }
 }
@@ -11601,6 +11607,7 @@ set cmitmode "patch"
 set wrapcomment "none"
 set showneartags 1
 set hideremotes 0
+set hidetags 0
 set maxrefs 20
 set maxlinelen 200
 set showlocalchanges 1
--=20
1.7.8.6

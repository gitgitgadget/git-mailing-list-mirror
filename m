From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI)] git-gui: Fix focus transition in the blame viewer.
Date: Sun, 9 Nov 2008 18:36:50 +0300
Organization: HOME
Message-ID: <200811091836.50832.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 16:40:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzCOX-0005X7-LE
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 16:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbYKIPiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 10:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbYKIPiy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 10:38:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:7345 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbYKIPix (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 10:38:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1876801fgg.17
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Dx9x/TeMex1wrpYSK1lS+dCqhyfEwAuPzeZW0aFmbnc=;
        b=LoUt0RMLcxnUc8MIQIVcptd2TnkGZE/E1yKslt+qPI6wOiRDDtp7KPTg2ToVe4U4wc
         d4ocrX+Je3BBcYw4od8fM71VEn4vjnY0qKXh1qJHKwVswlNzMwKgA+SMxxSmv+Fr03c3
         t3SvOKLh3Ag3VwiMRf2uqnUcA0WABof4+ue7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=vLYCT/y5rGegA2y5PTmcIOS75bzHyQBt9w4FburzQXHsM8gIvT2CbWPLBs5uwSXNpn
         zSh0+ywYOjCkWWAM78KP4VepnEHDxFcshbb6TSWsux3iOy6ECbpU2IzYgnft+yVHpTxv
         HZfHLiD/p5jUB4Z5l80u9Kn3D3GsZorS2pa5k=
Received: by 10.181.36.9 with SMTP id o9mr1759064bkj.148.1226245131477;
        Sun, 09 Nov 2008 07:38:51 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm8620459fkt.3.2008.11.09.07.38.48
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 07:38:49 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100451>

Now that the blame viewer has a search panel, it should be
taken into account by the focus transition code. Otherwise
showing a commit tip (by accidentally moving the mouse to
the text frame) causes the focus to transfer away from the
search field.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl  |   16 ++++++++++++----
 lib/search.tcl |   14 +++++++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 765d08c..642f5ca 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -321,7 +321,7 @@ constructor new {i_commit i_path i_jump} {
 			tk_popup $w.ctxm %X %Y
 		"
 		bind $i <Shift-Tab> "[list focus $w_cviewer];break"
-		bind $i <Tab>       "[list focus $w_cviewer];break"
+		bind $i <Tab>       "[cb _focus_search $w_cviewer];break"
 	}
 
 	foreach i [concat $w_columns $w_cviewer] {
@@ -337,10 +337,10 @@ constructor new {i_commit i_path i_jump} {
 		bind $i <Control-Key-f> {catch {%W yview scroll  1 pages};break}
 	}
 
-	bind $w_cviewer <Shift-Tab> "[list focus $w_file];break"
+	bind $w_cviewer <Shift-Tab> "[cb _focus_search $w_file];break"
 	bind $w_cviewer <Tab>       "[list focus $w_file];break"
-	bind $w_cviewer <Button-1> [list focus $w_cviewer]
-	bind $w_file    <Visibility> [list focus $w_file]
+	bind $w_cviewer <Button-1>   [list focus $w_cviewer]
+	bind $w_file    <Visibility> [cb _focus_search $w_file]
 	bind $top       <F7>         [list searchbar::show $finder]
 	bind $top       <Escape>     [list searchbar::hide $finder]
 	bind $top       <F3>         [list searchbar::find_next $finder]
@@ -382,6 +382,14 @@ constructor new {i_commit i_path i_jump} {
 	_load $this $i_jump
 }
 
+method _focus_search {win} {
+	if {[searchbar::visible $finder]} {
+		focus [searchbar::editor $finder]
+	} else {
+		focus $win
+	}
+}
+
 method _handle_destroy {win} {
 	if {$win eq $w} {
 		_kill $this
diff --git a/lib/search.tcl b/lib/search.tcl
index d292f20..32c8656 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -19,11 +19,11 @@ constructor new {i_w i_text args} {
 
 	frame  $w
 	label  $w.l       -text [mc Find:]
+	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
 	button $w.bn      -text [mc Next] -command [cb find_next]
 	button $w.bp      -text [mc Prev] -command [cb find_prev]
 	checkbutton $w.cs -text [mc Case-Sensitive] \
 		-variable ${__this}::casesensitive -command [cb _incrsearch]
-	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
 	pack   $w.l   -side left
 	pack   $w.cs  -side right
 	pack   $w.bp  -side right
@@ -40,19 +40,27 @@ constructor new {i_w i_text args} {
 }
 
 method show {} {
-	if {![winfo ismapped $w]} {
+	if {![visible $this]} {
 		grid $w
 	}
 	focus -force $w.ent
 }
 
 method hide {} {
-	if {[winfo ismapped $w]} {
+	if {[visible $this]} {
 		focus $ctext
 		grid remove $w
 	}
 }
 
+method visible {} {
+	return [winfo ismapped $w]
+}
+
+method editor {} {
+	return $w.ent
+}
+
 method _get_new_anchor {} {
 	# use start of selection if it is visible,
 	# or the bounds of the visible area
-- 
1.6.0.3.15.gb8d36

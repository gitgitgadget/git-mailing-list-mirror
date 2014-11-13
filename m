From: lennart spitzner <lsp@informatik.uni-kiel.de>
Subject: [PATCH 1/1] gitk: Add support for --author-date-order
Date: Fri, 14 Nov 2014 00:06:03 +0100
Message-ID: <5465395B.5020807@informatik.uni-kiel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 00:07:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp3UU-00059t-T7
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 00:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934682AbaKMXHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 18:07:45 -0500
Received: from miraculix-out.informatik.uni-kiel.de ([134.245.248.209]:62948
	"EHLO miraculix.informatik.uni-kiel.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934347AbaKMXHm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 18:07:42 -0500
X-Virus-Scanned: amavisd-new at informatik.uni-kiel.de
Received: from [192.168.178.21] (kiel-4d066c64.pool.mediaways.net [77.6.108.100])
	(authenticated bits=0)
	by miraculix.informatik.uni-kiel.de (8.14.9/8.14.9) with ESMTP id sADN7CYt020394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 14 Nov 2014 00:07:14 +0100 (MET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=informatik.uni-kiel.de; s=ifi-200807; t=1415920035;
	bh=zlPdlWAv2EeaSxa7PPAlrqdHljEQWAWnzfs10PFRfyU=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:Content-Type:
	 Content-Transfer-Encoding;
	b=IHJfKQBH4XaF2oTn2xj8P+rkx5FoysxXC7Anv4h0EvaZn946qsC50Xh8KBsa1UyLy
	 8Oq2bQrXahlPjfQqMIIHdiYoQSuitOfUYIHeG3JWZ2+w2rVROdffY8fZvQjC+30h/X
	 dE33A/uwAiN70OBlF0bHswTvbltGZ6RDSzN8G0zY=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
X-Null-Tag: 25f926092521731c95a0c58517e05c62
X-Authenticated-Sender: user lsp from 77.6.108.100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitk previously allowed sort-by-committer-date.
Now also allow sort-by-author-date.

Separate the three options for ordering in a new line in the
view-config-dialogue, using radio buttons.

Signed-off-by: Lennart Spitzner <lsp@informatik.uni-kiel.de>
---
Found this useful for displaying a history with a rebase-heavy workflow,
where the committer-timestamps were largely different from
author-timestamps; sort-by-author-date produces a much simpler graph.

I do not really know much tcl, so review closely :p

 gitk | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/gitk b/gitk
index 78358a7..c176b79 100755
--- a/gitk
+++ b/gitk
@@ -155,11 +155,12 @@ proc unmerged_files {files} {
 }
  proc parseviewargs {n arglist} {
-    global vdatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
+    global vdatemode vauthordatemode vmergeonly vflags vdflags vrevs vfiltered vorigargs env
     global vinlinediff
     global worddiff git_version
      set vdatemode($n) 0
+    set vauthordatemode($n) 0
     set vmergeonly($n) 0
     set vinlinediff($n) 0
     set glflags {}
@@ -185,6 +186,12 @@ proc parseviewargs {n arglist} {
 		set origargs [lreplace $origargs $i $i]
 		incr i -1
 	    }
+	    "--author-date-order" {
+		set vauthordatemode($n) 1
+		# remove from origargs in case we hit an unknown option
+		set origargs [lreplace $origargs $i $i]
+		incr i -1
+	    }
 	    "-[puabwcrRBMC]" -
 	    "--no-renames" - "--full-index" - "--binary" - "--abbrev=*" -
 	    "--find-copies-harder" - "-l*" - "--ext-diff" - "--no-ext-diff" -
@@ -690,17 +697,21 @@ proc seeds {v} {
 }
  proc newvarc {view id} {
-    global varcid varctok parents children vdatemode
+    global varcid varctok parents children vdatemode vauthordatemode
     global vupptr vdownptr vleftptr vbackptr varcrow varcix varcstart
     global commitdata commitinfo vseedcount varccommits vlastins
      set a [llength $varctok($view)]
     set vid $view,$id
-    if {[llength $children($vid)] == 0 || $vdatemode($view)} {
+    if {[llength $children($vid)] == 0 || $vdatemode($view) || $vauthordatemode($view)} {
 	if {![info exists commitinfo($id)]} {
 	    parsecommit $id $commitdata($id) 1
 	}
-	set cdate [lindex [lindex $commitinfo($id) 4] 0]
+	if {$vauthordatemode($view)} {
+	    set cdate [lindex [lindex $commitinfo($id) 2] 0]
+	} else {
+	    set cdate [lindex [lindex $commitinfo($id) 4] 0]
+	}
 	if {![string is integer -strict $cdate]} {
 	    set cdate 0
 	}
@@ -800,7 +811,7 @@ proc splitvarc {p v} {
  proc renumbervarc {a v} {
     global parents children varctok varcstart varccommits
-    global vupptr vdownptr vleftptr vbackptr vlastins varcid vtokmod vdatemode
+    global vupptr vdownptr vleftptr vbackptr vlastins varcid vtokmod vdatemode vauthordatemode
      set t1 [clock clicks -milliseconds]
     set todo {}
@@ -836,7 +847,7 @@ proc renumbervarc {a v} {
 				      $children($v,$id)]
 	}
 	set oldtok [lindex $varctok($v) $a]
-	if {!$vdatemode($v)} {
+	if {!($vdatemode($v) || $vauthordatemode($v))} {
 	    set tok {}
 	} else {
 	    set tok $oldtok
@@ -1411,7 +1422,7 @@ proc check_interest {id scripts} {
  proc getcommitlines {fd inst view updating}  {
     global cmitlisted leftover
-    global commitidx commitdata vdatemode
+    global commitidx commitdata vdatemode vauthordatemode
     global parents children curview hlview
     global idpending ordertok
     global varccommits varcid varctok vtokmod vfilelimit vshortids
@@ -1553,7 +1564,7 @@ proc getcommitlines {fd inst view updating}  {
 	} elseif {$a == 0 && [llength $children($vid)] == 1} {
 	    set k [lindex $children($vid) 0]
 	    if {[llength $parents($view,$k)] == 1 &&
-		(!$vdatemode($view) ||
+		(!($vdatemode($view) || $vauthordatemode($view)) ||
 		 $varcid($view,$k) == [llength $varctok($view)] - 1)} {
 		set a $varcid($view,$k)
 	    }
@@ -3987,8 +3998,11 @@ set known_view_options {
     {limit_lbl l    +  {}               {mc "Limit and/or skip a number of revisions (positive integer):"}}
     {limit     t10  *. "--max-count=*"  {mc "Number to show:"}}
     {skip      t10  .  "--skip=*"       {mc "Number to skip:"}}
+    {order_l   l    +  {}               {mc "Ordering:"}}
+    {order_s   r0   .  {}               {mc "Default order"}}
+    {order_c   r1   .  {"--date-order" "-d"}      {mc "Strictly sort by (committer) date"}}
+    {order_a   r2   .  "--author-date-order"      {mc "Strictly sort by author date"}}
     {misc_lbl  l    +  {}               {mc "Miscellaneous options:"}}
-    {dorder    b    *. {"--date-order" "-d"}      {mc "Strictly sort by date"}}
     {lright    b    .  "--left-right"   {mc "Mark branch sides"}}
     {first     b    .  "--first-parent" {mc "Limit to first parent"}}
     {smplhst   b    .  "--simplify-by-decoration"   {mc "Simple history"}}
@@ -12308,6 +12322,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     set vdatemode(1) 0
+    set vauthordatemode(1) 0
     addviewmenu 1
     .bar.view entryconf [mca "Edit view..."] -state normal
     .bar.view entryconf [mca "Delete view"] -state normal
-- 
2.1.3

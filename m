From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 5/8] git-gui: Support conflict states _U & UT.
Date: Sun, 31 Aug 2008 01:00:49 +0400
Organization: TEPKOM
Message-ID: <200808310100.49998.angavrilov@gmail.com>
References: <200808310052.21595.angavrilov@gmail.com> <200808310056.51324.angavrilov@gmail.com> <200808310059.47327.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 23:16:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXo6-00089f-JV
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbYH3VOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 17:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbYH3VOg
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 17:14:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:57628 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215AbYH3VO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 17:14:29 -0400
Received: by fk-out-0910.google.com with SMTP id 18so883437fkq.5
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bIW/ZT0fI6K8mlFeRxbqCZnNiXsocjW5nfYmqsPEsXg=;
        b=FOfcMlzPKxcE1h+XG+9JRVFupRoQGPu+U0ifwZ+xa5fuhRXrHdTBVM5Za8nAqeqBQz
         89OC9luNIS7QzwAakD2xCWzLkrEfsGbrqmA681sfdxuJB+kQAT9qM5MqUx88I3oB9i1y
         vln22bCXwwcZUDawPbtqio8Prxzof2wVxV4MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bojfRBE366MkfoEKojUoiXTyvAOaMrf8SZPE2RlDLiZSkssWwxzuJeTgVo6DK7eSHR
         u8RuWKL67gLOhujd3/eeG2dwqaBRqkTaxRf32V87SuxS1rbcC6InzqqOrFoI61X3PNBO
         bpZwNEfzuuqgK91gApoB0kAdnE1hdymFB6DDQ=
Received: by 10.180.235.10 with SMTP id i10mr4099139bkh.56.1220130869031;
        Sat, 30 Aug 2008 14:14:29 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id d13sm4092560fka.3.2008.08.30.14.14.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 14:14:28 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808310059.47327.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94433>

Support _U (local deleted, remote modified) and
UT (file type changed in conflict) modes.

Note that 'file type changed' does not refer to
changes in the executable bit, instead it denotes
replacing a file with a link, or vice versa.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh     |    6 ++++--
 lib/commit.tcl |    1 +
 lib/diff.tcl   |    2 +-
 lib/index.tcl  |    1 +
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 8d4f715..a3000b6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1669,10 +1669,12 @@ foreach i {
 		{D_ {mc "Staged for removal"}}
 		{DO {mc "Staged for removal, still present"}}
 
+		{_U {mc "Requires merge resolution"}}
 		{U_ {mc "Requires merge resolution"}}
 		{UU {mc "Requires merge resolution"}}
 		{UM {mc "Requires merge resolution"}}
 		{UD {mc "Requires merge resolution"}}
+		{UT {mc "Requires merge resolution"}}
 	} {
 	set text [eval [lindex $i 1]]
 	if {$max_status_desc < [string length $text]} {
@@ -1843,7 +1845,7 @@ proc toggle_or_diff {w x y} {
 	# Do not stage files with conflicts
 	if {[info exists file_states($path)]} {
 		set state [lindex $file_states($path) 0]
-		if {[string index $state 0] eq {U}} {
+		if {[string first {U} $state] >= 0} {
 			set col 1
 		}
 	}
@@ -2814,7 +2816,7 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 	} else {
 		set state {__}
 	}
-	if {[string index $state 0] eq {U}} {
+	if {[string first {U} $state] >= 0} {
 		tk_popup $ctxmmg $X $Y
 	} else {
 		if {$::ui_index eq $::current_diff_side} {
diff --git a/lib/commit.tcl b/lib/commit.tcl
index f4ab707..2977315 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -151,6 +151,7 @@ The rescan will be automatically started now.
 		D? -
 		T_ -
 		M? {set files_ready 1}
+		_U -
 		U? {
 			error_popup [mc "Unmerged files cannot be committed.
 
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 52b79e4..a7fcdc6 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -166,7 +166,7 @@ proc show_diff {path w {lno {}} {scroll_pos {}}} {
 		lappend cmd diff-index
 		lappend cmd --cached
 	} elseif {$w eq $ui_workdir} {
-		if {[string index $m 0] eq {U}} {
+		if {[string first {U} $m] >= 0} {
 			lappend cmd diff
 		} else {
 			lappend cmd diff-files
diff --git a/lib/index.tcl b/lib/index.tcl
index 7c27f2a..06a4fb0 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -164,6 +164,7 @@ proc write_update_index {fd pathList totalCnt batch after} {
 		_O -
 		AM {set new A_}
 		_T {set new T_}
+		_U -
 		U? {
 			if {[file exists $path]} {
 				set new M_
-- 
1.6.0.20.g6148bc

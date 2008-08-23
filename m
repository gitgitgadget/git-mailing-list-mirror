From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 3/7] git-gui: Support starting gitk from Gui Blame
Date: Sat, 23 Aug 2008 12:30:00 +0400
Organization: TEPKOM
Message-ID: <200808231230.00397.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:31:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoWo-0003li-2J
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:31:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYHWIaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYHWIaR
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:30:17 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:8409 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbYHWIaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:30:14 -0400
Received: by fk-out-0910.google.com with SMTP id 18so488262fkq.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4/z8frCEyjTlkAns8FyPAkvjw5sLkIV7PNsCYUdZzNM=;
        b=J6u1RDI1DsvK6oDj1YnLktVMS+vLaKeFiPH+6JdhmS6Ctda3ir+wOtDqtlqdDhjPYn
         DcHA78TfYvBvufkpaqVEzcWEjbIEbGM9X+dBMif8WoKyz32EqJPVpx+Z03L2EvJoLll1
         aXAMqMvNkE0a9GNw+S3WGjBANpUcfHIk9o9No=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Hmd/3TmFT+p6p/LNTd09AWGWKkzw94/JcFBatniXeJfF6EDeMyEWQj1yfrabs5LqMP
         blxarYLilsEq29jF8dOfUwlUbKZSpb/nkXu12jrxpi+XGFhtfqKCfTUPJOJyyRHIDpJx
         fWmCX+IgBEySS9YY4R0ENpHuHAVTmNEdQw17o=
Received: by 10.180.218.16 with SMTP id q16mr1150140bkg.15.1219480212682;
        Sat, 23 Aug 2008 01:30:12 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id 13sm2014034fks.6.2008.08.23.01.30.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:30:12 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231225.12596.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93436>

Add a context menu command to load commits
that are within a certain time range from the
selected commit into gitk.

It can be useful for understanding of the code,
especially if the repository is imported from
a VCS that does not support atomic commits.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh     |    1 +
 lib/blame.tcl  |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 lib/option.tcl |    1 +
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ad65aaa..b8bbcd5 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -668,6 +668,7 @@ set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
 set default_config(gui.fastcopyblame) false
 set default_config(gui.copyblamethreshold) 40
+set default_config(gui.blamehistoryctx) 7
 set default_config(gui.diffcontext) 5
 set default_config(gui.commitmsgwidth) 75
 set default_config(gui.newbranchtemplate) {}
diff --git a/lib/blame.tcl b/lib/blame.tcl
index b6e42cb..d6c56e8 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -259,6 +259,9 @@ constructor new {i_commit i_path} {
 	$w.ctxm add command \
 		-label [mc "Do Full Copy Detection"] \
 		-command [cb _fullcopyblame]
+	$w.ctxm add command \
+		-label [mc "Show History Context"] \
+		-command [cb _gitkcommit]
 
 	foreach i $w_columns {
 		for {set g 0} {$g < [llength $group_colors]} {incr g} {
@@ -905,10 +908,14 @@ method _showcommit {cur_w lno} {
 	}
 }
 
-method _copycommit {} {
+method _get_click_amov_info {} {
 	set pos @$::cursorX,$::cursorY
 	set lno [lindex [split [$::cursorW index $pos] .] 0]
-	set dat [lindex $amov_data $lno]
+	return [lindex $amov_data $lno]
+}
+
+method _copycommit {} {
+	set dat [_get_click_amov_info $this]
 	if {$dat ne {}} {
 		clipboard clear
 		clipboard append \
@@ -918,6 +925,50 @@ method _copycommit {} {
 	}
 }
 
+method _format_offset_date {base offset} {
+	set exval [expr {$base + $offset*24*60*60}]
+	return [clock format $exval -format {%Y-%m-%d}]
+}
+
+method _gitkcommit {} {
+	set dat [_get_click_amov_info $this]
+	if {$dat ne {}} {
+		set cmit [lindex $dat 0]
+		set radius [get_config gui.blamehistoryctx]
+		set cmdline [list --select-commit=$cmit]
+
+                if {$radius > 0} {
+			set author_time {}
+			set committer_time {}
+		
+			catch {set author_time $header($cmit,author-time)}
+			catch {set committer_time $header($cmit,committer-time)}
+
+			if {$committer_time eq {}} {
+				set committer_time $author_time
+			}
+
+			set after_time [_format_offset_date $this $committer_time [expr {-$radius}]]
+			set before_time [_format_offset_date $this $committer_time $radius]
+
+			lappend cmdline --after=$after_time --before=$before_time
+		}
+
+		lappend cmdline $cmit
+
+		set base_rev "HEAD"
+		if {$commit ne {}} {
+			set base_rev $commit
+		}
+
+		if {$base_rev ne $cmit} {
+			lappend cmdline $base_rev
+		}
+
+		do_gitk $cmdline
+	}
+}
+
 method _show_tooltip {cur_w pos} {
 	if {$tooltip_wm ne {}} {
 		_open_tooltip $this $cur_w
diff --git a/lib/option.tcl b/lib/option.tcl
index ffb3f00..eb958ff 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -125,6 +125,7 @@ proc do_options {} {
 		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
+		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
 		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
-- 
1.6.0.rc2

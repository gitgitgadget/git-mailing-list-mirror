From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 4/4] git-gui: add search history to searchbar
Date: Fri, 14 Oct 2011 10:14:52 +0200
Message-ID: <7c2c9ba170f22b6693c33ae888b14f4065b6e3d7.1318579823.git.bert.wesarg@googlemail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
 <9350c86dc58e6345b237de5af186718d97fdd19b.1318579823.git.bert.wesarg@googlemail.com>
 <a93e3d17587afbaef299b2d497ec3c3a037f4101.1318579823.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 10:15:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcvJ-0007o2-IE
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 10:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab1JNIPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 04:15:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53845 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1JNIPN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 04:15:13 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2512825bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=tfVphL6gCFNmyg38jE4Fvj3Kyj3JZpApCMQ+ZbIo3TY=;
        b=KA6rXgFy0pkL/DDeKUEG7gIdXChgU/P5nw2glXnt4ADfvaN8mFr1VmxGFQ11osAP2N
         Wt+XZ26+nfMqoznkOZBmyVaUeHH1iisIM66iiAnwXU3MwkPVr2A03Y87vtKHpcNFmYjK
         jlu/5s8uvb1g/CWETH1niNOapAW7abrYlBgJw=
Received: by 10.204.7.81 with SMTP id c17mr5342118bkc.25.1318580112734;
        Fri, 14 Oct 2011 01:15:12 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id d17sm7463111bkq.11.2011.10.14.01.15.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 01:15:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
In-Reply-To: <a93e3d17587afbaef299b2d497ec3c3a037f4101.1318579823.git.bert.wesarg@googlemail.com>
In-Reply-To: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
References: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183556>

Use the up/down keys to browse the history.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/search.tcl |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/lib/search.tcl b/lib/search.tcl
index 9268ec3..15f99d8 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -13,6 +13,9 @@ field casesensitive
 field default_casesensitive
 field searchdirn     -forwards
 
+field history
+field history_index
+
 field smarktop
 field smarkbot
 
@@ -28,6 +31,8 @@ constructor new {i_w i_text args} {
 		set default_casesensitive 1
 	}
 
+	set history [list]
+
 	${NS}::frame  $w
 	${NS}::label  $w.l       -text [mc Find:]
 	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
@@ -50,6 +55,8 @@ constructor new {i_w i_text args} {
 	trace add variable searchstring write [cb _incrsearch_cb]
 	bind $w.ent <Return> [cb find_next]
 	bind $w.ent <Shift-Return> [cb find_prev]
+	bind $w.ent <Key-Up>   [cb _prev_search]
+	bind $w.ent <Key-Down> [cb _next_search]
 	
 	bind $w <Destroy> [list delete_this $this]
 	return $this
@@ -58,8 +65,10 @@ constructor new {i_w i_text args} {
 method show {} {
 	if {![visible $this]} {
 		grid $w
+		$w.ent delete 0 end
 		set regexpsearch  $default_regexpsearch
 		set casesensitive $default_casesensitive
+		set history_index [llength $history]
 	}
 	focus -force $w.ent
 }
@@ -68,6 +77,7 @@ method hide {} {
 	if {[visible $this]} {
 		focus $ctext
 		grid remove $w
+		_save_search $this
 	}
 }
 
@@ -160,6 +170,55 @@ method _incrsearch {} {
 	}
 }
 
+method _save_search {} {
+	if {$searchstring eq {}} {
+		return
+	}
+	if {[llength $history] > 0} {
+		foreach {s_regexp s_case s_expr} [lindex $history end] break
+	} else {
+		set s_regexp $regexpsearch
+		set s_case   $casesensitive
+		set s_expr   ""
+	}
+	if {$searchstring eq $s_expr} {
+		# update modes
+		set history [lreplace $history end end \
+				[list $regexpsearch $casesensitive $searchstring]]
+	} else {
+		lappend history [list $regexpsearch $casesensitive $searchstring]
+	}
+	set history_index [llength $history]
+}
+
+method _prev_search {} {
+	if {$history_index > 0} {
+		incr history_index -1
+		foreach {s_regexp s_case s_expr} [lindex $history $history_index] break
+		$w.ent delete 0 end
+		$w.ent insert 0 $s_expr
+		set regexpsearch $s_regexp
+		set casesensitive $s_case
+	}
+}
+
+method _next_search {} {
+	if {$history_index < [llength $history]} {
+		incr history_index
+	}
+	if {$history_index < [llength $history]} {
+		foreach {s_regexp s_case s_expr} [lindex $history $history_index] break
+	} else {
+		set s_regexp $default_regexpsearch
+		set s_case   $default_casesensitive
+		set s_expr   ""
+	}
+	$w.ent delete 0 end
+	$w.ent insert 0 $s_expr
+	set regexpsearch $s_regexp
+	set casesensitive $s_case
+}
+
 method find_prev {} {
 	find_next $this -backwards
 }
@@ -170,6 +229,7 @@ method find_next {{dir -forwards}} {
 	set searchdirn $dir
 	$ctext mark unset anchor
 	if {$searchstring ne {}} {
+		_save_search $this
 		set start [_get_new_anchor $this]
 		if {$dir eq "-forwards"} {
 			set start "$start + 1c"
-- 
1.7.6.789.gb4599

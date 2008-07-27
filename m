From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 5/6] gitk: Fixed automatic row selection during load.
Date: Sun, 27 Jul 2008 10:21:46 +0400
Organization: TEPKOM
Message-ID: <200807271021.46661.angavrilov@gmail.com>
References: <200807271017.23272.angavrilov@gmail.com> <200807271020.02415.angavrilov@gmail.com> <200807271020.53171.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 27 08:22:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzei-0003aX-Ng
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbYG0GV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbYG0GV5
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:21:57 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:55421 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbYG0GV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:21:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1893288fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5a6U1Fbmhi9ySy82AFbrMWPMPinlRXwrZMlwnJtK+0U=;
        b=RlLockLKW4Ic9hFRAYtpehE0QlSXCsKEijpxTiRonnPRv8pYEfys10E0aIukLk1pYQ
         W1908/pB+iof0yc5G6a/YQJS7MxQvhpEh05jsk/vNbeRR4jkhqmGPqKWH3qBq0U7EcVV
         MyQYSXiKfRZIlkWJSyWMomJZ75X5UB6Bo7/Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LzwmJuMXHr/UC2zuxNoA+DssAConS5wU5tatbA8Y3zJIIxjExwpm7gFlMyHLUr3ujc
         KUAOWikq+VT8ZJsKHhB1jnKzxelgaJ7VckJNHcPyeQpXoVRJNS4pYFzG/6BUq/kvxZxe
         lcSfuOS7ugfshc1VsI8u88c9US3GqqsBqPHuw=
Received: by 10.86.72.3 with SMTP id u3mr1394985fga.62.1217139714789;
        Sat, 26 Jul 2008 23:21:54 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 12sm6712572fgg.0.2008.07.26.23.21.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:21:54 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807271020.53171.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90319>

Date: Sat, 26 Jul 2008 20:13:45 +0400

- Switching views now actually preserves the selected commit.
- Reloading (also Edit View) preserves the currently selected commit.
- Initial selection does not produce weird scrolling.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/gitk b/gitk
index abb6542..5021437 100755
--- a/gitk
+++ b/gitk
@@ -307,7 +307,7 @@ proc start_rev_list {view} {
     global viewargs viewargscmd viewfiles vfilelimit
     global showlocalchanges commitinterest
     global viewactive viewinstances vmergeonly
-    global pending_select mainheadid
+    global mainheadid
     global vcanopt vflags vrevs vorigargs
 
     set startmsecs [clock clicks -milliseconds]
@@ -374,9 +374,6 @@ proc start_rev_list {view} {
     }
     filerun $fd [list getcommitlines $fd $i $view 0]
     nowbusy $view [mc "Reading"]
-    if {$view == $curview} {
-	set pending_select $mainheadid
-    }
     set viewcomplete($view) 0
     set viewactive($view) 1
     return 1
@@ -418,11 +415,22 @@ proc stop_rev_list {view} {
     set viewinstances($view) {}
 }
 
-proc getcommits {} {
+proc reset_pending_select {selid} {
+    global pending_select mainheadid
+
+    if {$selid ne {}} {
+	set pending_select $selid
+    } else {
+	set pending_select $mainheadid
+    }
+}
+
+proc getcommits {selid} {
     global canv curview need_redisplay viewactive
 
     initlayout
     if {[start_rev_list $curview]} {
+	reset_pending_select $selid
 	show_status [mc "Reading commits..."]
 	set need_redisplay 1
     } else {
@@ -503,7 +511,7 @@ proc updatecommits {} {
     filerun $fd [list getcommitlines $fd $i $view 1]
     incr viewactive($view)
     set viewcomplete($view) 0
-    set pending_select $mainheadid
+    reset_pending_select {}
     nowbusy $view "Reading"
     if {$showneartags} {
 	getallcommits
@@ -515,6 +523,11 @@ proc reloadcommits {} {
     global showneartags treediffs commitinterest cached_commitrow
     global targetid
 
+    set selid {}
+    if {$selectedline ne {}} {
+	set selid $currentid
+    }
+
     if {!$viewcomplete($curview)} {
 	stop_rev_list $curview
     }
@@ -533,7 +546,7 @@ proc reloadcommits {} {
     catch {unset cached_commitrow}
     catch {unset targetid}
     setcanvscroll
-    getcommits
+    getcommits $selid
     return 0
 }
 
@@ -3325,10 +3338,7 @@ proc showview {n} {
 
     run refill_reflist
     if {![info exists viewcomplete($n)]} {
-	if {$selid ne {}} {
-	    set pending_select $selid
-	}
-	getcommits
+	getcommits $selid
 	return
     }
 
@@ -3365,11 +3375,7 @@ proc showview {n} {
     } elseif {$mainheadid ne {} && [commitinview $mainheadid $curview]} {
 	selectline [rowofcommit $mainheadid] 1
     } elseif {!$viewcomplete($n)} {
-	if {$selid ne {}} {
-	    set pending_select $selid
-	} else {
-	    set pending_select $mainheadid
-	}
+	reset_pending_select $selid
     } else {
 	set row [first_real_row]
 	if {$row < $numcommits} {
@@ -4036,6 +4042,7 @@ proc layoutmore {} {
     }
     if {[info exists pending_select] &&
 	[commitinview $pending_select $curview]} {
+	update
 	selectline [rowofcommit $pending_select] 1
     }
     drawvisible
@@ -9973,4 +9980,4 @@ if {[info exists permviews]} {
 	addviewmenu $n
     }
 }
-getcommits
+getcommits {}
-- 
1.5.6.3.18.gfe82

Received: from sar.suljee.de (suljee.de [46.23.91.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8612CDBE
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.91.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776375406; cv=none; b=QIdr1rrV9w3CZSLjupnkFY2xaXEnB5wT2Ja63JJlL5ntnQCI5EMrE3GSQAVdXpR3VVmD6E9BnpMpONNP18PoDs2WsDNOmnbXf3Glbpd0LY4wis/ZigXGWWfocaK3GwxRFDNmYFkEW2RCHFyihZa27xvYMjlFnG5U1qkB0CADtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776375406; c=relaxed/simple;
	bh=4LxjDb/QAfvHUbL2erP9XqOh+fPOP1rmrGai4LETHPU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=RL7jzPjMxklHttxFHMKG8sMGA8yi/ab2IOJgwCCOUlgTAZY7SrbZJiCrpNW2nRiZeoiFhi/ThKwJtf6F+jhhqYHdO2AQ3WHRjir86g+BG5YOaW8ya37khnbsHLVl4r+5mqDBAfW3v0wM8RR68jgSp3+L6e+7gjVeHwQOk//TlNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suljee.de; spf=pass smtp.mailfrom=suljee.de; dkim=pass (2048-bit key) header.d=suljee.de header.i=@suljee.de header.b=EUg0ibYY; arc=none smtp.client-ip=46.23.91.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suljee.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suljee.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suljee.de header.i=@suljee.de header.b="EUg0ibYY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20231003; bh=4LxjDb/QAfv
	HUbL2erP9XqOh+fPOP1rmrGai4LETHPU=; h=subject:to:from:date;
	d=suljee.de; b=EUg0ibYYFR4Y0oBFN9ClEkmNyvTHGPlLx2rXPk1o9TYe5IT5He307Kk
	MGP7DwXbH4fqINE3r3UcE9TTAG2xn0X+ai+5dqldVDn/j54y9xHrG3w5XuAVv+le7Q05Pi
	Zg4bBQCymVtIQp+vh8/ks+XDhQDWB2PNrQWXT57UeUPmrQSx+cXpv7XZ/PVeetQitZlrZF
	gedpj2UZ+FwNjuN6BWcjEmiNELOnXgJm0HkZhPweqbJ2DWDBSoAupo7fnFbK8hFLPAvwrj
	D2VMgib/xqJ39+zQrrFyYX76Hy4AtgiOY0+HPdkaA9uTBhyIgZkJMpHgkH4S5AETUHRrpL
	V0mRq2A==
Received: from rosa.suljee.de (dynamic-095-117-017-018.95.117.pool.telefonica.de [95.117.17.18])
	by sar.suljee.de (OpenSMTPD) with ESMTPSA id 23cbd23d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Apr 2026 23:36:40 +0200 (CEST)
Date: Thu, 16 Apr 2026 23:36:39 +0200
From: Michael Warmuth-Uhl <michael.warmuth-uhl@suljee.de>
To: git@vger.kernel.org
Subject: gitk: race condition when changing view
Message-ID: <20260416233639.32e5b481@rosa.suljee.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-unknown-openbsd7.9)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi.

when displaying a bigger commit and then changing the view, gitk reports 

        can't read "treediffs(b107a60c5bed3002ecef93b4405a44d809776e6f)": no such variable
        can't read "treediffs(b107a60c5bed3002ecef93b4405a44d809776e6f)": no such variable
            while executing
        "lsearch -exact $treediffs($ids) $fname"
            (procedure "makediffhdr" line 7)
            invoked from within
        "makediffhdr $fname $ids"
            (procedure "parseblobdiffline" line 56)
            invoked from within
        "parseblobdiffline $ids $line"
            (procedure "getblobdiffline" line 16)
            invoked from within
        "getblobdiffline file6 b107a60c5bed3002ecef93b4405a44d809776e6f"
            ("eval" body line 1)
            invoked from within
        "eval $script"
            (procedure "dorunq" line 11)
            invoked from within
        "dorunq"
            ("after" script)

It is reproducible with:

        TCDIR=/tmp/testcase
        N=512

        rm -rf $TCDIR
        git init $TCDIR
        for i in `seq $N` ; do 
            dd if=/dev/random status=none bs=1024 count=16 | uuencode "" > $TCDIR/foo_$i 
        done
        git -C $TCDIR add . 
        git -C $TCDIR commit -m "commit" 

        cd $TCDIR
        gitk --all

followed by an immediate change to "All Files" in gitk menu "View".

That happens because proc showview (and some others) clear treediffs which is 
still needed by tasks pending in runq.

The patch below makes showview wait until runq is empty which is slow (waits for 
useless operations) and feels wrong. I have no idea how to cleanly flush runq 
instead.

The same issue has been mentioned here before: 
	https://stackoverflow.com/questions/17977996/gitk-cant-read-treediffs-error

Michael

---
diff --git a/gitk-git/gitk b/gitk-git/gitk
index 2730274966..f40bb1aa8c 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -281,10 +281,11 @@ proc gitworktree {} {
 # run before X event handlers, so reading from a fast source can
 # make the GUI completely unresponsive.
 proc run args {
-    global isonrunq runq currunq
+    global isonrunq runq currunq runq_active
 
     set script $args
     if {[info exists isonrunq($script)]} return
+    set $runq_active 1
     if {$runq eq {} && ![info exists currunq]} {
         after idle dorunq
     }
@@ -297,8 +298,9 @@ proc filerun {fd script} {
 }
 
 proc filereadable {fd script} {
-    global runq currunq
+    global runq currunq runq_active
 
+    set $runq_active 1
     fileevent $fd readable {}
     if {$runq eq {} && ![info exists currunq]} {
         after idle dorunq
@@ -318,12 +320,20 @@ proc nukefile {fd} {
     }
 }
 
+proc wait_runq_empty {} {
+    global runq runq_active
+    while {$runq ne {} || $runq_active > 0} {
+        dorunq
+    }
+}
+
 proc dorunq {} {
-    global isonrunq runq currunq
+    global isonrunq runq currunq runq_active
 
     set tstart [clock clicks -milliseconds]
     set t0 $tstart
     while {[llength $runq] > 0} {
+        set $runq_active 1
         set fd [lindex $runq 0 0]
         set script [lindex $runq 0 1]
         set currunq [lindex $runq 0]
@@ -343,6 +353,7 @@ proc dorunq {} {
         } elseif {$fd eq {}} {
             unset isonrunq($script)
         }
+        set $runq_active 0
         set t0 $t1
         if {$t1 - $tstart >= 80} break
     }
@@ -825,6 +836,7 @@ proc reloadcommits {} {
     global showneartags treediffs commitinterest cached_commitrow
     global targetid commitinfo
 
+    wait_runq_empty
     set selid {}
     if {$selectedline ne {}} {
         set selid $currentid
@@ -3660,6 +3672,7 @@ proc pop_flist_menu {w X Y x y} {
     global ctext cflist cmitmode flist_menu flist_menu_file
     global treediffs diffids
 
+    wait_runq_empty
     stopfinding
     set l [lindex [split [$w index "@$x,$y"] "."] 0]
     if {$l <= 1} return
@@ -4664,6 +4677,8 @@ proc showview {n} {
     global hlview selectedhlview commitinterest
 
     if {$n == $curview} return
+
+    wait_runq_empty
     set selid {}
     set ymax [lindex [$canv cget -scrollregion] 3]
     set span [$canv yview]
@@ -12909,6 +12924,7 @@ if {[file exists $themeloader]} {
 set appname "gitk"
 
 set runq {}
+set runq_active 0
 set history {}
 set historyindex 0
 set fh_serial 0




Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93C2D7D47
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759764604; cv=none; b=byN8pFGhuneO/F0pcj67sGf8BUpnJT2cMcxC/MO3QQ54iJHGzMPXKtc0dPjzyNXDo731xw7MSFEJzNU/7mVmmIr3gqQykREa9Tbigvsvz7kmdAkfAiHBRe7TwSzA6qe39QaPZwKsDVhEcav3VarI7f1QXLWaeqqU680OgQkx1Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759764604; c=relaxed/simple;
	bh=h/a276hT2sfliIT5QAmbYCBNqjq2dTRSaZ1/deZn/ps=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hAhdoY5sfR1XkuTtdlnzPjz17Sgcxj7D8LJf4RZm1tT3mNDhCPNXEmMjbK1a2uCcywUYKSn4c+wQqow7Uh9fReuguwl8LmMuOH3iKcT8gJTQZuRD/z+q0wOywMQs6ORGf+HhrNM4hzDuo2oNmGe7NW8o8O4iQi97fZRYhSPwpTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cgNVn2m0PzRpWS;
	Mon,  6 Oct 2025 17:29:53 +0200 (CEST)
Message-ID: <e999c9d2-01d2-4569-ab32-2922ded29dcf@kdbg.org>
Date: Mon, 6 Oct 2025 17:29:53 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] gitk: persist position and size of the Tags and Heads
 window
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Michael Rappazzo <rappazzo@gmail.com>
Cc: git@vger.kernel.org
References: <20250928135435.59623-1-rappazzo@gmail.com>
 <20250928135435.59623-3-rappazzo@gmail.com>
 <fd6450e2-cf56-4b99-b0ed-37a174d7ce9c@kdbg.org>
 <941180e0-d8a1-4f2b-a0d8-2128428b36d8@kdbg.org>
In-Reply-To: <941180e0-d8a1-4f2b-a0d8-2128428b36d8@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Tags and Heads window always opens at a default position and size,
requiring users to reposition it each time. Remember its geometry
between sessions in the config file as `geometry(showrefs)`.

Note that the existing configuration is sourced in proc savestuff
right before new settings are written. This makes the old settings
available as local variables(!) and does not overwrite the current
settings. Since we need access to the global geometry(showrefs), it
is necessary to unset the local variable.

Helped-by: Michael Rappazzo <rappazzo@gmail.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Changes since v1:
- On Windows, only the size was restored, but not the position. There is
  special logic for Windows that positions popup windows. Now we take
  this into account.

 gitk | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 275f353..ed61661 100755
--- a/gitk
+++ b/gitk
@@ -2131,12 +2131,14 @@ proc ttk_toplevel {w args} {
     return $w
 }
 
-proc make_transient {window origin} {
+proc make_transient {window origin {geometry ""}} {
     wm transient $window $origin
 
-    # Windows fails to place transient windows normally, so
-    # schedule a callback to center them on the parent.
-    if {[tk windowingsystem] eq {win32}} {
+    if {$geometry ne ""} {
+        after idle [list wm geometry $window $geometry]
+    } elseif {[tk windowingsystem] eq {win32}} {
+        # Windows fails to place transient windows normally, so
+        # schedule a callback to center them on the parent.
         after idle [list tk::PlaceWindow $window widget $origin]
     }
 }
@@ -3106,6 +3108,11 @@ proc savestuff {w} {
         puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
         puts $f "set geometry(botwidth) [winfo width .bleft]"
         puts $f "set geometry(botheight) [winfo height .bleft]"
+        unset -nocomplain geometry
+        global geometry
+        if {[info exists geometry(showrefs)]} {
+            puts $f "set geometry(showrefs) $geometry(showrefs)"
+        }
 
         array set view_save {}
         array set views {}
@@ -10193,6 +10200,7 @@ proc rmbranch {} {
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor
     global bglist fglist reflistfilter reflist maincursor
+    global geometry
 
     set top .showrefs
     set showrefstop $top
@@ -10203,7 +10211,11 @@ proc showrefs {} {
     }
     ttk_toplevel $top
     wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
-    make_transient $top .
+    if {[info exists geometry(showrefs)]} {
+        make_transient $top . $geometry(showrefs)
+    } else {
+        make_transient $top .
+    }
     text $top.list -background $bgcolor -foreground $fgcolor \
         -selectbackground $selectbgcolor -font mainfont \
         -xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
@@ -10239,6 +10251,9 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    # avoid <Configure> being bound to child windows
+    bindtags $top [linsert [bindtags $top] 1 bind$top]
+    bind bind$top <Configure> {set geometry(showrefs) [wm geometry %W]}
 }
 
 proc sel_reflist {w x y} {
-- 
2.51.0.431.g0f99086cdf


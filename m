Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E983594B
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759602345; cv=none; b=IRcftDdlWXb/NgMAaJAxjANNapf7ysU8WrdLO8jNBKkVS4IJc0um3ufEmOPqJA6cpaEA2MT6vH6BHCPTgof5nFDtVCDAZ83dwIzZ3tLdNtLuM2lNW9C485iO5ag0rOsdtHmSfm6M9ZZTnHGOzbFpcBUEvv09ODvqsLkdIiN8AgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759602345; c=relaxed/simple;
	bh=oHqUPpkmoqFWAVFapDU9Zedq27MqK8ltTLxymHMV3Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=onXasU6oPV4m5zvvyhzOX3LKaq5D8lxfgD8jUBd5JRISPekiMAEbGS7rd4gCM/f3msxLxJnHaSw1F+ytUPMzfKT7Q9b0GiuttZOtpwoqJvE7Y7kmw8flNlXeOO939mb/dOjExAxWy6NJsNSMjLDDh3xUtbJZg/wmH0KwQWcVhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4cfCQ61p3pz7RGvr
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 19:36:46 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4cfCPv5SYfzRpKx;
	Sat,  4 Oct 2025 19:36:35 +0200 (CEST)
Message-ID: <fd6450e2-cf56-4b99-b0ed-37a174d7ce9c@kdbg.org>
Date: Sat, 4 Oct 2025 19:36:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gitk: make Tags and Heads window geometry sticky
To: Michael Rappazzo <rappazzo@gmail.com>
References: <20250928135435.59623-1-rappazzo@gmail.com>
 <20250928135435.59623-3-rappazzo@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250928135435.59623-3-rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.09.25 um 15:54 schrieb Michael Rappazzo:
> Currently, the Tags and Heads window always opens at a default position
> and size, requiring users to reposition it each time. This patch makes
> the window remember its geometry between sessions.
> 
> This change saves and restores the Tags and Heads window size and position
> relative to the main gitk window. The geometry is stored in the config file
> as `geometry(showrefs)` and persists between gitk sessions. The window
> position is stored relative to the main window, so it maintains the same
> spatial relationship when the main window is moved or when gitk is restarted
> on different monitors.
> 
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  gitk | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/gitk b/gitk
> index 275f353811..79a6dcdb4c 100755
> --- a/gitk
> +++ b/gitk
> @@ -3106,6 +3106,11 @@ proc savestuff {w} {
>          puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos 1] 1\""
>          puts $f "set geometry(botwidth) [winfo width .bleft]"
>          puts $f "set geometry(botheight) [winfo height .bleft]"
> +        if {[winfo exists .showrefs]} {
> +            puts $f "set geometry(showrefs) \"[wm geometry .showrefs]\""
> +        } elseif {[info exists geometry(showrefs)]} {
> +            puts $f "set geometry(showrefs) \"$geometry(showrefs)\""
> +        }
>  
>          array set view_save {}
>          array set views {}
> @@ -10199,11 +10204,13 @@ proc showrefs {} {
>      if {[winfo exists $top]} {
>          raise $top
>          refill_reflist
> +        wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
>          return
>      }
>      ttk_toplevel $top
>      wm title $top [mc "Tags and heads: %s" [file tail [pwd]]]
>      make_transient $top .
> +    wm protocol $top WM_DELETE_WINDOW [list destroy_showrefs $top]
>      text $top.list -background $bgcolor -foreground $fgcolor \
>          -selectbackground $selectbgcolor -font mainfont \
>          -xscrollcommand "$top.xsb set" -yscrollcommand "$top.ysb set" \
> @@ -10229,8 +10236,8 @@ proc showrefs {} {
>      ttk::checkbutton $top.sort -text [mc "Sort refs by type"] \
>          -variable sortrefsbytype -command {refill_reflist}
>      grid $top.sort - -sticky w -pady 2
> -    ttk::button $top.close -command [list destroy $top] -text [mc "Close"]
> -    bind $top <Key-Escape> [list destroy $top]
> +    ttk::button $top.close -command [list destroy_showrefs $top] -text [mc "Close"]
> +    bind $top <Key-Escape> [list destroy_showrefs $top]
>      grid $top.close -
>      grid columnconfigure $top 0 -weight 1
>      grid rowconfigure $top 0 -weight 1
> @@ -10239,6 +10246,9 @@ proc showrefs {} {
>      bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
>      set reflist {}
>      refill_reflist
> +    # Restore geometry after the window is fully created and mapped
> +    # Delay Configure binding to avoid overwriting restored geometry
> +    bind $top <Map> [list after idle [list setup_showrefs_geometry_tracking $top]]
>  }
>  
>  proc sel_reflist {w x y} {
> @@ -10271,6 +10281,31 @@ proc reflistfilter_change {n1 n2 op} {
>      after 200 refill_reflist
>  }
>  
> +proc save_showrefs_geometry {top} {
> +    global geometry
> +    if {[winfo exists $top]} {
> +        set geometry(showrefs) [wm geometry $top]
> +    }
> +}
> +
> +proc restore_showrefs_geometry {top} {
> +    global geometry
> +    if {[info exists geometry(showrefs)] && [winfo exists $top]} {
> +        wm geometry $top $geometry(showrefs)
> +    }
> +}
> +
> +proc setup_showrefs_geometry_tracking {top} {
> +    restore_showrefs_geometry $top
> +    bind $top <Configure> [list save_showrefs_geometry $top]
> +}
> +
> +proc destroy_showrefs {top} {
> +    save_showrefs_geometry $top
> +    savestuff .
> +    destroy $top
> +}
> +
>  proc refill_reflist {} {
>      global reflist reflistfilter showrefstop headids tagids otherrefids sortrefsbytype
>      global curview upstreamofref

A patch should be much smaller than this. I was thinking along the lines
of the below diff. However, it doesn't work for some reason: the
variable that is updated from the Configure handler is not the same that
is serialized in proc savestuff, and I don't know why. Nevertheless,
within a session, the window geometry *is* preserved, just not across
sessions.


diff --git a/gitk b/gitk
index 275f353..77d5acc 100755
--- a/gitk
+++ b/gitk
@@ -3058,7 +3058,7 @@ proc config_variable_change_cb {name name2 op} {
 }

 proc savestuff {w} {
-    global stuffsaved
+    global stuffsaved geometry
     global config_file config_file_tmp
     global config_variables config_variable_changed
     global viewchanged
@@ -3106,6 +3106,9 @@ proc savestuff {w} {
         puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sashpos
1] 1\""
         puts $f "set geometry(botwidth) [winfo width .bleft]"
         puts $f "set geometry(botheight) [winfo height .bleft]"
+        if {[info exists geometry(showrefs)]} {
+            puts $f "set geometry(showrefs) \"$geometry(showrefs)\""
+        }

         array set view_save {}
         array set views {}
@@ -10193,6 +10196,7 @@ proc rmbranch {} {
 proc showrefs {} {
     global showrefstop bgcolor fgcolor selectbgcolor
     global bglist fglist reflistfilter reflist maincursor
+    global geometry

     set top .showrefs
     set showrefstop $top
@@ -10239,6 +10243,12 @@ proc showrefs {} {
     bind $top.list <ButtonRelease-1> {sel_reflist %W %x %y; break}
     set reflist {}
     refill_reflist
+    if {[info exists geometry(showrefs)]} {
+        after idle [list wm geometry $top $geometry(showrefs)]
+    }
+    # avoid <Configure> being bound to child windows
+    bindtags $top [linsert [bindtags $top] 1 bind$top]
+    bind bind$top <Configure> {set geometry(showrefs) [wm geometry %W]}
 }

 proc sel_reflist {w x y} {


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4833D1F461
	for <e@80x24.org>; Thu, 29 Aug 2019 01:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfH2BvP (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 21:51:15 -0400
Received: from ozlabs.org ([203.11.71.1]:55939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfH2BvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 21:51:15 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 46JlvM6Yr4z9sDB; Thu, 29 Aug 2019 11:51:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1567043471; bh=XQvx1azBdRw38WoWxsCqO2hLbO5fNS08UDHvuIA2KmI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=eo+3gEEAM8ikZWrMWW8RNio3PzljCCe6QrAMVKonw/s7mv6DdpRy9Qy8HFcuevfFL
         YLNPVFr7toxoROgVDIy+NBupFD332WWOzaNDp3s1yKwXJMxUueenw7gNj1WeUXa7XO
         nl+S3cxgotiNvmlRbDMe2ZQVPzg+ZieYi/gwzyg4Wp5EBg5PwCj2s1ZWaqcxEA8svy
         PNjcAQEunsxczs5P0B41Yltk99pjJlS0RIffNvIQoc89EaPXMmyPmGYmZqhoVp+U9h
         ZMyvMA+7HwIFp3U4COnqQA3/WtNkij9Q2phUCx/KY6XXIYH1he5lrCuxy6v9EUNlsv
         UJ+hFkHp5oKDA==
Date:   Thu, 29 Aug 2019 11:27:02 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     git@vger.kernel.org
Subject: [PATCH v2] gitk: Make web links clickable
Message-ID: <20190829012702.GB3297@blackberry>
References: <20190826221444.GB7402@blackberry>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826221444.GB7402@blackberry>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes gitk look for http or https URLs in the commit description
and make the URLs clickable.  Clicking on them will invoke an external
web browser with the URL.

The web browser command is by default "xdg-open" on Linux, "open" on
MacOS, and "cmd /c start" on Windows.  The command can be changed in
the preferences window, and it can include parameters as well as the
command name.  If it is set to the empty string then URLs will no
longer be made clickable.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
v2: Match URLs anywhere, not just after [Bug]Link:.

 gitk | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index a14d7a1..2a0d00c 100755
--- a/gitk
+++ b/gitk
@@ -7016,6 +7016,7 @@ proc commit_descriptor {p} {
 
 # append some text to the ctext widget, and make any SHA1 ID
 # that we know about be a clickable link.
+# Also look for URLs of the form "http[s]://..." and make them web links.
 proc appendwithlinks {text tags} {
     global ctext linknum curview
 
@@ -7032,6 +7033,18 @@ proc appendwithlinks {text tags} {
 	setlink $linkid link$linknum
 	incr linknum
     }
+    set wlinks [regexp -indices -all -inline -line \
+		    {https?://[^[:space:]]+} $text]
+    foreach l $wlinks {
+	set s2 [lindex $l 0]
+	set e2 [lindex $l 1]
+	set url [string range $text $s2 $e2]
+	incr e2
+	$ctext tag delete link$linknum
+	$ctext tag add link$linknum "$start + $s2 c" "$start + $e2 c"
+	setwlink $url link$linknum
+	incr linknum
+    }
 }
 
 proc setlink {id lk} {
@@ -7064,6 +7077,18 @@ proc setlink {id lk} {
     }
 }
 
+proc setwlink {url lk} {
+    global ctext
+    global linkfgcolor
+    global web_browser
+
+    if {$web_browser eq {}} return
+    $ctext tag conf $lk -foreground $linkfgcolor -underline 1
+    $ctext tag bind $lk <1> [list browseweb $url]
+    $ctext tag bind $lk <Enter> {linkcursor %W 1}
+    $ctext tag bind $lk <Leave> {linkcursor %W -1}
+}
+
 proc appendshortlink {id {pre {}} {post {}}} {
     global ctext linknum
 
@@ -7098,6 +7123,16 @@ proc linkcursor {w inc} {
     }
 }
 
+proc browseweb {url} {
+    global web_browser
+
+    if {$web_browser eq {}} return
+    # Use eval here in case $web_browser is a command plus some arguments
+    if {[catch {eval exec $web_browser [list $url] &} err]} {
+	error_popup "[mc "Error starting web browser:"] $err"
+    }
+}
+
 proc viewnextline {dir} {
     global canv linespc
 
@@ -11488,7 +11523,7 @@ proc create_prefs_page {w} {
 proc prefspage_general {notebook} {
     global NS maxwidth maxgraphpct showneartags showlocalchanges
     global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
-    global hideremotes want_ttk have_ttk maxrefs
+    global hideremotes want_ttk have_ttk maxrefs web_browser
 
     set page [create_prefs_page $notebook.general]
 
@@ -11539,6 +11574,13 @@ proc prefspage_general {notebook} {
     pack configure $page.extdifff.l -padx 10
     grid x $page.extdifff $page.extdifft -sticky ew
 
+    ${NS}::entry $page.webbrowser -textvariable web_browser
+    ${NS}::frame $page.webbrowserf
+    ${NS}::label $page.webbrowserf.l -text [mc "Web browser" ]
+    pack $page.webbrowserf.l -side left
+    pack configure $page.webbrowserf.l -padx 10
+    grid x $page.webbrowserf $page.webbrowser -sticky ew
+
     ${NS}::label $page.lgen -text [mc "General options"]
     grid $page.lgen - -sticky w -pady 10
     ${NS}::checkbutton $page.want_ttk -variable want_ttk \
@@ -12310,6 +12352,7 @@ if {[tk windowingsystem] eq "win32"} {
     set bgcolor SystemWindow
     set fgcolor SystemWindowText
     set selectbgcolor SystemHighlight
+    set web_browser "cmd /c start"
 } else {
     set uicolor grey85
     set uifgcolor black
@@ -12317,6 +12360,11 @@ if {[tk windowingsystem] eq "win32"} {
     set bgcolor white
     set fgcolor black
     set selectbgcolor gray85
+    if {[tk windowingsystem] eq "aqua"} {
+	set web_browser "open"
+    } else {
+	set web_browser "xdg-open"
+    }
 }
 set diffcolors {red "#00a000" blue}
 set diffcontext 3
@@ -12390,6 +12438,7 @@ set config_variables {
     filesepbgcolor filesepfgcolor linehoverbgcolor linehoverfgcolor
     linehoveroutlinecolor mainheadcirclecolor workingfilescirclecolor
     indexcirclecolor circlecolors linkfgcolor circleoutlinecolor
+    web_browser
 }
 foreach var $config_variables {
     config_init_trace $var
-- 
2.7.4


From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default encoding.
Date: Thu, 18 Sep 2008 01:07:32 +0400
Message-ID: <1221685659-476-2-git-send-email-angavrilov@gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 17 23:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg4Hp-0003CH-6Z
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 23:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbYIQVJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 17:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbYIQVJA
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 17:09:00 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:3836 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYIQVI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 17:08:58 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2497220muf.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M0d6Y1hWCSs7J8cH548U3NxZ/WKMM4qZzfHnjDWAxto=;
        b=Lzgl5+AO3cl3o2D+Pa/knlA9GOzeP3ohVoqpTj3dqvuyzSffVWR5ox5lMXyYEGx1gJ
         k/oYQ4hS5uFyI8vimErYkNBDIcWzu/XGDRMymwRCKMQYbNFWeLEhwDUUvMItneHJW7if
         ip7O8WtvgyprjGDnCwicJFykOvi/5oSvbCCOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tzB5s+7l+AIr/nzVmDLC5NTI9eG1m0RsSrcNpgkJkicB+nwScgu7bLx415i+orklIU
         S96TwfT0mSV69U3D0TvbhuksMT0/meecg5Z9CNLiaTGq9mH4wLLNsjPTCdcq4HO1CrJd
         JD3efVC4khKG+TIAUmtsi0aI3bLe6b2FZIScY=
Received: by 10.180.236.14 with SMTP id j14mr2336119bkh.36.1221685736653;
        Wed, 17 Sep 2008 14:08:56 -0700 (PDT)
Received: from localhost.localdomain ( [92.255.85.78])
        by mx.google.com with ESMTPS id z10sm17426586fka.15.2008.09.17.14.08.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 14:08:55 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96136>

- Make diffs and blame default to the system (locale)
  encoding instead of hard-coding UTF-8.
- Add a gui.encoding option to allow overriding it.
- gitattributes still have the final word.

The rationale for this is Windows support:

1) Windows people are accustomed to using legacy encodings
   for text files. For many of them defaulting to utf-8
   will be counter-intuitive.
2) Windows doesn't support utf-8 locales, and switching
   the system encoding is a real pain. Thus the option.

This patch also adds proper encoding conversion to Apply Hunk/Line.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh       |    1 +
 lib/blame.tcl    |    2 +-
 lib/diff.tcl     |   11 ++++++-----
 lib/encoding.tcl |   14 ++++++++++++++
 lib/option.tcl   |   24 ++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 91457a2..444990b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -678,6 +678,7 @@ set default_config(merge.verbosity) 2
 set default_config(user.name) {}
 set default_config(user.email) {}
 
+set default_config(gui.encoding) [encoding system]
 set default_config(gui.matchtrackingbranch) false
 set default_config(gui.pruneduringfetch) false
 set default_config(gui.trustmtime) false
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 7535adb..84d55b5 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -402,7 +402,7 @@ method _load {jump} {
 	fconfigure $fd \
 		-blocking 0 \
 		-translation lf \
-		-encoding [tcl_encoding [gitattr $path encoding UTF-8]]
+		-encoding [get_path_encoding $path]
 	fileevent $fd readable [cb _read_file $fd $jump]
 	set current_fd $fd
 }
diff --git a/lib/diff.tcl b/lib/diff.tcl
index b0ecfbc..8fefc5d 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -164,11 +164,10 @@ proc show_other_diff {path w m scroll_pos} {
 					set sz [string length $content]
 				}
 				file {
-					set enc [gitattr $path encoding UTF-8]
 					set fd [open $path r]
 					fconfigure $fd \
 						-eofchar {} \
-						-encoding [tcl_encoding $enc]
+						-encoding [get_path_encoding $path]
 					set content [read $fd $max_sz]
 					close $fd
 					set sz [file size $path]
@@ -282,7 +281,7 @@ proc start_show_diff {scroll_pos {add_opts {}}} {
 	set ::current_diff_inheader 1
 	fconfigure $fd \
 		-blocking 0 \
-		-encoding [tcl_encoding [gitattr $path encoding UTF-8]] \
+		-encoding [get_path_encoding $path] \
 		-translation lf
 	fileevent $fd readable [list read_diff $fd $scroll_pos]
 }
@@ -435,8 +434,9 @@ proc apply_hunk {x y} {
 	}
 
 	if {[catch {
+		set enc [get_path_encoding $current_diff_path]
 		set p [eval git_write $apply_cmd]
-		fconfigure $p -translation binary -encoding binary
+		fconfigure $p -translation binary -encoding $enc
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p [$ui_diff get $s_lno $e_lno]
 		close $p} err]} {
@@ -604,8 +604,9 @@ proc apply_line {x y} {
 	set patch "@@ -$hln,$n +$hln,[eval expr $n $sign 1] @@\n$patch"
 
 	if {[catch {
+		set enc [get_path_encoding $current_diff_path]
 		set p [eval git_write $apply_cmd]
-		fconfigure $p -translation binary -encoding binary
+		fconfigure $p -translation binary -encoding $enc
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p $patch
 		close $p} err]} {
diff --git a/lib/encoding.tcl b/lib/encoding.tcl
index 7f06b0d..e186b0c 100644
--- a/lib/encoding.tcl
+++ b/lib/encoding.tcl
@@ -274,3 +274,17 @@ proc tcl_encoding {enc} {
     }
     return {}
 }
+
+proc get_path_encoding {path} {
+	set tcl_enc [tcl_encoding [get_config gui.encoding]]
+	if {$tcl_enc eq {}} {
+		set tcl_enc [encoding system]
+	}
+	if {$path ne {}} {
+		set enc2 [tcl_encoding [gitattr $path encoding $tcl_enc]]
+		if {$enc2 ne {}} {
+			set tcl_enc $enc2
+		}
+	}
+	return $tcl_enc
+}
diff --git a/lib/option.tcl b/lib/option.tcl
index 9b865f6..40af44e 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -1,6 +1,28 @@
 # git-gui options editor
 # Copyright (C) 2006, 2007 Shawn Pearce
 
+proc config_check_encodings {} {
+	global repo_config_new global_config_new
+
+	set enc $global_config_new(gui.encoding)
+	if {$enc eq {}} {
+		set global_config_new(gui.encoding) [encoding system]
+	} elseif {[tcl_encoding $enc] eq {}} {
+		error_popup [mc "Invalid global encoding '%s'" $enc]
+		return 0
+	}
+
+	set enc $repo_config_new(gui.encoding)
+	if {$enc eq {}} {
+		set repo_config_new(gui.encoding) [encoding system]
+	} elseif {[tcl_encoding $enc] eq {}} {
+		error_popup [mc "Invalid repo encoding '%s'" $enc]
+		return 0
+	}
+
+	return 1
+}
+
 proc save_config {} {
 	global default_config font_descs
 	global repo_config global_config
@@ -130,6 +152,7 @@ proc do_options {} {
 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
+		{t gui.encoding {mc "Default File Contents Encoding"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
@@ -275,6 +298,7 @@ proc do_restore_defaults {} {
 }
 
 proc do_save_config {w} {
+	if {![config_check_encodings]} return
 	if {[catch {save_config} err]} {
 		error_popup [strcat [mc "Failed to completely save options:"] "\n\n$err"]
 	}
-- 
1.6.0.20.g6148bc

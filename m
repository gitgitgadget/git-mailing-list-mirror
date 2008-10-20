From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI,MINGW) 1/3] git-gui: Add a dialog that shows the OpenSSH public key.
Date: Mon, 20 Oct 2008 20:02:18 +0400
Message-ID: <1224518540-23782-2-git-send-email-angavrilov@gmail.com>
References: <1224518540-23782-1-git-send-email-angavrilov@gmail.com>
Cc: msysgit@googlegroups.com, Johannes Sixt <johannes.sixt@telecom.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 21:13:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrxG7-0006X3-T6
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbYJTQEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYJTQEQ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 12:04:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:46649 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYJTQEP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 12:04:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1444220fgg.17
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=uAswcK0gQd4nXWPxzfuNSTXsNon/HmKh+DO1z/2iKe8=;
        b=SC88aHJB4Ha16jD4c1dzDtyDiNOUEwjCfgM4hKET7hCMcHipwlru+mG8iVX24KylFG
         JpNtvT1ZrdCsX8qAigYoGmriMFKn0eC3zbHPjnSVuWufK+O1E6p/nK89fBV5XlyngNDh
         DUG3Z49boULoE9quqa0V19nOGrNiB6IEf2WJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hpnWOGfsSZtDw/BShtGLXHxIJThCx7XoihZPdVqQunfZUE/VDhHgPm/R0KCgNqAvxx
         Swh4BqbDOedRmLoO6QARoaRIAoReL/rp6PnuwrZkdVK6EGnpoiGiT3pkKfh8c4mLL/fK
         jzVBn/stXS/k7xmwRQGSfoXfys3AHcO2o2xvE=
Received: by 10.181.144.10 with SMTP id w10mr2664791bkn.84.1224518652152;
        Mon, 20 Oct 2008 09:04:12 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id p17sm7985073fka.14.2008.10.20.09.04.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Oct 2008 09:04:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
In-Reply-To: <1224518540-23782-1-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98692>

Generating a new SSH key or finding an existing one may
be a difficult task for non-technical users, especially
on Windows.

This commit adds a new dialog that shows the public key,
or allows the user to generate a new one if none were found.
Since this is a convenience/informational feature for new
users, and the dialog is mostly read-only, it is located
in the Help menu.

The command line used to invoke ssh-keygen is designed to
force it to use SSH_ASKPASS if available, or accept empty
passphrases, but _never_ wait for user response on the tty.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh     |    4 ++
 lib/sshkey.tcl |  126 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 0 deletions(-)
 create mode 100644 lib/sshkey.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 4f95139..e4d1f70 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2536,6 +2536,10 @@ proc start_browser {url} {
 
 .mbar.help add command -label [mc "Online Documentation"] \
 	-command [list start_browser $doc_url]
+
+.mbar.help add command -label [mc "Show SSH Key"] \
+	-command do_ssh_key
+
 unset doc_path doc_url
 
 # -- Standard bindings
diff --git a/lib/sshkey.tcl b/lib/sshkey.tcl
new file mode 100644
index 0000000..82a1a80
--- /dev/null
+++ b/lib/sshkey.tcl
@@ -0,0 +1,126 @@
+# git-gui about git-gui dialog
+# Copyright (C) 2006, 2007 Shawn Pearce
+
+proc find_ssh_key {} {
+	foreach name {~/.ssh/id_dsa.pub ~/.ssh/id_rsa.pub ~/.ssh/identity.pub} {
+		if {[file exists $name]} {
+			set fh    [open $name r]
+			set cont  [read $fh]
+			close $fh
+			return [list $name $cont]
+		}
+	}
+
+	return {}
+}
+
+proc do_ssh_key {} {
+	global sshkey_title have_tk85 sshkey_fd
+
+	set w .sshkey_dialog
+	if {[winfo exists $w]} {
+		raise $w
+		return
+	}
+
+	toplevel $w
+	wm transient $w .
+
+	set finfo [find_ssh_key]
+	if {$finfo eq {}} {
+		set sshkey_title [mc "No keys found."]
+		set gen_state   normal
+	} else {
+		set sshkey_title [mc "Found a public key in: %s" [lindex $finfo 0]]
+		set gen_state   disabled
+	}
+
+	frame $w.header -relief flat
+	label $w.header.lbl -textvariable sshkey_title -anchor w
+	button $w.header.gen -text [mc "Generate Key"] \
+		-command [list make_ssh_key $w] -state $gen_state
+	pack $w.header.lbl -side left -expand 1 -fill x
+	pack $w.header.gen -side right
+	pack $w.header -fill x -pady 5 -padx 5
+
+	text $w.contents -width 60 -height 10 -wrap char -relief sunken
+	pack $w.contents -fill both -expand 1
+	if {$have_tk85} {
+		$w.contents configure -inactiveselectbackground darkblue
+	}
+
+	frame $w.buttons
+	button $w.buttons.close -text [mc Close] \
+		-default active -command [list destroy $w]
+	pack $w.buttons.close -side right
+	button $w.buttons.copy -text [mc "Copy To Clipboard"] \
+		-command [list tk_textCopy $w.contents]
+	pack $w.buttons.copy -side left
+	pack $w.buttons -side bottom -fill x -pady 5 -padx 5
+
+	if {$finfo ne {}} {
+		$w.contents insert end [lindex $finfo 1] sel
+	}
+	$w.contents configure -state disabled
+
+	bind $w <Visibility> "grab $w; focus $w.buttons.close"
+	bind $w <Key-Escape> "destroy $w"
+	bind $w <Key-Return> "destroy $w"
+	bind $w <Destroy> kill_sshkey
+	wm title $w [mc "Your OpenSSH Public Key"]
+	tk::PlaceWindow $w widget .
+	tkwait window $w
+}
+
+proc make_ssh_key {w} {
+	global sshkey_title sshkey_output sshkey_fd
+
+	set sshkey_title [mc "Generating..."]
+	$w.header.gen configure -state disabled
+
+	set cmdline [list sh -c {echo | ssh-keygen -q -t rsa -f ~/.ssh/id_rsa 2>&1}]
+
+	if {[catch { set sshkey_fd [_open_stdout_stderr $cmdline] } err]} {
+		error_popup [mc "Could not start ssh-keygen:\n\n%s" $err]
+		return
+	}
+
+	set sshkey_output {}
+	fconfigure $sshkey_fd -blocking 0
+	fileevent $sshkey_fd readable [list read_sshkey_output $sshkey_fd $w]
+}
+
+proc kill_sshkey {} {
+	global sshkey_fd
+	if {![info exists sshkey_fd]} return
+	catch { kill_file_process $sshkey_fd }
+	catch { close $sshkey_fd }
+}
+
+proc read_sshkey_output {fd w} {
+	global sshkey_fd sshkey_output sshkey_title
+
+	set sshkey_output "$sshkey_output[read $fd]"
+	if {![eof $fd]} return
+
+	fconfigure $fd -blocking 1
+	unset sshkey_fd
+
+	$w.contents configure -state normal
+	if {[catch {close $fd} err]} {
+		set sshkey_title [mc "Generation failed."]
+		$w.contents insert end $err
+		$w.contents insert end "\n"
+		$w.contents insert end $sshkey_output
+	} else {
+		set finfo [find_ssh_key]
+		if {$finfo eq {}} {
+			set sshkey_title [mc "Generation succeded, but no keys found."]
+			$w.contents insert end $sshkey_output
+		} else {
+			set sshkey_title [mc "Your key is in: %s" [lindex $finfo 0]]
+			$w.contents insert end [lindex $finfo 1] sel
+		}
+	}
+	$w.contents configure -state disable
+}
-- 
1.6.0.20.g6148bc

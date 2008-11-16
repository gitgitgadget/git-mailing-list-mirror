From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) v2 5/5] git-gui: Implement automatic rescan after Tool execution.
Date: Sun, 16 Nov 2008 21:46:51 +0300
Message-ID: <1226861211-16995-6-git-send-email-angavrilov@gmail.com>
References: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
 <1226861211-16995-2-git-send-email-angavrilov@gmail.com>
 <1226861211-16995-3-git-send-email-angavrilov@gmail.com>
 <1226861211-16995-4-git-send-email-angavrilov@gmail.com>
 <1226861211-16995-5-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 16 19:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1mhl-0001pL-Su
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 19:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbYKPStO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 13:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753279AbYKPStN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 13:49:13 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:8153 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYKPStH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 13:49:07 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2494253fkq.5
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 10:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=qWARCiyKgvozYb7/pfBh/dk6eIrdYGMpxJ8FMqOLLk0=;
        b=PLt0TqeWqgEmDvfyv27bV4+o+DKsbSTAyClPj9GglGi+exOBeMTnLvSfTchhYE/i5n
         S+JwTWPdvdZKnBK6a2DMXpbOu9HNirYuHiay6qFLuhCbxjL+pBUg1aTfE7vNCFRD7jaY
         LlQ+k6R8QK9Pq8gqanRPbfhnGndJry8MSBHl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=boXxfbcZ1rT+vIw/OwhfXL9HUAnDMC6BNWpTTC/5lGj7wf8dlBSpwb+79Gkx2cCkO7
         xaiFRA9HmUcpZS+o2cKY/5jZRzrOIrl1lw9V1udCWKkHAfRdeA9okcYU2VEhn7MWpP+d
         gU+ma/HVBlXh6gLGPm+/hY5WsjjNkULRwz4t4=
Received: by 10.181.223.2 with SMTP id a2mr794991bkr.184.1226861346587;
        Sun, 16 Nov 2008 10:49:06 -0800 (PST)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id z15sm3020368fkz.16.2008.11.16.10.49.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 Nov 2008 10:49:05 -0800 (PST)
X-Mailer: git-send-email 1.6.0.3.15.gb8d36
In-Reply-To: <1226861211-16995-5-git-send-email-angavrilov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101155>

The Tools menu is generally intended for commands that
affect the working directory or repository state. Thus,
the user would usually want to initiate rescan after
execution of a tool. This commit implements it.

In case somebody would want to avoid rescanning after
certain tools, it also adds an option that controls it,
although it is not made available through the Add dialog.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/tools.tcl |   44 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/lib/tools.tcl b/lib/tools.tcl
index 044432e..51366b0 100644
--- a/lib/tools.tcl
+++ b/lib/tools.tcl
@@ -102,13 +102,15 @@ proc tools_exec {fullname} {
 
 	set cmdline $repo_config(guitool.$fullname.cmd)
 	if {[is_config_true "guitool.$fullname.noconsole"]} {
-		exec sh -c $cmdline &
+		tools_run_silent [list sh -c $cmdline] \
+				 [list tools_complete $fullname {}]
 	} else {
 		regsub {/} $fullname { / } title
 		set w [console::new \
 			[mc "Tool: %s" $title] \
 			[mc "Running: %s" $cmdline]]
-		console::exec $w [list sh -c $cmdline]
+		console::exec $w [list sh -c $cmdline] \
+				 [list tools_complete $fullname $w]
 	}
 
 	unset env(GIT_GUITOOL)
@@ -117,3 +119,41 @@ proc tools_exec {fullname} {
 	catch { unset env(ARGS) }
 	catch { unset env(REVISION) }
 }
+
+proc tools_run_silent {cmd after} {
+	lappend cmd 2>@1
+	set fd [_open_stdout_stderr $cmd]
+	
+	fconfigure $fd -blocking 0 -translation binary
+	fileevent $fd readable [list tools_consume_input $fd $after]
+}
+
+proc tools_consume_input {fd after} {
+	read $fd
+	if {[eof $fd]} {
+		fconfigure $fd -blocking 1
+		if {[catch {close $fd}]} {
+			uplevel #0 $after 0
+		} else {
+			uplevel #0 $after 1
+		}
+	}
+}
+
+proc tools_complete {fullname w {ok 1}} {
+	if {$w ne {}} {
+		console::done $w $ok
+	}
+
+	if {$ok} {
+		set msg [mc "Tool completed succesfully: %s" $fullname]
+	} else {
+		set msg [mc "Tool failed: %s" $fullname]
+	}
+
+	if {[is_config_true "guitool.$fullname.norescan"]} {
+		ui_status $msg
+	} else {
+		rescan [list ui_status $msg]
+	}
+}
-- 
1.6.0.3.15.gb8d36

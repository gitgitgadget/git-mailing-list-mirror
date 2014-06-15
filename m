From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: avoid mkdtemp on Windows
Date: Sun, 15 Jun 2014 15:23:56 -0700
Message-ID: <1402871036-1389-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 00:24:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwIqT-0007Ft-0c
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaFOWYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 18:24:10 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:64908 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbaFOWYH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 18:24:07 -0400
Received: by mail-pb0-f50.google.com with SMTP id rp16so3788082pbb.37
        for <git@vger.kernel.org>; Sun, 15 Jun 2014 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nQwtciVQ3Z0k/zi4HcwRQJFepcnHgfVBPbvBlcHUcj0=;
        b=XML6PyrBiBEznouKJq/RmeuMbNCnXOabojWpYWSfyIQqR8Gytup6hG1CyAvop74pUa
         N7wDXQQhnfTsR31zHaCrMBtmmEPDTSNuHwQp8i+Hk2aela+wUlOvwzH/osL3sDtZfrLx
         j8e5PBqJ8ouj+ooDDlc5o0jBl50KegMa6dDuHrxIzW8hdrG+HRc4UJ6kbr/6muyfZztL
         8bF8Rc38CYIdPH7B4Ff05uQjneWMF8jN9+vJDYfKcAJp6tK6Ee/pCOAAYlm3vBrk/CWZ
         abnYEk3JzVSXla1HmmxoQkoN1A8MorDTwqv0+ImJGw+7yZJNNvjE95yO/OMCL6sKVzBv
         0B/A==
X-Received: by 10.66.66.72 with SMTP id d8mr19959730pat.8.1402871047104;
        Sun, 15 Jun 2014 15:24:07 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id nw13sm58449769pab.37.2014.06.15.15.24.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 15 Jun 2014 15:24:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.257.g75cc6c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251700>

105b5d3fbb1c00bb0aeaf9d3e0fbe26a7b1993fc introduced a dependency
on mkdtemp, which is not available on Windows.

Restore the original temporary directory behavior for Windows so
that gitk creates temporary directories in the current
repository.

The Unix code path retains new TMPDIR behavior.

Reported-by: Pat Thoyts <patthoyts@users.sourceforge.net>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/gitk b/gitk
index 41e5071..66d8c9e 100755
--- a/gitk
+++ b/gitk
@@ -3496,15 +3496,22 @@ proc gitknewtmpdir {} {
     global diffnum gitktmpdir gitdir env
 
     if {![info exists gitktmpdir]} {
-	if {[info exists env(GITK_TMPDIR)]} {
-	    set tmpdir $env(GITK_TMPDIR)
-	} elseif {[info exists env(TMPDIR)]} {
-	    set tmpdir $env(TMPDIR)
+	if {$::tcl_platform(platform) eq {windows}} {
+	    # Windows does not have mkdtemp so use the current directory
+	    # to avoid using an unsafe pattern in a world-writeable
+	    # temporary directory.
+	    set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
 	} else {
-	    set tmpdir $gitdir
+	    if {[info exists env(GITK_TMPDIR)]} {
+		set tmpdir $env(GITK_TMPDIR)
+	    } elseif {[info exists env(TMPDIR)]} {
+		set tmpdir $env(TMPDIR)
+	    } else {
+		set tmpdir $gitdir
+	    }
+	    set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
+	    set gitktmpdir [exec mktemp -d $gitktmpformat]
 	}
-	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
-	set gitktmpdir [exec mktemp -d $gitktmpformat]
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
2.0.0.257.g75cc6c6

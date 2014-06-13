From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: honor TMPDIR when viewing external diffs
Date: Fri, 13 Jun 2014 14:13:37 -0700
Message-ID: <1402694017-91249-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvYnB-0000LI-0k
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbaFMVNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 17:13:41 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:59840 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbaFMVNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:13:40 -0400
Received: by mail-pb0-f54.google.com with SMTP id jt11so2509826pbb.13
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 14:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KRD068cidfvRcFA9Eg/zI8xUYlYuCyMpFTk00cNOZ2c=;
        b=y9qELt/pU0acpf3s/5CgF5ep8oGMUWn7cAGU9A+HVWRLSwETNcMRiWX9ZhFWNBwdvJ
         0lg891w5pZpAoXpHSCX3ouDJNjbzSx5rr0oYNBjK0surt6OLK2bWGFH3hCwvXakMBNqu
         C/GfTvLIXqn7FTUKUHPr//FtgRc+U1/5Dk3Syh+QfIBd+3Ro+VimxtOtxefswL9nBRn4
         NAM8KySVuXha9zj+uaVvdMCnGB06D5zuy+95Rf5WVPKDE4VT4EF8OFRlS0a30xXL+IRV
         WnSnAvz4B/Bg00vTLjEyozXQLfFYDBX0qyLm2ZK4J/K3cWXQ8/SEhLAtKoYM+Ce01/5J
         Rg/w==
X-Received: by 10.66.142.199 with SMTP id ry7mr6406541pab.10.1402694019772;
        Fri, 13 Jun 2014 14:13:39 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id iz2sm5243611pbb.95.2014.06.13.14.13.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 14:13:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.257.g75cc6c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251637>

gitk fails to show diffs when browsing a read-only repository.
This is due to gitk's assumption that the current directory is always
writable.

Teach gitk to honor either the GITK_TMPDIR or TMPDIR environment
variables.  This allows users to override the default location
used when writing temporary files.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 90764e8..82293dd 100755
--- a/gitk
+++ b/gitk
@@ -3492,10 +3492,17 @@ proc flist_hl {only} {
 }
 
 proc gitknewtmpdir {} {
-    global diffnum gitktmpdir gitdir
+    global diffnum gitktmpdir gitdir env
 
     if {![info exists gitktmpdir]} {
-	set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
+	if {[info exists env(GITK_TMPDIR)]} {
+	    set tmpdir $env(GITK_TMPDIR)
+	} elseif {[info exists env(TMPDIR)]} {
+	    set tmpdir $env(TMPDIR)
+	} else {
+	    set tmpdir $gitdir
+	}
+	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
2.0.0.257.g75cc6c6

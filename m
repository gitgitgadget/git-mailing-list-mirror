From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] git-gui: deal with unknown files when pressing the "Stage
	Changed" button
Date: Fri, 27 May 2011 17:40:24 +0200
Message-ID: <20110527154020.GA2273@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Fri May 27 17:47:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPzFs-0008Dr-5a
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 17:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab1E0PrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 11:47:12 -0400
Received: from darksea.de ([83.133.111.250]:60207 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751316Ab1E0PrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 11:47:09 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 May 2011 11:47:08 EDT
Received: (qmail 8967 invoked from network); 27 May 2011 17:40:25 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 May 2011 17:40:25 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174624>

As a shortcut the "Stage Changed" button can be used to stage all current
changes in the worktree which are not set to ignore. Previously unknown
files would be ignored. The user might want to say: "Just save everything
in my worktree". To support this workflow we now ask whether the user also
wants to stage the unknown files if there are some present.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 lib/index.tcl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index 5d7bbf2..e38b647 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -356,12 +356,21 @@ proc do_add_all {} {
 	global file_states
 
 	set paths [list]
+	set unknown_paths [list]
 	foreach path [array names file_states] {
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
 		?M -
 		?T -
 		?D {lappend paths $path}
+		?O {lappend unknown_paths $path}
+		}
+	}
+	if {[llength $unknown_paths]} {
+		set reply [ask_popup [mc "There are unknown files do you also want
+to stage those?"]]
+		if {$reply} {
+			set paths [concat $paths $unknown_paths]
 		}
 	}
 	add_helper {Adding all changed files} $paths
-- 
1.7.5.1.219.g4c6b2

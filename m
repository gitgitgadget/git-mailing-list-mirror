From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 3/4] git gui: de-dup selected repo from recentrepo history
Date: Mon, 14 Dec 2015 15:09:02 +0000
Message-ID: <1450105743-2432-4-git-send-email-philipoakley@iee.org>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
 <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Cc: Alexey Astakhov <asstv7@gmail.com>, sender <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:09:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ukb-0003dW-MW
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbbLNPJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:09:11 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:7300 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752441AbbLNPJE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:09:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ADCwCz2m5WPCSzBlxeGQEBAQELAQIBAQEBAYI5UYFBgmKDfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgESiDO9MQEBAQcjhlaOPQWWdo8fh22TTIRnPjSFBgEBAQ
X-IPAS-Result: A2ADCwCz2m5WPCSzBlxeGQEBAQELAQIBAQEBAYI5UYFBgmKDfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgESiDO9MQEBAQcjhlaOPQWWdo8fh22TTIRnPjSFBgEBAQ
X-IronPort-AV: E=Sophos;i="5.20,427,1444690800"; 
   d="scan'208";a="570746132"
Received: from host-92-6-179-36.as43234.net (HELO localhost) ([92.6.179.36])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 14 Dec 2015 15:31:05 +0000
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282359>

When the gui/user selects a repo for display, that repo is brought to
the end of the recentrepo config list. The logic can fail if there are
duplicate old entries for the repo (you cannot unset a single config
entry when duplicates are present).

Similarly, the maxrecentrepo logic could fail if older duplicate entries
are present.

The first commit of this series ({this}~2) fixed the config unsetting
issue. Rather than manipulating a local copy of the $recent list (one
cannot know how many entries were removed), simply re-read it.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 git-gui/lib/choose_repository.tcl | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index aa87bcc..ad7a888 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -262,12 +262,11 @@ proc _append_recentrepos {path} {
 	set i [lsearch $recent $path]
 	if {$i >= 0} {
 		_unset_recentrepo $path
-		set recent [lreplace $recent $i $i]
 	}
 
-	lappend recent $path
 	git config --global --add gui.recentrepo $path
 	load_config 1
+	set recent [get_config gui.recentrepo]
 
 	if {[set maxrecent [get_config gui.maxrecentrepo]] eq {}} {
 		set maxrecent 10
@@ -275,7 +274,7 @@ proc _append_recentrepos {path} {
 
 	while {[llength $recent] > $maxrecent} {
 		_unset_recentrepo [lindex $recent 0]
-		set recent [lrange $recent 1 end]
+		set recent [get_config gui.recentrepo]
 	}
 }
 
-- 
2.5.2.windows.2

From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 3/4] git gui: de-dup selected repo from recentrepo history
Date: Wed, 16 Dec 2015 23:58:06 +0000
Message-ID: <1450310287-4936-4-git-send-email-philipoakley@iee.org>
References: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:58:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Lxh-00037l-Hb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934303AbbLPX6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:58:22 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:45216 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755302AbbLPX6U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 18:58:20 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BDCADm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYE/hmC0cIQJhgcEAgKBKE0BAQEBAQEHAQEBAUE/hDUBAQRWIxBROQoUBhOIM7IejBABAQEHI4ZWjj0FlnyPJIdtk1KEaD40hG4BAQE
X-IPAS-Result: A2BDCADm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYE/hmC0cIQJhgcEAgKBKE0BAQEBAQEHAQEBAUE/hDUBAQRWIxBROQoUBhOIM7IejBABAQEHI4ZWjj0FlnyPJIdtk1KEaD40hG4BAQE
X-IronPort-AV: E=Sophos;i="5.20,438,1444690800"; 
   d="scan'208";a="571788359"
Received: from host-2-99-183-201.as13285.net (HELO localhost.localdomain) ([2.99.183.201])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 17 Dec 2015 00:21:56 +0000
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282621>

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
2.6.4.windows.1

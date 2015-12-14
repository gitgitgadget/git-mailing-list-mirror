From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 2/4] git gui: cope with duplicates in _get_recentrepo
Date: Mon, 14 Dec 2015 15:09:01 +0000
Message-ID: <1450105743-2432-3-git-send-email-philipoakley@iee.org>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
 <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Cc: Alexey Astakhov <asstv7@gmail.com>, sender <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:09:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Uka-0003dW-H8
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbbLNPJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:09:05 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:7300 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751860AbbLNPJD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:09:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2ADCwCz2m5WPCSzBlxeGQEBAQELAQIBAQEBAYI5UYFBgmKDfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgESiDO9MQEBAQcjhlaOPQWWdpx9jVuEZz40hQYBAQE
X-IPAS-Result: A2ADCwCz2m5WPCSzBlxeGQEBAQELAQIBAQEBAYI5UYFBgmKDfoFYsmKECoYIBAICgSJNAQEBAQEBBwEBAQFAAT+ENQEBBFYjEAhJOQoUBgESiDO9MQEBAQcjhlaOPQWWdpx9jVuEZz40hQYBAQE
X-IronPort-AV: E=Sophos;i="5.20,427,1444690800"; 
   d="scan'208";a="570746130"
Received: from host-92-6-179-36.as43234.net (HELO localhost) ([92.6.179.36])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 14 Dec 2015 15:31:05 +0000
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282361>

_get_recentrepo will fail if duplicate invalid entries are present
in the recentrepo config list. The previous commit fixed the
'git config' limitations in _unset_recentrepo by unsetting all config
entries, however this code would fail on the second attempt to unset it.

Refactor the code to pre-sort and de-duplicate the recentrepo list to
avoid a potential second unset attempt.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 git-gui/lib/choose_repository.tcl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 133ca0a..aa87bcc 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -235,14 +235,14 @@ method _invoke_next {} {
 
 proc _get_recentrepos {} {
 	set recent [list]
-	foreach p [get_config gui.recentrepo] {
+	foreach p [lsort -unique [get_config gui.recentrepo]] {
 		if {[_is_git [file join $p .git]]} {
 			lappend recent $p
 		} else {
 			_unset_recentrepo $p
 		}
 	}
-	return [lsort $recent]
+	return $recent
 }
 
 proc _unset_recentrepo {p} {
-- 
2.5.2.windows.2

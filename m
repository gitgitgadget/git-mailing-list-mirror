From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 2/4] git gui: cope with duplicates in _get_recentrepo
Date: Wed, 16 Dec 2015 23:58:05 +0000
Message-ID: <1450310287-4936-3-git-send-email-philipoakley@iee.org>
References: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:58:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Lxr-0003VL-Re
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934593AbbLPX6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:58:23 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:3705 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754954AbbLPX6U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 18:58:20 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BDCADm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYE/hmC0cIQJhgcEAgKBKE0BAQEBAQEHAQEBAUE/hDUBAQRWIxBROQoUBhOIM7IejBABAQEHI4ZWjj0FlnydAo1hhGg+NIRuAQEB
X-IPAS-Result: A2BDCADm+XFWPMm3YwJeGQEBAQEPAQEBAYI5UYE/hmC0cIQJhgcEAgKBKE0BAQEBAQEHAQEBAUE/hDUBAQRWIxBROQoUBhOIM7IejBABAQEHI4ZWjj0FlnydAo1hhGg+NIRuAQEB
X-IronPort-AV: E=Sophos;i="5.20,438,1444690800"; 
   d="scan'208";a="571788358"
Received: from host-2-99-183-201.as13285.net (HELO localhost.localdomain) ([2.99.183.201])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 17 Dec 2015 00:21:55 +0000
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282625>

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
2.6.4.windows.1

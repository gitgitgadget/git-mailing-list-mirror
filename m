From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] gitk: parse arbitrary commit-ish in SHA1 field
Date: Sat, 8 Aug 2009 16:56:11 +0200
Message-ID: <f7e6f82a33aa8496de81262d641953534089e980.1249742874.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 16:56:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZnLt-0002VW-6H
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 16:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbZHHO4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 10:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbZHHO4s
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 10:56:48 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:38108 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbZHHO4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 10:56:47 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 8 Aug
 2009 16:56:45 +0200
Received: from localhost.localdomain (77.56.221.170) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Sat, 8 Aug
 2009 16:56:25 +0200
X-Mailer: git-send-email 1.6.4.199.g24c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125279>

We only accepted either SHA1s or heads/tags that have been read.  This
meant the user could not, e.g., enter HEAD to go back to the current
commit.

Add code to call out to git-rev-parse with the string entered if all
other methods of interpreting it failed.  The error paths change
slighly, because we now know from the rev-parse invocation whether the
expression was valid at all.  The previous "unknown" path is now only
triggered if the revision does exist, but is not in the current view
display.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Of course, *ideally* we'd resort to *changing* the current view so
that it also lists the requested commit.  But my Tk-fu is currently
not up to that task.


 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..4b27886 100755
--- a/gitk
+++ b/gitk
@@ -7906,6 +7906,11 @@ proc gotocommit {} {
 		}
 		set id [lindex $matches 0]
 	    }
+	} else {
+	    if {[catch {set id [exec git rev-parse $sha1string]}]} {
+		error_popup [mc "Revision %s is not known" $sha1string]
+		return
+	    }
 	}
     }
     if {[commitinview $id $curview]} {
@@ -7915,7 +7920,7 @@ proc gotocommit {} {
     if {[regexp {^[0-9a-fA-F]{4,}$} $sha1string]} {
 	set msg [mc "SHA1 id %s is not known" $sha1string]
     } else {
-	set msg [mc "Tag/Head %s is not known" $sha1string]
+	set msg [mc "Revision %s is not in the current view" $sha1string]
     }
     error_popup $msg
 }
-- 
1.6.4.199.g24c3

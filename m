From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] gitk: parse arbitrary commit-ish in SHA1 field
Date: Thu, 13 Aug 2009 09:25:03 +0200
Message-ID: <c3c4afa39354da6df5a0b17ee43eb4e8dfcfb099.1250148240.git.trast@student.ethz.ch>
References: <7vtz0fndak.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 09:25:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbUgs-0006d1-4F
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 09:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbZHMHZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 03:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbZHMHZV
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 03:25:21 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:52702 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZHMHZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 03:25:19 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 09:25:19 +0200
Received: from localhost.localdomain (129.132.210.214) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 09:25:18 +0200
X-Mailer: git-send-email 1.6.4.269.g0449d
In-Reply-To: <7vtz0fndak.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125789>

We only accepted either SHA1s or heads/tags that have been read.  This
meant the user could not, e.g., enter HEAD to go back to the current
commit.

Add code to call out to git rev-parse --verify with the string entered
if all other methods of interpreting it failed.  (git-rev-parse alone
is not enough as we really want a single revision.)

The error paths change slighly, because we now know from the rev-parse
invocation whether the expression was valid at all.  The previous
"unknown" path is now only triggered if the revision does exist, but
is not in the current view display.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> > +     } else {
> > +         if {[catch {set id [exec git rev-parse $sha1string]}]} {
> 
> "--verify", or "--no-flags --revs-only"?

Indeed, thanks.


 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 4604c83..e50b666 100755
--- a/gitk
+++ b/gitk
@@ -7906,6 +7906,11 @@ proc gotocommit {} {
 		}
 		set id [lindex $matches 0]
 	    }
+	} else {
+	    if {[catch {set id [exec git rev-parse --verify $sha1string]}]} {
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
1.6.4.269.g0449d

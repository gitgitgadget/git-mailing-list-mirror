From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 3/3] gitk: Allow displaying time zones from author and commit
 timestamps
Date: Wed, 19 Jan 2011 14:47:52 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1101191447340.23868@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfe0e-0000fW-Gx
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732Ab1ASTrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:47:55 -0500
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:64214 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750827Ab1ASTry (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jan 2011 14:47:54 -0500
X-AuditID: 12074422-b7c3eae000000a70-79-4d373fea81d7
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id FA.FA.02672.AEF373D4; Wed, 19 Jan 2011 14:47:54 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p0JJlrgk027118;
	Wed, 19 Jan 2011 14:47:53 -0500
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p0JJlq5K020487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 19 Jan 2011 14:47:53 -0500 (EST)
In-Reply-To: <alpine.DEB.2.02.1101191445130.23868@dr-wily.mit.edu>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165288>

Now gitk can be configured to display author and commit dates in their
original timezone, by putting %z into datetimeformat in ~/.gitk.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 5c6058a..a072593 100755
--- a/gitk
+++ b/gitk
@@ -11018,7 +11018,18 @@ proc prefsok {} {
 proc formatdate {d} {
     global datetimeformat
     if {$d ne {}} {
-	set d [clock format [lindex $d 0] -format $datetimeformat]
+	if {[string match {*%[zZ]*} $datetimeformat]} {
+	    if {[catch {set d [clock format [lindex $d 0] -timezone [lindex $d 1] -format $datetimeformat]}]} {
+		# Tcl < 8.5 does not support -timezone.
+		global env
+		set zone [lindex $d 1]
+		set env(TZ) "IDK[string range $zone 0 2]:[string range $zone 3 end]"
+		set d [clock format [lindex $d 0] -format $datetimeformat]
+		unset env(TZ)
+	    }
+	} else {
+	    set d [clock format [lindex $d 0] -format $datetimeformat]
+	}
     }
     return $d
 }
-- 
1.7.4.rc1

From: Anders Kaseorg <andersk@MIT.EDU>
Subject: [PATCH 4/4] gitk: Allow displaying time zones from author and commit timestamps
Date: Fri, 19 Nov 2010 02:38:20 -0500
Message-ID: <1290152300-21393-4-git-send-email-andersk@mit.edu>
References: <1290152300-21393-1-git-send-email-andersk@mit.edu>
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 08:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJLYF-0002kB-1I
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 08:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab0KSHi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 02:38:27 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:44006 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751132Ab0KSHi0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 02:38:26 -0500
X-AuditID: 1209190f-b7c1dae000000a2b-c9-4ce629713a6f
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id C6.7C.02603.17926EC4; Fri, 19 Nov 2010 02:38:25 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id oAJ7cP6N024244;
	Fri, 19 Nov 2010 02:38:25 -0500
Received: from localhost (ET-TWENTY-THREE.MIT.EDU [18.208.1.23])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oAJ7cORh019344;
	Fri, 19 Nov 2010 02:38:25 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1290152300-21393-1-git-send-email-andersk@mit.edu>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161726>

Now gitk can be configured to display author and commit dates in their
original timezone, by putting %z into datetimeformat in ~/.gitk.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 gitk-git/gitk |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index acdbd21..b67ecc4 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10957,7 +10957,18 @@ proc prefsok {} {
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
1.7.3.2

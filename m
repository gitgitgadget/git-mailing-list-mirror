From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v4' 1/2] gitk: do not parse "  >" context as submodule change
Date: Mon, 19 Apr 2010 18:27:26 +0200
Message-ID: <671110fcac73c5fc8a935b82d88f8553c510c50c.1271694102.git.trast@student.ethz.ch>
References: <20100419010819.GA4386@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 18:27:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3tp0-0004To-PM
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 18:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab0DSQ1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 12:27:30 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:9424 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab0DSQ13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 12:27:29 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 19 Apr
 2010 18:27:27 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 19 Apr
 2010 18:27:26 +0200
X-Mailer: git-send-email 1.7.1.rc1.284.g4b2e3
In-Reply-To: <20100419010819.GA4386@brick.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145314>

Since 5c838d2 (gitk: Use the --submodule option for displaying diffs
when available, 2009-10-28) gitk erroneously matches "  >" and "  <"
at the beginning of a line in the submodule code even if we're in the
diff text section and the lines should be treated as context.

Fix by (ab)using the $diffinhdr variable also in the 'Submodule...'
case, and move the "  >"/"  <" specific code inside the $diffinhdr
test.  The existing code will set $diffinhdr to 0 when it hits a
"+++", so that it is always 0 when we can hit a context line.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

> Thanks, but now that I have applied Jens Lehmann's patch that also
> touches this area, your patch doesn't apply.  Could you rebase it and
> send it again?

Sure.


 gitk |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/gitk b/gitk
index 1b0e09a..6513ef8 100755
--- a/gitk
+++ b/gitk
@@ -7706,14 +7706,8 @@ proc getblobdiffline {bdf ids} {
 	    } else {
 		$ctext insert end "$line\n" filesep
 	    }
-	} elseif {![string compare -length 3 "  >" $line]} {
-	    set $currdiffsubmod ""
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" dresult
-	} elseif {![string compare -length 3 "  <" $line]} {
-	    set $currdiffsubmod ""
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" d0
+	    # pretend we're in a file header to correctly parse "  [><]"
+	    set diffinhdr 1
 	} elseif {$diffinhdr} {
 	    if {![string compare -length 12 "rename from " $line]} {
 		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
@@ -7732,6 +7726,14 @@ proc getblobdiffline {bdf ids} {
 		    set fname [lindex $fname 0]
 		}
 		makediffhdr $fname $ids
+	    } elseif {![string compare -length 3 "  >" $line]} {
+		set line [encoding convertfrom $diffencoding $line]
+		$ctext insert end "$line\n" dresult
+		continue
+	    } elseif {![string compare -length 3 "  <" $line]} {
+		set line [encoding convertfrom $diffencoding $line]
+		$ctext insert end "$line\n" d0
+		continue
 	    } elseif {[string compare -length 3 $line "---"] == 0} {
 		# do nothing
 		continue
-- 
1.7.1.rc1.284.g4b2e3

From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3 2/3] gitk: do not parse "  >" context as submodule change
Date: Mon, 12 Apr 2010 15:07:45 +0200
Message-ID: <ba83d579ded263a44455508ad89ff142272626c6.1271077334.git.trast@student.ethz.ch>
References: <cover.1271077334.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 15:08:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1JNI-0006hj-CE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 15:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab0DLNIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 09:08:04 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:33992 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963Ab0DLNH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 09:07:59 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:07:57 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:07:46 +0200
X-Mailer: git-send-email 1.7.1.rc0.260.g2b919
In-Reply-To: <cover.1271077334.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144726>

Since 5c838d2 (gitk: Use the --submodule option for displaying diffs
when available, 2009-10-28) gitk erroneously matches "  >" and "  <"
at the beginning of a line in the submodule code even if we're in the
diff text section and the lines should be treated as context.

Fix by (ab)using the $diffinhdr variable also in the 'Submodule...'
case, and move the "  >"/"  <" specific code inside the $diffinhdr
test.  The existing code will set $diffinhdr to 0 when it hits a
"+++", so that it is always 0 when we can hit a context line.
---
 gitk |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..e9e284e 100755
--- a/gitk
+++ b/gitk
@@ -7688,12 +7688,8 @@ proc getblobdiffline {bdf ids} {
 	    lappend ctext_file_lines $fname
 	    makediffhdr $fname $ids
 	    $ctext insert end "\n$line\n" filesep
-	} elseif {![string compare -length 3 "  >" $line]} {
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" dresult
-	} elseif {![string compare -length 3 "  <" $line]} {
-	    set line [encoding convertfrom $diffencoding $line]
-	    $ctext insert end "$line\n" d0
+	    # pretend we're in a file header to correctly parse "  [><]"
+	    set diffinhdr 1
 	} elseif {$diffinhdr} {
 	    if {![string compare -length 12 "rename from " $line]} {
 		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
@@ -7712,6 +7708,12 @@ proc getblobdiffline {bdf ids} {
 		    set fname [lindex $fname 0]
 		}
 		makediffhdr $fname $ids
+	    } elseif {![string compare -length 3 "  >" $line]} {
+		set line [encoding convertfrom $diffencoding $line]
+		$ctext insert end "$line\n" dresult
+	    } elseif {![string compare -length 3 "  <" $line]} {
+		set line [encoding convertfrom $diffencoding $line]
+		$ctext insert end "$line\n" d0
 	    } elseif {[string compare -length 3 $line "---"] == 0} {
 		# do nothing
 		continue
-- 
1.7.1.rc0.262.gff1a3

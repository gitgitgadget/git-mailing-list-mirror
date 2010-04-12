From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3.1] gitk: do not parse "  >" context as submodule change
Date: Mon, 12 Apr 2010 15:25:53 +0200
Message-ID: <5531510bfb94997f729a894a0b5a3158177a9add.1271078624.git.trast@student.ethz.ch>
References: <ba83d579ded263a44455508ad89ff142272626c6.1271077334.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, Miles Bader <miles@gnu.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 15:26:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Jef-0000ZG-2B
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 15:26:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411Ab0DLN0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 09:26:14 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:40018 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740Ab0DLN0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 09:26:13 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:26:13 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Mon, 12 Apr
 2010 15:25:53 +0200
X-Mailer: git-send-email 1.7.1.rc0.260.gfbdca
In-Reply-To: <ba83d579ded263a44455508ad89ff142272626c6.1271077334.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144728>

Since 5c838d2 (gitk: Use the --submodule option for displaying diffs
when available, 2009-10-28) gitk erroneously matches "  >" and "  <"
at the beginning of a line in the submodule code even if we're in the
diff text section and the lines should be treated as context.

Fix by (ab)using the $diffinhdr variable also in the 'Submodule...'
case, and move the "  >"/"  <" specific code inside the $diffinhdr
test.  The existing code will set $diffinhdr to 0 when it hits a
"+++", so that it is always 0 when we can hit a context line.
---

I just noticed that I forgot to add the 'continue' that prevents the
final 'insert' in the $diffinhdr block from kicking in, which resulted
in doubling of the lines.  This one has them.  Sorry for the noise.


 gitk |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 1f36a3e..7b8799e 100755
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
@@ -7712,6 +7708,14 @@ proc getblobdiffline {bdf ids} {
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
1.7.1.rc0.260.g2b919

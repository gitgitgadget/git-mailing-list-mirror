From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 gitk 3/5] gitk: split out diff part in $commitinfo
Date: Sat, 16 Nov 2013 18:37:42 +0100
Message-ID: <ea752daecf16e623a19432dbc2e05d07b970edcb.1384622392.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622392.git.tr@thomasrast.ch>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhjon-0007H5-4Y
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873Ab3KPRh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:37:58 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38461 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab3KPRhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:37:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 83DE64D65A3;
	Sat, 16 Nov 2013 18:37:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uAKOWjLShItj; Sat, 16 Nov 2013 18:37:52 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id C5E764D6570;
	Sat, 16 Nov 2013 18:37:51 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622392.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237931>

From: Thomas Rast <trast@inf.ethz.ch>

So far we just parsed everything after the headers into the "comment"
bit of $commitinfo, including notes and -- if you gave weird options
-- the diff.

Split out the diff, if any, into a separate field.  It's easy to
recognize, since it always starts with /^diff/ and is preceded by an
empty line.

We take care to snip away said empty line.  The display code already
properly spaces the end of the message from the first diff, and
leaving another empty line at the end looks ugly.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 11e988e..78b4354 100755
--- a/gitk
+++ b/gitk
@@ -1704,8 +1704,17 @@ proc parsecommit {id contents listed} {
 	set comment $newcomment
     }
     set hasnote [string first "\nNotes:\n" $contents]
+    set diff ""
+    # If there is diff output shown in the git-log stream, split it
+    # out.  But get rid of the empty line that always precedes the
+    # diff.
+    set i [string first "\n\ndiff" $comment]
+    if {$i >= 0} {
+	set diff [string range $comment $i+1 end]
+	set comment [string range $comment 0 $i-1]
+    }
     set commitinfo($id) [list $headline $auname $audate \
-			     $comname $comdate $comment $hasnote]
+			     $comname $comdate $comment $hasnote $diff]
 }
 
 proc getcommit {id} {
-- 
1.8.5.rc2.348.gb73b695

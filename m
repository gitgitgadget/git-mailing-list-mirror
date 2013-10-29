From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 3/7] gitk: split out diff part in $commitinfo
Date: Tue, 29 Oct 2013 08:20:36 +0100
Message-ID: <9b4daa449f4cb8228f75477f0d32826edfc401cd.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3cH-0006P2-Pg
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab3J2HVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:23 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56302 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052Ab3J2HVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 604934D65B2;
	Tue, 29 Oct 2013 08:21:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id D9qyW-t8Qqr0; Tue, 29 Oct 2013 08:20:58 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 8A12A4D659D;
	Tue, 29 Oct 2013 08:20:56 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
In-Reply-To: <cover.1383031141.git.tr@thomasrast.ch>
References: <cover.1383031141.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236902>

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
 gitk-git/gitk | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 11e988e..78b4354 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
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
1.8.4.2.838.ga9a3e20

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Make git-format-patch's signoff option more consistent
Date: Tue, 16 Aug 2005 02:20:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508160208020.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 16 02:22:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4pC5-0005kK-P0
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 02:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbVHPAUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 20:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVHPAUg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 20:20:36 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45795 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965047AbVHPAUf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 20:20:35 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D68AE2820; Tue, 16 Aug 2005 02:20:34 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 30E74B08A1; Tue, 16 Aug 2005 02:20:34 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 14410AD0CB; Tue, 16 Aug 2005 02:20:34 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 03B7EE2820; Tue, 16 Aug 2005 02:20:34 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Since git-commit-script has a "--signoff" option, use that in 
git-format-patch-script, too (and since partial option names are 
supported,"--sign" is still valid).

Also, if the message already contains the S-O-B line, silently ignore the 
"--signoff" request.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 git-format-patch-script |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

36d8f8116e677848da231e3d33da379bd4546505
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -6,7 +6,7 @@
 . git-sh-setup-script || die "Not a git archive."
 
 usage () {
-    echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [--sign] [-<diff options>...] upstream [ our-head ]
+    echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [--signoff] [-<diff options>...] upstream [ our-head ]
 
 Prepare each commit with its patch since our-head forked from upstream,
 one file per patch, for e-mail submission.  Each output file is
@@ -46,7 +46,7 @@ do
     date=t author=t mbox=t ;;
     -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
     numbered=t ;;
-    -s|--s|--si|--sig|--sign)
+    -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
     signoff=t ;;
     -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
     --output-d=*|--output-di=*|--output-dir=*|--output-dire=*|\
@@ -179,9 +179,12 @@ Date: '"$ad"
 
 	test "$signoff" = "t" && {
 		offsigner=`git-var GIT_COMMITTER_IDENT | sed -e 's/>.*/>/'`
-		echo
-		echo "Signed-off-by: $offsigner"
-		echo
+		line="Signed-off-by: $offsigner"
+		grep -q "^$line\$" $commsg || {
+			echo
+			echo "$line"
+			echo
+		}
 	}
 
 	echo '---'

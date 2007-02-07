From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: [PATCH] add -C[NUM] to git-am
Date: Wed, 7 Feb 2007 22:15:11 +0200
Message-ID: <20070207201511.GF12140@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:14:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtBn-0002Do-4B
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbXBGUOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030659AbXBGUOn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:14:43 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:51881 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030657AbXBGUOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:14:43 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 2333ac54.1716288432.7074.00-047.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 07 Feb 2007 13:14:42 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Feb 2007 22:16:49 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  7 Feb 2007 22:12:31 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Feb 2007 20:16:49.0426 (UTC) FILETIME=[E5FB0F20:01C74AF4]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14984.001
X-TM-AS-Result: No--10.555400-4.000000-31
X-Spam: [F=0.2053272300; S=0.205(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38959>


Add -C[NUM] to git-am so that patches can be applied even
if context has changed a bit.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

I just had to apply a largish number of patches on a project
that has evolved since, and I found the following to be useful.

What do others think.

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index aa4ce1d..f7d551e 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -64,6 +64,10 @@ default.   You could use `--no-utf8` to override this.
 	This flag is passed to the `git-apply` program that applies
 	the patch.
 
+-C<n>::
+	This flag is passed to the `git-apply` program that applies
+	the patch.
+
 --interactive::
 	Run interactively, just like git-applymbox.
 
diff --git a/git-am.sh b/git-am.sh
index 1252f26..9a61234 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005, 2006 Junio C Hamano
 
 USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
-  [--interactive] [--whitespace=<option>] <mbox>...
+  [--interactive] [--whitespace=<option>] [-CNUM] <mbox>...
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 set_reflog_action am
@@ -106,7 +106,8 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= ws= resolvemsg=
+dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= resolvemsg=
+git_apply_opt=
 
 while case "$#" in 0) break;; esac
 do
@@ -142,7 +143,10 @@ do
 	skip=t; shift ;;
 
 	--whitespace=*)
-	ws=$1; shift ;;
+	git_apply_opt="$git_apply_opt $1"; shift ;;
+
+	-C*)
+	git_apply_opt="$git_apply_opt $1"; shift ;;
 
 	--resolvemsg=*)
 	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
@@ -394,7 +398,7 @@ do
 
 	case "$resolved" in
 	'')
-		git-apply $binary --index $ws "$dotest/patch"
+		git-apply $git_apply_opt $binary --index "$dotest/patch"
 		apply_status=$?
 		;;
 	t)

-- 
MST

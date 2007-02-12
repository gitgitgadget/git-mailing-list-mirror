From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: Merge git-gui into 1.5.0 ?
Date: Mon, 12 Feb 2007 08:25:29 +0200
Message-ID: <20070212062529.GE28231@mellanox.co.il>
References: <7vvei89b9k.fsf@assigned-by-dhcp.cox.net> <20070212055903.GD28231@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUcZ-000555-KL
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933010AbXBLGY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933029AbXBLGY7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:24:59 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:33019 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbXBLGY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:24:58 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id a3800d54.1830480816.47722.00-001.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 11 Feb 2007 23:24:58 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 12 Feb 2007 08:27:12 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 12 Feb 2007 08:22:58 +0200
Content-Disposition: inline
In-Reply-To: <20070212055903.GD28231@mellanox.co.il>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 Feb 2007 06:27:12.0205 (UTC) FILETIME=[D482A7D0:01C74E6E]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14988.001
X-TM-AS-Result: No--15.154300-4.000000-2
X-Spam: [F=0.1295462456; S=0.129(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39376>

> Quoting Michael S. Tsirkin <mst@mellanox.co.il>:
> Subject: Re: Merge git-gui into 1.5.0 ?
> 
> > Quoting Junio C Hamano <junkio@cox.net>:
> > Subject: Re: Merge git-gui into 1.5.0 ?
> > 
> > "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> > 
> > > Actually, -p<n> option to git-am is also useful for piping
> > > patches to git-am directly from mail: sometimes people would generate
> > > a patch by hand and this results in patches incorrect -p level.
> > 
> > You also would need negative -p option to deal with it as well.
> > Think of getting "diff a/git-add.txt b/git-add.txt" and wanting
> > to apply it to Documentation/git-add.txt.
> 
> Heh, right. With patch I just switch to another shell, cd to the correct
> directory, start mutt *there* and pipe the message to patch.  Since this already
> seems to work for git-apply, maybe this can be made to work with git-am as well?
> 
> Currently:
> $git-am mbox
> fatal: Not a git repository: '.git'
> You need to run this command from the toplevel of the working tree.

Junio, the following seems to work for me. Is this correct?
If yes, adding -p is trivial.

Make git-am support "negative strip-level" patches by running it
in a subdirectory.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

diff --git a/git-am.sh b/git-am.sh
index 9a61234..4cea1d2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -5,6 +5,8 @@
 USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
   [--interactive] [--whitespace=<option>] [-CNUM] <mbox>...
   or, when resuming [--skip | --resolved]'
+where=$PWD
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 set_reflog_action am
 require_work_tree
@@ -60,7 +62,7 @@ fall_back_3way () {
     mkdir "$dotest/patch-merge-tmp-dir"
 
     # First see if the patch records the index info that we can use.
-    git-apply -z --index-info "$dotest/patch" \
+    (cd $where && git-apply -z --index-info "$dotest/patch") \
 	>"$dotest/patch-merge-index-info" &&
     GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
     git-update-index -z --index-info <"$dotest/patch-merge-index-info" &&
@@ -69,8 +71,8 @@ fall_back_3way () {
     cannot_fallback "Patch does not record usable index information."
 
     echo Using index info to reconstruct a base tree...
-    if GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
-	git-apply $binary --cached <"$dotest/patch"
+    if (cd $where && GIT_INDEX_FILE="$dotest/patch-merge-tmp-index" \
+	git-apply $binary --cached <"$dotest/patch")
     then
 	mv "$dotest/patch-merge-base+" "$dotest/patch-merge-base"
 	mv "$dotest/patch-merge-tmp-index" "$dotest/patch-merge-index"
@@ -398,7 +400,7 @@ do
 
 	case "$resolved" in
 	'')
-		git-apply $git_apply_opt $binary --index "$dotest/patch"
+		(cd $where && git-apply $git_apply_opt $binary --index "$dotest/patch")
 		apply_status=$?
 		;;
 	t)
-- 
MST

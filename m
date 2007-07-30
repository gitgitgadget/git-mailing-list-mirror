From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH] guilt-header: Add -e option for editing
Date: Mon, 30 Jul 2007 07:34:28 -0700
Message-ID: <87r6mqarkb.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Josef Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 16:34:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFWKc-0004bs-Ca
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 16:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbXG3Oen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 10:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbXG3Oen
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 10:34:43 -0400
Received: from smtp-9.smtp.ucla.edu ([169.232.48.138]:54658 "EHLO
	smtp-9.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbXG3Oem (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 10:34:42 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-9.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6UEYZXn015520;
	Mon, 30 Jul 2007 07:34:35 -0700
Received: from localhost (adsl-75-26-179-197.dsl.scrm01.sbcglobal.net [75.26.179.197])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6UEYY4N003149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 07:34:35 -0700
Received: by localhost (Postfix, from userid 1000)
	id 6DD671E80A8; Mon, 30 Jul 2007 07:34:28 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.48.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54233>

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 Documentation/guilt-header.txt |    6 ++++--
 guilt                          |    9 +++++++++
 guilt-header                   |   20 +++++++++++++++++---
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/guilt-header.txt b/Documentation/guilt-header.txt
index ed9ab34..d432959 100644
--- a/Documentation/guilt-header.txt
+++ b/Documentation/guilt-header.txt
@@ -11,10 +11,12 @@ include::usage-guilt-header.txt[]
 
 DESCRIPTION
 -----------
-Prints either the topmost patches' header or the header of a specified patch.
+Prints either the topmost patch's header or the header of a specified patch.
 
+-e::
+        Open the header in an editor, instead of printing it.
 <patchname>::
-	Name of the patch. 
+	Name of the patch.
 
 Author
 ------
diff --git a/guilt b/guilt
index f67bfb5..7f2b93c 100755
--- a/guilt
+++ b/guilt
@@ -209,6 +209,15 @@ do_make_header()
 	'
 }
 
+# usage: do_get_patch patchfile
+do_get_patch()
+{
+	cat "$1" | awk '
+BEGIN{}
+/^(diff|---)/,/END{}/
+'
+}
+
 # usage: do_get_header patchfile
 do_get_header()
 {
diff --git a/guilt-header b/guilt-header
index d07e2be..496cb5b 100755
--- a/guilt-header
+++ b/guilt-header
@@ -3,13 +3,18 @@
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
-USAGE="[<patchname>]"
+USAGE="[-e] [<patchname>]"
 . `dirname $0`/guilt
 
-if [ $# -gt 1 ]; then
+if [ $# -gt 2 ]; then
 	usage
 fi
 
+if [ "$1" = "-e" ]; then
+	edit=t
+	shift
+fi
+
 patch="$1"
 
 if [ -z "$patch" ]; then
@@ -34,6 +39,15 @@ for p in `get_series`; do
 	[ $idx -lt $eidx ] && continue
 	[ $idx -gt $eidx ] && break
 
-	do_get_header $GUILT_DIR/$branch/$p
+	if [ -z "$edit" ]; then
+		do_get_header $GUILT_DIR/$branch/$p
+	else
+		do_get_full_header $GUILT_DIR/$branch/$p > /tmp/guilt.msg.$$
+		do_get_patch  $GUILT_DIR/$branch/$p > /tmp/guilt.diff.$$
+		$editor "/tmp/guilt.msg.$$"
+		mv $GUILT_DIR/$branch/$p $GUILT_DIR/$branch/$p~
+		cat /tmp/guilt.msg.$$ > $GUILT_DIR/$branch/$p
+		cat /tmp/guilt.diff.$$ >> $GUILT_DIR/$branch/$p
+	fi
 done
 
-- 
1.5.2

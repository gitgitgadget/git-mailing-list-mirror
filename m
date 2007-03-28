From: Eric Lesh <eclesh@ucla.edu>
Subject: [PATCH guilt] guilt-fork: Use first argument (if given) as name of
	new patch
Date: Tue, 27 Mar 2007 20:46:16 -0700
Message-ID: <1175053576.5945.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Wed Mar 28 05:46:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWP7E-00043x-1J
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 05:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbXC1DqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 23:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXC1DqY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 23:46:24 -0400
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:45805 "EHLO
	smtp-5.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbXC1DqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 23:46:24 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-5.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l2S3kHjF026222;
	Tue, 27 Mar 2007 20:46:17 -0700
Received: from [192.168.1.7] (adsl-75-26-189-151.dsl.scrm01.sbcglobal.net [75.26.189.151])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l2S3kG0E014349
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Tue, 27 Mar 2007 20:46:16 -0700
X-Mailer: Evolution 2.8.1 
X-Probable-Spam: no
X-Scanned-By: smtp.ucla.edu on 169.232.47.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43350>

From: Eric Lesh <eclesh@ucla.edu>
Date: Tue, 27 Mar 2007 20:28:34 -0700
Subject: [PATCH] guilt-fork: Use first argument (if given) as name of new patch

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt-fork |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/guilt-fork b/guilt-fork
index ae31739..426a7e7 100755
--- a/guilt-fork
+++ b/guilt-fork
@@ -3,9 +3,10 @@
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
 
+USAGE="[<new_name>]"
 . guilt
 
-if [ $# -gt 0 ]; then
+if [ $# -gt 1 ]; then
 	usage
 fi
 
@@ -20,11 +21,19 @@ if ! must_commit_first; then
 fi
 
 # Rename patches smartly
-base=$(echo "$patch" \
-	| sed -r -e 's:(\.diff?|\.patch)$::')
-num=$(echo "$base" | sed -nre 's:.*-([0-9]+)$:\1:'p)
-[ -n "$num" ] || num=1
-newpatch="${base%-$num}-$((num+1))${patch#$base}"
+if [ $# -eq 1 ]; then
+	newpatch="$1"
+else
+	base=$(echo "$patch" \
+		| sed -r -e 's:(\.diff?|\.patch)$::')
+	num=$(echo "$base" | sed -nre 's:.*-([0-9]+)$:\1:'p)
+	[ -n "$num" ] || num=1
+	newpatch="${base%-$num}-$((num+1))${patch#$base}"
+fi
+
+if [ -e "$GUILT_DIR/$branch/$newpatch" ]; then
+	die "Patch \"$newpatch\" already exists. Choose another name."
+fi
 
 # copy the patch
 cp "$GUILT_DIR/$branch/$patch" "$GUILT_DIR/$branch/$newpatch"
-- 
1.5.1-rc1.GIT

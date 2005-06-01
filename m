From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Unused pos[] in apply.c
Date: Wed, 01 Jun 2005 00:20:06 -0400
Message-ID: <1117599606.13776.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 01 06:18:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdKfd-0001xn-Np
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 06:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVFAEUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 00:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVFAEUQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 00:20:16 -0400
Received: from h-64-105-159-118.phlapafg.covad.net ([64.105.159.118]:24770
	"EHLO dv.roinet.com") by vger.kernel.org with ESMTP id S261247AbVFAEUH
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 00:20:07 -0400
Received: from dv.roinet.com (localhost.localdomain [127.0.0.1])
	by dv.roinet.com (8.13.4/8.13.4) with ESMTP id j514K6qu003323
	for <git@vger.kernel.org>; Wed, 1 Jun 2005 00:20:06 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j514K6FA003320
	for git@vger.kernel.org; Wed, 1 Jun 2005 00:20:06 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

gcc 4.0 complains about current cogito (and current git from Linus):

apply.c: In function 'apply_patch':
apply.c:622: warning: 'pos[0]' is used uninitialized in this function
apply.c:624: warning: 'pos[1]' is used uninitialized in this function

Indeed, pos[] is never initialized and never used again.

My understanding of the code is that it's trying to figure out whether
the patch is adding or removing a file.  If the first line for the chunk
or the line count for the old file is not 0, the old file existed, so
the patch is not adding the file.  Conversely, non-zero position or line
count for the new file means we are not deleting it.

Following patch makes the code do what it was meant to do.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -611,7 +611,7 @@ static int parse_fragment(char *line, un
 {
 	int added, deleted;
 	int len = linelen(line, size), offset;
-	unsigned long pos[4], oldlines, newlines;
+	unsigned long oldlines, newlines;
 
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
@@ -619,9 +619,9 @@ static int parse_fragment(char *line, un
 	oldlines = fragment->oldlines;
 	newlines = fragment->newlines;
 
-	if (patch->is_new < 0 && (pos[0] || oldlines))
+	if (patch->is_new < 0 && (fragment->oldpos || oldlines))
 		patch->is_new = 0;
-	if (patch->is_delete < 0 && (pos[1] || newlines))
+	if (patch->is_delete < 0 && (fragment->newpos || newlines))
 		patch->is_delete = 0;
 
 	/* Parse the thing.. */


-- 
Regards,
Pavel Roskin


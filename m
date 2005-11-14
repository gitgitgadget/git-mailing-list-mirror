From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] cogito tutorial-script - more testsuite improvements
Date: Mon, 14 Nov 2005 18:14:45 -0500
Message-ID: <1132010085.24084.32.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 15 00:17:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbnXH-0005h6-2z
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbVKNXOs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVKNXOs
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:14:48 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:62629 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751293AbVKNXOr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:14:47 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EbnXC-0001xJ-N3
	for git@vger.kernel.org; Mon, 14 Nov 2005 18:14:46 -0500
Received: from proski by dv.roinet.com with local (Exim 4.54)
	id 1EbnXB-0001U8-CS; Mon, 14 Nov 2005 18:14:45 -0500
To: git <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11864>

Report line in should_fail().  Require bash, since reporting calling
line is bash specific.  Set "-e" flag in the script, so that e.g.
"bash -x script.sh" cannot cancel it accidentally.  Trap and report
unexpected errors.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/Documentation/tutorial-script/script.sh b/Documentation/tutorial-script/script.sh
index 8cdfe36..bc70b77 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -1,4 +1,4 @@
-#!/bin/sh -e
+#!/bin/bash
 #
 # FIXME: This script has many GITisms. Some of them are unnecessary, while
 # some stem from missing Cogito features (especially no support for pushing
@@ -10,10 +10,16 @@
 # for executing this script to make sure we did not break it with any
 # Cogito changes.
 should_fail () {
-	echo "Expected failure, got success - aborting" >&2
+	echo "Expected failure, got success on line ${BASH_LINENO[0]}" \
+	     "- aborting" >&2
+	trap - exit
 	exit 1
 }
 
+# Conversely, if something fails when it shouldn't, report it and exit.
+set -e
+trap 'echo >&2 "Unexpected error $? on line $LINENO"; exit 1' exit
+
 
 ### Set up playground
 sh 0000-playground.sh
@@ -309,4 +315,5 @@ cg-add stack.h
 cg-commit -m "Merge with 0.4"
 
 # Great, we are done.
+trap - exit
 echo "Script completed successfully!"



-- 
Regards,
Pavel Roskin

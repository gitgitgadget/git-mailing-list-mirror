From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] t9600-cvsimport.sh: set HOME before checking for cvsps
	availability
Date: Wed, 26 Mar 2008 17:34:20 +0000
Message-ID: <20080326173420.16383.qmail@4b0e1e5c705f62.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 18:35:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeZWQ-0008Vd-2U
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 18:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012AbYCZReD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 13:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754751AbYCZReD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 13:34:03 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:58876 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753914AbYCZReC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 13:34:02 -0400
Received: (qmail 16385 invoked by uid 1000); 26 Mar 2008 17:34:20 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78292>

From: Frank Lichtenheld <djpig@debian.org>

This actually sounds like a bug in cvsps, which requires an existing
home directory when asked for the usage through -h

 $ HOME=/nonexistent cvsps -h
 Cannot create the cvsps directory '.cvsps': No such file or directory

This made t9600 think that cvsps is not available if HOME did not exist,
causing the tests to be skipped

 $ HOME=/nonexistent sh t9600-cvsimport.sh
 * skipping cvsimport tests, cvsps not found
 * passed all 0 test(s)

Now t9600 sets HOME to the current working directory before checking for
the availability of the cvsps program.

This issue has been discovered by Marco Rodrigues, and fixed by Frank
Lichtenheld through
 http://bugs.debian.org/471969

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 t/t9600-cvsimport.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t9600-cvsimport.sh b/t/t9600-cvsimport.sh
index 7706430..00a74ee 100755
--- a/t/t9600-cvsimport.sh
+++ b/t/t9600-cvsimport.sh
@@ -3,6 +3,12 @@
 test_description='git-cvsimport basic tests'
 . ./test-lib.sh
 
+CVSROOT=$(pwd)/cvsroot
+export CVSROOT
+# for clean cvsps cache
+HOME=$(pwd)
+export HOME
+
 if ! type cvs >/dev/null 2>&1
 then
 	say 'skipping cvsimport tests, cvs not found'
@@ -26,12 +32,6 @@ case "$cvsps_version" in
 	;;
 esac
 
-CVSROOT=$(pwd)/cvsroot
-export CVSROOT
-# for clean cvsps cache
-HOME=$(pwd)
-export HOME
-
 test_expect_success 'setup cvsroot' 'cvs init'
 
 test_expect_success 'setup a cvs module' '
-- 
1.5.4.4

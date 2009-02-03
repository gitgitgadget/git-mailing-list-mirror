From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/8] valgrind: ignore ldso and more libz errors
Date: Wed, 4 Feb 2009 00:26:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040024490.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfv-0007K0-M1
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbZBCXZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZBCXZd
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:32910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752175AbZBCXZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:31 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp027) with SMTP; 04 Feb 2009 00:25:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Iiap10cQI3eE0JZhBkdRypNsnRHSYXsGAmBsPmN
	/CfSBT0WRxgd0T
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108270>

From: Jeff King <peff@peff.net>

On some Linux systems, we get a host of Cond and Addr errors
from calls to dlopen that are caused by nss modules. We
should be able to safely ignore anything happening in
ld-*.so as "not our problem."

[Johannes: I added some more... unfortunately using valgrind 3.4.0 syntax]

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/valgrind/default.supp |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/t/valgrind/default.supp b/t/valgrind/default.supp
index 2482b3b..5f341b8 100644
--- a/t/valgrind/default.supp
+++ b/t/valgrind/default.supp
@@ -5,17 +5,39 @@
 }
 
 {
+	ignore-zlib-errors-value8
+	Memcheck:Value8
+	obj:*libz.so*
+}
+
+{
 	ignore-zlib-errors-value4
 	Memcheck:Value4
 	obj:*libz.so*
 }
 
 {
-	writing-data-from-zlib-triggers-errors
+	ignore-ldso-cond
+	Memcheck:Cond
+	obj:*ld-*.so
+}
+
+{
+	ignore-ldso-addr8
+	Memcheck:Addr8
+	obj:*ld-*.so
+}
+
+{
+	ignore-ldso-addr4
+	Memcheck:Addr4
+	obj:*ld-*.so
+}
+
+{
+	writing-data-from-zlib-triggers-even-more-errors
 	Memcheck:Param
 	write(buf)
-	obj:/lib/ld-*.so
-	fun:write_in_full
-	fun:write_buffer
+	...
 	fun:write_loose_object
 }
-- 
1.6.1.2.582.g3fdd5

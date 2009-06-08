From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 10/11 v2] Fix warnings in nedmalloc when compiling with GCC
 4.4.0
Date: Mon, 8 Jun 2009 16:46:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de>
 <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de>
 <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302>
 <7viqjefxcv.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> <7vprdl9qon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:47:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDg7o-0001Pt-Q4
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 16:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbZFHOqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 10:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbZFHOqu
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 10:46:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:54821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753169AbZFHOqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 10:46:49 -0400
Received: (qmail invoked by alias); 08 Jun 2009 14:46:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp045) with SMTP; 08 Jun 2009 16:46:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Sy4RegfOS/9yB0KqS88Bijtg37WqwUnyvoBwc7t
	HgxOYMuSBjFZId
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vprdl9qon.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121078>


Nedmalloc's source code has a cute #define construct to avoid inserting
an if() statement, because that might interact badly with enclosing if()
statements.  However, GCC > 4 complains with a "warning: value computed
is not used".  So we cast the result to "void".

GCC also does not understand the Visual C++ specific pragmas, so we need
to disable them for MinGW.

We need to include malloc.h on Windows even if we happen to compile the
stuff as a MinGW program.  Otherwise the function declaration of alloca()
is missing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Forgot to send.

 compat/nedmalloc/malloc.c.h  |    4 +++-
 compat/nedmalloc/nedmalloc.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index bb0f482..b5b1495 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1270,7 +1270,9 @@ int mspace_mallopt(int, int);
 /*------------------------------ internal #includes ---------------------- */
 
 #ifdef WIN32
+#ifndef __GNUC__
 #pragma warning( disable : 4146 ) /* no "unsigned" warnings */
+#endif
 #endif /* WIN32 */
 
 #include <stdio.h>       /* for printing in malloc_stats */
@@ -2541,7 +2543,7 @@ struct malloc_params {
 static struct malloc_params mparams;
 
 /* Ensure mparams initialized */
-#define ensure_initialization() (mparams.magic != 0 || init_mparams())
+#define ensure_initialization() ((void)(mparams.magic == 0 || init_mparams()))
 
 #if !ONLY_MSPACES
 
diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 41a3234..d9a17a8 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -34,7 +34,7 @@ DEALINGS IN THE SOFTWARE.
 /*#define FULLSANITYCHECKS*/
 
 #include "nedmalloc.h"
-#if defined(WIN32) && !defined(__MINGW32__)
+#if defined(WIN32)
  #include <malloc.h>
 #endif
 #define MSPACES 1
-- 
1.6.3.284.g6fecc

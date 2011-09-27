From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 2/2] Make misuse of get_pathname() buffers detectable by valgrind
Date: Tue, 27 Sep 2011 06:28:07 +0200
Message-ID: <1317097687-11098-3-git-send-email-mhagger@alum.mit.edu>
References: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8PIH-0006ML-4C
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 06:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503Ab1I0E3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 00:29:11 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58801 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1I0E3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 00:29:07 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB231.dip.t-dialin.net [84.190.178.49])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8R4SE3S023431;
	Tue, 27 Sep 2011 06:28:20 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1317097687-11098-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182211>

A temporary buffer produced by get_pathname() is recycled after a few
subsequent calls of get_pathname().  The use of such a buffer after it
has been recycled can result in the wrong file being accessed with
very strange effects.  Moreover, such a bug can lie dormant until code
elsewhere is changed to use a temporary buffer, causing very
mysterious, nonlocal failures that are hard to analyze.

Add a second implementation of get_pathname() (activated if the
VALGRIND preprocessor macro is defined) that allocates and frees
buffers instead of recycling statically-allocated buffers.  This does
not make the problem less serious, but it turns the errors into
access-after-free errors, making it possible to locate the guilty code
using valgrind.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I believe that it is frowned upon to use #ifdefs in git code, but no
good alternative is obvious to me for this type of use.  Suggestions
are welcome.

I would also welcome suggestions for a better name than "VALGRIND" for
the preprocessor macro.  Are there standard names used elsewhere in
git for such purposes?

 path.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git path.c path.c
index 6c4714d..3021207 100644
--- path.c
+++ path.c
@@ -9,6 +9,20 @@
  *   f = open(mkpath("%s/%s.git", base, name), O_RDONLY);
  *
  * which is what it's designed for.
+ *
+ * The temporary buffers returned by these functions will be clobbered
+ * by later calls to these functions.  Therefore it is important not
+ * to expect such buffers to keep their values across calls to other
+ * git functions.  Violations of this rule can cause the original
+ * buffer to be overwritten and lead to very confusing, nonlocal bugs,
+ * including data loss (you think you are writing to your file but are
+ * actually writing to a filename created by some other caller).
+ *
+ * If the VALGRIND preprocessor macro is defined, then buffers are
+ * created via xmalloc and old temporary buffers are recycled using
+ * free().  This changes the symptom of abuse of the buffers from
+ * mysterious, random errors into access-after-free errors that are
+ * detectable by valgrind.
  */
 #include "cache.h"
 #include "strbuf.h"
@@ -17,12 +31,34 @@
 #define PATHNAME_BUFFER_COUNT (1 << 2)
 
 static char bad_path[] = "/bad-path/";
+#ifdef VALGRIND
+static char buggy_path[] = "/git-internal-error/";
+#endif
 
 static char *get_pathname(void)
 {
-	static char pathname_array[PATHNAME_BUFFER_COUNT][PATH_MAX];
 	static int index;
-	return pathname_array[(PATHNAME_BUFFER_COUNT - 1) & ++index];
+#ifdef VALGRIND
+	static char *pathname_array[PATHNAME_BUFFER_COUNT];
+	index = (index + 1) & (PATHNAME_BUFFER_COUNT - 1);
+	if (pathname_array[index]) {
+		/*
+		 * In a correct program, this will have no effect, but
+		 * *if* somebody erroneously uses this buffer after it
+		 * has been freed, it gives more of a chance that the
+		 * error will be detected even if valgrind is not
+		 * running:
+		 */
+		strcpy(pathname_array[index], buggy_path);
+
+		free(pathname_array[index]);
+	}
+	pathname_array[index] = xmalloc(PATH_MAX);
+	return pathname_array[index];
+#else
+	static char pathname_array[PATHNAME_BUFFER_COUNT][PATH_MAX];
+ 	return pathname_array[(PATHNAME_BUFFER_COUNT - 1) & ++index];
+#endif
 }
 
 static char *cleanup_path(char *path)
-- 
1.7.7.rc2

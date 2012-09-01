From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] argv-array: add pop function
Date: Sat, 1 Sep 2012 07:25:27 -0400
Message-ID: <20120901112527.GA19163@sigill.intra.peff.net>
References: <20120901112251.GA11445@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <ossi@kde.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 13:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7lpY-0004gF-UF
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 13:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430Ab2IALZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Sep 2012 07:25:30 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50816 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926Ab2IALZa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2012 07:25:30 -0400
Received: (qmail 27080 invoked by uid 107); 1 Sep 2012 11:25:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Sep 2012 07:25:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Sep 2012 07:25:27 -0400
Content-Disposition: inline
In-Reply-To: <20120901112251.GA11445@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204625>

Sometimes we build a set of similar command lines, differing
only in the final arguments (e.g., "fetch --multiple"). To
use argv_array for this, you have to either push the same
set of elements repeatedly, or break the abstraction by
manually manipulating the array's internal members.

Instead, let's provide a sanctioned "pop" function to remove
elements from the end.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-argv-array.txt | 4 ++++
 argv-array.c                               | 9 +++++++++
 argv-array.h                               | 1 +
 3 files changed, 14 insertions(+)

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
index 1b7d8f1..1a79781 100644
--- a/Documentation/technical/api-argv-array.txt
+++ b/Documentation/technical/api-argv-array.txt
@@ -46,6 +46,10 @@ Functions
 	Format a string and push it onto the end of the array. This is a
 	convenience wrapper combining `strbuf_addf` and `argv_array_push`.
 
+`argv_array_pop`::
+	Remove the final element from the array. If there are no
+	elements in the array, do nothing.
+
 `argv_array_clear`::
 	Free all memory associated with the array and return it to the
 	initial, empty state.
diff --git a/argv-array.c b/argv-array.c
index 0b5f889..55e8443 100644
--- a/argv-array.c
+++ b/argv-array.c
@@ -49,6 +49,15 @@ void argv_array_pushl(struct argv_array *array, ...)
 	va_end(ap);
 }
 
+void argv_array_pop(struct argv_array *array)
+{
+	if (!array->argc)
+		return;
+	free((char *)array->argv[array->argc - 1]);
+	array->argv[array->argc - 1] = NULL;
+	array->argc--;
+}
+
 void argv_array_clear(struct argv_array *array)
 {
 	if (array->argv != empty_argv) {
diff --git a/argv-array.h b/argv-array.h
index b93a69c..f4b9866 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -16,6 +16,7 @@ void argv_array_pushl(struct argv_array *, ...);
 __attribute__((format (printf,2,3)))
 void argv_array_pushf(struct argv_array *, const char *fmt, ...);
 void argv_array_pushl(struct argv_array *, ...);
+void argv_array_pop(struct argv_array *);
 void argv_array_clear(struct argv_array *);
 
 #endif /* ARGV_ARRAY_H */
-- 
1.7.12.rc3.8.g89db099

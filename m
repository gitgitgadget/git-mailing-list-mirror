From: "Cedric Vivier" <cedricv@neonux.com>
Subject: [PATCH] use natural ordering to display list of branches.
Date: Thu, 5 Jun 2008 19:41:17 +0200
Message-ID: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 19:42:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4JTd-0002TE-HU
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 19:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYFERlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 13:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbYFERlU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 13:41:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:49629 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbYFERlT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 13:41:19 -0400
Received: by wa-out-1112.google.com with SMTP id j37so464416waf.23
        for <git@vger.kernel.org>; Thu, 05 Jun 2008 10:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=nIEGr/lRwhQEbQA6I0ifg91/riMLPNwygSrYKZ/XGsg=;
        b=oe136LH7bq9+1g8yFzu2hYt6G6RfdxPUaoMjEu67gkLmAldWEUjmx2bsiwvSaNbfHC
         OxB+28U0F914KAjN9m1eSuXbua9EsqG1zO/XjgRuQ9oGKNwbCS62wGa8ZSesX9L4Ww40
         dvu9G0Jc02WIaQZIRhRviPJWJRRzAK+dXsNDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=wZ6CaYlDb1DMGjwuEfFmOPnH850sLfKqu7LwYfcB/ovA12pKPnqRzsSy4oZ6xRAiQj
         WSBuI9zorPEgrz+T3xp3jGhCampQj5BxTyBrWYNkh0i7AnFiBikeql8KAdnjglFrguBZ
         zuhPTQmWae6F5Nk1xEWHoEuiI6B/+qxtS6Ugk=
Received: by 10.114.120.1 with SMTP id s1mr1944878wac.31.1212687677998;
        Thu, 05 Jun 2008 10:41:17 -0700 (PDT)
Received: by 10.115.33.3 with HTTP; Thu, 5 Jun 2008 10:41:17 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 18f22e71ba50fe46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83945>

Hi everyone,

This small patch makes git display list of branches in natural order.
This way, when you name your branches against, for instance, a bug number from
some bug-tracking tool, the list will show up in a natural/human/logical order.

Current behavior for "git branch":
BUG-1040-doing-bar-is-too-slow
BUG-84-calling-Z-with-null-segfaults
BUG-900-program-freezes-when-user-click-on-button
experimental-feature-X
master

With the patch:
BUG-84-calling-Z-with-null-segfaults
BUG-900-program-freezes-when-user-click-on-button
BUG-1040-doing-bar-takes-too-much-time
experimental-feature-X
master


Signed-off-by: Cedric Vivier <cedricv@neonux.com>
---
 Makefile         |    3 +
 builtin-branch.c |    3 +-
 strnatcmp.c      |  179 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 strnatcmp.h      |   32 ++++++++++
 4 files changed, 216 insertions(+), 1 deletions(-)
 create mode 100644 strnatcmp.c
 create mode 100644 strnatcmp.h

diff --git a/Makefile b/Makefile
index cce5a6e..469b312 100644
--- a/Makefile
+++ b/Makefile
@@ -376,6 +376,7 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += utf8.h
 LIB_H += wt-status.h
+LIB_H += strnatcmp.h

 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
@@ -471,6 +472,7 @@ LIB_OBJS += write_or_die.o
 LIB_OBJS += ws.o
 LIB_OBJS += wt-status.o
 LIB_OBJS += xdiff-interface.o
+LIB_OBJS += strnatcmp.o

 BUILTIN_OBJS += builtin-add.o
 BUILTIN_OBJS += builtin-annotate.o
@@ -1141,6 +1143,7 @@ $(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h
xdiff/xdiff.h xdiff/xtypes.h \
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)

+strnatcmp.o: strnatcmp.c

 doc:
 	$(MAKE) -C Documentation all
diff --git a/builtin-branch.c b/builtin-branch.c
index d279702..c9c6788 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -13,6 +13,7 @@
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
+#include "strnatcmp.h"

 static const char * const builtin_branch_usage[] = {
 	"git-branch [options] [-r | -a] [--merged | --no-merged]",
@@ -279,7 +280,7 @@ static int ref_cmp(const void *r1, const void *r2)

 	if (c1->kind != c2->kind)
 		return c1->kind - c2->kind;
-	return strcmp(c1->name, c2->name);
+	return strnatcmp(c1->name, c2->name);
 }

 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
diff --git a/strnatcmp.c b/strnatcmp.c
new file mode 100644
index 0000000..46bae0f
--- /dev/null
+++ b/strnatcmp.c
@@ -0,0 +1,179 @@
+/* -*- mode: c; c-file-style: "k&r" -*-
+
+  strnatcmp.c -- Perform 'natural order' comparisons of strings in C.
+  Copyright (C) 2000, 2004 by Martin Pool <mbp sourcefrog net>
+
+  This software is provided 'as-is', without any express or implied
+  warranty.  In no event will the authors be held liable for any damages
+  arising from the use of this software.
+
+  Permission is granted to anyone to use this software for any purpose,
+  including commercial applications, and to alter it and redistribute it
+  freely, subject to the following restrictions:
+
+  1. The origin of this software must not be misrepresented; you must not
+     claim that you wrote the original software. If you use this software
+     in a product, an acknowledgment in the product documentation would be
+     appreciated but is not required.
+  2. Altered source versions must be plainly marked as such, and must not be
+     misrepresented as being the original software.
+  3. This notice may not be removed or altered from any source distribution.
+*/
+
+
+/* partial change history:
+ *
+ * 2004-10-10 mbp: Lift out character type dependencies into macros.
+ *
+ * Eric Sosman pointed out that ctype functions take a parameter whose
+ * value must be that of an unsigned int, even on platforms that have
+ * negative chars in their default char type.
+ */
+
+#include <ctype.h>
+#include <string.h>
+#include <assert.h>
+#include <stdio.h>
+
+#include "strnatcmp.h"
+
+
+/* These are defined as macros to make it easier to adapt this code to
+ * different characters types or comparison functions. */
+static inline int
+nat_isdigit(nat_char a)
+{
+     return isdigit((unsigned char) a);
+}
+
+
+static inline int
+nat_isspace(nat_char a)
+{
+     return isspace((unsigned char) a);
+}
+
+
+static inline nat_char
+nat_toupper(nat_char a)
+{
+     return toupper((unsigned char) a);
+}
+
+
+
+static int
+compare_right(nat_char const *a, nat_char const *b)
+{
+     int bias = 0;
+
+     /* The longest run of digits wins.  That aside, the greatest
+	value wins, but we can't know that it will until we've scanned
+	both numbers to know that they have the same magnitude, so we
+	remember it in BIAS. */
+     for (;; a++, b++) {
+	  if (!nat_isdigit(*a)  &&  !nat_isdigit(*b))
+	       return bias;
+	  else if (!nat_isdigit(*a))
+	       return -1;
+	  else if (!nat_isdigit(*b))
+	       return +1;
+	  else if (*a < *b) {
+	       if (!bias)
+		    bias = -1;
+	  } else if (*a > *b) {
+	       if (!bias)
+		    bias = +1;
+	  } else if (!*a  &&  !*b)
+	       return bias;
+     }
+
+     return 0;
+}
+
+
+static int
+compare_left(nat_char const *a, nat_char const *b)
+{
+     /* Compare two left-aligned numbers: the first to have a
+     different value wins. */
+     for (;; a++, b++) {
+	  if (!nat_isdigit(*a)  &&  !nat_isdigit(*b))
+	       return 0;
+	  else if (!nat_isdigit(*a))
+	       return -1;
+	  else if (!nat_isdigit(*b))
+	       return +1;
+	  else if (*a < *b)
+	       return -1;
+	  else if (*a > *b)
+	       return +1;
+     }
+
+     return 0;
+}
+
+
+static int strnatcmp0(nat_char const *a, nat_char const *b, int fold_case)
+{
+     int ai, bi;
+     nat_char ca, cb;
+     int fractional, result;
+
+     assert(a && b);
+     ai = bi = 0;
+     while (1) {
+	  ca = a[ai]; cb = b[bi];
+
+	  /* skip over leading spaces or zeros */
+	  while (nat_isspace(ca))
+	       ca = a[++ai];
+
+	  while (nat_isspace(cb))
+	       cb = b[++bi];
+
+	  /* process run of digits */
+	  if (nat_isdigit(ca)  &&  nat_isdigit(cb)) {
+	       fractional = (ca == '0' || cb == '0');
+
+	       if (fractional) {
+		    if ((result = compare_left(a+ai, b+bi)) != 0)
+			 return result;
+	       } else {
+		    if ((result = compare_right(a+ai, b+bi)) != 0)
+			 return result;
+	       }
+	  }
+
+	  if (!ca && !cb) {
+	       /* The strings compare the same.  Perhaps the caller
+	       will want to call strcmp to break the tie. */
+	       return 0;
+	  }
+
+	  if (fold_case) {
+	       ca = nat_toupper(ca);
+	       cb = nat_toupper(cb);
+	  }
+
+	  if (ca < cb)
+	       return -1;
+	  else if (ca > cb)
+	       return +1;
+
+	  ++ai; ++bi;
+     }
+}
+
+
+
+int strnatcmp(nat_char const *a, nat_char const *b) {
+     return strnatcmp0(a, b, 0);
+}
+
+
+/* Compare, recognizing numeric string and ignoring case. */
+int strnatcasecmp(nat_char const *a, nat_char const *b) {
+     return strnatcmp0(a, b, 1);
+}
+
diff --git a/strnatcmp.h b/strnatcmp.h
new file mode 100644
index 0000000..7b2ca39
--- /dev/null
+++ b/strnatcmp.h
@@ -0,0 +1,32 @@
+/* -*- mode: c; c-file-style: "k&r" -*-
+
+  strnatcmp.c -- Perform 'natural order' comparisons of strings in C.
+  Copyright (C) 2000, 2004 by Martin Pool <mbp sourcefrog net>
+
+  This software is provided 'as-is', without any express or implied
+  warranty.  In no event will the authors be held liable for any damages
+  arising from the use of this software.
+
+  Permission is granted to anyone to use this software for any purpose,
+  including commercial applications, and to alter it and redistribute it
+  freely, subject to the following restrictions:
+
+  1. The origin of this software must not be misrepresented; you must not
+     claim that you wrote the original software. If you use this software
+     in a product, an acknowledgment in the product documentation would be
+     appreciated but is not required.
+  2. Altered source versions must be plainly marked as such, and must not be
+     misrepresented as being the original software.
+  3. This notice may not be removed or altered from any source distribution.
+*/
+
+
+/* CUSTOMIZATION SECTION
+ *
+ * You can change this typedef, but must then also change the inline
+ * functions in strnatcmp.c */
+typedef char nat_char;
+
+int strnatcmp(nat_char const *a, nat_char const *b);
+int strnatcasecmp(nat_char const *a, nat_char const *b);
+
-- 
1.5.6.rc1.12.g7f71.dirty

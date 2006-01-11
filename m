From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH 1/2] Use light stacking for non-option arguments.
Date: Wed, 11 Jan 2006 21:42:36 +0100 (CET)
Message-ID: <20060111204236.187A95BEC0@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:42:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewmnr-0007qA-Br
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWAKUmj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWAKUmj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:42:39 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:48544 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964841AbWAKUmh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 15:42:37 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 43B676BD07
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:42:36 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 187A95BEC0; Wed, 11 Jan 2006 21:42:36 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14516>

This patch adds some simple library code that can help C-programs
in the git suite ignore argument ordering without interfering
with the current argument parsing code too much.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 Makefile |    4 ++--
 stack.c  |   42 ++++++++++++++++++++++++++++++++++++++++++
 stack.h  |    9 +++++++++
 3 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 stack.c
 create mode 100644 stack.h

5ebd4cbfef1a2c369f763eb3a98f079ffb4f6b5d
diff --git a/Makefile b/Makefile
index c9c15b5..ba861fb 100644
--- a/Makefile
+++ b/Makefile
@@ -165,7 +165,7 @@ LIB_FILE=libgit.a
 LIB_H = \
 	blob.h cache.h commit.h count-delta.h csum-file.h delta.h \
 	diff.h epoch.h object.h pack.h pkt-line.h quote.h refs.h \
-	run-command.h strbuf.h tag.h tree.h git-compat-util.h
+	run-command.h stack.h strbuf.h tag.h tree.h git-compat-util.h
 
 DIFF_OBJS = \
 	diff.o diffcore-break.o diffcore-order.o diffcore-pathspec.o \
@@ -176,7 +176,7 @@ LIB_OBJS = \
 	date.o diff-delta.o entry.o ident.o index.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
-	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
+	server-info.o setup.o sha1_file.o sha1_name.o stack.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
 	fetch-clone.o \
 	$(DIFF_OBJS)
diff --git a/stack.c b/stack.c
new file mode 100644
index 0000000..e76a197
--- /dev/null
+++ b/stack.c
@@ -0,0 +1,42 @@
+#include <stdlib.h>
+#include <string.h>
+#include "stack.h"
+#include "git-compat-util.h"
+
+struct stack *stack_push(struct stack *s, const void *ptr)
+{
+	if (!s)
+		s = xcalloc(1, sizeof(struct stack));
+
+	if (s) {
+		s->stack = xrealloc(s->stack, sizeof(void *) * s->ents + 1);
+		s->stack[s->ents++] = (void *)ptr;
+	}
+
+	return s;
+}
+
+/* pull is from top, pop from bottom */
+void *stack_pull(struct stack *s)
+{
+	if (s && s->next < s->ents)
+		return s->stack[s->next++];
+
+	return NULL;
+}
+
+void *stack_pop(struct stack *s)
+{
+	if (s && s->ents)
+		return s->stack[--s->ents];
+
+	return NULL;
+}
+
+void stack_destroy(struct stack *s)
+{
+	if (s && s->stack) {
+		free(s->stack);
+		memset(s, 0, sizeof(struct stack));
+	}
+}
diff --git a/stack.h b/stack.h
new file mode 100644
index 0000000..5682559
--- /dev/null
+++ b/stack.h
@@ -0,0 +1,9 @@
+struct stack {
+	void **stack;
+	unsigned ents, next;
+};
+
+struct stack *stack_push(struct stack *s, const void *ptr);
+void *stack_pull(struct stack *s);
+void *stack_pop(struct stack *s);
+void stack_destroy(struct stack *s);
-- 
1.1.0

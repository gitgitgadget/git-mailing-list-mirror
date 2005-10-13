From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 08:46:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510130838240.15297@g5.osdl.org>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com>
 <7vachd6hdx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 13 17:56:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ5IK-0000IL-N6
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 17:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbVJMPq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 11:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbVJMPq4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 11:46:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751401AbVJMPq4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 11:46:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DFkm4s006055
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 08:46:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DFklB9020788;
	Thu, 13 Oct 2005 08:46:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0510130756550.15297@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10078>



On Thu, 13 Oct 2005, Linus Torvalds wrote:
> 
> I'm almost goign to suggest that we do our own ctype.h, just to get the 
> sane semantics: we want locale-independence, _and_ we want the right 
> signed behaviour. Plus we only use a very small subset of ctype.h anyway 
> (isspace, isalpha, isdigit and isalnum).

Maybe something like this.

No, I'm not 100% sure we need it. But hey, it's probably less complicated 
than trying to de-localize various different targets.

Is there anything else that is locale-dependent that we use in the C 
toolchain?

		Linus

---
diff-tree f6fea67a590196d81bc4c6a6be1a16dd8bf2815d (from d06b689a933f6d2130f8afdf1ac0ddb83eeb59ab)
Author: Linus Torvalds <torvalds@osdl.org>
Date:   Thu Oct 13 08:36:35 2005 -0700

    Add locale-independent (and stupid) ctype.
    
    It's also safe for signed chars.

diff --git a/Makefile b/Makefile
index 5e7d055..31e62d4 100644
--- a/Makefile
+++ b/Makefile
@@ -158,7 +158,8 @@ LIB_OBJS = \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o \
 	quote.o read-cache.o refs.o run-command.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
-	tag.o tree.o usage.o config.o environment.o $(DIFF_OBJS)
+	tag.o tree.o usage.o config.o environment.o ctype.o \
+	$(DIFF_OBJS)
 
 LIBS = $(LIB_FILE)
 LIBS += -lz
diff --git a/apply.c b/apply.c
index 155fbe8..f4d00f2 100644
--- a/apply.c
+++ b/apply.c
@@ -6,7 +6,6 @@
  * This applies patches on top of some (arbitrary) version of the SCM.
  *
  */
-#include <ctype.h>
 #include <fnmatch.h>
 #include "cache.h"
 
diff --git a/cache.h b/cache.h
index 1a7e047..a465952 100644
--- a/cache.h
+++ b/cache.h
@@ -386,4 +386,30 @@ extern int git_config_bool(const char *,
 extern char git_default_email[MAX_GITNAME];
 extern char git_default_name[MAX_GITNAME];
 
+/* Sane ctype - no locale, and works with signed chars */
+#undef isspace
+#undef isdigit
+#undef isalpha
+#undef isalnum
+#undef tolower
+#undef toupper
+extern unsigned char sane_ctype[256];
+#define GIT_SPACE 0x01
+#define GIT_DIGIT 0x02
+#define GIT_ALPHA 0x04
+#define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
+#define isspace(x) sane_istest(x,GIT_SPACE)
+#define isdigit(x) sane_istest(x,GIT_DIGIT)
+#define isalpha(x) sane_istest(x,GIT_ALPHA)
+#define isalnum(x) sane_istest(x,GIT_ALPHA | GIT_DIGIT)
+#define tolower(x) sane_case((unsigned char)(x), 0x20)
+#define toupper(x) sane_case((unsigned char)(x), 0)
+
+static inline int sane_case(int x, int high)
+{
+	if (sane_istest(x, GIT_ALPHA))
+		x = (x & ~0x20) | high;
+	return x;
+}
+
 #endif /* CACHE_H */
diff --git a/commit-tree.c b/commit-tree.c
index 030fb70..ea0fdd4 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -7,7 +7,6 @@
 
 #include <pwd.h>
 #include <time.h>
-#include <ctype.h>
 
 #define BLOCKING (1ul << 14)
 
diff --git a/commit.c b/commit.c
index f735f98..8f40318 100644
--- a/commit.c
+++ b/commit.c
@@ -1,4 +1,3 @@
-#include <ctype.h>
 #include "tag.h"
 #include "commit.h"
 #include "cache.h"
diff --git a/config.c b/config.c
index 9b7c6f2..519fecf 100644
--- a/config.c
+++ b/config.c
@@ -1,4 +1,3 @@
-#include <ctype.h>
 
 #include "cache.h"
 
diff --git a/convert-objects.c b/convert-objects.c
index 9ad0c77..a892013 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -1,6 +1,5 @@
 #define _XOPEN_SOURCE /* glibc2 needs this */
 #include <time.h>
-#include <ctype.h>
 #include "cache.h"
 
 struct entry {
diff --git a/ctype.c b/ctype.c
new file mode 100644
index 0000000..56bdffa
--- /dev/null
+++ b/ctype.c
@@ -0,0 +1,23 @@
+/*
+ * Sane locale-independent, ASCII ctype.
+ *
+ * No surprises, and works with signed and unsigned chars.
+ */
+#include "cache.h"
+
+#define SS GIT_SPACE
+#define AA GIT_ALPHA
+#define DD GIT_DIGIT
+
+unsigned char sane_ctype[256] = {
+	 0,  0,  0,  0,  0,  0,  0,  0,  0, SS, SS,  0,  0, SS,  0,  0,		/* 0-15 */
+	 0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 16-15 */
+	SS,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,		/* 32-15 */
+	DD, DD, DD, DD, DD, DD, DD, DD, DD, DD,  0,  0,  0,  0,  0,  0,		/* 48-15 */
+	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 64-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 80-15 */
+	 0, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,		/* 96-15 */
+	AA, AA, AA, AA, AA, AA, AA, AA, AA, AA, AA,  0,  0,  0,  0,  0,		/* 112-15 */
+	/* Nothing in the 128.. range */
+};
+
diff --git a/date.c b/date.c
index b21cadc..63f5a09 100644
--- a/date.c
+++ b/date.c
@@ -4,7 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#include <ctype.h>
 #include <time.h>
 
 #include "cache.h"
diff --git a/diff-tree.c b/diff-tree.c
index 2203fa5..8517220 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -1,4 +1,3 @@
-#include <ctype.h>
 #include "cache.h"
 #include "diff.h"
 #include "commit.h"
diff --git a/ident.c b/ident.c
index 7a9f567..1bfbc6f 100644
--- a/ident.c
+++ b/ident.c
@@ -9,7 +9,6 @@
 
 #include <pwd.h>
 #include <time.h>
-#include <ctype.h>
 
 static char git_default_date[50];
 
diff --git a/mailsplit.c b/mailsplit.c
index 0f8100d..189f4ed 100644
--- a/mailsplit.c
+++ b/mailsplit.c
@@ -11,7 +11,6 @@
 #include <sys/stat.h>
 #include <string.h>
 #include <stdio.h>
-#include <ctype.h>
 #include <assert.h>
 #include "cache.h"
 
diff --git a/pack-objects.c b/pack-objects.c
index 3d62278..83ac22b 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1,4 +1,3 @@
-#include <ctype.h>
 #include "cache.h"
 #include "object.h"
 #include "delta.h"
diff --git a/patch-id.c b/patch-id.c
index 960e7ce..edbc4aa 100644
--- a/patch-id.c
+++ b/patch-id.c
@@ -1,4 +1,3 @@
-#include <ctype.h>
 #include "cache.h"
 
 static void flush_current_id(int patchlen, unsigned char *id, SHA_CTX *c)
diff --git a/refs.c b/refs.c
index 5a8cbd4..42240d2 100644
--- a/refs.c
+++ b/refs.c
@@ -2,7 +2,6 @@
 #include "cache.h"
 
 #include <errno.h>
-#include <ctype.h>
 
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
diff --git a/update-ref.c b/update-ref.c
index 4a1704c..65dc3d6 100644
--- a/update-ref.c
+++ b/update-ref.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "refs.h"
-#include <ctype.h>
 
 static const char git_update_ref_usage[] = "git-update-ref <refname> <value> [<oldval>]";
 

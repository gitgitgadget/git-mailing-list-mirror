From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] tests: add GETENV_POISON option to simulate unfriendly
 getenv()
Date: Fri, 12 Nov 2010 12:59:49 -0600
Message-ID: <20101112185949.GA18064@burratino>
References: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru>
 <20101111181728.GF16972@burratino>
 <20101112140329.GA29604@tugrik.mns.mnsspb.ru>
 <20101112160332.GB15141@burratino>
 <20101112172028.GA3941@tugrik.mns.mnsspb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Nov 12 20:00:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGyrN-0000Og-NT
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 20:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565Ab0KLTAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 14:00:24 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61543 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520Ab0KLTAW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 14:00:22 -0500
Received: by eye27 with SMTP id 27so2099246eye.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AlXN/uR1Y8TFYDgil9ozk6vkR7AkY3XzRlFjIQifGXk=;
        b=vXTlzU0r5hM2gqFHnjODbiIWpLQ/SFF/0F0RaLTHFaWpMX2OEaNVgfoGP0o4QNeU7D
         qfrjthntfDD/sZDN8L258qP+txt2B3mlUl2lVehJcavL5rW/3dd6nLrGk1Bemzfg/ZKN
         xdUW7Zb9WDvRr7UTipnCUMg8Q1YGTG7qkw1QI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UYEcm5P3LXnP1odyLS5+TW87MS5Gi/Csj51YgmUApza/CVKkCh2TDegoO5ZNH54NP9
         z5bDV56qJaThImqLryTzUXpNY1M/SecMmHEiNZCsYNIoWLtsF3mrbuyleSHfY7s4R+Ti
         uE3N453148p9qNU8w2hl00gTeysGbwzPxTOhs=
Received: by 10.216.244.11 with SMTP id l11mr2313813wer.43.1289588420166;
        Fri, 12 Nov 2010 11:00:20 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id o43sm2342103weq.47.2010.11.12.11.00.18
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 11:00:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101112172028.GA3941@tugrik.mns.mnsspb.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161356>

Kirill Smelkov wrote:
> On Fri, Nov 12, 2010 at 10:03:32AM -0600, Jonathan Nieder wrote:

>> Right, but do we know of any platforms that work that way currently?
>
> I don't. Actually I was really surprised after reading getenv manual
> about that.

Here's an artificial one.  If someone shows up interested in cleaning
the getenv() usage, something like this could make it easier to
maintain the result.

Before then, it provides a chance to see how invasive the changes
would need to be to support such a theoretical unfriendly platform.
The results don't look so good.

> No, I'm not in a hurry - better to fix this properly. Though personally,
> I've already scratched my itch here.

Thanks for reporting.

-- 8< --
Subject: add GETENV_POISON option to simulate unfriendly getenv()

Traditionally, getenv() returns a pointer into the environment structure,
and on typical platforms the pointed-to value remains valid until that
environment variable gets a new value.

On some platforms (e.g., wine), unfortunately, it does not remain valid
even after an unrelated setenv() call.

The standard even allows getenv to return its result in a static buffer
(meaning it would not remain valid after another getenv() call).  So if
we want to be maximally portable, we should always copy the return
value from getenv() before fetching another value from the environment.

This patch adds a GETENV_POISON option to demonstrate how hard that
would be.  When GETENV_POISON is set, getenv is replaced with a wrapper
that clobbers its old return value after each call, in the hope that
broken callers might notice.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile               |    4 ++++
 cache.h                |   20 --------------------
 compat/getenv-poison.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h      |   25 +++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 20 deletions(-)
 create mode 100644 compat/getenv-poison.c

diff --git a/Makefile b/Makefile
index 1f1ce04..e16d10e 100644
--- a/Makefile
+++ b/Makefile
@@ -1443,6 +1443,10 @@ ifdef INTERNAL_QSORT
 	COMPAT_CFLAGS += -DINTERNAL_QSORT
 	COMPAT_OBJS += compat/qsort.o
 endif
+ifdef GETENV_POISON
+	COMPAT_CFLAGS += -DGETENV_POISON
+	COMPAT_OBJS += compat/getenv-poison.o
+endif
 ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
 endif
diff --git a/cache.h b/cache.h
index 33decd9..574dc8f 100644
--- a/cache.h
+++ b/cache.h
@@ -438,26 +438,6 @@ extern void verify_non_filename(const char *prefix, const char *name);
 
 extern int init_db(const char *template_dir, unsigned int flags);
 
-#define alloc_nr(x) (((x)+16)*3/2)
-
-/*
- * Realloc the buffer pointed at by variable 'x' so that it can hold
- * at least 'nr' entries; the number of entries currently allocated
- * is 'alloc', using the standard growing factor alloc_nr() macro.
- *
- * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
- */
-#define ALLOC_GROW(x, nr, alloc) \
-	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc = (nr); \
-			else \
-				alloc = alloc_nr(alloc); \
-			x = xrealloc((x), alloc * sizeof(*(x))); \
-		} \
-	} while (0)
-
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
 extern int read_index_preload(struct index_state *, const char **pathspec);
diff --git a/compat/getenv-poison.c b/compat/getenv-poison.c
new file mode 100644
index 0000000..a88ec85
--- /dev/null
+++ b/compat/getenv-poison.c
@@ -0,0 +1,44 @@
+/*
+ * getenv(3) says:
+ *	The implementation of getenv() is not required to be reentrant.
+ *	The string pointed to by the return value of getenv() may be
+ *	statically allocated, and can be modified by a subsequent call
+ *	to getenv(), putenv(3), setenv(3), or unsetenv(3).
+ *
+ * This file provides an unpleasant but conformant getenv()
+ * implementation, for tests.
+ */
+#include "../git-compat-util.h"
+#undef getenv
+
+static void poison_buffer(char *buf, size_t buflen)
+{
+	if (!buflen)
+		return;
+	memset(buf, '\xa5', buflen - 1);
+	buf[buflen - 1] = '\0';
+}
+
+static void fill_buffer(char **buf, size_t *alloc, const char *str)
+{
+	size_t len = strlen(str) + 1;
+	ALLOC_GROW(*buf, len, *alloc);
+	memcpy(*buf, str, len);
+}
+
+char *gitgetenv(const char *name)
+{
+	static char *envvar_array[2];
+	static size_t envvar_len[2];
+	static unsigned int index;
+	const char *value;
+
+	poison_buffer(envvar_array[index], envvar_len[index]);
+	index = (index + 1) % 2;
+
+	value = getenv(name);
+	if (!value)
+		return NULL;
+	fill_buffer(&envvar_array[index], &envvar_len[index], value);
+	return envvar_array[index];
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 2af8d3e..1f6a2ce 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -298,6 +298,11 @@ extern ssize_t read_in_full(int fd, void *buf, size_t count);
 extern int gitsetenv(const char *, const char *, int);
 #endif
 
+#ifdef GETENV_POISON
+#define getenv gitgetenv
+extern char *gitgetenv(const char *name);
+#endif
+
 #ifdef NO_MKDTEMP
 #define mkdtemp gitmkdtemp
 extern char *gitmkdtemp(char *);
@@ -421,6 +426,26 @@ static inline int has_extension(const char *filename, const char *ext)
 	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
 }
 
+#define alloc_nr(x) (((x)+16)*3/2)
+
+/*
+ * Realloc the buffer pointed at by variable 'x' so that it can hold
+ * at least 'nr' entries; the number of entries currently allocated
+ * is 'alloc', using the standard growing factor alloc_nr() macro.
+ *
+ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
+ */
+#define ALLOC_GROW(x, nr, alloc) \
+	do { \
+		if ((nr) > alloc) { \
+			if (alloc_nr(alloc) < (nr)) \
+				alloc = (nr); \
+			else \
+				alloc = alloc_nr(alloc); \
+			x = xrealloc((x), alloc * sizeof(*(x))); \
+		} \
+	} while (0)
+
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
 #undef isspace
-- 
1.7.2.3.557.gab647.dirty

From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 11/13] Win32: keep the environment sorted
Date: Thu, 17 Jul 2014 17:38:04 +0200
Message-ID: <1405611486-10176-12-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:18 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f185.google.com ([209.85.212.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nlA-0008Vl-AD
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:16 +0200
Received: by mail-wi0-f185.google.com with SMTP id f8sf300964wiw.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=7cpmILDxOWXF1OCaY3EmGkLbBxD1IWIFRbIY1EeOViY=;
        b=c4cepg0qvTs+p8YGD7RelHKmZwzlbBTNIHWuxu9TKNmFIvnnmgSYw/0EMdUUvo9lbg
         nyPfCRQM45j3JUYwoS8+NVicLI1ozv0U1PxY0luukRe3pq6K1eywrrrwjZJDWD6Lgqlb
         6Qhk3BVkg386opfb9EZmiBTOA/OBNCMPjsw9U0T/0KLfv45yRv9zBZMV1HroW0cKQTAn
         0ZYcVVSznfz+5wG7Vw5lODxbCrTzb13uvNPfgEhbHdXQ2GzNB5OFPNOECz7U0+aS+Rus
         +RffC3vX112j9KRGXQ8G0P9IVNh+BDUOOGTXCaqtR9aIjhTrBJ87XI4ofR8Row+1nRVQ
         jhEQ==
X-Received: by 10.152.27.41 with SMTP id q9mr9513lag.30.1405611495858;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.4.97 with SMTP id j1ls219263laj.10.gmail; Thu, 17 Jul 2014
 08:38:14 -0700 (PDT)
X-Received: by 10.112.145.233 with SMTP id sx9mr3750168lbb.2.1405611494746;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id d9si372950wie.3.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 8B9441C01AE; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
X-Original-Sender: kasal@ucw.cz
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: kasal@ucw.cz does not designate permitted sender hosts) smtp.mail=kasal@ucw.cz
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253756>

From: Karsten Blees <blees@dcon.de>

The Windows environment is sorted, keep it that way for O(log n)
environment access.

Change compareenv to compare only the keys, so that it can be used to
find an entry irrespective of the value.

Change lookupenv to binary seach for an entry. Return one's complement of
the insert position if not found (libc's bsearch returns NULL).

Replace MSVCRT's getenv with a minimal do_getenv based on the binary search
function.

Change do_putenv to insert new entries at the correct position. Simplify
the function by swapping if conditions and using memmove instead of for
loops.

Move qsort from make_environment_block to mingw_startup. We still need to
sort on startup to make sure that the environment is sorted according to
our compareenv function (while Win32 / CreateProcess requires the
environment block to be sorted case-insensitively, CreateProcess currently
doesn't enforce this, and some applications such as bash just don't care).

Note that environment functions are _not_ thread-safe and are not required
to be so by POSIX, the application is responsible for synchronizing access
to the environment. MSVCRT's getenv and our new getenv implementation are
better than that in that they are thread-safe with respect to other getenv
calls as long as the environment is not modified. Git's indiscriminate use
of getenv in background threads currently requires this property.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 104 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 39 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 757a6b1..9dc6bf6 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -905,13 +905,6 @@ static int environ_size = 0;
 /* allocated size of environ array, in bytes */
 static int environ_alloc = 0;
 
-static int compareenv(const void *a, const void *b)
-{
-	char *const *ea = a;
-	char *const *eb = b;
-	return strcasecmp(*ea, *eb);
-}
-
 /*
  * Create environment block suitable for CreateProcess. Merges current
  * process environment and the supplied environment changes.
@@ -933,9 +926,6 @@ static wchar_t *make_environment_block(char **deltaenv)
 	for (i = 0; deltaenv && deltaenv[i]; i++)
 		size = do_putenv(tmpenv, deltaenv[i], size, 0);
 
-	/* environment must be sorted */
-	qsort(tmpenv, size - 1, sizeof(char*), compareenv);
-
 	/* create environment block from temporary environment */
 	for (i = 0; tmpenv[i]; i++) {
 		size = 2 * strlen(tmpenv[i]) + 2; /* +2 for final \0 */
@@ -1193,16 +1183,42 @@ int mingw_kill(pid_t pid, int sig)
 	return -1;
 }
 
-static int lookupenv(char **env, const char *name, size_t nmln)
-{
-	int i;
+/*
+ * Compare environment entries by key (i.e. stopping at '=' or '\0').
+ */
+static int compareenv(const void *v1, const void *v2)
+{
+	const char *e1 = *(const char**)v1;
+	const char *e2 = *(const char**)v2;
+
+	for (;;) {
+		int c1 = *e1++;
+		int c2 = *e2++;
+		c1 = (c1 == '=') ? 0 : tolower(c1);
+		c2 = (c2 == '=') ? 0 : tolower(c2);
+		if (c1 > c2)
+			return 1;
+		if (c1 < c2)
+			return -1;
+		if (c1 == 0)
+			return 0;
+	}
+}
 
-	for (i = 0; env[i]; i++) {
-		if (!strncasecmp(env[i], name, nmln) && '=' == env[i][nmln])
-			/* matches */
-			return i;
+static int bsearchenv(char **env, const char *name, size_t size)
+{
+	unsigned low = 0, high = size;
+	while (low < high) {
+		unsigned mid = low + ((high - low) >> 1);
+		int cmp = compareenv(&env[mid], &name);
+		if (cmp < 0)
+			low = mid + 1;
+		else if (cmp > 0)
+			high = mid;
+		else
+			return mid;
 	}
-	return -1;
+	return ~low; /* not found, return 1's complement of insert position */
 }
 
 /*
@@ -1212,39 +1228,46 @@ static int lookupenv(char **env, const char *name, size_t nmln)
  */
 static int do_putenv(char **env, const char *name, int size, int free_old)
 {
-	char *eq = strchrnul(name, '=');
-	int i = lookupenv(env, name, eq-name);
+	int i = bsearchenv(env, name, size - 1);
 
-	if (i < 0) {
-		if (*eq) {
-			env[size - 1] = (char*) name;
-			env[size] = NULL;
+	/* optionally free removed / replaced entry */
+	if (i >= 0 && free_old)
+		free(env[i]);
+
+	if (strchr(name, '=')) {
+		/* if new value ('key=value') is specified, insert or replace entry */
+		if (i < 0) {
+			i = ~i;
+			memmove(&env[i + 1], &env[i], (size - i) * sizeof(char*));
 			size++;
 		}
-	}
-	else {
-		if (free_old)
-			free(env[i]);
-		if (*eq)
-			env[i] = (char*) name;
-		else {
-			for (; env[i]; i++)
-				env[i] = env[i+1];
-			size--;
-		}
+		env[i] = (char*) name;
+	} else if (i >= 0) {
+		/* otherwise ('key') remove existing entry */
+		size--;
+		memmove(&env[i], &env[i + 1], (size - i) * sizeof(char*));
 	}
 	return size;
 }
 
-#undef getenv
+static char *do_getenv(const char *name)
+{
+	char *value;
+	int pos = bsearchenv(environ, name, environ_size - 1);
+	if (pos < 0)
+		return NULL;
+	value = strchr(environ[pos], '=');
+	return value ? &value[1] : NULL;
+}
+
 char *mingw_getenv(const char *name)
 {
-	char *result = getenv(name);
+	char *result = do_getenv(name);
 	if (!result && !strcmp(name, "TMPDIR")) {
 		/* on Windows it is TMP and TEMP */
-		result = getenv("TMP");
+		result = do_getenv("TMP");
 		if (!result)
-			result = getenv("TEMP");
+			result = do_getenv("TEMP");
 	}
 	return result;
 }
@@ -2087,6 +2110,9 @@ void mingw_startup()
 	environ[i] = NULL;
 	free(buffer);
 
+	/* sort environment for O(log n) getenv / putenv */
+	qsort(environ, i, sizeof(char*), compareenv);
+
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
 
-- 
2.0.0.9635.g0be03cb

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

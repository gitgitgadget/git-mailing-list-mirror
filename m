From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH 07/13] Win32: factor out environment block creation
Date: Thu, 17 Jul 2014 17:38:00 +0200
Message-ID: <1405611486-10176-8-git-send-email-kasal@ucw.cz>
References: <1405611486-10176-1-git-send-email-kasal@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	msysGit <msysgit@googlegroups.com>,
	Karsten Blees <blees@dcon.de>,
	Stepan Kasal <kasal@ucw.cz>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com Thu Jul 17 17:38:17 2014
Return-path: <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCU63DXMWULRBZ63T6PAKGQES63JOCQ@googlegroups.com>)
	id 1X7nl9-0008Va-O5
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 17:38:15 +0200
Received: by mail-wg0-f59.google.com with SMTP id a1sf269670wgh.14
        for <gcvm-msysgit@m.gmane.org>; Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=e+7XM2wbTJtskyTmgow9u1p1SwFsGUo90lVATiw7QbM=;
        b=TAhZ4yf4S0501+wPC8XpjsM2+Z17jfjjA/FCKct2nTs3VLs5FLWYZhgOGJ5DBTHL6B
         p7Ck368unsiOQ1uvJ3TP6ZO4zl83LhX4Tb8Fm/ZO/veYZvqJuOqkdERBz75lv+5s+2P0
         YZ+aFRHESQR6qfQrlzuTXCJiY2k5Hq6H26oivBevCULzrSK+ahHGB0vmq55ROM8jn6hW
         RwHBn4qd7caQZC7PY0z0PW+qOIm6UW8vjm8HQor08GCjkY6cIl7PUxNF9hJI3PkaN/+f
         XaIbk96aLNNmNftKpT8hocnsdW/smyAc79ZFfrOS5+7vtbYwZOjh0ge9rrw0CdQ/05ft
         Jojw==
X-Received: by 10.181.12.79 with SMTP id eo15mr95659wid.8.1405611495374;
        Thu, 17 Jul 2014 08:38:15 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.77.68 with SMTP id q4ls455487wiw.45.gmail; Thu, 17 Jul
 2014 08:38:14 -0700 (PDT)
X-Received: by 10.180.38.71 with SMTP id e7mr2144097wik.2.1405611494647;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz. [46.255.230.98])
        by gmr-mx.google.com with ESMTP id d9si372949wie.3.2014.07.17.08.38.14
        for <msysgit@googlegroups.com>;
        Thu, 17 Jul 2014 08:38:14 -0700 (PDT)
Received-SPF: none (google.com: kasal@ucw.cz does not designate permitted sender hosts) client-ip=46.255.230.98;
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id 725AF1C01A8; Thu, 17 Jul 2014 17:38:14 +0200 (CEST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253747>

From: Karsten Blees <blees@dcon.de>

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 compat/mingw.c | 55 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 89fe62b..3f81c90 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -905,6 +905,36 @@ static int compareenv(const void *a, const void *b)
 	return strcasecmp(*ea, *eb);
 }
 
+/*
+ * Create environment block suitable for CreateProcess.
+ */
+static wchar_t *make_environment_block(char **env)
+{
+	wchar_t *wenvblk = NULL;
+	int count = 0;
+	char **e, **tmpenv;
+	int size = 0, wenvsz = 0, wenvpos = 0;
+
+	for (e = env; *e; e++)
+		count++;
+
+	/* environment must be sorted */
+	tmpenv = xmalloc(sizeof(*tmpenv) * (count + 1));
+	memcpy(tmpenv, env, sizeof(*tmpenv) * (count + 1));
+	qsort(tmpenv, count, sizeof(*tmpenv), compareenv);
+
+	/* create environment block from temporary environment */
+	for (e = tmpenv; *e; e++) {
+		size = 2 * strlen(*e) + 2; /* +2 for final \0 */
+		ALLOC_GROW(wenvblk, (wenvpos + size) * sizeof(wchar_t), wenvsz);
+		wenvpos += xutftowcs(&wenvblk[wenvpos], *e, size) + 1;
+	}
+	/* add final \0 terminator */
+	wenvblk[wenvpos] = 0;
+	free(tmpenv);
+	return wenvblk;
+}
+
 struct pinfo_t {
 	struct pinfo_t *next;
 	pid_t pid;
@@ -981,29 +1011,8 @@ static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
 	xutftowcs(wargs, args.buf, 2 * args.len + 1);
 	strbuf_release(&args);
 
-	if (env) {
-		int count = 0;
-		char **e, **sorted_env;
-		int size = 0, wenvsz = 0, wenvpos = 0;
-
-		for (e = env; *e; e++)
-			count++;
-
-		/* environment must be sorted */
-		sorted_env = xmalloc(sizeof(*sorted_env) * (count + 1));
-		memcpy(sorted_env, env, sizeof(*sorted_env) * (count + 1));
-		qsort(sorted_env, count, sizeof(*sorted_env), compareenv);
-
-		/* create environment block from temporary environment */
-		for (e = sorted_env; *e; e++) {
-			size = 2 * strlen(*e) + 2; /* +2 for final \0 */
-			ALLOC_GROW(wenvblk, (wenvpos + size) * sizeof(wchar_t), wenvsz);
-			wenvpos += xutftowcs(&wenvblk[wenvpos], *e, size) + 1;
-		}
-		/* add final \0 terminator */
-		wenvblk[wenvpos] = 0;
-		free(sorted_env);
-	}
+	if (env)
+		wenvblk = make_environment_block(env);
 
 	memset(&pi, 0, sizeof(pi));
 	ret = CreateProcessW(wcmd, wargs, NULL, NULL, TRUE, flags,
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

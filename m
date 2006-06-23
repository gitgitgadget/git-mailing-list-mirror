From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Customizable error handlers
Date: Fri, 23 Jun 2006 15:38:47 +0200
Message-ID: <20060623133847.GN21864@pasky.or.cz>
References: <20060623133227.27854.65567.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 15:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtmAZ-0008FD-3W
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 15:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWFWN5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWFWN5m
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 09:57:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:30178 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750707AbWFWNit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 09:38:49 -0400
Received: (qmail 28303 invoked by uid 2001); 23 Jun 2006 15:38:47 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060623133227.27854.65567.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22420>

Dear diary, on Fri, Jun 23, 2006 at 03:32:27PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5d543d2..e954002 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -36,9 +36,13 @@ #endif
>  #endif
>  
>  /* General helper functions */
> -extern void usage(const char *err) NORETURN;
> -extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
> -extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
> +void usage(const char *err) NORETURN;
> +void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
> +int error(const char *err, ...) __attribute__((format (printf, 1, 2)));

Wah, this kind of slipped through. Below is a patch without the
externs removed. Sorry about the noise.

>  int error(const char *err, ...)
>  {
>  	va_list params;
> +	int ret;
>  
>  	va_start(params, err);
> -	report("error: ", err, params);
> +	ret = error_routine(err, params);
>  	va_end(params);
> -	return -1;
> +	return ret;
>  }

BTW, I don't mind if you just force the return value to -1 here.
It might be saner.

---

[PATCH] Customizable error handlers

This patch makes the usage(), die() and error() handlers customizable.
Nothing in the git code itself uses that but many other libgit users
(like Git.pm) will.

This is implemented using the mutator functions primarily because you
cannot directly modifying global variables of libgit from a program that
dlopen()ed it, apparently. But having functions for that is a better API
anyway.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

diff --git a/git-compat-util.h b/git-compat-util.h
index 5d543d2..0c5ceb3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -40,6 +40,10 @@ extern void usage(const char *err) NORET
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
+extern void set_usage_routine(void (*routine)(const char *err) NORETURN);
+extern void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN);
+extern void set_error_routine(int (*routine)(const char *err, va_list params));
+
 #ifdef NO_MMAP
 
 #ifndef PROT_READ
diff --git a/usage.c b/usage.c
index 1fa924c..445456d 100644
--- a/usage.c
+++ b/usage.c
@@ -12,28 +12,68 @@ static void report(const char *prefix, c
 	fputs("\n", stderr);
 }
 
-void usage(const char *err)
+void usage_builtin(const char *err)
 {
 	fprintf(stderr, "usage: %s\n", err);
 	exit(129);
 }
 
+void die_builtin(const char *err, va_list params)
+{
+	report("fatal: ", err, params);
+	exit(128);
+}
+
+int error_builtin(const char *err, va_list params)
+{
+	report("error: ", err, params);
+	return -1;
+}
+
+
+/* If we are in a dlopen()ed .so write to a global variable would segfault
+ * (ugh), so keep things static. */
+static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
+static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
+static int (*error_routine)(const char *err, va_list params) = error_builtin;
+
+void set_usage_routine(void (*routine)(const char *err) NORETURN)
+{
+	usage_routine = routine;
+}
+
+void set_die_routine(void (*routine)(const char *err, va_list params) NORETURN)
+{
+	die_routine = routine;
+}
+
+void set_error_routine(int (*routine)(const char *err, va_list params))
+{
+	error_routine = routine;
+}
+
+
+void usage(const char *err)
+{
+	usage_routine(err);
+}
+
 void die(const char *err, ...)
 {
 	va_list params;
 
 	va_start(params, err);
-	report("fatal: ", err, params);
+	die_routine(err, params);
 	va_end(params);
-	exit(128);
 }
 
 int error(const char *err, ...)
 {
 	va_list params;
+	int ret;
 
 	va_start(params, err);
-	report("error: ", err, params);
+	ret = error_routine(err, params);
 	va_end(params);
-	return -1;
+	return ret;
 }

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.

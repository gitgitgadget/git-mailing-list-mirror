From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add strerror(errno) to die() calls where applicable
Date: Tue, 2 Jun 2009 21:55:03 -0400
Message-ID: <20090603015503.GA14166@coredump.intra.peff.net>
References: <8df45fb3586160fa5c47af39d2a7eb2b8d405a3c.1243978065.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jun 03 03:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBfhJ-0005vA-Ii
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 03:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbZFCBzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 21:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbZFCBzL
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 21:55:11 -0400
Received: from peff.net ([208.65.91.99]:44008 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752315AbZFCBzK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 21:55:10 -0400
Received: (qmail 17158 invoked by uid 107); 3 Jun 2009 01:55:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 02 Jun 2009 21:55:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jun 2009 21:55:03 -0400
Content-Disposition: inline
In-Reply-To: <8df45fb3586160fa5c47af39d2a7eb2b8d405a3c.1243978065.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120572>

On Tue, Jun 02, 2009 at 11:34:33PM +0200, Thomas Rast wrote:

> Lots of die() calls did not actually report the kind of error, which
> can leave the user confused as to the real problem.  Add a
> strerror(errno) where the die() is immediately preceded by a
> system/library call that sets errno on failure, or by one of the
> following that wrap such calls:

I like this, as I remember being frustrated in the past by "cannot $foo"
messages with no indication of the cause of the error. My only questions
or concerns with such a patch would be:

  1. How did you determine the set of callsites? Did you check that each
     non-syscall function always sets errno? Are there are functions
     which are setting errno which could also be included?

  2. Extra error conditions may leak information about the filesystem to
     people feeding bogus paths to upload-pack. I didn't see anything
     obvious in your patch that would cause this, but it is something to
     consider.

  3. This is such a common thing to do, I wonder if we would be better
     off adding a "diesys" function that appends ": strerror(errno)"
     to the emitted error. Something like the (totally untested) patch
     below.

And a few comments on the patch itself:

> @@ -109,7 +113,8 @@ int is_directory(const char *path)
>  	} else {
>  		const char *cwd = get_pwd_cwd();
>  		if (!cwd)
> -			die("Cannot determine the current working directory");
> +			die("Cannot determine the current working directory",
> +			    strerror(errno));

Missing ": %s" here?

> -		die("closing file %s: %s", path, strerror(errno));
> +		die("closing file '%s': %s", path, strerror(errno));

This one is actually just a style change, though I think it is
worthwhile (and there are a few others like it).


The diesys patch is below.

---
diff --git a/git-compat-util.h b/git-compat-util.h
index 4236647..410ac87 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -155,6 +155,7 @@
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
+extern void diesys(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
diff --git a/usage.c b/usage.c
index 820d09f..da5e58e 100644
--- a/usage.c
+++ b/usage.c
@@ -12,6 +12,14 @@ static void report(const char *prefix, const char *err, va_list params)
 	fprintf(stderr, "%s%s\n", prefix, msg);
 }
 
+static void report_sys(int err, const char *prefix, const char *fmt, va_list
+		params)
+{
+	char msg[1024];
+	vsnprintf(msg, sizeof(msg), fmt, params);
+	fprintf(stderr, "%s%s: %s\n", prefix, msg, hstrerror(err));
+}
+
 static NORETURN void usage_builtin(const char *err)
 {
 	fprintf(stderr, "usage: %s\n", err);
@@ -24,6 +32,12 @@ static NORETURN void die_builtin(const char *err, va_list params)
 	exit(128);
 }
 
+static NORETURN void diesys_builtin(int err, const char *fmt, va_list params)
+{
+	report_sys(err, "fatal: ", fmt, params);
+	exit(128);
+}
+
 static void error_builtin(const char *err, va_list params)
 {
 	report("error: ", err, params);
@@ -38,6 +52,7 @@ static void warn_builtin(const char *warn, va_list params)
  * (ugh), so keep things static. */
 static void (*usage_routine)(const char *err) NORETURN = usage_builtin;
 static void (*die_routine)(const char *err, va_list params) NORETURN = die_builtin;
+static void (*diesys_routine)(int err, const char *fmt, va_list params) NORETURN = diesys_builtin;
 static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 
@@ -60,6 +75,16 @@ void die(const char *err, ...)
 	va_end(params);
 }
 
+void diesys(const char *fmt, ...)
+{
+	va_list params;
+	int err = errno;
+
+	va_start(params, fmt);
+	diesys_routine(err, fmt, params);
+	va_end(params);
+}
+
 int error(const char *err, ...)
 {
 	va_list params;

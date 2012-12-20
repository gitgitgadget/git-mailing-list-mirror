From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2012, #05; Tue, 18)
Date: Thu, 20 Dec 2012 14:58:37 -0500
Message-ID: <20121220195837.GB21785@sigill.intra.peff.net>
References: <7v4njjf6fk.fsf@alter.siamese.dyndns.org>
 <20121220145941.GC27211@sigill.intra.peff.net>
 <7vwqwc617y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 20:58:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlmGg-0005ly-1J
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 20:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab2LTT6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 14:58:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60015 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2LTT6k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 14:58:40 -0500
Received: (qmail 14431 invoked by uid 107); 20 Dec 2012 19:59:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 14:59:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 14:58:37 -0500
Content-Disposition: inline
In-Reply-To: <7vwqwc617y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211922>

On Thu, Dec 20, 2012 at 10:13:37AM -0800, Junio C Hamano wrote:

> >> * jk/error-const-return (2012-12-15) 2 commits
> >>  - silence some -Wuninitialized false positives
> >>  - make error()'s constant return value more visible
> >> 
> >>  Help compilers' flow analysis by making it more explicit that
> >>  error() always returns -1, to reduce false "variable used
> >>  uninitialized" warnings.
> >> 
> >>  This is still an RFC.
> >
> > What's your opinion on this?
> 
> Ugly but not too much so, and it would be useful.
> 
> The only thing that makes it ugly is that it promises error() will
> return -1 and nothing else forever, but at this point in the
> evolution of the codebase, I think we are pretty much committed to
> it anyway, so I do not think it is a problem.

Right. I do not mind saying "error() will always return -1" and forcing
somebody who changes that assumption to update the macro. But what
worries me is that when they make that update, there is no compile-time
check that indicates the macro and the function are no longer in sync.
So our attempt for more compile-time safety may actually introduce a
run-time bug.  And it is a hard bug to find, as the preprocessor
"magically" converts the error code into -1 without you being able to
see it in the code.

It would be safer to just unconditionally use the macros and drop the
return values from the functions entirely, like the patch below
(squashed on top of what is in jk/error-const-return). But it cannot
work for error(), because the variadic nature means we need to restrict
ourselves to __GNUC__.

diff --git a/cache.h b/cache.h
index 0e8e5d8..694b146 100644
--- a/cache.h
+++ b/cache.h
@@ -1135,10 +1135,8 @@ extern int config_error_nonbool(const char *);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
-extern int config_error_nonbool(const char *);
-#ifdef __GNUC__
+extern void config_error_nonbool(const char *);
 #define config_error_nonbool(s) (config_error_nonbool(s), -1)
-#endif
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
diff --git a/config.c b/config.c
index 526f682..a22e78c 100644
--- a/config.c
+++ b/config.c
@@ -1661,7 +1661,7 @@ int config_error_nonbool(const char *var)
  * get a boolean value (i.e. "[my] var" means "true").
  */
 #undef config_error_nonbool
-int config_error_nonbool(const char *var)
+void config_error_nonbool(const char *var)
 {
-	return error("Missing value for '%s'", var);
+	error("Missing value for '%s'", var);
 }
diff --git a/parse-options.c b/parse-options.c
index 67e98a6..ba39dd9 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -586,11 +586,12 @@ int opterror(const struct option *opt, const char *reason, int flags)
 }
 
 #undef opterror
-int opterror(const struct option *opt, const char *reason, int flags)
+void opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
-		return error("switch `%c' %s", opt->short_name, reason);
+		error("switch `%c' %s", opt->short_name, reason);
 	if (flags & OPT_UNSET)
-		return error("option `no-%s' %s", opt->long_name, reason);
-	return error("option `%s' %s", opt->long_name, reason);
+		error("option `no-%s' %s", opt->long_name, reason);
+	else
+		error("option `%s' %s", opt->long_name, reason);
 }
diff --git a/parse-options.h b/parse-options.h
index e703853..bd43314 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -176,10 +176,8 @@ extern int opterror(const struct option *opt, const char *reason, int flags);
 				   const struct option *options);
 
 extern int optbug(const struct option *opt, const char *reason);
-extern int opterror(const struct option *opt, const char *reason, int flags);
-#ifdef __GNUC__
+extern void opterror(const struct option *opt, const char *reason, int flags);
 #define opterror(o,r,f) (opterror((o),(r),(f)), -1)
-#endif
 
 /*----- incremental advanced APIs -----*/
 

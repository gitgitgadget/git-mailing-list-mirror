From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Sun, 13 Jul 2014 14:36:29 -0400
Message-ID: <20140713183629.GA19293@sigill.intra.peff.net>
References: <1405119347-3308-1-git-send-email-jacob.e.keller@intel.com>
 <1405119347-3308-3-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cR9VCtNhk-FbqDM1LTCa8VeUTYXU4XEX36Rb5CxPFfLWQ@mail.gmail.com>
 <xmqqfvi518xo.fsf@gitster.dls.corp.google.com>
 <20140713173356.GA8406@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 20:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Odk-0005Lh-6Z
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 20:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbaGMSgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 14:36:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:33198 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750924AbaGMSgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 14:36:32 -0400
Received: (qmail 32111 invoked by uid 102); 13 Jul 2014 18:36:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 13 Jul 2014 13:36:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Jul 2014 14:36:29 -0400
Content-Disposition: inline
In-Reply-To: <20140713173356.GA8406@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253454>

On Sun, Jul 13, 2014 at 01:33:56PM -0400, Jeff King wrote:

> I realize that I am reinventing the error-reporting wheel on a sleepy
> Sunday afternoon without having thought about it much, so there is
> probably some gotcha or case that makes this ugly, or perhaps it just
> ends up verbose in practice. But one can dream.

Just for fun...

---
diff --git a/builtin/tag.c b/builtin/tag.c
index 5e0744b..0f5be3b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -379,7 +379,10 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "tag.sort")) {
 		if (!value)
 			return config_error_nonbool(var);
-		parse_sort_string(value, &tag_sort);
+		set_error_routine(collect_errors);
+		if (parse_sort_string(value, &tag_sort) < 0)
+			print_errors(warning, "#{error} in config option 'tag.sort'");
+		pop_error_routine();
 		return 0;
 	}
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 9de3180..6bf91a6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -346,6 +346,11 @@ extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_lis
 extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
+void pop_error_routine(void);
+void collect_errors(const char *err, va_list params);
+__attribute__((format (printf, 2, 3)))
+void print_errors(void (*func)(const char *, ...), const char *fmt, ...);
+
 extern int starts_with(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 
diff --git a/usage.c b/usage.c
index ed14645..055ccc7 100644
--- a/usage.c
+++ b/usage.c
@@ -57,10 +57,16 @@ static int die_is_recursing_builtin(void)
  * (ugh), so keep things static. */
 static NORETURN_PTR void (*usage_routine)(const char *err, va_list params) = usage_builtin;
 static NORETURN_PTR void (*die_routine)(const char *err, va_list params) = die_builtin;
-static void (*error_routine)(const char *err, va_list params) = error_builtin;
 static void (*warn_routine)(const char *err, va_list params) = warn_builtin;
 static int (*die_is_recursing)(void) = die_is_recursing_builtin;
 
+struct error_func_list {
+	void (*func)(const char *, va_list);
+	struct error_func_list *next;
+};
+static struct error_func_list default_error_func = { error_builtin };
+static struct error_func_list *error_funcs = &default_error_func;
+
 void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params))
 {
 	die_routine = routine;
@@ -68,7 +74,84 @@ void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list param
 
 void set_error_routine(void (*routine)(const char *err, va_list params))
 {
-	error_routine = routine;
+	struct error_func_list *efl = xmalloc(sizeof(*efl));
+	efl->func = routine;
+	efl->next = error_funcs;
+	error_funcs = efl;
+}
+
+void pop_error_routine(void)
+{
+	while (error_funcs != &default_error_func) {
+		struct error_func_list *efl = error_funcs;
+		error_funcs = efl->next;
+		free(efl);
+	}
+}
+
+struct error_list {
+	struct strbuf buf;
+	struct error_list *next;
+};
+struct error_list *error_list;
+struct error_list **error_list_tail = &error_list;
+
+void collect_errors(const char *fmt, va_list params)
+{
+	struct error_list *err = xmalloc(sizeof(*err));
+
+	strbuf_init(&err->buf, 0);
+	strbuf_vaddf(&err->buf, fmt, params);
+	err->next = NULL;
+	*error_list_tail = err;
+	error_list_tail = &err->next;
+}
+
+static void clear_errors(void)
+{
+	while (error_list) {
+		struct error_list *next = error_list->next;
+		strbuf_release(&error_list->buf);
+		free(error_list);
+		error_list = next;
+	}
+	error_list_tail = &error_list;
+}
+
+void print_errors(void (*func)(const char *, ...), const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	va_list params;
+	int prefix_len, suffix_start;
+	const char *p;
+	struct error_list *el;
+
+	va_start(params, fmt);
+	strbuf_vaddf(&buf, fmt, params);
+	va_end(params);
+
+	/*
+	 * The intent here is that callers will put #{error} in their fmt
+	 * string. Doing two layers of interpolation is gross, because we may
+	 * accidentally find "#{error}" in one of the substitutions, not the
+	 * original fmt. Ideally we would do it all in a single pass (and call
+	 * #{error} "%M" or something), but that would require extending
+	 * vsprintf, and there is no way to do that portably.
+	 */
+	p = strstr(buf.buf, "#{error}");
+	if (!p)
+		die("BUG: error printer does not want to print error!?");
+	prefix_len = p - buf.buf;
+	suffix_start = prefix_len + strlen("#{error}");
+
+	for (el = error_list; el; el = el->next)
+		func("%.*s%.*s%.*s",
+		     prefix_len, buf.buf,
+		     el->buf.len, el->buf.buf,
+		     buf.len - suffix_start, buf.buf + suffix_start);
+
+	strbuf_release(&buf);
+	clear_errors();
 }
 
 void set_die_is_recursing_routine(int (*routine)(void))
@@ -144,7 +227,7 @@ int error(const char *err, ...)
 	va_list params;
 
 	va_start(params, err);
-	error_routine(err, params);
+	error_funcs->func(err, params);
 	va_end(params);
 	return -1;
 }

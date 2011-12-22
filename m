From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] i18n of multi-line messages
Date: Wed, 21 Dec 2011 23:38:01 -0800
Message-ID: <7vaa6ldpk6.fsf@alter.siamese.dyndns.org>
References: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
 <4EF2D436.3080303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 22 08:38:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RddEU-0001ga-Lq
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 08:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469Ab1LVHiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Dec 2011 02:38:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab1LVHiF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2011 02:38:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82E2A418C;
	Thu, 22 Dec 2011 02:38:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3vGRoTY9pgG1AFRSmiKe4p6EYTs=; b=iOffG+
	cAvW5KauBd1JFk0Gcvm85Uj4kwmMFe27F9G1qgJWqmV9pxtFotHSN16aW4lxHYNw
	imn60eAtdVByX4CQbUOFVVJq4Ol7F3FYCKqHyz2vUe/JP4m2og+Px4lkTP0DJ8DF
	Z4Ga/rCbpEKw/QWH5wHjq7nbaSBMH8Be1iS48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLyiYM1Pr7FkamM91k1TYPKV2bJCfMZ1
	gt6pCXfdRHAaNiJaYF2yZNFZsztLgbfkyzx3QBnRLH38JGQwnnDHsywDbL/lMKnb
	fwhEHXsVAnS+ZjN7MFgNcBioEf03o8ZiVnhtBE6Ydr2MVAPhjOsZaGEi4quwStp9
	tr0UFtXJrdM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 794A84188;
	Thu, 22 Dec 2011 02:38:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADE56417B; Thu, 22 Dec 2011
 02:38:02 -0500 (EST)
In-Reply-To: <4EF2D436.3080303@viscovery.net> (Johannes Sixt's message of
 "Thu, 22 Dec 2011 07:54:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E117975A-2C6F-11E1-AE11-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187601>

Johannes Sixt <j.sixt@viscovery.net> writes:

> IMHO, this logic should be moved into vreportf(), and we get proper
> prefixing of multi-line warning(), error(), and die() messages for free.

I agree with this, so here is a rewrite to do so.

Two points to note.

 - Existing users of vreportf() and vwritef() are modified to pass the
   prefix like "error", "warning", etc. without colon+SP. The formatting
   convention regarding how the "prefix" is separated from the body of the
   message should also be locale specific.

 - I expect some tests will fail, as there would be existing users that
   pass multi-line strings to die(), error() and friends.

For the latter, I didn't bother to check, but I would not be surprised if
everybody thinks the updated output that repeats the same prefix line to
every line is easier to read and formatted more consistently. Updating the
tests to go with this change is left as an exercise for the reader.

-- >8 --
Advice messages are by definition meant for human end-users, and prime
candidates for i18n/l10n. They tend to also be more verbose to be helpful,
and need to be longer than just one line.

Although we do not have parameterized multi-line advice messages yet, once
we do, we cannot emit such a message like this:

	advise(_("Please rename %s to something else"), gostak);
        advise(_("so that we can avoid distimming %s unnecessarily."), doshes);

because some translations may need to have the replacement of 'gostak' on
the second line (or 'doshes' on the first line). Some languages may even
need to use three lines in order to fit the same message within a
reasonable width.

Instead, it has to be a single advise() construct, like this:

	advise(_("Please rename %s to something else\n"
                 "so that we can avoid distimming %s unnecessarily."),
		gostak, doshes);

Update the advise() function and its existing callers to

 - take a format string that can be multi-line and translatable as a
   whole;
 - use the string and the parameters to form a localized message; and
 - append each line in the result to localization of the "hint: " prefix.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 advice.c         |   13 +++++------
 builtin/revert.c |    9 +++----
 http-backend.c   |    2 +-
 run-command.c    |    2 +-
 usage.c          |   63 +++++++++++++++++++++++++++++++++++++++++------------
 5 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/advice.c b/advice.c
index e02e632..93a03f5 100644
--- a/advice.c
+++ b/advice.c
@@ -24,7 +24,7 @@ void advise(const char *advice, ...)
 	va_list params;
 
 	va_start(params, advice);
-	vreportf("hint: ", advice, params);
+	vreportf("hint", advice, params);
 	va_end(params);
 }
 
@@ -46,16 +46,15 @@ int git_default_advice_config(const char *var, const char *value)
 int error_resolve_conflict(const char *me)
 {
 	error("'%s' is not possible because you have unmerged files.", me);
-	if (advice_resolve_conflict) {
+	if (advice_resolve_conflict)
 		/*
 		 * Message used both when 'git commit' fails and when
 		 * other commands doing a merge do.
 		 */
-		advise("Fix them up in the work tree,");
-		advise("and then use 'git add/rm <file>' as");
-		advise("appropriate to mark resolution and make a commit,");
-		advise("or use 'git commit -a'.");
-	}
+		advise(_("Fix them up in the work tree,\n"
+			 "and then use 'git add/rm <file>' as\n"
+			 "appropriate to mark resolution and make a commit,\n"
+			 "or use 'git commit -a'."));
 	return -1;
 }
 
diff --git a/builtin/revert.c b/builtin/revert.c
index 1ea525c..3ad14a1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -332,11 +332,10 @@ static void print_advice(int show_hint)
 		return;
 	}
 
-	if (show_hint) {
-		advise("after resolving the conflicts, mark the corrected paths");
-		advise("with 'git add <paths>' or 'git rm <paths>'");
-		advise("and commit the result with 'git commit'");
-	}
+	if (show_hint)
+		advise(_("after resolving the conflicts, mark the corrected paths\n"
+			 "with 'git add <paths>' or 'git rm <paths>'\n"
+			 "and commit the result with 'git commit'"));
 }
 
 static void write_message(struct strbuf *msgbuf, const char *filename)
diff --git a/http-backend.c b/http-backend.c
index 59ad7da..d372252 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -490,7 +490,7 @@ static NORETURN void die_webcgi(const char *err, va_list params)
 		hdr_nocache();
 		end_headers();
 
-		vreportf("fatal: ", err, params);
+		vreportf("fatal", err, params);
 	}
 	exit(0); /* we successfully reported a failure ;-) */
 }
diff --git a/run-command.c b/run-command.c
index 1c51043..f7a7b5c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -78,7 +78,7 @@ static void notify_parent(void)
 
 static NORETURN void die_child(const char *err, va_list params)
 {
-	vwritef(child_err, "fatal: ", err, params);
+	vwritef(child_err, "fatal", err, params);
 	exit(128);
 }
 
diff --git a/usage.c b/usage.c
index a2a6678..2d392a4 100644
--- a/usage.c
+++ b/usage.c
@@ -6,45 +6,78 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+typedef void (*emit_fn)(struct strbuf *, void *);
+
+static void v_format(const char *prefix, const char *fmt, va_list params,
+		     emit_fn emit, void *cb_data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf line = STRBUF_INIT;
+	const char *cp, *np;
+
+	strbuf_vaddf(&buf, fmt, params);
+	for (cp = buf.buf; *cp; cp = np) {
+		np = strchrnul(cp, '\n');
+		/*
+		 * TRANSLATORS: the format is designed so that in RTL
+		 * languages you could reorder and put the "prefix" at
+		 * the end instead of the beginning of a line if you
+		 * wanted to.
+		 */
+		strbuf_addf(&line,
+			    _("%s: %.*s\n"),
+			    prefix,
+			    (int)(np - cp), cp);
+		emit(&line, cb_data);
+		strbuf_reset(&line);
+		if (*np)
+			np++;
+	}
+	strbuf_release(&buf);
+	strbuf_release(&line);
+}
+
+static void emit_report(struct strbuf *line, void *cb_data)
+{
+	fprintf(stderr, "%.*s", (int)line->len, line->buf);
+}
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
-	char msg[4096];
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	v_format(prefix, err, params, emit_report, NULL);
 }
 
-void vwritef(int fd, const char *prefix, const char *err, va_list params)
+static void emit_write(struct strbuf *line, void *cb_data)
 {
-	char msg[4096];
-	int len = vsnprintf(msg, sizeof(msg), err, params);
-	if (len > sizeof(msg))
-		len = sizeof(msg);
+	int *fd = cb_data;
+	write_in_full(*fd, line->buf, line->len);
+}
 
-	write_in_full(fd, prefix, strlen(prefix));
-	write_in_full(fd, msg, len);
-	write_in_full(fd, "\n", 1);
+void vwritef(int fd, const char *prefix, const char *err, va_list params)
+{
+	v_format(prefix, err, params, emit_write, &fd);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
 {
-	vreportf("usage: ", err, params);
+	vreportf("usage", err, params);
 	exit(129);
 }
 
 static NORETURN void die_builtin(const char *err, va_list params)
 {
-	vreportf("fatal: ", err, params);
+	vreportf("fatal", err, params);
 	exit(128);
 }
 
 static void error_builtin(const char *err, va_list params)
 {
-	vreportf("error: ", err, params);
+	vreportf("error", err, params);
 }
 
 static void warn_builtin(const char *warn, va_list params)
 {
-	vreportf("warning: ", warn, params);
+	vreportf("warning", warn, params);
 }
 
 /* If we are in a dlopen()ed .so write to a global variable would segfault
-- 
1.7.8.1.389.gc5932

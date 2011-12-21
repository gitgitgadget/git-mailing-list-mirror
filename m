From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] i18n of multi-line messages
Date: Wed, 21 Dec 2011 15:55:26 -0800
Message-ID: <7vr4zxeaz5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 00:55:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdW0U-00014s-D5
	for gcvg-git-2@lo.gmane.org; Thu, 22 Dec 2011 00:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab1LUXzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 18:55:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1LUXz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 18:55:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 230DF6D2E;
	Wed, 21 Dec 2011 18:55:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	TEI4nPibzAQmr+dc/qpGhd3nG4=; b=rYSLhQz21CjKFB/hA24e6B2l7dxTSZiWK
	JZw2Go+AnhThfKgKU8QIZb3ZVubcWXC+zmIgZUpbPStqkpPlPHIlJILmGb5SK4qP
	GGqSgW2FiXsNf9yLyb4gO+3jhYbixPRPYwRgvRyYpT//EBpnvEYsoArCpowZdY/7
	K613L1KCYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=oVph6jSEgAPyWnlFuVMJ+nxWbHPA9lIDGXMuNYdVmsbhdFm77gZK0rcU
	zUjNyvF7melLlJJzFa/HOvJISqNhQ/IIg0N2f7EnvEOnp0Xk8gSQsWCE+aMeFKyi
	rqroIRAWPKLo+VWJN/iE1Bq7yU+xl+CRljxkM2K7MjqzZv1lt1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A3546D2D;
	Wed, 21 Dec 2011 18:55:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D28D6D2C; Wed, 21 Dec 2011
 18:55:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 41B41232-2C2F-11E1-B831-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187592>

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
 advice.c         |   23 ++++++++++++++++-------
 builtin/revert.c |    9 ++++-----
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/advice.c b/advice.c
index e02e632..fcdf66a 100644
--- a/advice.c
+++ b/advice.c
@@ -21,11 +21,21 @@ static struct {
 
 void advise(const char *advice, ...)
 {
+	struct strbuf buf = STRBUF_INIT;
 	va_list params;
+	const char *cp, *np;
 
 	va_start(params, advice);
-	vreportf("hint: ", advice, params);
+	strbuf_addf(&buf, advice, params);
 	va_end(params);
+
+	for (cp = buf.buf; *cp; cp = np) {
+		np = strchrnul(cp, '\n');
+		fprintf(stderr, "%s%.*s\n", _("hint: "), (int)(np - cp), cp);
+		if (*np)
+			np++;
+	}
+	strbuf_release(&buf);
 }
 
 int git_default_advice_config(const char *var, const char *value)
@@ -46,16 +56,15 @@ int git_default_advice_config(const char *var, const char *value)
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
index fce3f92..440d2be 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -343,11 +343,10 @@ static void print_advice(int show_hint)
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

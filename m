From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/33] t3210: test for spurious error messages for dangling packed refs
Date: Wed, 17 Apr 2013 15:38:08 -0700
Message-ID: <7vbo9ceqb3.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
	<1365944088-10588-17-git-send-email-mhagger@alum.mit.edu>
	<7vobdfvglf.fsf@alter.siamese.dyndns.org>
	<516D5CC6.10505@alum.mit.edu>
	<7vip3mhxhq.fsf@alter.siamese.dyndns.org>
	<20130416235712.GA20585@sigill.intra.peff.net>
	<7v38upix82.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 18 00:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USaza-0004EZ-1M
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 00:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966873Ab3DQWiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 18:38:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966831Ab3DQWiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 18:38:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0171317AE6;
	Wed, 17 Apr 2013 22:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n5VH40iciJmHUUWzSmLf8klTwyo=; b=glUCrW
	txhKkbx1mxUUD2SrBGOLU9AmSm9Iv8B2PWAkeFiGECzaa7w+TIGxaze4/vqz/jik
	Npya6VOTuNPJ1DH8G6qlHajsAv6/WqBWQryFEo30EmBZp5yYyhYeFg4E3ZChimgD
	qU2yYmhvVFlA8n/NIlPvZD57th+3BwBsaZHL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z85eOxsfTJXx40ZNTYk44MOx69dB0Y77
	X3/mQwgyxJOiORtLh8Up72B/QV7s/i7ZPILkMrYAHP8GOj7uqT5N1edskHsc2d8Y
	M0HNibCgfSVg1RBVtiW3aod8vsF+LIZNyEszfkDiWVkcdPDKCZsmfpFTvOw67IKm
	ouD6DML30iw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECC1117AE5;
	Wed, 17 Apr 2013 22:38:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33DAD17AE1;
	Wed, 17 Apr 2013 22:38:10 +0000 (UTC)
In-Reply-To: <7v38upix82.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 16 Apr 2013 21:42:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B2D0396-A7AF-11E2-97D9-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221581>

Junio C Hamano <gitster@pobox.com> writes:

>> Do we want to use approxidate_careful here to catch other junk?
>
> We can catch a misspelt argument or configuration value that way.
> That would be a good idea.

-- >8 --
Subject: date.c: add parse_expiry_date()

"git reflog --expire=all" tries to expire reflog entries up to the
current second, because the approxidate() parser gives the current
timestamp for anything it does not understand (and it does not know
what time "all" means).  When the user tells us to expire "all" (or
set the expiration time to "now"), the user wants to remove all the
reflog entries (no reflog entry should record future time).

Just set it to ULONG_MAX and to let everything that is older that
timestamp expire.

While at it, allow "now" to be treated the same way for callers that
parse expiry date timestamp with this function.  Also use an error
reporting version of approxidate() to report misspelled date.  When
the user says e.g. "--expire=mnoday" to delete entries two days or
older on Wednesday, we wouldn't want the "unknown, default to now"
logic to kick in.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * adoption to more users and tests are left as an exercise to the
   reader.

 builtin/reflog.c | 14 +++++++-------
 cache.h          |  1 +
 date.c           | 22 ++++++++++++++++++++++
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b3c9e27..44700f9 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -496,11 +496,9 @@ static int parse_expire_cfg_value(const char *var, const char *value, unsigned l
 {
 	if (!value)
 		return config_error_nonbool(var);
-	if (!strcmp(value, "never") || !strcmp(value, "false")) {
-		*expire = 0;
-		return 0;
-	}
-	*expire = approxidate(value);
+	if (parse_expiry_date(value, expire))
+		return error(_("%s' for '%s' is not a valid timestamp"),
+			     value, var);
 	return 0;
 }
 
@@ -613,11 +611,13 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
 		else if (!prefixcmp(arg, "--expire=")) {
-			cb.expire_total = approxidate(arg + 9);
+			if (parse_expiry_date(arg + 9, &cb.expire_total))
+				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
 		else if (!prefixcmp(arg, "--expire-unreachable=")) {
-			cb.expire_unreachable = approxidate(arg + 21);
+			if (parse_expiry_date(arg + 21, &cb.expire_unreachable))
+				die(_("'%s' is not a valid timestamp"), arg);
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
 		else if (!strcmp(arg, "--stale-fix"))
diff --git a/cache.h b/cache.h
index 3622e18..f43f6d9 100644
--- a/cache.h
+++ b/cache.h
@@ -878,6 +878,7 @@ void show_date_relative(unsigned long time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, char *buf, int bufsize);
 int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
+int parse_expiry_date(const char *date, unsigned long *timestamp);
 void datestamp(char *buf, int bufsize);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
diff --git a/date.c b/date.c
index 57331ed..876d679 100644
--- a/date.c
+++ b/date.c
@@ -705,6 +705,28 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 	return 0; /* success */
 }
 
+int parse_expiry_date(const char *date, unsigned long *timestamp)
+{
+	int errors = 0;
+
+	if (!strcmp(date, "never") || !strcmp(date, "false"))
+		*timestamp = 0;
+	else if (!strcmp(date, "all") || !strcmp(date, "now"))
+		/*
+		 * We take over "now" here, which usually translates
+		 * to the current timestamp.  This is because the user
+		 * really means to expire everything she has done in
+		 * the past, and by definition reflogs are the record
+		 * of the past, and there is nothing from the future
+		 * to be kept.
+		 */
+		*timestamp = ULONG_MAX;
+	else
+		*timestamp = approxidate_careful(date, &errors);
+
+	return errors;
+}
+
 int parse_date(const char *date, char *result, int maxlen)
 {
 	unsigned long timestamp;

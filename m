From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Tue, 26 Jan 2010 11:58:00 -0800
Message-ID: <7vockgzliv.fsf@alter.siamese.dyndns.org>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
 <1263980322-4142-2-git-send-email-gitster@pobox.com>
 <20100126130745.GB28179@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 20:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZrYH-0004U2-8O
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 20:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab0AZT6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727Ab0AZT6M
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 14:58:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab0AZT6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 14:58:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 620EC917E7;
	Tue, 26 Jan 2010 14:58:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R4BG/ZIodKqV/Of9bI85NvhBXbk=; b=sGyqaq
	lGBtuAwL0RohCdgBbw/nJSienm66nPJLDE+U6ORTV/YMH8smQESWCmokpmlfBJ39
	Q5HiFbmfxfTTgRUDTQmm6CK/2QsVGcPQkoCXn+sfQ0KrQwTcBrA53E3z27vsENUj
	RFq5nBAiL2fhwHqtbqL0ClLweOvelXgXKgz+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GyZZiZc+m4BALGnDV4bhuzQ4YkJWkL5u
	atftDzpGVUrsecET9W+8f8V+YKsxN0twZn2eYN8c4lhl5t7daJtXRS13LqqdMFmX
	agrYHjxIEIZD/UufAo0ZGpFtytnv6sUY782n6L6zoRP/pN6YkWmumLSa30JinFz6
	KnHFB3LTfpc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 284B9917E0;
	Tue, 26 Jan 2010 14:58:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA854917DA; Tue, 26 Jan
 2010 14:58:01 -0500 (EST)
In-Reply-To: <20100126130745.GB28179@coredump.intra.peff.net> (Jeff King's
 message of "Tue\, 26 Jan 2010 08\:07\:45 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E7E61AC-0AB5-11DF-A864-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138069>

Jeff King <peff@peff.net> writes:

> The first one is that @{usptream} silently becomes @{0}. I think
> we need to double-check whether approxidate found absolutely nothing,
> and complain if that is the case.

This is not a new problem introduced by Dscho's @{u} series; it was there
even before 861f00e (fix reflog approxidate parsing bug, 2008-04-30).

Nevertheless, it would be nice to fix it.

-- >8 --
Subject: approxidate_careful() reports errorneous date string

For a long time, the time based reflog syntax (e.g. master@{yesterday})
didn't complain when the "human readable" timestamp was misspelled, as
the underlying mechanism tried to be as lenient as possible.  The funny
thing was that parsing of "@{now}" even relied on the fact that anything
not recognized by the machinery returned the current timestamp.

Introduce approxidate_careful() that takes an optional pointer to an
integer, that gets assigned 1 when the input does not make sense as a
timestamp.

As I am too lazy to fix all the callers that use approxidate(), most of
the callers do not take advantage of the error checking, but convert the
code to parse reflog to use it as a demonstration.

Tests are mostly from Jeff King.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h              |    3 ++-
 date.c               |   43 +++++++++++++++++++++++++++++++++++--------
 sha1_name.c          |    5 ++++-
 t/t0101-at-syntax.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index b3370eb..f0fea2d 100644
--- a/cache.h
+++ b/cache.h
@@ -762,7 +762,8 @@ const char *show_date_relative(unsigned long time, int tz,
 			       size_t timebuf_size);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
-unsigned long approxidate(const char *);
+#define approxidate(s) approxidate_careful(s, NULL)
+unsigned long approxidate_careful(const char *, int *);
 unsigned long approxidate_relative(const char *date, const struct timeval *now);
 enum date_mode parse_date_format(const char *format);
 
diff --git a/date.c b/date.c
index 45f3684..002aa3c 100644
--- a/date.c
+++ b/date.c
@@ -696,6 +696,11 @@ static unsigned long update_tm(struct tm *tm, struct tm *now, unsigned long sec)
 	return n;
 }
 
+static void date_now(struct tm *tm, struct tm *now, int *num)
+{
+	update_tm(tm, now, 0);
+}
+
 static void date_yesterday(struct tm *tm, struct tm *now, int *num)
 {
 	update_tm(tm, now, 24*60*60);
@@ -770,6 +775,7 @@ static const struct special {
 	{ "PM", date_pm },
 	{ "AM", date_am },
 	{ "never", date_never },
+	{ "now", date_now },
 	{ NULL }
 };
 
@@ -790,7 +796,7 @@ static const struct typelen {
 	{ NULL }
 };
 
-static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm *now, int *num)
+static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm *now, int *num, int *touched)
 {
 	const struct typelen *tl;
 	const struct special *s;
@@ -804,6 +810,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 		int match = match_string(date, month_names[i]);
 		if (match >= 3) {
 			tm->tm_mon = i;
+			*touched = 1;
 			return end;
 		}
 	}
@@ -812,6 +819,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 		int len = strlen(s->name);
 		if (match_string(date, s->name) == len) {
 			s->fn(tm, now, num);
+			*touched = 1;
 			return end;
 		}
 	}
@@ -821,11 +829,14 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 			int len = strlen(number_name[i]);
 			if (match_string(date, number_name[i]) == len) {
 				*num = i;
+				*touched = 1;
 				return end;
 			}
 		}
-		if (match_string(date, "last") == 4)
+		if (match_string(date, "last") == 4) {
 			*num = 1;
+			*touched = 1;
+		}
 		return end;
 	}
 
@@ -835,6 +846,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 		if (match_string(date, tl->type) >= len-1) {
 			update_tm(tm, now, tl->length * *num);
 			*num = 0;
+			*touched = 1;
 			return end;
 		}
 		tl++;
@@ -852,6 +864,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 			diff += 7*n;
 
 			update_tm(tm, now, diff * 24 * 60 * 60);
+			*touched = 1;
 			return end;
 		}
 	}
@@ -866,6 +879,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 			tm->tm_year--;
 		}
 		tm->tm_mon = n;
+		*touched = 1;
 		return end;
 	}
 
@@ -873,6 +887,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
 		update_tm(tm, now, 0); /* fill in date fields if needed */
 		tm->tm_year -= *num;
 		*num = 0;
+		*touched = 1;
 		return end;
 	}
 
@@ -929,9 +944,12 @@ static void pending_number(struct tm *tm, int *num)
 	}
 }
 
-static unsigned long approxidate_str(const char *date, const struct timeval *tv)
+static unsigned long approxidate_str(const char *date,
+				     const struct timeval *tv,
+				     int *error_ret)
 {
 	int number = 0;
+	int touched = 0;
 	struct tm tm, now;
 	time_t time_sec;
 
@@ -951,33 +969,42 @@ static unsigned long approxidate_str(const char *date, const struct timeval *tv)
 		if (isdigit(c)) {
 			pending_number(&tm, &number);
 			date = approxidate_digit(date-1, &tm, &number);
+			touched = 1;
 			continue;
 		}
 		if (isalpha(c))
-			date = approxidate_alpha(date-1, &tm, &now, &number);
+			date = approxidate_alpha(date-1, &tm, &now, &number, &touched);
 	}
 	pending_number(&tm, &number);
+	if (!touched)
+		*error_ret = 1;
 	return update_tm(&tm, &now, 0);
 }
 
 unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 {
 	char buffer[50];
+	int errors = 0;
 
 	if (parse_date(date, buffer, sizeof(buffer)) > 0)
 		return strtoul(buffer, NULL, 0);
 
-	return approxidate_str(date, tv);
+	return approxidate_str(date, tv, &errors);
 }
 
-unsigned long approxidate(const char *date)
+unsigned long approxidate_careful(const char *date, int *error_ret)
 {
 	struct timeval tv;
 	char buffer[50];
+	int dummy = 0;
+	if (!error_ret)
+		error_ret = &dummy;
 
-	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+	if (parse_date(date, buffer, sizeof(buffer)) > 0) {
+		*error_ret = 0;
 		return strtoul(buffer, NULL, 0);
+	}
 
 	gettimeofday(&tv, NULL);
-	return approxidate_str(date, &tv);
+	return approxidate_str(date, &tv, error_ret);
 }
diff --git a/sha1_name.c b/sha1_name.c
index 9215ad1..ed4c028 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -413,8 +413,11 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		} else if (0 <= nth)
 			at_time = 0;
 		else {
+			int errors = 0;
 			char *tmp = xstrndup(str + at + 2, reflog_len);
-			at_time = approxidate(tmp);
+			at_time = approxidate_careful(tmp, &errors);
+			if (errors)
+				die("Bogus timestamp '%s'", tmp);
 			free(tmp);
 		}
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
new file mode 100755
index 0000000..ccabc37
--- /dev/null
+++ b/t/t0101-at-syntax.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='various @{whatever} syntax tests'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit one &&
+	test_commit two
+'
+
+check_at() {
+	echo "$2" >expect &&
+	git log -1 --format=%s "$1" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '@{0} shows current' '
+	check_at @{0} two
+'
+
+test_expect_success '@{1} shows old' '
+	check_at @{1} one
+'
+
+test_expect_success '@{now} shows current' '
+	check_at @{now} two
+'
+
+test_expect_success '@{30.years.ago} shows old' '
+	check_at @{30.years.ago} one
+'
+
+test_expect_success 'silly approxidates work' '
+	check_at @{3.hot.dogs.and.30.years.ago} one
+'
+
+test_expect_success 'notice misspelled upstream' '
+	test_must_fail git log -1 --format=%s @{usptream}
+'
+
+test_expect_success 'complain about total nonsense' '
+	test_must_fail git log -1 --format=%s @{utter.bogosity}
+'
+
+test_done

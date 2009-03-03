From: Junio C Hamano <gitster@pobox.com>
Subject: Re: orthogonal cases of log --date option
Date: Tue, 03 Mar 2009 00:45:37 -0800
Message-ID: <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:47:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQHQ-0004eu-Od
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbZCCIpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbZCCIpp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:45:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbZCCIpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:45:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5621F1485;
	Tue,  3 Mar 2009 03:45:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5A27D1483; Tue, 
 3 Mar 2009 03:45:39 -0500 (EST)
In-Reply-To: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Tue, 03 Mar 2009 17:18:56 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ADD060C4-07CF-11DE-BFD3-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112033>

Miles Bader <miles@gnu.org> writes:

> I can use "git log --date=iso" to get YYYY-MM-DD format for dates, or
> "git log --date=local" to force the dates to use my local time zone, but
> if I use _both_ of these options together, it uses only the last one,
> and ignores any preceding --date (even those in this case, the two
> --date options affect orthogonal properties of dates).  Is there a way
> to get YYYY-MM-DD format dates, but in my local time-zone?

No, there isn't.

But this patch may help you get started.

Just like any other patches I send out to only show a way to competent
people I can trust to carry it forward, it is not even compile tested,
though.

---
 builtin-for-each-ref.c |    2 +-
 builtin-log.c          |    2 +-
 cache.h                |   15 ++++++++-------
 date.c                 |   27 +++++++++++++++------------
 revision.c             |    2 +-
 5 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index e46b7ad..3a9f64b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -361,7 +361,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	formatp = strchr(atomname, ':');
 	if (formatp != NULL) {
 		formatp++;
-		date_mode = parse_date_format(formatp);
+		date_mode = parse_date_format(formatp, 0);
 	}
 
 	if (!eoemail)
diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..618922a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -41,7 +41,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
-		rev->date_mode = parse_date_format(default_date_mode);
+		rev->date_mode = parse_date_format(default_date_mode, 0);
 
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 
diff --git a/cache.h b/cache.h
index 189151d..a3ecf63 100644
--- a/cache.h
+++ b/cache.h
@@ -692,19 +692,20 @@ extern struct object *peel_to_type(const char *name, int namelen,
 
 enum date_mode {
 	DATE_NORMAL = 0,
-	DATE_RELATIVE,
-	DATE_SHORT,
-	DATE_LOCAL,
-	DATE_ISO8601,
-	DATE_RFC2822,
-	DATE_RAW
+	DATE_RELATIVE = 1,
+	DATE_SHORT = 2,
+	DATE_ISO8601 = 3,
+	DATE_RFC2822 = 4,
+	DATE_RAW = 5,
+
+	DATE_LOCAL = 16, /* OR'ed in to others */
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
-enum date_mode parse_date_format(const char *format);
+enum date_mode parse_date_format(const char *format, enum date_mode so_far);
 
 #define IDENT_WARN_ON_NO_NAME  1
 #define IDENT_ERROR_ON_NO_NAME 2
diff --git a/date.c b/date.c
index d75dff4..8d04418 100644
--- a/date.c
+++ b/date.c
@@ -89,6 +89,10 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	struct tm *tm;
 	static char timebuf[200];
 
+	if (mode & DATE_LOCAL)
+		tz = local_tzoffset(time);
+	mode &= ~DATE_LOCAL;
+
 	if (mode == DATE_RAW) {
 		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
 		return timebuf;
@@ -136,9 +140,6 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 		/* Else fall back on absolute format.. */
 	}
 
-	if (mode == DATE_LOCAL)
-		tz = local_tzoffset(time);
-
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
@@ -604,24 +605,26 @@ int parse_date(const char *date, char *result, int maxlen)
 	return date_string(then, offset, result, maxlen);
 }
 
-enum date_mode parse_date_format(const char *format)
+enum date_mode parse_date_format(const char *format, enum date_mode so_far)
 {
+	int or_in_local = so_far & DATE_LOCAL;
+
 	if (!strcmp(format, "relative"))
-		return DATE_RELATIVE;
+		return DATE_RELATIVE | or_in_local;
 	else if (!strcmp(format, "iso8601") ||
 		 !strcmp(format, "iso"))
-		return DATE_ISO8601;
+		return DATE_ISO8601 | or_in_local;
 	else if (!strcmp(format, "rfc2822") ||
 		 !strcmp(format, "rfc"))
-		return DATE_RFC2822;
+		return DATE_RFC2822 | or_in_local;
 	else if (!strcmp(format, "short"))
-		return DATE_SHORT;
-	else if (!strcmp(format, "local"))
-		return DATE_LOCAL;
+		return DATE_SHORT | or_in_local;
 	else if (!strcmp(format, "default"))
-		return DATE_NORMAL;
+		return DATE_NORMAL | or_in_local;
 	else if (!strcmp(format, "raw"))
-		return DATE_RAW;
+		return DATE_RAW | or_in_local;
+	else if (!strcmp(format, "local"))
+		return DATE_LOCAL | so_far;
 	else
 		die("unknown date format %s", format);
 }
diff --git a/revision.c b/revision.c
index 286e416..be9bbc4 100644
--- a/revision.c
+++ b/revision.c
@@ -1177,7 +1177,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--relative-date")) {
 		revs->date_mode = DATE_RELATIVE;
 	} else if (!strncmp(arg, "--date=", 7)) {
-		revs->date_mode = parse_date_format(arg + 7);
+		revs->date_mode = parse_date_format(arg + 7, revs->date_mode);
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size = 1;
 	}

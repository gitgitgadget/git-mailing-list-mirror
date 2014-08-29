From: Beat Bolli <bbolli@ewanet.ch>
Subject: [PATCH v2] pretty: Provide a strict ISO8601 date format
Date: Fri, 29 Aug 2014 18:58:42 +0200
Message-ID: <1409331522-8457-1-git-send-email-bbolli@ewanet.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPVl-0003zm-A8
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbaH2Q6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:58:49 -0400
Received: from smtp1.mail.fcom.ch ([212.60.46.170]:46762 "EHLO
	smtp1.mail.fcom.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbaH2Q6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:58:48 -0400
Received: from drbeat.li (84-243-153-5.dyn.cable.fcom.ch [5.153.243.84])
	by smtp1.mail.fcom.ch (Postfix) with ESMTP id 569D621549
	for <git@vger.kernel.org>; Fri, 29 Aug 2014 18:58:43 +0200 (CEST)
Received: by drbeat.li (Postfix, from userid 1000)
	id C627D200A8; Fri, 29 Aug 2014 18:58:42 +0200 (CEST)
X-Mailer: git-send-email 2.1.0
X-Virus-Scanned: clamav-milter 0.98.4 at smtp1.mail.fcom.ch
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256164>

There has been concern that Git's "ISO" date format does not really
conform to the ISO 8601 standard. Thus, it cannot be parsed by
ISO 8601 compliant parsers, e.g. those of XML toolchains.

The differences between the two formats are the following:
  - a space instead of the `T` date/time delimiter
  - a space between time and time zone
  - no colon between hours and minutes of the time zone

This commit adds a strict ISO 8601 date format for displaying committer
and author dates. It uses the '%aI' and '%cI' format specifiers (note
the uppercase 'I') and the '--date=iso-strict' or
'--date=iso8601-strict' date format names.

See http://thread.gmane.org/gmane.comp.version-control.git/255879 and
http://thread.gmane.org/gmane.comp.version-control.git/52414/focus=52585
for discussion.

Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
---

v2:
  - Improve commit message
  - Fix time zone display for negative values close to zero

 Documentation/git-rev-list.txt     |  2 +-
 Documentation/pretty-formats.txt   |  6 ++++--
 Documentation/rev-list-options.txt | 13 +++++++++++--
 cache.h                            |  1 +
 date.c                             | 14 +++++++++++++-
 pretty.c                           |  5 ++++-
 t/t4205-log-pretty-formats.sh      |  7 +++++++
 7 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 7a1585d..fd7f8b5 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -45,7 +45,7 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date=(local|relative|default|iso|rfc|short) ]
+	     [ \--date=(local|relative|default|iso|iso-strict|rfc|short) ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 85d6353..50a2c30 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -115,7 +115,8 @@ The placeholders are:
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
-- '%ai': author date, ISO 8601 format
+- '%ai': author date, ISO 8601-like format
+- '%aI': author date, strict ISO 8601 format
 - '%cn': committer name
 - '%cN': committer name (respecting .mailmap, see
   linkgit:git-shortlog[1] or linkgit:git-blame[1])
@@ -126,7 +127,8 @@ The placeholders are:
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
-- '%ci': committer date, ISO 8601 format
+- '%ci': committer date, ISO 8601-like format
+- '%cI': committer date, strict ISO 8601 format
 - '%d': ref names, like the --decorate option of linkgit:git-log[1]
 - '%e': encoding
 - '%s': subject
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index deb8cca..5d311b8 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -677,7 +677,7 @@ include::pretty-options.txt[]
 --relative-date::
 	Synonym for `--date=relative`.
 
---date=(relative|local|default|iso|rfc|short|raw)::
+--date=(relative|local|default|iso|iso-strict|rfc|short|raw)::
 	Only takes effect for dates shown in human-readable format, such
 	as when using `--pretty`. `log.date` config variable sets a default
 	value for the log command's `--date` option.
@@ -687,7 +687,16 @@ e.g. ``2 hours ago''.
 +
 `--date=local` shows timestamps in user's local time zone.
 +
-`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
+`--date=iso` (or `--date=iso8601`) shows timestamps in a ISO 8601-like format.
+The differences to the strict ISO 8601 format are:
+
+	- a space instead of the `T` date/time delimiter
+	- a space between time and time zone
+	- no colon between hours and minutes of the time zone
+
++
+`--date=iso-strict` (or `--date=iso8601-strict`) shows timestamps in strict
+ISO 8601 format.
 +
 `--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
 format, often found in email messages.
diff --git a/cache.h b/cache.h
index fcb511d..fa92aaf 100644
--- a/cache.h
+++ b/cache.h
@@ -1037,6 +1037,7 @@ enum date_mode {
 	DATE_SHORT,
 	DATE_LOCAL,
 	DATE_ISO8601,
+	DATE_ISO8601_STRICT,
 	DATE_RFC2822,
 	DATE_RAW
 };
diff --git a/date.c b/date.c
index 782de95..5d73d9b 100644
--- a/date.c
+++ b/date.c
@@ -200,7 +200,16 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
-	else if (mode == DATE_RFC2822)
+	else if (mode == DATE_ISO8601_STRICT) {
+		char sign = (tz >= 0) ? '+' : '-';
+		tz = abs(tz);
+		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec,
+				sign, tz / 100, tz % 100);
+	} else if (mode == DATE_RFC2822)
 		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
@@ -751,6 +760,9 @@ enum date_mode parse_date_format(const char *format)
 	else if (!strcmp(format, "iso8601") ||
 		 !strcmp(format, "iso"))
 		return DATE_ISO8601;
+	else if (!strcmp(format, "iso8601-strict") ||
+		 !strcmp(format, "iso-strict"))
+		return DATE_ISO8601_STRICT;
 	else if (!strcmp(format, "rfc2822") ||
 		 !strcmp(format, "rfc"))
 		return DATE_RFC2822;
diff --git a/pretty.c b/pretty.c
index 3a1da6f..7dd5601 100644
--- a/pretty.c
+++ b/pretty.c
@@ -731,9 +731,12 @@ static size_t format_person_part(struct strbuf *sb, char part,
 	case 'r':	/* date, relative */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_RELATIVE));
 		return placeholder_len;
-	case 'i':	/* date, ISO 8601 */
+	case 'i':	/* date, ISO 8601-like */
 		strbuf_addstr(sb, show_ident_date(&s, DATE_ISO8601));
 		return placeholder_len;
+	case 'I':	/* date, ISO 8601 strict */
+		strbuf_addstr(sb, show_ident_date(&s, DATE_ISO8601_STRICT));
+		return placeholder_len;
 	}
 
 skip:
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 349c531..aad7a80 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -431,6 +431,13 @@ EOF
 	test_cmp expected actual
 '
 
+# ISO strict date format
+test_expect_success 'ISO and ISO-strict date formats display the same values' '
+	git log --format=%ai%n%ci | sed -e "s/ /T/; s/ //; s/..\$/:&/" >expected &&
+	git log --format=%aI%n%cI >actual &&
+	test_cmp expected actual
+'
+
 # get new digests (with no abbreviations)
 head1=$(git rev-parse --verify HEAD~0) &&
 head2=$(git rev-parse --verify HEAD~1) &&
-- 
2.1.0

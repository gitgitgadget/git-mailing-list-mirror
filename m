Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB291F464
	for <e@80x24.org>; Tue, 10 Sep 2019 16:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436618AbfIJQ0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 12:26:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:45508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2436494AbfIJQ0c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 12:26:32 -0400
Received: (qmail 401 invoked by uid 109); 10 Sep 2019 16:26:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 10 Sep 2019 16:26:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16828 invoked by uid 111); 10 Sep 2019 16:28:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2019 12:28:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Sep 2019 12:26:29 -0400
From:   Jeff King <peff@peff.net>
To:     Diomidis Spinellis <dds@aueb.gr>
Cc:     git@vger.kernel.org
Subject: Re: Patching Git to handle dates before the Unix epoch
Message-ID: <20190910162629.GA12758@sigill.intra.peff.net>
References: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c12e3505-7a02-3eaf-7d71-57a3b4df28d1@aueb.gr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 10, 2019 at 05:14:53PM +0300, Diomidis Spinellis wrote:

> As people use Git to create synthetic commits of code written in the past
> [1,2] it becomes important to handle dates before the Unix epoch (1/1/1970).
> I see that modern C libraries, Unix kernels, and tools can handle such
> dates.  However Git seems to mishandle such dates in several places, such as
> in date.c [3,4].  I'm planning to work on a fix, but before I embark on this
> I have a few questions.

Coincidentally I was looking into this yesterday. See below.

> - Do you see any reasons that may prevent the acceptance of such a patch?

No, I think this is where we want to go. One of the long-standing
blockers was that timestamps were treated as "unsigned long" all over
the code base. That was cleaned up into a single date type around
dddbad728c (timestamp_t: a new data type for timestamps, 2017-04-26).

So there's definitely still work to be done before switching that to a
signed type, but most of the far-reaching changes have already been
done.

> - Can you think of any non-obvious issues (e.g. backward compatibility,
> switch to the Gregorian calendar) I should be aware of?

The big question is: what will existing implementations do with a commit
object that contains a negative timestamp?

There are a few answers I found (at least for existing versions of Git;
I didn't check other tools):

  - git-log and friends will realize they can't parse it and quietly
    rewrite it to "0 +0000" (e.g., when formatting human-readable author
    dates). That's pretty reasonable.

  - fsck will complain, which may cause servers to reject objects if
    they use transfer.fsckObjects. Once there are patches, presumably
    most hosting sites would apply them relatively quickly, but it's
    likely to cause some friction. OTOH, you only see that friction if
    you're working with a history that has such negative timestamps.

  - I'm not sure what we'd do for commit timestamps, which are still
    stored as 32-bit unsigned integers for the purposes of traversal
    (and ditto in commit graphs). IMHO the correct thing would be having
    modern commit timestamps and "real" author timestamps. I'm not sure
    if fsck should enforce that or not.

> - Should I submit changes as a bug fix on the maint branch or as a new
> feature on master?

While it is a bug fix, I think it's a big enough change that it should
be part of a major release. So base it on master.

Here's how far I got working on this yesterday. It's quite messy, but
seems to work at least for basic tests like:

  $ git commit --date='@-6105998402 -0500' --allow-empty -m foo
  [master f83702e] foo
   Date: Thu Jul 4 12:19:58 1776 -0500

  $ git show
  commit f83702e850366c0a9a6dc5a5fb70d21072cf40e5 (HEAD -> master)
  Author: Jeff King <peff@peff.net>
  Date:   Thu Jul 4 12:19:58 1776 -0500

      foo

It obviously needs split up into individual patches with each bit
explained. The most glaring problem is that it switches our custom
tm_to_time_t() to use timegm(), which isn't portable. We can probably
pull a fallback implementation from glibc or elsewhere (I've seen a few
floating around the net, and they're less horrible than you might think
because they don't have to deal with timezones).

There are probably more corner cases to be poked at and found. Notably
this _doesn't_ work:

  $ git commit --date='1776-07-04 12:19:58' ...

because we're too picky in our parsing. There might be some improvement
possible there, at least for unambiguous iso8601-looking cases
(approxidate will probably always have use heuristics that assume a
recent-ish date).

---
 Makefile          |  5 ++---
 date.c            | 42 ++++++++++++++++++------------------------
 git-compat-util.h |  9 +++++----
 ident.c           |  4 +++-
 4 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/Makefile b/Makefile
index ad71ae1219..41cdb4bd8c 100644
--- a/Makefile
+++ b/Makefile
@@ -2525,8 +2525,7 @@ endif
 ## Git repository (not a tarball extract), (2) any local modifications
 ## will be lost.
 ## Gettext tools cannot work with our own custom PRItime type, so
-## we replace PRItime with PRIuMAX.  We need to update this to
-## PRIdMAX if we switch to a signed type later.
+## we replace PRItime with PRIdMAX.
 
 po/git.pot: $(GENERATED_H) FORCE
 	# All modifications will be reverted at the end, so we do not
@@ -2535,7 +2534,7 @@ po/git.pot: $(GENERATED_H) FORCE
 
 	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
 	do \
-		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
+		sed -e 's|PRItime|PRIdMAX|g' <"$$s" >"$$s+" && \
 		cat "$$s+" >"$$s" && rm "$$s+"; \
 	done
 
diff --git a/date.c b/date.c
index 8126146c50..52e54e3e2a 100644
--- a/date.c
+++ b/date.c
@@ -7,27 +7,14 @@
 #include "cache.h"
 
 /*
- * This is like mktime, but without normalization of tm_wday and tm_yday.
+ * This is like mktime, but without normalization of tm_wday and tm_yday,
+ * and always operating in UTC, not the local timezone.
  */
-static time_t tm_to_time_t(const struct tm *tm)
+static time_t tm_to_time_t(const struct tm *tm_const)
 {
-	static const int mdays[] = {
-	    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
-	};
-	int year = tm->tm_year - 70;
-	int month = tm->tm_mon;
-	int day = tm->tm_mday;
-
-	if (year < 0 || year > 129) /* algo only works for 1970-2099 */
-		return -1;
-	if (month < 0 || month > 11) /* array bounds */
-		return -1;
-	if (month < 2 || (year + 2) % 4)
-		day--;
-	if (tm->tm_hour < 0 || tm->tm_min < 0 || tm->tm_sec < 0)
-		return -1;
-	return (year * 365 + (year + 1) / 4 + mdays[month] + day) * 24*60*60UL +
-		tm->tm_hour * 60*60 + tm->tm_min * 60 + tm->tm_sec;
+	struct tm tm = *tm_const;
+	/* this is a GNUism; we need to provide a fallback */
+	return timegm(&tm);
 }
 
 static const char *month_names[] = {
@@ -51,8 +38,7 @@ static time_t gm_time_t(timestamp_t time, int tz)
 		if (unsigned_add_overflows(time, minutes * 60))
 			die("Timestamp+tz too large: %"PRItime" +%04d",
 			    time, tz);
-	} else if (time < -minutes * 60)
-		die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);
+	}
 	time += minutes * 60;
 	if (date_overflows(time))
 		die("Timestamp too large for this system: %"PRItime, time);
@@ -773,10 +759,11 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
 	timestamp_t stamp;
 	int ofs;
 
-	if (*date < '0' || '9' < *date)
+	if (*date != '-' && (*date < '0' || '9' < *date))
 		return -1;
+	errno = 0;
 	stamp = parse_timestamp(date, &end, 10);
-	if (*end != ' ' || stamp == TIME_MAX || (end[1] != '+' && end[1] != '-'))
+	if (*end != ' ' || errno == ERANGE || (end[1] != '+' && end[1] != '-'))
 		return -1;
 	date = end + 2;
 	ofs = strtol(date, &end, 10);
@@ -841,6 +828,13 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 		date += match;
 	}
 
+	if (tm.tm_year < 0 ||
+	    tm.tm_mon < 0 || tm.tm_mon > 11 ||
+	    tm.tm_hour < 0 || tm.tm_hour > 23 ||
+	    tm.tm_min < 0 || tm.tm_min > 59 ||
+	    tm.tm_sec < 0 || tm.tm_sec > 59)
+		return -1;
+
 	/* do not use mktime(), which uses local timezone, here */
 	*timestamp = tm_to_time_t(&tm);
 	if (*timestamp == -1)
@@ -1322,7 +1316,7 @@ int date_overflows(timestamp_t t)
 	time_t sys;
 
 	/* If we overflowed our timestamp data type, that's bad... */
-	if ((uintmax_t)t >= TIME_MAX)
+	if (t >= TIME_MAX || t <= TIME_MIN)
 		return 1;
 
 	/*
diff --git a/git-compat-util.h b/git-compat-util.h
index 83be89de0a..9a93d43429 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -340,10 +340,11 @@ char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
-typedef uintmax_t timestamp_t;
-#define PRItime PRIuMAX
-#define parse_timestamp strtoumax
-#define TIME_MAX UINTMAX_MAX
+typedef intmax_t timestamp_t;
+#define PRItime PRIdMAX
+#define parse_timestamp strtoimax
+#define TIME_MAX INTMAX_MAX
+#define TIME_MIN INTMAX_MIN
 
 #ifndef PATH_SEP
 #define PATH_SEP ':'
diff --git a/ident.c b/ident.c
index e666ee4e59..2734bf890d 100644
--- a/ident.c
+++ b/ident.c
@@ -322,10 +322,12 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 	if (line + len <= cp)
 		goto person_only;
 	split->date_begin = cp;
+	if (*cp == '-')
+		cp++;
 	span = strspn(cp, "0123456789");
 	if (!span)
 		goto person_only;
-	split->date_end = split->date_begin + span;
+	split->date_end = cp + span;
 	for (cp = split->date_end; cp < line + len && isspace(*cp); cp++)
 		;
 	if (line + len <= cp || (*cp != '+' && *cp != '-'))
-- 
2.23.0.663.gbe3d117559


From: Tuomas Suutari <tuomas.suutari@gmail.com>
Subject: [PATCH/RFC] New date format: local_original
Date: Tue, 6 Oct 2009 22:09:47 +0300
Message-ID: <200910062209.47606.tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 21:17:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvFX1-00063o-9o
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 21:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758255AbZJFTLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 15:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758181AbZJFTLj
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 15:11:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:3657 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757300AbZJFTLi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 15:11:38 -0400
Received: by fg-out-1718.google.com with SMTP id 22so893186fge.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date
         :mime-version:content-disposition:to:content-transfer-encoding
         :message-id;
        bh=+X6zyzegoFBL1C5lYwCRn/MuZXsaB+SMEz8JrzJcubQ=;
        b=XE/ON0FkpR3ZVbB3U622m506AKnPbyurOyu7xrhRVDNORVUpGGG3IOHXH54X03HD7E
         b+oLwr2sWZFm+MTMmypjIpjKLamZCDkBNkyUgE4BEjXRC/DxYAmw+SckbUJ7wuirZVgL
         +grGHjRh1UV1wap5CrX7UmoxF6VwOjuMftJyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:mime-version:content-disposition:to
         :content-transfer-encoding:message-id;
        b=AXqx6uNxogEIKZsGbLrMeCP1VvS7EBYWs/qXptogamfgMvHGutNjRs37gNMq3+yJ9n
         jMciP7WQfiJV0e3/EL4qyghGC+bwK1KrgILkJIo94acDWsvtyB0QqqQGbyaFOd1qRunT
         h1LRwchV3uG9opmN9LIyB2ZFPRfQ4Kticdzjc=
Received: by 10.86.227.26 with SMTP id z26mr862584fgg.76.1254856190020;
        Tue, 06 Oct 2009 12:09:50 -0700 (PDT)
Received: from ws-26-184.laitilanpuhelin.fi (ws-26-184.laitilanpuhelin.fi [188.123.26.184])
        by mx.google.com with ESMTPS id d4sm587821fga.19.2009.10.06.12.09.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Oct 2009 12:09:49 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129632>

Formats date and time with local and original timezone representation
in same string. They both can be useful at the same time: local
timezone for relating timestamp to local events, and original timezone
to see the author's time of the day.

The format is ISO-8601 timestamp with weekday in local timezone
followed by weekday and time in original timezone in parentheses. The
weekday part makes it easier to understand the timestamps when the
days differ. For example, if local timezone is +0800, then timestamp
2009-10-04T19:37:03+0300 would be formatted as
"Mon 2009-10-05 00:37:03 (Sun 19:37:03 +0300)".

Signed-off-by: Tuomas Suutari <tuomas.suutari@gmail.com>
---

It was hard to decide whether to use --date=local or --date=iso
with git log, so I though that maybe I could have them both.

Hardest part was to decide the actual format string, especially
because they tend to get so long. My solution for that,
is to drop the date part out from the other timestamp and use
weekday as a way to relate them to each other.

So, what do you think? Could this be useful for anyone else?
Any better ideas for the format string?

ps. I tried to find the relevant parts of the documentation
and tests by grepping the names of the other formats (iso8601
and rfc2822) and updated them, but I could have easily missed
something. Tests did not show any new problems, but the
cvsimport tests (t960?) didn't seem to work before or after
my changes.

 Documentation/git-for-each-ref.txt     |    4 ++--
 Documentation/rev-list-options.txt     |    4 +++-
 builtin-blame.c                        |    3 +++
 cache.h                                |    3 ++-
 contrib/completion/git-completion.bash |    5 ++++-
 date.c                                 |   23 +++++++++++++++++++++++
 t/t6300-for-each-ref.sh                |   15 ++++++++++++++-
 7 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 8dc873f..00525c2 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -114,8 +114,8 @@ returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
 the date by adding one of `:default`, `:relative`, `:short`, `:local`,
-`:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
-`%(taggerdate:relative)`.
+`:iso8601`, `:rfc2822`, or `:local_original`, to the end of the
+fieldname; e.g. `%(taggerdate:relative)`.
 
 
 EXAMPLES
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index bf66116..e007244 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -13,7 +13,7 @@ include::pretty-options.txt[]
 
 	Synonym for `--date=relative`.
 
---date={relative,local,default,iso,rfc,short,raw}::
+--date={relative,local,default,iso,rfc,short,raw,local_original}::
 
 	Only takes effect for dates shown in human-readable format, such
 	as when using "--pretty". `log.date` config variable sets a default
@@ -35,6 +35,8 @@ format, often found in E-mail messages.
 +
 `--date=default` shows timestamps in the original timezone
 (either committer's or author's).
++
+`--date=local_original` shows timestamps in local and original timezone.
 
 ifdef::git-rev-list[]
 --header::
diff --git a/builtin-blame.c b/builtin-blame.c
index 7512773..4766dd5 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2290,6 +2290,9 @@ parse_done:
 	case DATE_NORMAL:
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
+	case DATE_LOCAL_ORIGINAL:
+		blame_date_width = sizeof("Thu 2006-10-19 16:00:04 (Thu 16:00:04 -0700)");
+		break;
 	}
 	blame_date_width -= 1; /* strip the null */
 
diff --git a/cache.h b/cache.h
index a5eeead..89c3c12 100644
--- a/cache.h
+++ b/cache.h
@@ -729,7 +729,8 @@ enum date_mode {
 	DATE_LOCAL,
 	DATE_ISO8601,
 	DATE_RFC2822,
-	DATE_RAW
+	DATE_RAW,
+	DATE_LOCAL_ORIGINAL
 };
 
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c2a0d4..4f4ca53 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1152,7 +1152,10 @@ __git_log_shortlog_options="
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
-__git_log_date_formats="relative iso8601 rfc2822 short local default raw"
+__git_log_date_formats="
+	relative iso8601 rfc2822 short local default raw
+	local_original
+"
 
 _git_log ()
 {
diff --git a/date.c b/date.c
index 5d05ef6..b34a735 100644
--- a/date.c
+++ b/date.c
@@ -151,6 +151,7 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 {
 	struct tm *tm;
 	static char timebuf[200];
+	int n;
 
 	if (mode == DATE_RAW) {
 		snprintf(timebuf, sizeof(timebuf), "%lu %+05d", time, tz);
@@ -185,6 +186,26 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
+	else if (mode == DATE_LOCAL_ORIGINAL) {
+		/* Use local timezone first... */
+		tm = time_to_tm(time, local_tzoffset(time));
+		if (!tm)
+			return NULL;
+		n = sprintf(timebuf, "%.3s %04d-%02d-%02d %02d:%02d:%02d",
+			weekday_names[tm->tm_wday],
+			tm->tm_year + 1900,
+			tm->tm_mon + 1,
+			tm->tm_mday,
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		/* ...and then original timezone. */
+		tm = time_to_tm(time, tz);
+		if (!tm)
+			return NULL;
+		sprintf(timebuf + n, " (%.3s %02d:%02d:%02d %+05d)",
+			weekday_names[tm->tm_wday],
+			tm->tm_hour, tm->tm_min, tm->tm_sec,
+			tz);
+	}
 	else
 		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
@@ -656,6 +677,8 @@ enum date_mode parse_date_format(const char *format)
 		return DATE_NORMAL;
 	else if (!strcmp(format, "raw"))
 		return DATE_RAW;
+	else if (!strcmp(format, "local_original"))
+		return DATE_LOCAL_ORIGINAL;
 	else
 		die("unknown date format %s", format);
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8052c86..1c91b21 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -122,7 +122,8 @@ test_expect_success 'Check valid format specifiers for date fields' '
 	git for-each-ref --format="%(authordate:short)" refs/heads &&
 	git for-each-ref --format="%(authordate:local)" refs/heads &&
 	git for-each-ref --format="%(authordate:iso8601)" refs/heads &&
-	git for-each-ref --format="%(authordate:rfc2822)" refs/heads
+	git for-each-ref --format="%(authordate:rfc2822)" refs/heads &&
+	git for-each-ref --format="%(authordate:local_original)" refs/heads
 '
 
 test_expect_success 'Check invalid format specifiers are errors' '
@@ -211,6 +212,18 @@ test_expect_success 'Check format "rfc2822" date fields output' '
 '
 
 cat >expected <<\EOF
+'refs/heads/master' 'Mon 2006-07-03 15:18:43 (Mon 17:18:43 +0200)' 'Mon 2006-07-03 15:18:44 (Mon 17:18:44 +0200)'
+'refs/tags/testtag' 'Mon 2006-07-03 15:18:45 (Mon 17:18:45 +0200)'
+EOF
+
+test_expect_success 'Check format "local_original" date fields output' '
+	f=local_original &&
+	(git for-each-ref --shell --format="%(refname) %(committerdate:$f) %(authordate:$f)" refs/heads &&
+	git for-each-ref --shell --format="%(refname) %(taggerdate:$f)" refs/tags) >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
 refs/heads/master
 refs/remotes/origin/master
 refs/tags/testtag
-- 
1.6.4.1

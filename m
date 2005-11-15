From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git's rev-parse.c function show_datestring presumes gnu date
Date: Mon, 14 Nov 2005 19:29:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511141857121.3263@g5.osdl.org>
References: <86zmo6vnnj.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0511141504530.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 04:32:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbrWx-0001Ep-Jv
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 04:30:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVKODao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 22:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbVKODao
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 22:30:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbVKODan (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 22:30:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAF3T7nO018630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Nov 2005 19:29:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAF3T6g7013709;
	Mon, 14 Nov 2005 19:29:07 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511141504530.3263@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11874>



On Mon, 14 Nov 2005, Linus Torvalds wrote:
> 
> It shouldn't be all that difficult to do some trivial cases (gnu date 
> handles totally insane things, we could easily do with just a simpler 
> thing). 

Ok. This is the insane patch to do this.

It really isn't very careful, and the reason I call it "approxidate()" 
will become obvious when you look at the code. It is very liberal in what 
it accepts, to the point where sometimes the results may not make a whole 
lot of sense.

It accepts "last week" as a date string, by virtue of "last" parsing as 
the number 1, and it totally ignoring superfluous fluff like "ago", so 
"last week" ends up being exactly the same thing as "1 week ago". Fine so 
far.

It has strange side effects: "last december" will actually parse as "Dec 
1", which actually _does_ turn out right, because it will then notice that 
it's not December yet, so it will decide that you must be talking about a 
date last year. So it actually gets it right, but it's kind of for the 
"wrong" reasons.

It also accepts the numbers 1..10 in string format ("one" .. "ten"), so 
you can do "ten weeks ago" or "ten hours ago" and it will do the right 
thing.

But it will do some really strange thigns too: the string "this will last 
forever", will not recognize anyting but "last", which is recognized as 
"1", which since it doesn't understand anything else it will think is the 
day of the month. So if you do

	gitk --since="this will last forever"

the date will actually parse as the first day of the current month.

And it will parse the string "now" as "now", but only because it doesn't 
understand it at all, and it makes everything relative to "now".

Similarly, it doesn't actually parse the "ago" or "from now", so "2 weeks 
ago" is exactly the same as "2 weeks from now". It's the current date 
minus 14 days.

But hey, it's probably better (and certainly faster) than depending on GNU 
date. So now you can portably do things like

	gitk --since="two weeks and three days ago"
	git log --since="July 5"
	git-whatchanged --since="10 hours ago"
	git log --since="last october"

and it will actually do exactly what you thought it would do (I think). It 
will count 17 days backwards, and it will do so even if you don't have GNU 
date installed.

(I don't do "last monday" or similar yet, but I can extend it to that too 
if people want).

It was kind of fun trying to write code that uses such totally relaxed 
"understanding" of dates yet tries to get it right for the trivial cases. 
The result should be mixed with a few strange preprocessor tricks, and be 
submitted for the IOCCC ;)

Feel free to try it out, and see how many strange dates it gets right. Or 
wrong.

And if you find some interesting (and valid - not "interesting" as in 
"strange", but "interesting" as in "I'd be interested in actually doing 
this) thing it gets wrong - usually by not understanding it and silently 
just doing some strange things - please holler.

Now, as usual this certainly hasn't been getting a lot of testing. But my 
code always works, no?

		Linus

----
diff --git a/cache.h b/cache.h
index 677c6ac..dcfee1e 100644
--- a/cache.h
+++ b/cache.h
@@ -257,6 +257,7 @@ extern void *read_object_with_reference(
 const char *show_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
+unsigned long approxidate(const char *);
 
 extern int setup_ident(void);
 extern char *get_ident(const char *name, const char *email, const char *date_str);
diff --git a/date.c b/date.c
index 63f5a09..73c063b 100644
--- a/date.c
+++ b/date.c
@@ -5,6 +5,7 @@
  */
 
 #include <time.h>
+#include <sys/time.h>
 
 #include "cache.h"
 
@@ -460,3 +461,126 @@ void datestamp(char *buf, int bufsize)
 
 	date_string(now, offset, buf, bufsize);
 }
+
+static void update_tm(struct tm *tm, unsigned long sec)
+{
+	time_t n = mktime(tm) - sec;
+	localtime_r(&n, tm);
+}
+
+static const char *number_name[] = {
+	"zero", "one", "two", "three", "four",
+	"five", "six", "seven", "eight", "nine", "ten",
+};
+
+static struct typelen {
+	const char *type;
+	int length;
+} typelen[] = {
+	{ "seconds", 1 },
+	{ "minutes", 60 },
+	{ "hours", 60*60 },
+	{ "days", 24*60*60 },
+	{ "weeks", 7*24*60*60 },
+	{ NULL }
+};	
+
+static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
+{
+	struct typelen *tl;
+	const char *end = date;
+	int n = 1, i;
+
+	while (isalpha(*++end))
+		n++;
+
+	for (i = 0; i < 12; i++) {
+		int match = match_string(date, month_names[i]);
+		if (match >= 3) {
+			tm->tm_mon = i;
+			return end;
+		}
+	}
+
+	if (match_string(date, "yesterday") > 8) {
+		update_tm(tm, 24*60*60);
+		return end;
+	}
+
+	if (!*num) {
+		for (i = 1; i < 11; i++) {
+			int len = strlen(number_name[i]);
+			if (match_string(date, number_name[i]) == len) {
+				*num = i;
+				return end;
+			}
+		}
+		if (match_string(date, "last") == 4)
+			*num = 1;
+		return end;
+	}
+
+	tl = typelen;
+	while (tl->type) {
+		int len = strlen(tl->type);
+		if (match_string(date, tl->type) >= len-1) {
+			update_tm(tm, tl->length * *num);
+			*num = 0;
+			return end;
+		}
+		tl++;
+	}
+
+	if (match_string(date, "months") >= 5) {
+		int n = tm->tm_mon - *num;
+		*num = 0;
+		while (n < 0) {
+			n += 12;
+			tm->tm_year--;
+		}
+		tm->tm_mon = n;
+		return end;
+	}
+
+	if (match_string(date, "years") >= 4) {
+		tm->tm_year -= *num;
+		*num = 0;
+		return end;
+	}
+
+	return end;
+}
+
+unsigned long approxidate(const char *date)
+{
+	int number = 0;
+	struct tm tm, now;
+	struct timeval tv;
+	char buffer[50];
+
+	if (parse_date(date, buffer, sizeof(buffer)) > 0)
+		return strtoul(buffer, NULL, 10);
+
+	gettimeofday(&tv, NULL);
+	localtime_r(&tv.tv_sec, &tm);
+	now = tm;
+	for (;;) {
+		unsigned char c = *date;
+		if (!c)
+			break;
+		date++;
+		if (isdigit(c)) {
+			char *end;
+			number = strtoul(date-1, &end, 10);
+			date = end;
+			continue;
+		}
+		if (isalpha(c))
+			date = approxidate_alpha(date-1, &tm, &number);
+	}
+	if (number > 0 && number < 32)
+		tm.tm_mday = number;
+	if (tm.tm_mon > now.tm_mon)
+		tm.tm_year--;
+	return mktime(&tm);
+}
diff --git a/rev-parse.c b/rev-parse.c
index 5a98982..bb4949a 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -131,25 +131,12 @@ static int show_reference(const char *re
 
 static void show_datestring(const char *flag, const char *datestr)
 {
-	FILE *date;
 	static char buffer[100];
-	static char cmd[1000];
-	int len;
 
 	/* date handling requires both flags and revs */
 	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
 		return;
-	len = strlen(flag);
-	memcpy(buffer, flag, len);
-
-	snprintf(cmd, sizeof(cmd), "date --date=%s +%%s", sq_quote(datestr));
-	date = popen(cmd, "r");
-	if (!date || !fgets(buffer + len, sizeof(buffer) - len, date))
-		die("git-rev-list: bad date string");
-	pclose(date);
-	len = strlen(buffer);
-	if (buffer[len-1] == '\n')
-		buffer[--len] = 0;
+	snprintf(buffer, sizeof(buffer), "%s%lu", flag, approxidate(datestr));
 	show(buffer);
 }
 

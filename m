From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 08:56:40 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511180842480.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
 <Pine.LNX.4.64.0511171520390.13959@g5.osdl.org> <20051118121210.GA19714@abridgegame.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 18:55:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdAS3-0008ME-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 18:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbVKRQ4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 11:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVKRQ4q
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 11:56:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37332 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbVKRQ4p (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 11:56:45 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIGufnO017228
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 08:56:42 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIGueRv018653;
	Fri, 18 Nov 2005 08:56:41 -0800
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20051118121210.GA19714@abridgegame.org>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12241>



On Fri, 18 Nov 2005, David Roundy wrote:
> 
> Don't forget "high noon"!  (and perhaps "tea time"?)  :)

Done.

    [torvalds@g5 git]$ ./test-date "now" "midnight" "high noon" "tea-time"
    now -> bad -> Wed Dec 31 16:00:00 1969
    now -> Fri Nov 18 08:50:54 2005

    midnight -> bad -> Wed Dec 31 16:00:00 1969
    midnight -> Fri Nov 18 00:00:00 2005

    high noon -> bad -> Wed Dec 31 16:00:00 1969
    high noon -> Thu Nov 17 12:00:00 2005

    tea-time -> bad -> Wed Dec 31 16:00:00 1969
    tea-time -> Thu Nov 17 17:00:00 2005

Thanks for pointing out tea-time.

This is also written to easily extended to allow people to add their own 
important dates like Christmas and their own birthdays.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/date.c b/date.c
index d2a67cc..3e11500 100644
--- a/date.c
+++ b/date.c
@@ -468,12 +468,52 @@ static void update_tm(struct tm *tm, uns
 	localtime_r(&n, tm);
 }
 
+static void date_yesterday(struct tm *tm, int *num)
+{
+	update_tm(tm, 24*60*60);
+}
+
+static void date_time(struct tm *tm, int hour)
+{
+	if (tm->tm_hour < hour)
+		date_yesterday(tm, NULL);
+	tm->tm_hour = hour;
+	tm->tm_min = 0;
+	tm->tm_sec = 0;
+}
+
+static void date_midnight(struct tm *tm, int *num)
+{
+	date_time(tm, 0);
+}
+
+static void date_noon(struct tm *tm, int *num)
+{
+	date_time(tm, 12);
+}
+
+static void date_tea(struct tm *tm, int *num)
+{
+	date_time(tm, 17);
+}
+
+static const struct special {
+	const char *name;
+	void (*fn)(struct tm *, int *);
+} special[] = {
+	{ "yesterday", date_yesterday },
+	{ "noon", date_noon },
+	{ "midnight", date_midnight },
+	{ "tea", date_tea },
+	{ NULL }
+};
+
 static const char *number_name[] = {
 	"zero", "one", "two", "three", "four",
 	"five", "six", "seven", "eight", "nine", "ten",
 };
 
-static struct typelen {
+static const struct typelen {
 	const char *type;
 	int length;
 } typelen[] = {
@@ -487,7 +527,8 @@ static struct typelen {
 
 static const char *approxidate_alpha(const char *date, struct tm *tm, int *num)
 {
-	struct typelen *tl;
+	const struct typelen *tl;
+	const struct special *s;
 	const char *end = date;
 	int n = 1, i;
 
@@ -502,9 +543,12 @@ static const char *approxidate_alpha(con
 		}
 	}
 
-	if (match_string(date, "yesterday") > 8) {
-		update_tm(tm, 24*60*60);
-		return end;
+	for (s = special; s->name; s++) {
+		int len = strlen(s->name);
+		if (match_string(date, s->name) == len) {
+			s->fn(tm, num);
+			return end;
+		}
 	}
 
 	if (!*num) {

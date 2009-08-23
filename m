From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Further 'approxidate' improvements
Date: Sat, 22 Aug 2009 18:11:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908221759420.3158@localhost.localdomain>
References: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 03:12:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf1cs-0007bC-Al
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 03:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933419AbZHWBLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 21:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933406AbZHWBLq
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 21:11:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33667 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933389AbZHWBLp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 21:11:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7N1BiP0015855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 22 Aug 2009 18:11:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7N1Bi6p002820;
	Sat, 22 Aug 2009 18:11:44 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0908221438450.3158@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126828>


The previous patch to improve approxidate got us to the point that a lot 
of the remaining annoyances were due to the 'strict' date handling running 
first, and deciding that it got a good enough date that the approximate 
date routines were never even invoked.

For example, using a date string like

	6AM, June 7, 2009

the strict date logic would be perfectly happy with the "June 7, 2009" 
part, and ignore the 6AM part that it didn't understand - resulting in the 
information getting dropped on the floor:

	6AM, June 7, 2009 -> Sat Jun 6 00:00:00 2009

and the date being calculated as if it was midnight, and the '6AM' having 
confused the date routines into thinking about '6 June' rather than 'June 
7' at 6AM (ie notice how the _day_ was wrong due to this, not just the 
time).

So this makes the strict date routines a bit stricter, and requires that 
not just the date, but also the time, has actually been parsed. With that 
fix, and trivial extension of the approxidate routines, git now properly 
parses the date as

	6AM, June 7, 2009 -> Sun Jun  7 06:00:00 2009

without dropping the fuzzy time ("6AM" or "noon" or any of the other 
non-strict time formats) on the floor.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
On Sat, 22 Aug 2009, Linus Torvalds wrote:
> 
> There are other oddnesses. This does not fix them all, but I think it 
> makes for fewer _really_ perplexing cases. At least now we have
> 
> 	Jun 6, 5AM -> Sat Jun  6 05:00:00 2009
> 	5AM, Jun 6 -> Sat Jun  6 05:00:00 2009
> 
> which makes me happier. I can still point to cases that don't work as 
> well, but those are separate issues.

This gets rid of the remaining "obviously bogus" issues with parsing of 
fuzzy dates. I'm sure there are other issues still remaining, but now I 
can't come up with any trivial cases any more without having clear 
garbage in the string. 

So trying to date-parse nonsensical crud still gives odd results:

	I ate six hot-dogs in June -> Sat Jun  6 18:09:26 2009

because it parses "six" and "June" and then puts it together as a date, 
and then adds the current time (and year) and is happy.

But parsing random things amusingly is a _feature_. Misparsing something 
that makes sense as a date is a bug.

 date.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/date.c b/date.c
index 51c6461..1de1845 100644
--- a/date.c
+++ b/date.c
@@ -24,6 +24,8 @@ time_t tm_to_time_t(const struct tm *tm)
 		return -1;
 	if (month < 2 || (year + 2) % 4)
 		day--;
+	if (tm->tm_hour < 0 || tm->tm_min < 0 || tm->tm_sec < 0)
+		return -1;
 	return (year * 365 + (year + 1) / 4 + mdays[month] + day) * 24*60*60UL +
 		tm->tm_hour * 60*60 + tm->tm_min * 60 + tm->tm_sec;
 }
@@ -425,13 +427,19 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 	return end - date;
 }
 
-/* Have we filled in any part of the time/date yet? */
+/*
+ * Have we filled in any part of the time/date yet?
+ * We just do a binary 'and' to see if the sign bit
+ * is set in all the values.
+ */
 static inline int nodate(struct tm *tm)
 {
-	return tm->tm_year < 0 &&
-		tm->tm_mon < 0 &&
-		tm->tm_mday < 0 &&
-		!(tm->tm_hour | tm->tm_min | tm->tm_sec);
+	return (tm->tm_year &
+		tm->tm_mon &
+		tm->tm_mday &
+		tm->tm_hour &
+		tm->tm_min &
+		tm->tm_sec) < 0;
 }
 
 /*
@@ -580,6 +588,9 @@ int parse_date(const char *date, char *result, int maxlen)
 	tm.tm_mon = -1;
 	tm.tm_mday = -1;
 	tm.tm_isdst = -1;
+	tm.tm_hour = -1;
+	tm.tm_min = -1;
+	tm.tm_sec = -1;
 	offset = -1;
 	tm_gmt = 0;
 
@@ -893,6 +904,17 @@ static void pending_number(struct tm *tm, int *num)
 		*num = 0;
 		if (tm->tm_mday < 0 && number < 32)
 			tm->tm_mday = number;
+		else if (tm->tm_mon < 0 && number < 13)
+			tm->tm_mon = number-1;
+		else if (tm->tm_year < 0) {
+			if (number > 1969 && number < 2100)
+				tm->tm_year = number - 1900;
+			else if (number > 69 && number < 100)
+				tm->tm_year = number;
+			else if (number < 38)
+				tm->tm_year = 100 + number;
+			/* We screw up for number = 00 ? */
+		}
 	}
 }
 

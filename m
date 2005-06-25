From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/9] fix date parsing for GIT raw commit timestamp format.
Date: Sat, 25 Jun 2005 02:21:16 -0700
Message-ID: <7vfyv64ws3.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:14:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6kX-0001N4-Km
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVFYJV1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbVFYJV1
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:21:27 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:24971 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262637AbVFYJVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:21:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625092116.ILYN19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:21:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 25 Jun 2005 02:16:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Usually all of the match_xxx routines in date.c fill tm
structure assuming that the parsed string talks about local
time, and parse_date routine compensates for it by adjusting the
value with tz offset parsed out separately.  However, this logic
does not work well when we feed GIT raw commit timestamp to it,
because what match_digits gets is already in GMT.

A good testcase is:

    $ make test-date
    $ ./test-date 'Fri Jun 24 16:55:27 2005 -0700' '1119657327 -0700'

These two timestamps represent the same time, but the second one
without the fix this commit introduces gives you 7 hours off.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 date.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

dff2db477c3d450350a0dfdce4fa3f9543206b86
diff --git a/date.c b/date.c
--- a/date.c
+++ b/date.c
@@ -270,7 +270,7 @@ static int match_multi_number(unsigned l
 /*
  * We've seen a digit. Time? Year? Date? 
  */
-static int match_digit(char *date, struct tm *tm, int *offset)
+static int match_digit(char *date, struct tm *tm, int *offset, int *tm_gmt)
 {
 	int n;
 	char *end;
@@ -283,8 +283,10 @@ static int match_digit(char *date, struc
 	 */
 	if (num > 946684800) {
 		time_t time = num;
-		if (gmtime_r(&time, tm))
+		if (gmtime_r(&time, tm)) {
+			*tm_gmt = 1;
 			return end - date;
+		}
 	}
 
 	/*
@@ -389,7 +391,7 @@ static int match_tz(char *date, int *off
 void parse_date(char *date, char *result, int maxlen)
 {
 	struct tm tm;
-	int offset, sign;
+	int offset, sign, tm_gmt;
 	time_t then;
 
 	memset(&tm, 0, sizeof(tm));
@@ -398,6 +400,7 @@ void parse_date(char *date, char *result
 	tm.tm_mday = -1;
 	tm.tm_isdst = -1;
 	offset = -1;
+	tm_gmt = 0;
 
 	for (;;) {
 		int match = 0;
@@ -410,7 +413,7 @@ void parse_date(char *date, char *result
 		if (isalpha(c))
 			match = match_alpha(date, &tm, &offset);
 		else if (isdigit(c))
-			match = match_digit(date, &tm, &offset);
+			match = match_digit(date, &tm, &offset, &tm_gmt);
 		else if ((c == '-' || c == '+') && isdigit(date[1]))
 			match = match_tz(date, &offset);
 
@@ -430,7 +433,8 @@ void parse_date(char *date, char *result
 	if (then == -1)
 		return;
 
-	then -= offset * 60;
+	if (!tm_gmt)
+		then -= offset * 60;
 
 	sign = '+';
 	if (offset < 0) {
------------


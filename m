From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 16:17:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org>
References: <20080816205325.GD10729@mrq1.org> <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 01:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUV30-00017T-Ig
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 01:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYHPXR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbYHPXR7
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 19:17:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45875 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766AbYHPXR6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Aug 2008 19:17:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7GNHpXg004497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Aug 2008 16:17:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7GNHoZv009636;
	Sat, 16 Aug 2008 16:17:50 -0700
In-Reply-To: <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.925 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92560>



On Sat, 16 Aug 2008, Linus Torvalds wrote:
> 
> Junio: we might also make the code that actually parses the 
> seconds-per-epoch thing only trigger if we haven't already seen a date (ie 
> it might check for "tm->tm_year < 0" etc before accepting that seconds 
> format).

Here's a slightly expanded version of the previous patch, which will 
ignore those big integer if it has already seen any human-readable date 
format (either any time except 0:00:00 or any normal date).

It includes the fractional second parsing code from the previous patch 
too, since that's an independent thing and makes sense regardless.

Junio, your call. But this one gets the date right for strings that just 
randomly have some big number in them, ie

	[torvalds@nehalem git]$ ./test-date "17:25:54 917476713 2008-06-04 -0700"
	17:25:54 917476713 2008-06-04 -0700 -> 1212625554 -0700 -> Wed Jun  4 17:25:54 2008
	17:25:54 917476713 2008-06-04 -0700 -> Wed Jun  4 17:25:54 2008

because it will now see that "nodate()" is not true. I think it's a good 
idea to only accept the epoch format when there hasn't been any other time 
format visible.

			Linus

---
 date.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 35a5257..e11e78e 100644
--- a/date.c
+++ b/date.c
@@ -363,6 +363,11 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 			tm->tm_hour = num;
 			tm->tm_min = num2;
 			tm->tm_sec = num3;
+
+			/* Ignore any possible fractional seconds */
+			if (*end == '.')
+				(void) strtol(end+1, &end, 10);
+
 			break;
 		}
 		return 0;
@@ -402,6 +407,15 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 	return end - date;
 }
 
+/* Have we filled in any part of the time/date yet? */
+static inline int nodate(struct tm *tm)
+{
+	return tm->tm_year < 0 &&
+		tm->tm_mon < 0 &&
+		tm->tm_mday < 0 &&
+		!(tm->tm_hour | tm->tm_min | tm->tm_sec);
+}
+
 /*
  * We've seen a digit. Time? Year? Date?
  */
@@ -418,7 +432,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	 * more than 8 digits. This is because we don't want to rule out
 	 * numbers like 20070606 as a YYYYMMDD date.
 	 */
-	if (num >= 100000000) {
+	if (num >= 100000000 && nodate(tm)) {
 		time_t time = num;
 		if (gmtime_r(&time, tm)) {
 			*tm_gmt = 1;

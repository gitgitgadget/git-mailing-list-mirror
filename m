From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 21:25:40 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808162054050.3324@nehalem.linux-foundation.org>
References: <20080816205325.GD10729@mrq1.org> <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org> <7vr68obbpd.fsf@gitster.siamese.dyndns.org>
 <7vk5egbaft.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 06:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUZr6-0000ny-0a
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 06:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbYHQEZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 00:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbYHQEZx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 00:25:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45440 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124AbYHQEZv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 00:25:51 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7H4PfNX018312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 16 Aug 2008 21:25:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7H4PeHM019802;
	Sat, 16 Aug 2008 21:25:40 -0700
In-Reply-To: <7vk5egbaft.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92571>



On Sat, 16 Aug 2008, Junio C Hamano wrote:
> 
> Perhaps like this.

So see in the previous email why I don't think "ignore nanoseconds" is 
really any better than "igore all fractions".

That said:

> @@ -363,6 +363,11 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
>  			tm->tm_hour = num;
>  			tm->tm_min = num2;
>  			tm->tm_sec = num3;
> +			if (*end == '.') {
> +				num = strspn(end+1, "0123456789");
> +				if (9 <= num)
> +					end += num + 1;

Apart from the "compare with 9", your patch is _much_ better than mine. 
Using "strtoul()" was a horrible horrible thing to do, since it will match 
not just '+' and '-' but also spaces etc.

So my patch was definitely crap, and yours is better, but I don't much 
like that expectations of 9+ digits. After all, if we only worry about 9+ 
digits of a big number, then the "nodate()" logic already takes care of 
much of it.

So here's a much better version, I think.

The rules are:

 - valid days of month/mday are always single or double digits.

 - valid years are either two or four digits

   No, we don't support the year 600 _anyway_, since our encoding is based 
   on the UNIX epoch, and the day we worry about the year 10,000 is far 
   away and we can raise the limit to five digits when we get closer.

 - Other numbers (eg "600 days ago") can have any number of digits, but 
   they cannot start with a zero. Again, the only exception is for 
   two-digit numbers, since that is fairly common for dates ("Dec 01" is 
   not unheard of)

So that means that any milli- or micro-second would be thrown out just 
because the number of digits shows that it cannot be an interesting date.

That would make the patch look something like this...

[ Those four deleted lines I removed just because the cases had already 
  been handled, eg the ">1900" case was already handled when we checked 
  for a four-digit year, and the >70 case was handled when we checked for 
  exactly two digits ]

Hmm?

		Linus

---
 date.c |   26 ++++++++++++++++++++------
 1 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 35a5257..950b88f 100644
--- a/date.c
+++ b/date.c
@@ -402,6 +402,15 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
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
@@ -418,7 +427,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	 * more than 8 digits. This is because we don't want to rule out
 	 * numbers like 20070606 as a YYYYMMDD date.
 	 */
-	if (num >= 100000000) {
+	if (num >= 100000000 && nodate(tm)) {
 		time_t time = num;
 		if (gmtime_r(&time, tm)) {
 			*tm_gmt = 1;
@@ -463,6 +472,13 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	}
 
 	/*
+	 * Ignore lots of numerals. We took care of 4-digit years above.
+	 * Days or months must be one or two digits.
+	 */
+	if (n > 2)
+		return n;
+
+	/*
 	 * NOTE! We will give precedence to day-of-month over month or
 	 * year numbers in the 1-12 range. So 05 is always "mday 5",
 	 * unless we already have a mday..
@@ -488,10 +504,6 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 
 	if (num > 0 && num < 32) {
 		tm->tm_mday = num;
-	} else if (num > 1900) {
-		tm->tm_year = num - 1900;
-	} else if (num > 70) {
-		tm->tm_year = num;
 	} else if (num > 0 && num < 13) {
 		tm->tm_mon = num-1;
 	}
@@ -823,7 +835,9 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num)
 		}
 	}
 
-	*num = number;
+	/* Accept zero-padding only for small numbers ("Dec 02", never "Dec 0002") */
+	if (date[0] != '0' || end - date <= 2)
+		*num = number;
 	return end;
 }
 

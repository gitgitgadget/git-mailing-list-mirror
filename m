From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 20:13:42 -0700
Message-ID: <7vk5egbaft.fsf@gitster.siamese.dyndns.org>
References: <20080816205325.GD10729@mrq1.org>
 <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org>
 <7vr68obbpd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 05:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUYjK-0006eq-1v
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 05:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbYHQDNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 23:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbYHQDNz
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 23:13:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYHQDNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 23:13:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 032EF5C606;
	Sat, 16 Aug 2008 23:13:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D648F5C605; Sat, 16 Aug 2008 23:13:48 -0400 (EDT)
In-Reply-To: <7vr68obbpd.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 16 Aug 2008 19:46:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85218E02-6C0A-11DD-BA69-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92565>

Junio C Hamano <gitster@pobox.com> writes:

> You've taught people here and on the kernel list that the "date" can use
> any non-digit-non-word as a word separator, and "git log --since 2.days"
> is something you often do.
>
> People who followed that advice would have gotten used to this already, e.g.
>
>    $ git reflog delete master@{07.04.2005.15:15:00.-0700}
>
> should not be broken.
>
> I think your first hunk needs to distinguish between "very-long-precision
> posint" (in which case we ignore because it is likely to be nanoseconds
> fraction) and others.

Perhaps like this.

-- >8 --
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Aug 2008 16:17:50 -0700
Subject: [PATCH] date parsing: do not mistake fractional nanosecond that follow HH:MM:SS

Some program output nanosecond fractional after the usual HH:MM:SS format.
If the fraction is large enough, it can be interpreted as the seconds
since epoch, and can overwrite the already parsed date/time.

We also make sure we use the seconds since epoch interpretation only when
we have not seen any other date/time data in the input yet.

Note that we cannot unconditionally drop anything that follows '.'; people
have been taught that we allow '.' as a word separator and have got used
to formats like "--since 2.days" and "2008.08.16.01:23:45.-0700" to work.

Noticed-by: Hermann Gausterer
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 35a5257..b2c5a8b 100644
--- a/date.c
+++ b/date.c
@@ -363,6 +363,11 @@ static int match_multi_number(unsigned long num, char c, const char *date, char
 			tm->tm_hour = num;
 			tm->tm_min = num2;
 			tm->tm_sec = num3;
+			if (*end == '.') {
+				num = strspn(end+1, "0123456789");
+				if (9 <= num)
+					end += num + 1;
+			}
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
-- 
1.6.0.rc3.17.gc14c8

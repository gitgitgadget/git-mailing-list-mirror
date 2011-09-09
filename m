From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] date.c: Support iso8601 timezone formats
Date: Fri, 09 Sep 2011 10:04:05 -0700
Message-ID: <7vd3f9ve9m.fsf@alter.siamese.dyndns.org>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
 <1315563033-9476-1-git-send-email-lihaitao@gmail.com>
 <7vhb4lvflb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Haitao Li <lihaitao@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 19:04:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R24Uz-0004yE-BU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 19:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759500Ab1IIREK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 13:04:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759390Ab1IIREJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 13:04:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95E2E536B;
	Fri,  9 Sep 2011 13:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n379NlhOssZuiFtG9XGBT0KC6Co=; b=M63T35
	LZ5fLKOoBxEfSvHUS80Caelp7JD5iicAIPha426UAMuc/LZVkykpPIM1rJC7JSO5
	oWX5EfAAJCMKXVZmlP/jVNZoykAZSngC5fCllqVqcwHXgm5WkCYXC1LSUM3cyyuB
	ED6LCSP2D90iqIH9nWdCKuqCuwR+ppHL+Xse0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKoqPeeFPu1QEZr5zhUcEwBHS69UyZTU
	uueBRjiK9iRztLUf5XvX7cckU0zp+IxRLhXTnDc7mdzvaYbgD1J3o/4ryaCGf67t
	gMr/M1x/96gSM7hqAuIa2v0jfA5Pj65Q/9TttBo9ga75bd+a+VWVs57zL33X+7DC
	ox+uxrV2wPA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C30D536A;
	Fri,  9 Sep 2011 13:04:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1BAB5368; Fri,  9 Sep 2011
 13:04:06 -0400 (EDT)
In-Reply-To: <7vhb4lvflb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Sep 2011 09:35:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA6B0C24-DB05-11E0-A3DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181094>

Junio C Hamano <gitster@pobox.com> writes:

> Haitao Li <lihaitao@gmail.com> writes:
>
>> Timezone designators including additional separator (`:`) are ignored.
>> Actually zone designators in below formats are all valid according to
>> ISO8601:2004, section 4.3.2:
>>     [+-]hh, [+-]hhmm, [+-]hh:mm
>
> Thanks for a re-roll.
>
>> This patch teaches git recognizing zone designators with hours and
>> minutes separated by colon, or minutes are empty.
>
> The last sentence above makes it sound as if you are accepting
>
> 	"2011-09-17 12:34:56 +09:"
>
> but I suspect that is not what you intend to allow.  Perhaps "we allowed
> hh and hhmm and this teaches Git to recognize hh:mm format as well"?

Also, I do not quite understand why the match_tz() logic needs to be that
long.

Wouldn't something like this patch (on top of yours) easier to follow?

 date.c |   50 +++++++++++++++++++++-----------------------------
 1 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/date.c b/date.c
index f8722c1..6079b1a 100644
--- a/date.c
+++ b/date.c
@@ -551,44 +551,36 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 
 static int match_tz(const char *date, int *offp)
 {
+	int min;
 	char *end;
-	int offset = strtoul(date+1, &end, 10);
-	int min, hour;
-	int n = end - date - 1;
+	int hour = strtoul(date + 1, &end, 10);
+	int n = end - (date + 1);
 
-	/*
-	 * ISO8601:2004(E) allows time zone designator been separated
-	 * by a clone in the extended format
-	 */
-	if (*end == ':') {
-		if (isdigit(end[1])) {
-			hour = offset;
-			min = strtoul(end+1, &end, 10);
-		} else {
-			/* Mark as invalid */
-			n = -1;
-		}
-	} else {
-		if (n == 1 || n == 2) {
-			/* Only hours specified */
-			hour = offset;
-			min = 0;
-		} else {
-			hour = offset / 100;
-			min = offset % 100;
-		}
+	if (n == 4) {
+		/* hhmm */
+		min = hour % 100;
+		hour = hour / 100;
+	} else if (n != 2) {
+		min = 99; /* random crap */
+	} else if (*end == ':') {
+		/* hh:mm? */
+		min = strtoul(end + 1, &end, 10);
+		if (end - (date + 1) != 5)
+			min = 99; /* random crap */
 	}
 
 	/*
-	 * Don't accept any random crap.. We might want to check that
-	 * the minutes are divisible by 15 or something too. (Offset of
+	 * Don't accept any random crap. Even though some places have
+	 * offset larger than 12 hours (e.g. Pacific/Kiritimati is at
+	 * UTC+14), there is something wrong if hour part is much
+	 * larger than that. We might also want to check that the
+	 * minutes are divisible by 15 or something too. (Offset of
 	 * Kathmandu, Nepal is UTC+5:45)
 	 */
-	if (n > 0 && min < 60) {
-		offset = hour*60+min;
+	if (min < 60 && hour < 24) {
+		int offset = hour * 60 + min;
 		if (*date == '-')
 			offset = -offset;
-
 		*offp = offset;
 	}
 	return end - date;

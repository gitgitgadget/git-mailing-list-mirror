From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] parse_date_basic(): let the system handle DST conversion
Date: Wed, 15 Apr 2015 09:24:46 -0700
Message-ID: <xmqq618xmka9.fsf_-_@gitster.dls.corp.google.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	<xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
	<20150415072223.GA1389@flurp.local>
	<xmqqk2xdmp0e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 18:25:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQ7Z-0006Id-DW
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 18:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756356AbbDOQYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 12:24:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756341AbbDOQYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 12:24:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3B61473D1;
	Wed, 15 Apr 2015 12:24:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=97aV/tKR4FsqXKxtJzSGWJXqglA=; b=tnKkXl
	A3+WkbkJ3mxCedwW+k/YbdoP0myU2rMgobZuPYDOMuzjaDR1eJgdP1opCwx+In4P
	S3UJ3zifXKGykcS5IEEz7mqw0FyL1skuqHcpcpxFSrV93WrXo8wj8z0vGIqppZYi
	12FhVhzn6VAq+7hUlSmxAaObx9p3uEJmQxOvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngK1V42LV6hGiBAkNAabSUm/dUP6YhRC
	+9B/0HFrQD71XRzJBWYQetmGM9ulzVVHpF1UjQKBdc9IHifHky4/0LEfOF0HvLW4
	n4XU9MWIRZcNmeALbzgLld4e0PfFLMGWneCShwBosemDm27nZAZTXYnWO7DmbSnI
	SaHRmBE1Zdw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD9FA473CF;
	Wed, 15 Apr 2015 12:24:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD0F8473A8;
	Wed, 15 Apr 2015 12:24:47 -0400 (EDT)
In-Reply-To: <xmqqk2xdmp0e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Apr 2015 07:42:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF0D55D0-E38B-11E4-B549-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267211>

The function parses the input to compute the broken-down time in
"struct tm", and the GMT timezone offset.  If the timezone offset
does not exist in the input, the broken-down time is turned into the
number of seconds since epoch both in the current timezone and in
GMT and the offset is computed as their difference.

However, we forgot to make sure tm.tm_isdst is set to -1 (i.e. let
the system figure out if DST is in effect in the current timezone
when turning the broken-down time to the number of seconds since
epoch); it is done so at the beginning of the function, but a call
to match_digit() in the function can lead to a call to gmtime_r() to
clobber the field.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Diagnosed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 01fd73f..8ad6cef 100644
--- a/date.c
+++ b/date.c
@@ -700,7 +700,11 @@ int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 		return -1;
 
 	if (*offset == -1) {
-		time_t temp_time = mktime(&tm);
+		time_t temp_time;
+
+		/* gmtime_r() in match_digit() may have clobbered it */
+		tm.tm_isdst = -1;
+		temp_time = mktime(&tm);
 		if ((time_t)*timestamp > temp_time) {
 			*offset = ((time_t)*timestamp - temp_time) / 60;
 		} else {
-- 
2.4.0-rc2-165-g862640d

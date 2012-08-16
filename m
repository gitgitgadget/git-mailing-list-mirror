From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] date: show relative dates in the future
Date: Thu, 16 Aug 2012 16:02:03 -0700
Message-ID: <1345158123-22189-3-git-send-email-gitster@pobox.com>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
 <1345158123-22189-1-git-send-email-gitster@pobox.com>
Cc: Tom Xue <tomxue0126@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T295Y-000867-GF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533Ab2HPXCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:02:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404Ab2HPXCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:02:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02F518A45;
	Thu, 16 Aug 2012 19:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bqai
	jF9PDP7BB67k3LcCLK0yoGM=; b=sx03Uqq5iOFK0mpZ9LbPS+POTD9e7tRPuT8L
	eAhUYvfUGo8CT7qDT9HrFSpSKgAKwPrhHw/tWcZ3zqbOrPfLKB6d2yjCt9kROx5B
	m1ifS69fBCk7wHxgHH2zrzC2+TZWWETkEw5pv1OLLvp8LFj579z4LPMFS29cZTqF
	NnYr+To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	e8YoNwp8/demZLW8ZAZHzJRpZnxBsQseLPZ+Mea+rbopzm/bbAdCmJGZUAh2K7dh
	eAkLzJNzwd5/Ndc9pW1E3XXIyLXr2Gi+gheGo2v2LmoHI4AdUmJInf5F7H22PTaH
	QUtpJILsl1XqlgOIpgzlAoGPel5GWdvD+LR9YZheTHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E480C8A44;
	Thu, 16 Aug 2012 19:02:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4865D8A42; Thu, 16 Aug 2012
 19:02:09 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc3
In-Reply-To: <1345158123-22189-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6824CE1A-E7F6-11E1-B282-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by an earlier patch on the list by Tom Xue, but I think
this is done in a much more maintainable way.

It still remains to be seen if this feature makes sense, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c          | 27 ++++++++++++++++++++++-----
 t/t0006-date.sh |  2 ++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/date.c b/date.c
index b6ff04e..f897955 100644
--- a/date.c
+++ b/date.c
@@ -166,7 +166,7 @@ void show_date_relative(unsigned long time, int tz,
 		struct { const char *s, *p; } msg_years_only;
 		struct { const char *s, *p; } msg_years_months;
 		struct { const char *s, *p; } msg_years;
-	} msg[1] = {
+	} msg[2] = {
 		{
 			{ "%lu second ago", "%lu seconds ago" },
 			{ "%lu minute ago", "%lu minutes ago" },
@@ -182,14 +182,31 @@ void show_date_relative(unsigned long time, int tz,
 				"%s, %lu months ago"
 			},
 			{ "%lu year ago", "%lu years ago" },
-		}
+		},
+		{
+			{ "%lu second in the future", "%lu seconds in the future" },
+			{ "%lu minute in the future", "%lu minutes in the future" },
+			{ "%lu hour in the future", "%lu hours in the future" },
+			{ "%lu day in the future", "%lu days in the future" },
+			{ "%lu week in the future", "%lu weeks in the future" },
+			{ "%lu month in the future", "%lu months in the future" },
+			{ "%lu year", "%lu years" },
+			{
+				/* TRANSLATORS: "%s" is "<n> years" */
+				"%s, %lu month in the future",
+				/* TRANSLATORS: "%s" is "<n> years" */
+				"%s, %lu months in the future"
+			},
+			{ "%lu year in the future", "%lu years in the future" },
+		},
 	};
 
 	if (now->tv_sec < time) {
-		strbuf_addstr(timebuf, _("in the future"));
-		return;
+		diff = time - now->tv_sec;
+		pf = 1; /* in the future */
+	} else {
+		diff = now->tv_sec - time;
 	}
-	diff = now->tv_sec - time;
 
 	switch (format_relative_date(diff, &rd)) {
 	case rd_seconds:
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 1d29810..eef932c 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -26,6 +26,8 @@ check_show 55188000 '1 year, 9 months ago'
 check_show 630000000 '20 years ago'
 check_show 31449600 '12 months ago'
 check_show 62985600 '2 years ago'
+check_show -5 '5 seconds in the future'
+check_show -55188000 '1 year, 9 months in the future'
 
 check_parse() {
 	echo "$1 -> $2" >expect
-- 
1.7.12.rc3.69.gaf0166d

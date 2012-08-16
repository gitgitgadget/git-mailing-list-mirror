From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] date: refactor the relative date logic from presentation
Date: Thu, 16 Aug 2012 16:02:02 -0700
Message-ID: <1345158123-22189-2-git-send-email-gitster@pobox.com>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
 <1345158123-22189-1-git-send-email-gitster@pobox.com>
Cc: Tom Xue <tomxue0126@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:02:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T295X-000867-TH
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab2HPXCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:02:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46172 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2HPXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:02:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B3608A40;
	Thu, 16 Aug 2012 19:02:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1XdR
	RuaWUixecm/xALneQqKetAA=; b=aZqCD2tSo8hL1gPK/kMx3VJoRlQ3CANMwM93
	2mw7N76WP9Yd6qYRFXmohH80uUiGdYuxTMXnfRsksdj0n34/9KqOIamArAsXBnOa
	5pXuqn2Kbiu3oTrM+1QMWV0ugn/uIVDVltpJfi6S68IfkI8NCesWiYgOlSiMmR9x
	QmHlZgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	VpKMbFgELMcfISEALe+4xABn42Qdyxhfx9rdTS/vRTgOoleO0Y/aGqdiTbmhUrtS
	wvWnIuWnCQdOC3xSXtOxvJWLnnS8d7ZD6TqfH17xWibr9uFZjfY2Pe+N3hmyQ3pC
	HdmGg8JgUB7t4kE/Rbb1Rlh2Fp22FcAec7liiMGWO+o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC93A8A3F;
	Thu, 16 Aug 2012 19:02:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00BF48A3B; Thu, 16 Aug 2012
 19:02:06 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc3
In-Reply-To: <1345158123-22189-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 66C6F2E6-E7F6-11E1-A953-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Separate the logic to decide which presentation (e.g. "N months") to
use based on the length of the time from the present and actual
presentation (i.e. "strbuf_addf()").  This is not strictly needed
but will make the next step easier to read.

The format strings lost N_() markings along the way; help from the
i18n folks to come up with the best and sane way to mark them up is
very much appreciated.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 date.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 127 insertions(+), 43 deletions(-)

diff --git a/date.c b/date.c
index 57331ed..b6ff04e 100644
--- a/date.c
+++ b/date.c
@@ -86,78 +86,162 @@ static int local_tzoffset(unsigned long time)
 	return offset * eastwest;
 }
 
-void show_date_relative(unsigned long time, int tz,
-			       const struct timeval *now,
-			       struct strbuf *timebuf)
+enum relative_style {
+	rd_seconds = 0, rd_minutes, rd_hours, rd_days, rd_weeks, rd_months, rd_years
+};
+
+struct relative_date {
+	int seconds;
+	int minutes;
+	int hours;
+	int days;
+	int weeks;
+	int months;
+	int years;
+};
+
+static enum relative_style format_relative_date(unsigned long diff,
+						struct relative_date *rd)
 {
-	unsigned long diff;
-	if (now->tv_sec < time) {
-		strbuf_addstr(timebuf, _("in the future"));
-		return;
-	}
-	diff = now->tv_sec - time;
+	memset(rd, 0, sizeof(*rd));
 	if (diff < 90) {
-		strbuf_addf(timebuf,
-			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
-		return;
+		rd->seconds = diff;
+		return rd_seconds;
 	}
 	/* Turn it into minutes */
 	diff = (diff + 30) / 60;
 	if (diff < 90) {
-		strbuf_addf(timebuf,
-			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
-		return;
+		rd->minutes = diff;
+		return rd_minutes;
 	}
 	/* Turn it into hours */
 	diff = (diff + 30) / 60;
 	if (diff < 36) {
-		strbuf_addf(timebuf,
-			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
-		return;
+		rd->hours = diff;
+		return rd_hours;
 	}
 	/* We deal with number of days from here on */
 	diff = (diff + 12) / 24;
 	if (diff < 14) {
-		strbuf_addf(timebuf,
-			 Q_("%lu day ago", "%lu days ago", diff), diff);
-		return;
+		rd->days = diff;
+		return rd_days;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
-		strbuf_addf(timebuf,
-			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
-			 (diff + 3) / 7);
-		return;
+		rd->weeks = (diff + 3) / 7;
+		return rd_weeks;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
-		strbuf_addf(timebuf,
-			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
-			 (diff + 15) / 30);
-		return;
+		rd->months = (diff + 15) / 30;
+		return rd_months;
 	}
 	/* Give years and months for 5 years or so */
 	if (diff < 1825) {
 		unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
-		unsigned long years = totalmonths / 12;
-		unsigned long months = totalmonths % 12;
-		if (months) {
+		rd->years = totalmonths / 12;
+		rd->months = totalmonths % 12;
+		return rd_years;
+	}
+	/* Otherwise, just years. Centuries is probably overkill. */
+	rd->years = (diff + 183) / 365;
+	return rd_years;
+}
+
+void show_date_relative(unsigned long time, int tz,
+			       const struct timeval *now,
+			       struct strbuf *timebuf)
+{
+	unsigned long diff;
+	struct relative_date rd;
+	int pf = 0; /* past or future */
+
+	struct {
+		struct { const char *s, *p; } msg_seconds;
+		struct { const char *s, *p; } msg_minutes;
+		struct { const char *s, *p; } msg_hours;
+		struct { const char *s, *p; } msg_days;
+		struct { const char *s, *p; } msg_weeks;
+		struct { const char *s, *p; } msg_months;
+		struct { const char *s, *p; } msg_years_only;
+		struct { const char *s, *p; } msg_years_months;
+		struct { const char *s, *p; } msg_years;
+	} msg[1] = {
+		{
+			{ "%lu second ago", "%lu seconds ago" },
+			{ "%lu minute ago", "%lu minutes ago" },
+			{ "%lu hour ago", "%lu hours ago" },
+			{ "%lu day ago", "%lu days ago" },
+			{ "%lu week ago", "%lu weeks ago" },
+			{ "%lu month ago", "%lu months ago" },
+			{ "%lu year", "%lu years" },
+			{
+				/* TRANSLATORS: "%s" is "<n> years" */
+				"%s, %lu month ago",
+				/* TRANSLATORS: "%s" is "<n> years" */
+				"%s, %lu months ago"
+			},
+			{ "%lu year ago", "%lu years ago" },
+		}
+	};
+
+	if (now->tv_sec < time) {
+		strbuf_addstr(timebuf, _("in the future"));
+		return;
+	}
+	diff = now->tv_sec - time;
+
+	switch (format_relative_date(diff, &rd)) {
+	case rd_seconds:
+		strbuf_addf(timebuf,
+			    Q_(msg[pf].msg_seconds.s, msg[pf].msg_seconds.p,
+			       rd.seconds), rd.seconds);
+		break;
+	case rd_minutes:
+		strbuf_addf(timebuf,
+			    Q_(msg[pf].msg_minutes.s, msg[pf].msg_minutes.p,
+			       rd.minutes), rd.minutes);
+		break;
+	case rd_hours:
+		strbuf_addf(timebuf,
+			    Q_(msg[pf].msg_hours.s, msg[pf].msg_hours.p,
+			       rd.hours), rd.hours);
+		break;
+	case rd_days:
+		strbuf_addf(timebuf,
+			    Q_(msg[pf].msg_days.s, msg[pf].msg_days.p,
+			       rd.days), rd.days);
+		break;
+	case rd_weeks:
+		strbuf_addf(timebuf,
+			    Q_(msg[pf].msg_weeks.s, msg[pf].msg_weeks.p,
+			       rd.weeks), rd.weeks);
+		break;
+	case rd_months:
+		strbuf_addf(timebuf,
+			    Q_(msg[pf].msg_months.s, msg[pf].msg_months.p,
+			       rd.months), rd.months);
+		break;
+
+	case rd_years:
+		if (rd.months) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
-			/* TRANSLATORS: "%s" is "<n> years" */
+			strbuf_addf(&sb, Q_(msg[pf].msg_years_only.s,
+					    msg[pf].msg_years_only.p,
+					    rd.years), rd.years);
 			strbuf_addf(timebuf,
-				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
-				 sb.buf, months);
+				    Q_(msg[pf].msg_years_months.s,
+				       msg[pf].msg_years_months.p,
+				       rd.months),
+				    sb.buf, rd.months);
 			strbuf_release(&sb);
-		} else
+		} else {
 			strbuf_addf(timebuf,
-				 Q_("%lu year ago", "%lu years ago", years), years);
-		return;
+				    Q_(msg[pf].msg_years.s, msg[pf].msg_years.p,
+				       rd.years), rd.years);
+		}
+		break;
 	}
-	/* Otherwise, just years. Centuries is probably overkill. */
-	strbuf_addf(timebuf,
-		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
-		 (diff + 183) / 365);
 }
 
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
-- 
1.7.12.rc3.69.gaf0166d

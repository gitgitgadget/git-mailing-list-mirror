Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482DB4691
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370479; cv=none; b=sBrRxVLJD0nzdfrbGwFJiiSXkOvVfmHBA0jl2pkskl0loX4IExoUXR9/I0phOtebYKYPPuBh/a/SC+ZAj0IOdr17cybIfnOx67z63WbIl+d8FXML5QBmbeyvcFMhqjIM/Z/931GGlNo+uGNb2sVbt5mPhPfrITcisZ5uNYeCEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370479; c=relaxed/simple;
	bh=G8NYKJfGH0cdBaUZ59wyRtyAZ4s6q9TngeNrpjTXbak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWorip1SSDMDNOQXtZNgquF/2ItNAewK8ERpmYlnD3dwS/vMC7fZzjDfnZiJ8x68bcAVNxxPhBc2JLCV1XljkgD7hH//E34B6gG/2Spsr3oeSKoJD/HwJ/4BlRuLe++BeIFJ6MzrLFnBOhJN+rIBQcnFJ3K7de90BpRusoPFheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rkXUX-0000000041S-31BM
	for git@vger.kernel.org;
	Wed, 13 Mar 2024 23:54:34 +0100
Received: from [10.20.10.233] (port=53500 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rkXUW-005u3v-1y;
	Wed, 13 Mar 2024 23:54:32 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 4A7141800FD;
	Wed, 13 Mar 2024 23:54:31 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Wed, 13 Mar 2024 23:54:31 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>,
	Michael Osipov <michael.osipov@innomotics.com>
Subject: [PATCH v3] date: make "iso-strict" conforming for the UTC timezone
Date: Wed, 13 Mar 2024 23:54:23 +0100
Message-ID: <20240313225423.11373-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <xmqqmsr169e5.fsf@gitster.g>
References: <xmqqmsr169e5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

ISO 8601-1:2020-12 specifies that a zero timezone offset must be denoted
with a "Z" suffix instead of the numeric "+00:00". Add the correponding
special case to show_date() and a new test.

Changing an established output format which might be depended on by
scripts is always problematic, but here we choose to adhere more closely
to the published standard.

Reported-by: Michael Osipov <michael.osipov@innomotics.com>
Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
Changes from v2:

- changed the rationale according to Junio's feedback

Changes from v1:

- added a comment why the change is fine
- removed the Link: trailer

 date.c          | 14 +++++++++-----
 t/t0006-date.sh |  1 +
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/date.c b/date.c
index 619ada5b2044..44cf2221d81f 100644
--- a/date.c
+++ b/date.c
@@ -342,14 +342,18 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
 	else if (mode->type == DATE_ISO8601_STRICT) {
-		char sign = (tz >= 0) ? '+' : '-';
-		tz = abs(tz);
-		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
+		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
-				tm->tm_hour, tm->tm_min, tm->tm_sec,
-				sign, tz / 100, tz % 100);
+				tm->tm_hour, tm->tm_min, tm->tm_sec);
+		if (tz == 0) {
+			strbuf_addch(&timebuf, 'Z');
+		} else {
+			strbuf_addch(&timebuf, tz >= 0 ? '+' : '-');
+			tz = abs(tz);
+			strbuf_addf(&timebuf, "%02d:%02d", tz / 100, tz % 100);
+		}
 	} else if (mode->type == DATE_RFC2822)
 		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index e18b1602864e..1d228a981ee9 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -46,6 +46,7 @@ check_show () {
 TIME='1466000000 +0200'
 check_show iso8601 "$TIME" '2016-06-15 16:13:20 +0200'
 check_show iso8601-strict "$TIME" '2016-06-15T16:13:20+02:00'
+check_show iso8601-strict "$(echo "$TIME" | sed 's/+0200$/+0000/')" '2016-06-15T14:13:20Z'
 check_show rfc2822 "$TIME" 'Wed, 15 Jun 2016 16:13:20 +0200'
 check_show short "$TIME" '2016-06-15'
 check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
-- 
2.44.0


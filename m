Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6DC208DC
	for <e@80x24.org>; Fri, 25 Aug 2017 19:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756539AbdHYTFB (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 15:05:01 -0400
Received: from mout.web.de ([212.227.17.12]:62438 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754446AbdHYTFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 15:05:00 -0400
Received: from [192.168.178.36] ([91.20.52.82]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MOilO-1drLmo1ybu-0065Da; Fri, 25
 Aug 2017 21:04:56 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] apply: check date of potential epoch timestamps first
Message-ID: <205339f5-bad8-62a3-8ccc-d3b0dd1d6736@web.de>
Date:   Fri, 25 Aug 2017 21:04:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:wQ/YaaA7/OcPhG8XCq7IdpIuDFm5UCSuqpnd26XoNzcLqgR3E6U
 UIPUeaxzjIxPVCda60qTjJVUq1wCVlgKwpTpcu+KPvH3skIbA2uNcb+CgJRQxspcv1ZI6fz
 KnMcDLb8H1Lnolz16ajGCKDAdynvLL5AoCLgYnrCohmggAnQ+AZkdEovu50okHCZp1mQQze
 FqmdtKgA9M3lfjuYZFrEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7wrgNfPEBQc=:AjmHrl6E4PL4U1l4re+z49
 ZF6akPDngSU2Xiu+J0qNpwm96e7aR0wn5XcRKQSuXfMIfp4pV6m8kBKM8qfcV2idwxp/sXAvG
 AcUlQd0uoIObAtnpn9cjCjBHV2j7bQnkA/7qBU0gT69u5/tAxg00bUh3B/a99o3qNyQD8ih7W
 6PDatMBxL2RBf3XmBi0pCL/0ScDXoHwSZV5iLBuVPepw+ow9YI/NgxCPtrq7FsXeF7XcHerdY
 utuiTYsFx1gQ30HbHYk582/tKNmZ5LSyB4tm43o55/9dP3n1TtSzC9jYddd9HAizyj+E9KVmU
 Ce+KYo1Y8qhmlBUWDQReY7oDDwC6XlgRqmUqmc3OuEzZtwo3K+YuLjAun0Moxha/jpflgUR0M
 nTvvlG/ywvbJrzZ8yU+E7/VCX4ufALgUOSgp8cIr0Yrj7VF9TDeWUsNCIpfnUkeHSf8hXCejo
 V/eovJAE1QILjjRVLe++OLiG3oMRodDMYUT5ogD6Ti6+xacXXyRSukJKUP4z9nbm6ToGLoCN+
 MAltgX6czmbnD9kWaYTjg52w8Q9Eev9UC8QPdkgVd4zZJcQM0zmKcr5omuGUg1isMH5WOjrPP
 iO/JQH2HZashgvgmTpd9uEVJtEgFOgTfkkhWDdvFVTsUym+96kYcAvYKxgXwwQ9uUU5EBe8TV
 oR9P6GLWGSayBs9u1JMWvyWQglAfMaNPLkuZ4VqTZfn6qTo3Ax+cH8ggY04SPQdFW5Q6RK0Qt
 30ryhT/xqaZhXXy2UPNRpWWrmhm+ZBqwZZJJP1MqNhpJcL4f7VrJPbQTUSfH1DaiIMOL+rPbQ
 EbmL2Wt8EaXBrcV1OCx3M4QdI/DNC5HeQdxnUYOwUrEgLZMD2Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

has_epoch_timestamp() looks for time stamps that amount to either
1969-12-31 24:00 or 1970-01-01 00:00 after applying the time zone
offset.  Move the check for these two dates up, set the expected hour
based on which one is found, or exit early if none of them are present,
thus avoiding to engage the regex machinery for newer dates.

This also gets rid of two magic string length constants.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 apply.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/apply.c b/apply.c
index 956f56a927..e14077eaee 100644
--- a/apply.c
+++ b/apply.c
@@ -819,8 +819,7 @@ static int has_epoch_timestamp(const char *nameline)
 	const char *timestamp = NULL, *cp, *colon;
 	static regex_t *stamp;
 	regmatch_t m[10];
-	int zoneoffset;
-	int hourminute;
+	int zoneoffset, epoch_hour, hour, minute;
 	int status;
 
 	for (cp = nameline; *cp != '\n'; cp++) {
@@ -829,6 +828,18 @@ static int has_epoch_timestamp(const char *nameline)
 	}
 	if (!timestamp)
 		return 0;
+
+	/*
+	 * YYYY-MM-DD hh:mm:ss must be from either 1969-12-31
+	 * (west of GMT) or 1970-01-01 (east of GMT)
+	 */
+	if (starts_with(timestamp, "1969-12-31"))
+		epoch_hour = 24;
+	else if (starts_with(timestamp, "1970-01-01"))
+		epoch_hour = 0;
+	else
+		return 0;
+
 	if (!stamp) {
 		stamp = xmalloc(sizeof(*stamp));
 		if (regcomp(stamp, stamp_regexp, REG_EXTENDED)) {
@@ -846,6 +857,9 @@ static int has_epoch_timestamp(const char *nameline)
 		return 0;
 	}
 
+	hour = strtol(timestamp + 11, NULL, 10);
+	minute = strtol(timestamp + 14, NULL, 10);
+
 	zoneoffset = strtol(timestamp + m[3].rm_so + 1, (char **) &colon, 10);
 	if (*colon == ':')
 		zoneoffset = zoneoffset * 60 + strtol(colon + 1, NULL, 10);
@@ -854,20 +868,7 @@ static int has_epoch_timestamp(const char *nameline)
 	if (timestamp[m[3].rm_so] == '-')
 		zoneoffset = -zoneoffset;
 
-	/*
-	 * YYYY-MM-DD hh:mm:ss must be from either 1969-12-31
-	 * (west of GMT) or 1970-01-01 (east of GMT)
-	 */
-	if ((zoneoffset < 0 && memcmp(timestamp, "1969-12-31", 10)) ||
-	    (0 <= zoneoffset && memcmp(timestamp, "1970-01-01", 10)))
-		return 0;
-
-	hourminute = (strtol(timestamp + 11, NULL, 10) * 60 +
-		      strtol(timestamp + 14, NULL, 10) -
-		      zoneoffset);
-
-	return ((zoneoffset < 0 && hourminute == 1440) ||
-		(0 <= zoneoffset && !hourminute));
+	return hour * 60 + minute - zoneoffset == epoch_hour * 60;
 }
 
 /*
-- 
2.14.1

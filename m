From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 04/11] ref-filter: introduce parsing functions for each valid atom
Date: Wed, 17 Feb 2016 23:36:12 +0530
Message-ID: <1455732379-22479-5-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:06:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6UC-0006tQ-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423489AbcBQSFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:51 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33917 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423438AbcBQSFr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:47 -0500
Received: by mail-pf0-f177.google.com with SMTP id x65so15368973pfb.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/FhXqx6OZQ/YlV/8+96Er6xqGV9B/tFcDmSVklPfrxQ=;
        b=XZDzO4oviL5n8NWNmJAUdhiYQmTMESRgAMFHJajoTO+Ocfhg9gjUQjoZa9vMmVKTFU
         clju2p1IaUjs33nCqbBg5odpqrEnQcd3doTHfbt6FVL0hjEGnXbSmQ+7aaOz58DYdmFR
         f0G82xr5zu5BXEfRS+uhKm6AqpHrmrHDYjhlMzXloCVXB/EU/mJyRAO6k4Ro7ZKQ6Jhz
         KA46Fl0DxK000OtFEvIAMtBFO60Zf53QaZw3ZaSsiDFGj2cGQMKziXu1y0I2l+VjFg9R
         0KkB7WBdg41R3HhmdZ3AsvcFiZ/4U9fn3nI1pkTGZMG8jHpiJ1rmYL2ZAn/LiyAfYWUu
         5VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/FhXqx6OZQ/YlV/8+96Er6xqGV9B/tFcDmSVklPfrxQ=;
        b=b/vboEmbI9SGxctwCntse/VJlnVH5+2RmA/hjrv7TXQSmJ80escxmMMvqUUf/x8myB
         vGnrSunnsXygJgV0rBq+kHdf3A63R/CFch/QKopxfTgH097i/iGZQ4YF6l1UOyHRL+Nq
         0tFLpqRhH7xhQ7xtMaHhVTCoxNIRqAKtjlZs1a5mYghc5KVeB3acgTD7pPPa4oqmlQyV
         Gzku4avumQ1WBdxQ+NbOaBKDe4dw4uxUR6b02dDsUi2To0ZOjBppI/5EmPKAfexu4MPL
         5PcCnn70fDXSoxI98vCF+qL+1GbUTT0R0Z2az9g7dB8FtzYNm7w+/wl7PCj0TBxDjzi+
         BOyw==
X-Gm-Message-State: AG10YOR+NhBRvDdLZ3Js5rXmup3GuAxZ61uI3QqnVS5Ep8g0UBJ/5SZ3feoXb8WpiGh8uw==
X-Received: by 10.98.72.215 with SMTP id q84mr4040143pfi.152.1455732346953;
        Wed, 17 Feb 2016 10:05:46 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:46 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286522>

Parsing atoms is done in populate_value(), this is repetitive and
hence expensive. Introduce a parsing function which would let us parse
atoms beforehand and store the required details into the 'used_atom'
structure for further usage.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8139709..8a34ba1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -36,6 +36,7 @@ static int need_color_reset_at_eol;
 static struct {
 	const char *name;
 	cmp_type cmp_type;
+	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
 	{ "refname" },
 	{ "objecttype" },
@@ -114,6 +115,7 @@ struct atom_value {
 int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
+	const char *arg;
 	int i, at;
 
 	sp = atom;
@@ -132,16 +134,16 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	/* Is the atom a valid one? */
 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
+
 		/*
 		 * If the atom name has a colon, strip it and everything after
 		 * it off - it specifies the format for this entry, and
 		 * shouldn't be used for checking against the valid_atom
 		 * table.
 		 */
-		const char *formatp = strchr(sp, ':');
-		if (!formatp || ep < formatp)
-			formatp = ep;
-		if (len == formatp - sp && !memcmp(valid_atom[i].name, sp, len))
+		arg = memchr(sp, ':', ep - sp);
+		if (len == (arg ? arg : ep) - sp &&
+		    !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
@@ -154,6 +156,10 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
 	used_atom[at].name = xmemdupz(atom, ep - atom);
 	used_atom[at].type = valid_atom[i].cmp_type;
+	if (arg)
+		arg = used_atom[at].name + (arg - atom) + 1;
+	if (valid_atom[i].parser)
+		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
 		need_tagged = 1;
 	if (!strcmp(used_atom[at].name, "symref"))
-- 
2.7.1

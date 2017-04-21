Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812B51FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971298AbdDUKpY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:45:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:49216 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971292AbdDUKpW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:45:22 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LeSOH-1cDbRD2go9-00q9ru; Fri, 21
 Apr 2017 12:45:18 +0200
Date:   Fri, 21 Apr 2017 12:45:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 1/9] ref-filter: avoid using `unsigned long` for catch-all
 data type
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <35bb906d44605aef36efc1dd505045cd73a8c27e.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:N28JIwZaqrFvCS/uP9V5wcDsbphaujEzjpepA4do3EYbpNCUnqZ
 zINTo2hIdd7W+j7xIvJHZsmZWaUckqonEPKJryXJMwXgnERoQ8LiHgSgnWBSnQbYc+Aadkk
 oS4ewIdAVs1iz4wOjOQqQcy7dIVO0P+pZEGNDfnGsOCjkX50puIO5Otl0gJ8ydLoNI1QO0C
 XU6cql4pyvZrcY1GaCfNQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DLIQxPXOOyY=:F5vk+JL0N0Wgt7RMfCWbnl
 90AF9qCdaHWeghUJ2L5xKbMYfO0+t9NvezCbnQZ+xgnlBHHlzT8OmIyLUBdx00ESO1W0b9uRY
 oSvWcQZMiMnaQIyToI7rgJWz2w5dSC+LKu4XzhJBbL9yQSO2TN+FwOR1ppsCUOdH0tK4iZdpS
 lzsOn5Gmy4+pHKNB6wQHDuA7vVx8vEEXmX2sI7Z3BSvYqVdd3M63SWPGRyr9CY+sMJvrS1L4o
 YBsL8Jl4Cjh36Aj5YdLrCdCVZwbOgQqTwUEmYOdVmwK7o2AG8IFbrpRuQesjKnTG/isCA4jP2
 j9Wb6aoh63DFTJX7PeNMoiiVefOlc3EVyyW/r+Hmy4QmuRHbpmQhxWrnSRcCxFZ91x7txL9rG
 g7TQD0/pAhY5S1K83wus74BwcE/OEKju5Y9G3eAbWA1MJp9eMx0xHvXiNWwc8SQX4bV6p4Z35
 TVa+qk8dxt2LHmFGV1Q1X78MnFthOivtG8Sacwjk2oNId1ojjsIZk6xH37z8fz4EBpUZ2K4rm
 YqFw7yj4qbqeoc09SsKSrLrsHf/XDYOwpzLPlRP69dcc5Hq527AxJokeVL+LzknWxEJVmt4qV
 yYEfiU/mAevnwyNM6btcW01MhOtLSoee7SpeIJjcgPr4JmyOIQ25Mj0NzlC2lEmMXD5PpN6C3
 /W7pEwnFKCJvJ9ji40mzWvBkDZm1OYb9poCYoblXQgiShFyzOwBFsXya7CZN8dNURCLhSbf61
 tH4dzmZXiELHMOt/aARvRpjTQlUnDJtqhx4Z+Ry7HmLUt0YDM981dNEp/1mJmghloJRXiequ6
 4zLMf75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In its `atom_value` struct, the ref-filter source code wants to store
different values in a field called `ul` (for `unsigned long`), e.g.
timestamps.

However, as we are about to switch the data type of timestamps away from
`unsigned long` (because it may be 32-bit even when `time_t` is 64-bit),
that data type is not large enough.

Simply change that field to use `uintmax_t` instead.

This patch is a bit larger than the mere change of the data type
because the field's name was tied to its data type, which has been fixed
at the same time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ref-filter.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3a640448fd8..92871266001 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -351,7 +351,7 @@ struct ref_formatting_state {
 struct atom_value {
 	const char *s;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
-	unsigned long ul; /* used for sorting when not FIELD_STR */
+	uintmax_t value; /* used for sorting when not FIELD_STR */
 	struct used_atom *atom;
 };
 
@@ -723,7 +723,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 		if (!strcmp(name, "objecttype"))
 			v->s = typename(obj->type);
 		else if (!strcmp(name, "objectsize")) {
-			v->ul = sz;
+			v->value = sz;
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
@@ -770,8 +770,8 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 			v->s = xstrdup(oid_to_hex(&commit->tree->object.oid));
 		}
 		else if (!strcmp(name, "numparent")) {
-			v->ul = commit_list_count(commit->parents);
-			v->s = xstrfmt("%lu", v->ul);
+			v->value = commit_list_count(commit->parents);
+			v->s = xstrfmt("%lu", (unsigned long)v->value);
 		}
 		else if (!strcmp(name, "parent")) {
 			struct commit_list *parents;
@@ -875,11 +875,11 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
 	v->s = xstrdup(show_date(timestamp, tz, &date_mode));
-	v->ul = timestamp;
+	v->value = timestamp;
 	return;
  bad:
 	v->s = "";
-	v->ul = 0;
+	v->value = 0;
 }
 
 /* See grab_values */
@@ -1941,9 +1941,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 	else if (cmp_type == FIELD_STR)
 		cmp = cmp_fn(va->s, vb->s);
 	else {
-		if (va->ul < vb->ul)
+		if (va->value < vb->value)
 			cmp = -1;
-		else if (va->ul == vb->ul)
+		else if (va->value == vb->value)
 			cmp = cmp_fn(a->refname, b->refname);
 		else
 			cmp = 1;
-- 
2.12.2.windows.2.406.gd14a8f8640f



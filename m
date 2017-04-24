Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93567207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171913AbdDXN6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:58:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:63347 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171899AbdDXN6B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:58:01 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M92lh-1cqrqz11DB-00CO5i; Mon, 24
 Apr 2017 15:57:56 +0200
Date:   Mon, 24 Apr 2017 15:57:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 1/8] ref-filter: avoid using `unsigned long` for catch-all
 data type
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Message-ID: <e801667c27e0dece4bc3489306831b4dfc9ad481.1493042239.git.johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9omY8HDhABzw8sWF+hKaA8opJksSw95U9YpLCjy0uS4ZVrcFZqp
 G5f0Ft0KAxDZm7NYtMn+NCImOd3r8hLLC861vjaiDkN1/w/GoaVlJUQUWTf0OcAu+UG+RIt
 05dw8uu5TAPjiGTYH6K5G/wBdd8IGUOezzDREkHRlb47HkfQG1C7pdpaaKNDzxb/bdMWGih
 O9hKqz4lkQw1/6zghkhZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LK7DbDOIeDU=:V0rvrTevhzZhOFXFTkMYzR
 krcVRU+g4raQrOhDls+IqCapjBssydrRdy/Jyl4bw3Xd9IFtIRW3e6GvqDuhryk/4J8PXCLYD
 9F/wQKevuJyw5inBB494CNGltOZhbsOG/oQmAhAM39pwxOvVJ/UGopwm6Gib8jAZ/pIaRi3M/
 JuE7GRaX2ahUUJXsqBbUHfjsIPT14IzvmHn98sHqM0hLDLHfP4Tw7SnwvCE0+UJDHPVdAG0Sv
 byQF3yumAH78MfcCOv0m+lYjk6FQC8VcQa+NXMay1qSwUz4Af3EubbChUY85fxyW4P1uTVjXE
 hReiXSaB6lL3lPhamNIU6fRZvdYsq3uWTmKsHTZK4yas+EnJs600MU3YmyWU8ZYqEm44sDfcn
 pqjb/1U5uPY+BZR9iugY9puMtbOxFbAyGPQznQ9pecyx4P+l06F8YXqB6tn+vnF7T7McixG5V
 ONtoO5R+FmmdrCZjbdEC4Is5Oa6b7wYGxSsZ4S7IiPJk1G+S18c4RTVtY6LulWM7rRNQNIMEj
 auqe365yYNlz4sYQASHT9WOjgbCkR8bxvQkpyOJmbjNaWerMap3IJyWdhWiaIoEz4xAMojejJ
 e8tpWq16NpBkB6mxr+6ob/el7PAc2eBsEVM3SJBOd0sFxgvsxs7GyXGjaQ72BWWLYVdXQ7adq
 /BGhSk25MrHNwM+hynJW9hgE6kpsyxZNf5ETYkVGwaEfyWWA1ltWRm9y7myp1/Zw62z7sRL/z
 VcPpuWnGDcCXbbN8GOnzzMS5Hx+ShXvnXXqTt0kMJfEFK5PjvHwZ9dqeTMmcFWFpFmT5VrTfv
 GE85x59
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



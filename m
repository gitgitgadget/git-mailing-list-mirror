Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78B6D207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033314AbdDTUwR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:52:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:65018 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032893AbdDTUwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:52:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzHZ7-1bxG3v2FeL-014W4T; Thu, 20
 Apr 2017 22:52:10 +0200
Date:   Thu, 20 Apr 2017 22:52:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/8] ref-filter: avoid using `unsigned long` for catch-all
 data type
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de>
Message-ID: <35bb906d44605aef36efc1dd505045cd73a8c27e.1492721487.git.johannes.schindelin@gmx.de>
References: <cover.1491159939.git.johannes.schindelin@gmx.de> <cover.1492721487.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AI0uh/emZQJei6oD864CuQOyL9Klc7EuFkRfE7oVrJOJuYhbrBQ
 wtW37EbAK7Oyiz9HdP9OE7QCVDdv1QkfnCqHEhfcPuABosdfJfevgK4IPsATCMwKbHQVB/g
 23NhBkJe0FRwiRPmwT1CGuh9CRm3upGYgcipxqhm9XuWyHfhnW1z9f/1PD7jf07+5q6EvHx
 Et/WbkY3eFII/oeFyZNSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ATmlRUG18w8=:URdhG7lR4eS8x5zKB5zU7s
 nPaPuthYBtSrMuYXV94zQnVBsvIUYLVe0uVgN+e8QDyAoHqEraG2SbeHnbuOihkHKCjIVJmkT
 tR0Ew8qrNT+7Q8L+CnccUaxCN5DDfHwh3bPfpTSlVzw6xwxPWa6AGoKsqz158uYh8JrC7c9eF
 Xe7JZV8H8poZkyBP9t4dQa/9/a4I0T5/RHsl0uKVWgN+sy/mNftsJGa1kIkJHiyKtIAVe3LYF
 qDh9d3w2TVu/i1yKxD4jYUzZlJHEB6gB/xHylw+DJuPqkCCuxsxIv4BmbPq+hLBDmHhCwPYui
 X41YAM6NWRDpGKe1gB0zxo49Z3/og/dYwroJypG8nd2TYF1lEdEluX2ZvhMJONJcRMtPJHtDA
 4NKZ3Cy4FvCTzzIaeRze6oio8YefgD6D8RFEk5rfJDGJYgszxwDygAJvFgt4heZvxrF61vP4c
 yotsrTrCe+MZrEQe3UnB3PntfMFSq5bqpQbneQHFQpptYmZQPB08yHKs82X2vqjBkbTUVwUya
 qOfm6gAd4dI1FOv1rKjffnodsXHfiW/ABi7dYVyFh7dZyyeH6OeHZsdgL43DXf8xwhM27VbvC
 dkJkYUiWDu9bd0/u1qRgXCDJxD3hO5eNdngxRhsJRVlEQcCwr3KItIvBAzbn8qBoNsShoo12z
 iA6OTs6gjjPcKDnyvEussgwJ8R9KkrPz5gzRHC6wiRCqAiiyMfc9cCASh1NnS+Z3Z92PQDYaU
 FYJ/aFO8hTMiCM0grlh2jbpOFvRg6azDncrARa3eD6NAlFLHNi9nup8n+AvNuwf0sbC2iQSSN
 Ecb76eR
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



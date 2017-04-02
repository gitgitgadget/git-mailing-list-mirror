Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6341F20966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbdDBTGU (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:06:20 -0400
Received: from mout.gmx.net ([212.227.15.18]:57109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbdDBTGS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:06:18 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMEG-1crVhP2VBU-00EIbw; Sun, 02
 Apr 2017 21:06:11 +0200
Date:   Sun, 2 Apr 2017 21:06:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] ref-filter: avoid using `unsigned long` for catch-all
 data type
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <bf91c11bd145a2f4b049ac02c02a18e58c496834.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Jeuic+gevUDq0NTCc7rNPHTs1LvmyrmcdgwpaEMAuZ03r+/O0xy
 ikc4oM6OXydP8EmHl52viIosnkOJVIJrOh4Zdlzh630CgbtSdMwmGIvdu+pS3Gh9D0/hi1Y
 HoxP3+EdckhOH/k4AgfyqK/UWLPjb3RQ8N/duOX+jCgLQI2Dnv69L7JH7YCfVrTTz2bnZU4
 th4EeSjByguo5ADhbqiEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LIsmm1fTM2g=:zcpiweXUJgSEXw/txaWvS8
 HlIxoVporjR66YnvAjJz5zmC95o0ce5Q3aM843b+0i0r1pTlPiAA7t3J7dlBpxZlsbF3TXMRG
 /sYhrk8MqBVOU7gYz4sMHOqtdwUpW78nT7eifsolppGTfDYOVLNEEOiD95UWrg+UncHv045pJ
 ZnqiER0TfNpks1QmhV2FlUXmNnQ59QApwY3mJic2X7mfwqfuHbRf3GYhNpte+uZS0eNL4CQqQ
 dUWmXL9OHcifD5HfR4V4XnMmCIFUqSNK2SXo8dhVq23HawX8DbVuJZeMRe85mHc2AWrG8w5e4
 L/b8RSO5u+eM96fPVJ8/8AW6fDEGkADAc0kw1E5YcLPN9XSUE5MG3LP1LXW9HJUrZ/EBszeNC
 WsRoWUspF2L+8m9CY+Ijv0y2sbre7gz/71Noh/RY1MGsCO2j3I/Tb0Tx11/ib+EUB/pgk5Uzx
 ErhL5rAVgUk9Rg/+1DuNVOQzjW50L0ZvnAND8Sb58ro3P2dpXJ1e5hvPBf2yswmIgl2lGGTes
 jVZTJHEA8wkXQKvIa47zb4Kt2eEE0eUBksB/6jwqtgJN9NkN4xy5bkJumSuQBO/ZMuiIIsy9e
 gDr04t2282Pevkv+Wmg+TGSvuj2l+AE+qArD7YREZ3VJl2cMDa+0V5axF+TQ2p2nh9l2V9KYD
 LV6v3YzyBUrqmpYb065pFNwKuM5Qg8k3DLHUZXqEpZ+IQPgxW3wjjdFtJ5E4BkIl1QyaRqbNS
 aOJMGaVL+8Q22OHtSl+Wxvv8GEkSyFodh5Rui/Ddc0OCJEaxtsRslgv6dB0zuJb7hWYSbk43G
 pd3B8c9
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
index 9c82b5b9d63..8538328fc7f 100644
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
@@ -1934,9 +1934,9 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
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
2.12.2.windows.1



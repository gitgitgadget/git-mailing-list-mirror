Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D95920958
	for <e@80x24.org>; Wed, 29 Mar 2017 14:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbdC2Ojj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 10:39:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:56393 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751843AbdC2Oje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 10:39:34 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0MTNxP-1ckffO3Zvb-00SO47; Wed, 29
 Mar 2017 16:39:25 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 1/3] name-rev: refactor logic to see if a new candidate is a better name
Date:   Wed, 29 Mar 2017 16:39:15 +0200
Message-Id: <a2687576f270d76fda1ecfa4c0df2e99bd641e5e.1490798142.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.712.gba4c48c431
In-Reply-To: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <cover.1490798142.git.git@grubix.eu>
References: <cover.1490798142.git.git@grubix.eu>
X-Provags-ID: V03:K0:jsDPTYfTgr9xNY3WJJPJwz8VMK/L/pB+X5h7OQzzEg+UKGd8RjS
 6OQK3BmKgIDv9Z+ZLAiQivlYcfqVLOnCV6tr5eEY676R9HyZ6kDzRIFM/zAGxIVBgfwlBOu
 2KBhQIiMqgJ7m/6eaVRiHeUMdHRUqhi186Qy0yJTBLDMYyXS7iyWTQiQsxtoytSbV2n3/Ak
 k8wWeCSNbgwbb1mQ9Zr1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jwbnuAPuqso=:xOMrtC78+yY+8qNuh8FojF
 hQdwpaOjZ/1hM8B9BM3oL1lXrMHJV/dcXJHfmzhCDcN1B48Bs9I/ZHk69kE1M0i4n+Sh4y01V
 E3Qj81konTtq7fm90r9GkcgwfTQIGVBNaxuXygQnRJGpuhK8tU1rxTnlZUIvtl+3bWnzT3ufq
 uyYgrP12Qw2fKHu3aVeIU/mLvAJk18AcOcMDt4VRh3F2qVoeGyTMDKEec22+lISpxvaVyx6BV
 1R+BWdPj3cLW+q2HbmD7WQ+pBlvOekp2R5QT7i+dl16SJIWVWSrEP8GZpHG8VslIuc+84FeDX
 1AitRmXLLjAeVXZ96/ro5QeaNXqFGhGSsBEttS8dNxQwyLjCGMji/ViNMNpYQa7pYyNBwNU5I
 T4Lr75D2URJHoHJSVE0JiHfB1F6RmWAzuCRMyAN8iMX1dPdqQ/q1nlBE4lw8xNij08x2n3CHQ
 Zla6+382wIl4f81uzR+DidSlbftAHhen6b6Jr66MOiRfHfUD7xRxNs1OHOMH84V615uqVwuhQ
 sRWt0jlTwB+CTDQag2vZRbXJkWwvN5iKRRlZGenN8PW1UNDa3+fs/V65ZTOyv1UKL0H0QcMoS
 p9YcKNSaYEb+Qmya/L17HUScUuVVNtW0A0LU+DLk7zXaI2IojAAcEcgD5rI2mbVwpsfFgKsfM
 68vN3QCHl4Ds7iUlm5imO3Go2RqztBrhLu0o7JX4yfRXgq+i8pWXV8pXS+WWDLvcSgyQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

When we encounter a new ref that could describe the commit we are
looking at, we compare the name that is formed using that ref and
the name we found so far and pick a better one.

Factor the comparison logic out to a separate helper function, while
keeping the current logic the same (i.e. a name that is based on an
older tag is better, and if two tags of the same age can reach the
commit, the one with fewer number of hops to reach the commit is
better).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/name-rev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8bdc3eaa6f..7890f826ce 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -20,6 +20,17 @@ static long cutoff = LONG_MAX;
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
 
+static int is_better_name(struct rev_name *name,
+			  const char *tip_name,
+			  unsigned long taggerdate,
+			  int generation,
+			  int distance)
+{
+	return (name->taggerdate > taggerdate ||
+		(name->taggerdate == taggerdate &&
+		 name->distance > distance));
+}
+
 static void name_rev(struct commit *commit,
 		const char *tip_name, unsigned long taggerdate,
 		int generation, int distance,
@@ -45,9 +56,8 @@ static void name_rev(struct commit *commit,
 		name = xmalloc(sizeof(rev_name));
 		commit->util = name;
 		goto copy_data;
-	} else if (name->taggerdate > taggerdate ||
-			(name->taggerdate == taggerdate &&
-			 name->distance > distance)) {
+	} else if (is_better_name(name, tip_name, taggerdate,
+				  generation, distance)) {
 copy_data:
 		name->tip_name = tip_name;
 		name->taggerdate = taggerdate;
-- 
2.12.2.712.gba4c48c431


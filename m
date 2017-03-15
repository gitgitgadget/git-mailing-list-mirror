Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312A2202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 22:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754119AbdCOW6e (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 18:58:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753814AbdCOW6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 18:58:05 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Mar 2017 18:58:05 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 25068802D8;
        Wed, 15 Mar 2017 18:50:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=tZQf
        whDT95/GaoUkBKWOuMBIQfY=; b=sKqhdYbza8/nHjgpe0mQOUM8d8fbyHyo2Mi8
        fLzDitd8QsVgVkwcOVNS/cqRDZUlC7JrfBlvvxiJHdATAA+31OnYSzvGwjOGZ8FN
        73/fkDcviF5Odl6ra+evRGF8zWvSOKyWb3NV6n4j/MLUFl+IcDEV2hp1LyY4hjt6
        eRXDQd0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        wVCi37bpVUyVE0qFHhvxgtPB/KQ0kF+g6pYomYPgrFfq1UaXlTmU1JV3cfhsGIjz
        0tAf8hlMFmlydUcsR5JvAi7BT2s2pd4N1y0i6X+5vNA9x31JSAMq8WwPvuYA2HJ/
        5LyIu+3YjmVLzKprSov7wQAkwBXKXE9MW61tWtGY3Wk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E7CA802D7;
        Wed, 15 Mar 2017 18:50:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 794B9802D6;
        Wed, 15 Mar 2017 18:50:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] name-rev: refactor logic to see if a new candidate is a better name
Date:   Wed, 15 Mar 2017 15:50:44 -0700
Message-Id: <20170315225045.15788-2-gitster@pobox.com>
X-Mailer: git-send-email 2.12.0-306-g4a9b9b32d4
In-Reply-To: <20170315225045.15788-1-gitster@pobox.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
 <20170315225045.15788-1-gitster@pobox.com>
X-Pobox-Relay-ID: D50A0D2C-09D1-11E7-A33E-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we encounter a new ref that could describe the commit we are
looking at, we compare the name that is formed using that ref and
the name we found so far and pick a better one.

Factor the comparison logic out to a separate helper function, while
keeping the current logic the same (i.e. a name that is based on an
older tag is better, and if two tags of the same age can reach the
commit, the one with fewer number of hops to reach the commit is
better).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/name-rev.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index cd89d48b65..f64c71d9bc 100644
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
2.12.0-306-g4a9b9b32d4


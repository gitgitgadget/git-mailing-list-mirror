Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADDDB2018E
	for <e@80x24.org>; Mon, 22 Aug 2016 11:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753827AbcHVLYN (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 07:24:13 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45291 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752112AbcHVLYM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Aug 2016 07:24:12 -0400
X-AuditID: 12074413-aa3ff70000000955-b7-57bae08e29bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id C7.3C.02389.E80EAB75; Mon, 22 Aug 2016 07:22:54 -0400 (EDT)
Received: from bagpipes.fritz.box (p5790719A.dip0.t-ipconnect.de [87.144.113.154])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7MBMnQP027076
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 Aug 2016 07:22:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/7] xdl_change_compact(): fix compaction heuristic to adjust ixo
Date:   Mon, 22 Aug 2016 13:22:40 +0200
Message-Id: <119c03e74c022ccdd6ebd8661a98b43917f8e966.1471864378.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1471864378.git.mhagger@alum.mit.edu>
References: <cover.1471864378.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqLv4wa5wg1ev1C26rnQzWTT0XmG2
        2L24n9lixdU5zBa3V8xntvjR0sNssXlzO4sDu8ff9x+YPHbOusvusWBTqcez3j2MHhcvKXt8
        3iQXwBbFZZOSmpNZllqkb5fAldG/QKpgIk/F2l1HWRoYj3J2MXJySAiYSFzeup8FxBYS2Moo
        cbpRq4uRC8g+xSTRffkoE0iCTUBXYlFPM5gtIiAu8fb4THaQImaBfiaJHx1djCAJYYEQiZ9f
        TrKC2CwCqhIT1u8Aa+AViJJY9novI8Q2OYlL274wdzFycHAKWEhsbVGGWGwu8WzHSfYJjDwL
        GBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoSElPAOxl0n5Q4xCnAwKvHw
        fji4M1yINbGsuDL3EKMkB5OSKK9ZK1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/p/V3hQrwp
        iZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV4HkEbBotT01Iq0zJwShDQT
        ByfIcB6g4cfugQwvLkjMLc5Mh8ifYlSUEufNB0kIgCQySvPgemEx/4pRHOgVYd5YkBU8wHQB
        1/0KaDAT0ODr/7eDDC5JREhJNTDuNFdK2W687uYcplSR3c63pJgrvm94u/KRsd2zs7MVjB6p
        nHhps+Tk1OaZG6+Vb1i8QPeo5UzJvxdvZvJVTn6b9MD12Zw96+OLWOwcXs9///n/lH3PT+oJ
        JjH6rNqzW7zK0ZnV/UfinXdvJ8Yk3TaY/1Eh4GHI1Dk5Cz/K8kZ6pWbHdBvFv03ZpcRSnJFo
        qMVcVJwIAFz+IRLUAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code branch used for the compaction heuristic forgot to keep ixo in
sync while the group was shifted. This is certainly wrong, as it causes
the two counters to get out of sync.

I *think* that this bug could also have caused the function to read past
the end of the rchgo array, though I haven't done the work to prove it
for sure. Here is my reasoning:

If ixo is not decremented correctly during one iteration of the outer
while loop, then it will loose sync with the ix counter. In particular,
ixo will be too large.

Suppose that the next iterations of the outer while loop (i.e.,
processing the next block of add/delete lines) don't have any sliders.
Then the ixo counter would be incremented by the number of non-changed
lines in xdf, which is the same as the number of non-changed lines in
xdfo that *should have* followed the group that experienced the
malfunction. But since ixo was too large at the end of that iteration,
it will be incremented past the end of the xdfo->rchg array, and will
try to read that memory illegally.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 xdiff/xdiffi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b3c6848..95b037e 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -528,6 +528,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
+				while (rchgo[--ixo]);
 			}
 		}
 	}
-- 
2.9.3


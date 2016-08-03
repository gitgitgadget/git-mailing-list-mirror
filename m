Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3841F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 22:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbcHCWBB (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 18:01:01 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:44998 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752312AbcHCWBA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2016 18:01:00 -0400
X-AuditID: 12074411-a07ff70000000932-33-57a26994cc86
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6A.84.02354.49962A75; Wed,  3 Aug 2016 18:00:52 -0400 (EDT)
Received: from michael.fritz.box (p57907C5F.dip0.t-ipconnect.de [87.144.124.95])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u73M0fSc023677
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Aug 2016 18:00:51 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	git@vger.kernel.org
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/8] xdl_change_compact(): fix compaction heuristic to adjust io
Date:	Thu,  4 Aug 2016 00:00:33 +0200
Message-Id: <ae7590443737a3996ec4973fd868ce89dc78a576.1470259583.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1470259583.git.mhagger@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsUixO6iqDslc1G4wbtn5hZdV7qZLBp6rzBb
	7F7cz2yx4uocZovbK+YzW/xo6WG22Ly5ncWB3ePv+w9MHjtn3WX3WLCp1ONZ7x5Gj4uXlD0+
	b5ILYIvisklJzcksSy3St0vgypj65glrwW6eiumnnzM3MD7m7GLk5JAQMJH4dXsZUxcjF4eQ
	wFZGiXfLe9kgnONMEhsWPmQGqWIT0JVY1NPMBGKLCIhLvD0+kx2kiFmgn0niR0cXI0hCWCBA
	4uWvK2ANLAKqEvPPTQeKc3DwCkRJPF0eDbFNTuLy9AdsIDangIXE1UmzwWYKCZhLvO3YxTqB
	kWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJCwEtzBOOOk3CFGAQ5G
	JR7eDZKLwoVYE8uKK3MPMUpyMCmJ8uakAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8N5LAcrx
	piRWVqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4kzOAGgWLUtNTK9Iyc0oQ
	0kwcnCDDeYCG70kHGV5ckJhbnJkOkT/FqCglzmsBkhAASWSU5sH1wuL+FaM40CvCvNUgK3iA
	KQOu+xXQYCagwScMFoAMLklESEk1MC5/tvbK2rCvLX2cX7XvNu0SvR/wQ9vsjXeE8yWTlCOX
	DbSCuavlY6xCjxXxmW91m5sstTH03azkU1XPZz73juEKbTq4IoN/kTdP6rqKKy9mL5gtfHaV
	7p2nacu2mkdWmnR9DK1wfFA++a/9meqcViarEOWYfSq+vBt+FP/97rL9w53Un/meL5RYijMS
	DbWYi4oTAREYfZbWAgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The code branch used for the compaction heuristic incorrectly forgot to
keep io in sync while the group was shifted. I think that could have
led to reading past the end of the rchgo array.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
I didn't actually try to verify the presence of a bug, because it
seems like more work than worthwhile. But here is my reasoning:

If io is not decremented correctly during one iteration of the outer
`while` loop, then it will loose sync with the `end` counter. In
particular it will be too large.

Suppose that the next iterations of the outer `while` loop (i.e.,
processing the next block of add/delete lines) don't have any sliders.
Then the `io` counter would be incremented by the number of
non-changed lines in xdf, which is the same as the number of
non-changed lines in xdfo that *should have* followed the group that
experienced the malfunction. But since `io` was too large at the end
of that iteration, it will be incremented past the end of the
xdfo->rchg array, and will try to read that memory illegally.

 xdiff/xdiffi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index c67cfe3..66129db 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -562,6 +562,10 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			       recs_match(recs, start - 1, end - 1, flags)) {
 				rchg[--start] = 1;
 				rchg[--end] = 0;
+
+				io--;
+				while (rchgo[io])
+					io--;
 			}
 		} else if (end_matching_other != -1) {
 			/*
-- 
2.8.1


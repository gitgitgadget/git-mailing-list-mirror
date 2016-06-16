Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.6 required=5.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070EE1FE4D
	for <e@80x24.org>; Thu, 16 Jun 2016 17:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbcFPRqd (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 13:46:33 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34889 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbcFPRqc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 13:46:32 -0400
Received: by mail-pa0-f46.google.com with SMTP id hl6so20075633pac.2
        for <git@vger.kernel.org>; Thu, 16 Jun 2016 10:46:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jHTCbWhriu4g7Mk+ViQdc+2gHSA8WB+BI6quwXeFTXA=;
        b=IK4amXYc/I8/pXD/cIVuwR6XxWnA/KrXHhQHZ9ycV+piHP/Hh1JCj1wP0leT83wDta
         3pgmiGwzweUN5sXlMDgT2xMjztp+kz9y7CqwS+Qaro3NgA3vMWF6PHZAzucs2pZAHUih
         +hNphzNgXfvydjBtTMAF0VVzBJI4S3VKgJlWPtHkQoaf8v2f6tc2Cpgwl0j5lFnbbqCy
         Y6kCRxxxvCrGnLJxM/v5bwBJMXXjIZfV9xEesmi0ZxiJvS5vz9JZeKkwJJFcR6sZwSqD
         fDMy1Qi9RbUwuYYdS6XxnIvSVJytC678MWOOb3/W/bBQC5jUOhv8y7NcsFA4BomuOSxU
         9CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jHTCbWhriu4g7Mk+ViQdc+2gHSA8WB+BI6quwXeFTXA=;
        b=H7vVsCiv6Su2h7EvWnK3KqIb0YGN8gldtoWvYfC461aTLNqoBeM8N0SUIAp+cIJth6
         lTcMCfpDoxhqf0Q1Ldxm9mRrUB60peCqRGLorwBAqj3X3HeXZgNzQ8MNKQe5Zm/OVJG4
         HaIGABJl8BojoIi15z+c9knOer/57TLDnO7ufDaP7rh8x6zAEFyd4N4po1jAvCrkJ8jn
         foD6TopqyCUFYxblvvxHAwUbiDQQvTxzuWDY/mtloNfGZIPYMm9+XUidSpF+oZw1QIOW
         n3e+xKGI/IElq+SeQntteSNvaHh/JIKDX2gNXnzqusOLRa5PCdJPwKYxlGYGiIDn4TMq
         7e2g==
X-Gm-Message-State: ALyK8tLCO+CBsBfevxUFQ7rD19dRV2jTyNgwwsZ9sa3ovWuZTJS1fXKZ4rAWjDdOTAwenBEh
X-Received: by 10.66.25.231 with SMTP id f7mr6557487pag.65.1466099191050;
        Thu, 16 Jun 2016 10:46:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6516:4d45:e462:99dd])
        by smtp.gmail.com with ESMTPSA id h6sm49799947pac.46.2016.06.16.10.46.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Jun 2016 10:46:30 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	peff@peff.net
Cc:	git@vger.kernel.org, jacob.keller@gmail.com, mhagger@alum.mit.edu,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH] diff compaction heuristic: favor shortest neighboring blank lines
Date:	Thu, 16 Jun 2016 10:46:20 -0700
Message-Id: <20160616174620.1011-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.2.g16976f7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The compaction heuristic for diffs was deemed quite good, but in 5580b27
we have an example demonstrates a common case, that fails with the existing
heuristic. That is why we disabled the heuristic in the v2.9.0 release.

With this patch a diff looks like:

         def bar
                 do_bar_stuff()

                 common_ending()
         end

+        def bal
+                do_bal_stuff()
+
+                common_ending()
+        end
+
         def baz
                 do_baz_stuff()

                 common_ending()
         end

whereas before we had:

  WIP (TODO: ask peff to provide an example that actually triggers, I seem to be
       unable to write one, though I thought the above was one)


The way we do it, is by inspecting the neighboring lines and see how
much indent there is and we choose the line that has the shortest amount
of blanks in the neighboring lines.

(TODO: update comments in the file)

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Hi Jeff, hi Michael,

thanks for pointing out the flaw in this ruby code base before the 2.9 release.
I think this patch would fix your finding, though I cannot reproduce it.
Can you provide an example repo/patch that looks ugly on current origin/master,
so I can be sure this fixes the issue?

This can also be a start of a discussion if this is a too short-sighted enhancement
of the heuristic. Essentially we'd want to prefer 

+        end
+
+        def bal

over:

+                do_bal_stuff()
+
+                common_ending()

because there is less space between line start and {end, def bal}
than for {do_bal_stuff, common_ending}.

Thanks,
Stefan

 xdiff/xdiffi.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index b3c6848..58adc74 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -405,6 +405,35 @@ static int is_blank_line(xrecord_t **recs, long ix, long flags)
 	return xdl_blankline(recs[ix]->ptr, recs[ix]->size, flags);
 }
 
+static unsigned int leading_blank(const char *line)
+{
+	unsigned int ret = 0;
+	while (*line) {
+		if (*line == '\t')
+			ret += 8;
+		else if (*line == ' ')
+			ret ++;
+		else
+			break;
+		line++;
+	}
+	return ret;
+}
+
+static unsigned int surrounding_leading_blank(xrecord_t **recs, long ix,
+		long flags, long nrec)
+{
+	unsigned int i, ret = UINT_MAX;
+	if (ix > 0)
+		ret = leading_blank(recs[ix - 1]->ptr);
+	if (ix < nrec - 1) {
+		i = leading_blank(recs[ix + 1]->ptr);
+		if (i < ret)
+			ret = i;
+	}
+	return ret;
+}
+
 static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 {
 	return (recs[ixs]->ha == recs[ix]->ha &&
@@ -416,7 +445,7 @@ static int recs_match(xrecord_t **recs, long ixs, long ix, long flags)
 int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 	long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
 	char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
-	unsigned int blank_lines;
+	unsigned int blank_lines, min_bl_neigh_indent;
 	xrecord_t **recs = xdf->recs;
 
 	/*
@@ -451,6 +480,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		do {
 			grpsiz = ix - ixs;
 			blank_lines = 0;
+			min_bl_neigh_indent = UINT_MAX;
 
 			/*
 			 * If the line before the current change group, is equal to
@@ -485,7 +515,13 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			 * the group.
 			 */
 			while (ix < nrec && recs_match(recs, ixs, ix, flags)) {
-				blank_lines += is_blank_line(recs, ix, flags);
+				if (is_blank_line(recs, ix, flags)) {
+					unsigned int bl_neigh_indent =
+						surrounding_leading_blank(recs, ix, flags, nrec);
+					if (min_bl_neigh_indent > bl_neigh_indent)
+						min_bl_neigh_indent = min_bl_neigh_indent;
+					blank_lines++;
+				}
 
 				rchg[ixs++] = 0;
 				rchg[ix++] = 1;
@@ -525,6 +561,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 		if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
 			while (ixs > 0 &&
 			       !is_blank_line(recs, ix - 1, flags) &&
+			       surrounding_leading_blank(recs, ix - 1, flags, nrec) > min_bl_neigh_indent &&
 			       recs_match(recs, ixs - 1, ix - 1, flags)) {
 				rchg[--ixs] = 1;
 				rchg[--ix] = 0;
-- 
2.9.0.8.gb6cbe66


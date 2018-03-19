Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD701F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968257AbeCSRyo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:54:44 -0400
Received: from avasout04.plus.net ([212.159.14.19]:52928 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965422AbeCSRyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:54:38 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id xyzTeXQarsD7bxyzUe8N5I; Mon, 19 Mar 2018 17:54:36 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=Maj145vmRMi2jL8wVUYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: PATCH 1/2] -Wuninitialized: remove some 'init-self' workarounds
Message-ID: <946e0ff9-307c-6886-6ade-7bd37cc9f97f@ramsayjones.plus.com>
Date:   Mon, 19 Mar 2018 17:54:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDpdyCQM+WUNSDGdn3wcOKzpXB34RMI9ONq0zL+2APj941w+QkTKP6yM4fGNnghTulq3yV5pr5wV/4V6b6eA0bn/qvwiuqsdzfGc4QzeoYVPhdu9DQJ7
 2mxXFB541hgFl+YywNLOy2va3PlVKYRWGxlanK5jGLCo5blz2MWNmeDNedJOmlBYkk/wF/023nse4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'self-initialised' variables construct (ie <type> var = var;) has
been used to silence gcc '-W[maybe-]uninitialized' warnings. This has,
unfortunately, caused MSVC to issue 'uninitialized variable' warnings.
Also, using clang static analysis causes complaints about an 'Assigned
value is garbage or undefined'.

There are six such constructs in the current codebase. Only one of the
six causes gcc to issue a '-Wmaybe-uninitialized' warning (which will
be addressed elsewhere). The remaining five 'init-self' gcc workarounds
are noted below, along with the commit which introduced them:

  1. builtin/rev-list.c: 'reaches' and 'all', see commit 457f08a030
     ("git-rev-list: add --bisect-vars option.", 2007-03-21).

  2. merge-recursive.c:2064 'mrtree', see commit f120ae2a8e ("merge-
     recursive.c: mrtree in merge() is not used before set", 2007-10-29).

  3. fast-import.c:3023 'oe', see commit 85c62395b1 ("fast-import: let
     importers retrieve blobs", 2010-11-28).

  4. fast-import.c:3006 'oe', see commit 28c7b1f7b7 ("fast-import: add a
     get-mark command", 2015-07-01).

Remove the 'self-initialised' variable constructs noted above.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 builtin/rev-list.c | 2 +-
 fast-import.c      | 4 ++--
 merge-recursive.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d5345b6a2..fbfc62de4 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -479,7 +479,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		mark_edges_uninteresting(&revs, show_edge);
 
 	if (bisect_list) {
-		int reaches = reaches, all = all;
+		int reaches, all;
 
 		find_bisection(&revs.commits, &reaches, &all, bisect_find_all);
 
diff --git a/fast-import.c b/fast-import.c
index b70ac025e..1f01a2205 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3003,7 +3003,7 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 
 static void parse_get_mark(const char *p)
 {
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	char output[GIT_MAX_HEXSZ + 2];
 
 	/* get-mark SP <object> LF */
@@ -3020,7 +3020,7 @@ static void parse_get_mark(const char *p)
 
 static void parse_cat_blob(const char *p)
 {
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	struct object_id oid;
 
 	/* cat-blob SP <object> LF */
diff --git a/merge-recursive.c b/merge-recursive.c
index 0fc580d8c..fa9067eec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2061,7 +2061,7 @@ int merge_recursive(struct merge_options *o,
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
-	struct tree *mrtree = mrtree;
+	struct tree *mrtree;
 	int clean;
 
 	if (show(o, 4)) {
-- 
2.16.0

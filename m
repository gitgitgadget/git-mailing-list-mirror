Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231691FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcF2Lic (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:38:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:58511 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767AbcF2Lib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:38:31 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MPUZ7-1bDWr42ybx-004m5i; Wed, 29 Jun 2016 13:38:27
 +0200
Date:	Wed, 29 Jun 2016 13:38:27 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] am: make a direct call to merge_recursive
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CA6smonyLPwGAdRsfNhX7agjiHYSe0bv78w5dKLXgt5sq49l8fL
 gsJSMFf81TjAiJJWTKD2GTZuZK/ZyKPjky+B+EkAgbO9OZ3qdQAXOtLYfbbVmlwes45KSRN
 RhSmeZB9Dp21WINy/46GiYbaF4FBGMliNj+zJj6qEoRLOsOGLmCzbCpL0L2aPCS0J0XFW4S
 OdNMmdLegPeAnsiTU5pcQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YWVI3oLhXps=:Pirky55NpFmgqH19dRJZya
 lvBJ02TybIuiNiyBPuy/yFonYJ/fryuknr/wIXxL3OWHdMZIx0WFQ6kaC4NxTquK7HT2DqKqW
 Bf11Iev4oWukYc+3cgtpZZBcd8NL0R/UwQdSnYbkOKr/sIwYfNReABaw6U2u1Yqb3n9jGMc/4
 tYJaFoJMH0HX+sxAhHPDxEhvGzkGCKruqDM0qp/V0M+4iGk4qs+kGDn9CKFwDV5k9SGC3S02O
 zm2FuM9sk/gJry+1SROLLdShbbCl/xIbvTYlyuguGcmTI3N6a2n8BMfbZvZhFe6f3erBx1CQB
 8x66EcloR5hPptxf+J0rXZkvqj0i3xbpfKB514Z2gWf+0WneZbngiKDwWbPwEuvF/94mGBShJ
 Onjh1+U2DUpJXP81ZnBRKX+8g0dO7W81zu+di9E8AVw+TiOiUwNVaAR9PKYYBBjExx2fXN+9H
 1OYV3IBvwVz0GVuYxOnq3+x6V2eoIINTwguKsTYkN+cXtPYnto0Iyff6u23NwMf31E3G5blw6
 xuo6HM3/PUYTV5eSqZa4GgHzeoqjh65jMZxgP2Byac+98Jn81VrKx/P7uYVeV+qIHD7AyQOkH
 j00ZLVfUdAlCytjIU2+WQqbeUx3UYt8xr7W7nDBc97scEbp+iBPAx3Ke3akKzLxjnlpn7ZRbw
 lE4ePHzQ7FPsxrZ5MBP0eSLYiTvGEmyoDAan/2p//xd/lxqHmQaZ8fJitSgzOuBdfP1n1Ds6P
 6WMd6pak/gDcktbaArrajBP8dqmXR8JKeHtigtzrFc25+AuZacJ2nw6D2924U3QtkDCIQwVT1
 AIT/KuU
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Instead of spawning merge-recursive via run_command() in
run_fallback_merge_recursive(), make a direct call to the internal
merge_recursive_generic().

Here is a quick benchmark result, applying a patch for b4391657
(merge: drop 'git merge <message> HEAD <commit>' syntax, 2015-03-25)
that was still cooking in 'next' on 4b1fd356 (git-multimail: update
to release 1.2.0, 2015-10-11) which was the tip of 'master' at some
stage, on an x86-64 running Ubuntu:

      real    0m0.169s                      real    0m0.163s
      user    0m0.108s                      user    0m0.134s
      sys     0m0.068s                      sys     0m0.033s

      real    0m0.175s                      real    0m0.161s
      user    0m0.110s                      user    0m0.120s
      sys     0m0.066s                      sys     0m0.047s

      real    0m0.168s                      real    0m0.162s
      user    0m0.124s                      user    0m0.114s
      sys     0m0.045s                      sys     0m0.051s

      real    0m0.167s                      real    0m0.152s
      user    0m0.124s                      user    0m0.122s
      sys     0m0.045s                      sys     0m0.031s

      real    0m0.169s                      real    0m0.164s
      user    0m0.131s                      user    0m0.129s
      sys     0m0.043s                      sys     0m0.041s

Left-hand side shows the original, right-hand side shows the result
of this optimization.

Timings on Windows:

original:
0.00user 0.01system 0:00.29elapsed
0.00user 0.00system 0:00.25elapsed
0.01user 0.00system 0:00.24elapsed
0.01user 0.00system 0:00.26elapsed
0.00user 0.01system 0:00.23elapsed

with optimization:
0.00user 0.01system 0:00.22elapsed
0.00user 0.00system 0:00.25elapsed
0.00user 0.01system 0:00.22elapsed
0.00user 0.00system 0:00.22elapsed
0.01user 0.00system 0:00.21elapsed

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	It feels *slightly* wrong to submit your own patch to review,
	however, please keep in mind that

	1) I changed the patch (o.gently does not exist anymore, so I do
	   not set it), and

	2) I added my own timings performed on Windows.

 builtin/am.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..dd41154 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1587,25 +1587,26 @@ static int run_fallback_merge_recursive(const struct am_state *state,
 					unsigned char *our_tree,
 					unsigned char *his_tree)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
+	const unsigned char *bases[1] = {orig_tree};
+	struct merge_options o;
+	struct commit *result;
+	char *his_tree_name;
 	int status;
 
-	cp.git_cmd = 1;
+	init_merge_options(&o);
+
+	o.branch1 = "HEAD";
+	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
+	o.branch2 = his_tree_name;
 
-	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
-			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
 	if (state->quiet)
-		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
+		o.verbosity = 0;
 
-	argv_array_push(&cp.args, "merge-recursive");
-	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
-	argv_array_push(&cp.args, "--");
-	argv_array_push(&cp.args, sha1_to_hex(our_tree));
-	argv_array_push(&cp.args, sha1_to_hex(his_tree));
+	status = merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result);
+	if (status < 0)
+		exit(128);
+	free(his_tree_name);
 
-	status = run_command(&cp) ? (-1) : 0;
-	discard_cache();
-	read_cache();
 	return status;
 }
 
-- 
2.9.0.268.gcabc8b0

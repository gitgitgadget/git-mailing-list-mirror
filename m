Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B7D20248
	for <e@80x24.org>; Sat, 23 Mar 2019 01:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfCWBTm (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 21:19:42 -0400
Received: from avasout03.plus.net ([84.93.230.244]:54247 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCWBTm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 21:19:42 -0400
Received: from [10.0.2.15] ([80.189.70.228])
        by smtp with ESMTPA
        id 7VJvhEu62R9La7VJxhzxyH; Sat, 23 Mar 2019 01:19:38 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Qa0YQfTv c=1 sm=1 tr=0
 a=5/rI1lTgw+ttA0Fwm4j1LQ==:117 a=5/rI1lTgw+ttA0Fwm4j1LQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=mz2ivM95io141dX7X_QA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] commit-graph: fix sparse 'NULL pointer' warning
Message-ID: <1908832c-8dd0-377e-917b-acb33b00273c@ramsayjones.plus.com>
Date:   Sat, 23 Mar 2019 01:19:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDAP2v5wKK0AvpSVc8Cam+9jFi6MoEhCkskpT+5Kvv+nnG/MuHYJjrXaJW+XBnMqs2gPrzCJCn88PZL2oYQZfc7IA/HuD+ksx7nMgA/0oPip9dbaNCt/
 +RYMN78Z+BiWa2zoiPwoLtYuQMTSkS0PhPR6Ms9sLCANvEFRFFMtl1KmaIQGFZX3TDNnMORCsVCPqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Ævar,

If you need to re-roll your 'ab/commit-graph-fixes' branch, could you
please squash this into the relevant patch (commit aeb244adbc
("commit-graph: don't early exit(1) on e.g. \"git status\"", 2019-02-21).

This same commit (aeb244adbc) also removes the last call, outside of the
commit-graph.c file, to the function load_commit_graph_one(). So, this
function is now a file-local symbol and could be marked 'static'.

Also, the function verify_commit_graph_lite(), introduced in commit
d8acf37ff7 ("commit-graph: fix segfault on e.g. \"git status\"",
2019-02-21), currently has no external callers. This function is also
a file-local symbol and could be marked 'static', unless you have plans
for future external calls?

Thanks!

ATB,
Ramsay Jones

 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 4696ee0036..680c6f5714 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -100,7 +100,7 @@ struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st)
 	if (graph_size < GRAPH_MIN_SIZE) {
 		close(fd);
 		error(_("commit-graph file is too small"));
-		return 0;
+		return NULL;
 	}
 	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	ret = parse_commit_graph(graph_map, fd, graph_size);
-- 
2.21.0

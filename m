Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854D81F404
	for <e@80x24.org>; Sat, 24 Feb 2018 02:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbeBXCYP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 21:24:15 -0500
Received: from avasout01.plus.net ([84.93.230.227]:41745 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752011AbeBXCYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 21:24:14 -0500
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id pPVTepr77H3zXpPVVeypMA; Sat, 24 Feb 2018 02:24:13 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=IJQs9DnG c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=T8cqLZuz-gKAs2iCaVcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     stolee@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] commit-graph: fix some "plain integer as NULL pointer"
 warnings
Message-ID: <e0bc5fe0-3b32-bebf-11cd-e335a8cf4e1c@ramsayjones.plus.com>
Date:   Sat, 24 Feb 2018 02:24:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfORL/0gTG+f16ZKSnhbDRlP9efKuRtrYb11ZNFjGOa14xEB7SEzXnOwD4vOnsJeaOTFMDhnpSBQPHm98p11eKiveoRZp7TtA9Kkq7xtjEReu6iWyuW+/
 AtOZMabSNTLubyP7UlbSmv2pW2LQdCYByhD8YaIWuL5swcBGnig5esRSPdTehM25L8bMccs6AlYMVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Derrick,

If you need to re-roll your 'ds/commit-graph' branch, could you
please squash this into the relevant patches (corresponding to
commits 0fd2d95ee6 ["commit-graph: implement --set-latest"],
a33b9b79ff ["commit-graph: implement --delete-expired"] and finally
commit b534f9e961 ["commit-graph: implement git commit-graph read"]).

Also, I note that two symbols are only used in commit-graph.c but
are declared extern. Namely 'commit_graph' (declared line #42) and
'prepare_commit_graph' (declared line #212). Do these symbols need
to be extern (in future patches, perhaps)?

Thanks!

ATB,
Ramsay Jones

 builtin/commit-graph.c | 2 +-
 commit-graph.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index be1883f1b..efdb003ca 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -33,7 +33,7 @@ static struct opts_commit_graph {
 
 static int graph_read(int argc, const char **argv)
 {
-	struct commit_graph *graph = 0;
+	struct commit_graph *graph = NULL;
 	struct strbuf full_path = STRBUF_INIT;
 
 	static struct option builtin_commit_graph_read_options[] = {
diff --git a/commit-graph.c b/commit-graph.c
index fc5ee7e99..c2f443436 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -45,7 +45,7 @@ char *get_graph_latest_filename(const char *obj_dir)
 {
 	struct strbuf fname = STRBUF_INIT;
 	strbuf_addf(&fname, "%s/info/graph-latest", obj_dir);
-	return strbuf_detach(&fname, 0);
+	return strbuf_detach(&fname, NULL);
 }
 
 char *get_graph_latest_contents(const char *obj_dir)
@@ -60,7 +60,7 @@ char *get_graph_latest_contents(const char *obj_dir)
 	FREE_AND_NULL(fname);
 
 	if (!f)
-		return 0;
+		return NULL;
 
 	while (!feof(f)) {
 		if (fgets(buf, sizeof(buf), f))
@@ -95,10 +95,10 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 	unsigned char graph_version, hash_version;
 
 	if (fd < 0)
-		return 0;
+		return NULL;
 	if (fstat(fd, &st)) {
 		close(fd);
-		return 0;
+		return NULL;
 	}
 	graph_size = xsize_t(st.st_size);
 
-- 
2.16.0

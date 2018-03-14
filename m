Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585B21F404
	for <e@80x24.org>; Wed, 14 Mar 2018 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeCNULG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 16:11:06 -0400
Received: from avasout04.plus.net ([212.159.14.19]:58656 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCNULE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 16:11:04 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id wCjjeLNrCsD7bwCjke41pl; Wed, 14 Mar 2018 20:11:03 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=7C2WyCFVwCjHCduJU-wA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d55fb94e-1f79-f120-7f3f-190cacfa72be@ramsayjones.plus.com>
Date:   Wed, 14 Mar 2018 20:10:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCom2UPdrMg66MYecT4UYTQoexs7uJh6jZLs1xWabn06KSY9Y2n7/Ll8aYIGmOGwIz0LCTvK6muYsJn/dyIL+PBN+VrcPwl/J9yVqL6G9FKQQtFhwYuR
 +t8d0Kcw7y+ONd/a/wRU4oI+3TG6DOz9YS2yC9U4DrX7+fGGfqBUboBW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/03/18 19:27, Derrick Stolee wrote:
> This v6 includes feedback around csum-file.c and the rename of hashclose()
> to finalize_hashfile(). These are the first two commits of the series, so
> they could be pulled out independently.
> 
> The only other change since v5 is that I re-ran the performance numbers
> in "commit: integrate commit graph with commit parsing".

I haven't looked at v6 (I will wait for it to hit pu), but v5 is
still causing sparse to complain.

The diff given below (on top of current pu @9e418c7c9), fixes it
for me. (Using a plain integer as a NULL pointer, in builtin/commit-
graph.c, and the 'commit_graph' symbol should be file-local, in
commit-graph.c).

Thanks!

ATB,
Ramsay Jones

-- >8 --
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 62ac26e44..855df66bd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -31,7 +31,7 @@ static struct opts_commit_graph {
 
 static int graph_read(int argc, const char **argv)
 {
-	struct commit_graph *graph = 0;
+	struct commit_graph *graph = NULL;
 	char *graph_name;
 
 	static struct option builtin_commit_graph_read_options[] = {
diff --git a/commit-graph.c b/commit-graph.c
index 631edac4c..7b45fe85d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -182,7 +182,7 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
 }
 
 /* global storage */
-struct commit_graph *commit_graph = NULL;
+static struct commit_graph *commit_graph = NULL;
 
 static void prepare_commit_graph_one(const char *obj_dir)
 {


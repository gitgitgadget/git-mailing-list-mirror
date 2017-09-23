Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEF620281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbdIWT4T (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:56:19 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:52572
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751495AbdIWTz5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ndaiV1qd+XDAhHW41F1+AM6/AyEjuSE5+0iqhFVaqjY=;
        b=arQp0Kc5upybff1KLTJkJeBinNgWkN+wTuNsm08zO28+HfmEeeeIDPE3kpVQUUwc
        zBSughRkkNxIifJeXu1x6WlXDq7cP0OlthacItqNsGQ/w2RhQfuTdJolPTXmlXTrkay
        0Ps9Pc7FXqxnkNPvB+Atv2VePlzLlDU9oHXhQEoU=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f8a12-84068e82-d13c-48d5-8147-3525b95a5481-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 7/9] perf/run: add run_subsection()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's actually use the subsections we find in the config file
to run the perf tests separately for each subsection.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index bd39398b9cc7d..cb8687bfcf98d 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -125,23 +125,46 @@ get_var_from_env_or_config () {
 	test -n "${4+x}" && eval "$env_var=\"$4\""
 }
 
-get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" 3
-export GIT_PERF_REPEAT_COUNT
+run_subsection () {
+	get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" 3
+	export GIT_PERF_REPEAT_COUNT
 
-get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf" "dirsOrRevs"
-set -- $GIT_PERF_DIRS_OR_REVS "$@"
+	get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf" "dirsOrRevs"
+	set -- $GIT_PERF_DIRS_OR_REVS "$@"
 
-get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
-get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
+	get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
+	get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
 
-GIT_PERF_AGGREGATING_LATER=t
-export GIT_PERF_AGGREGATING_LATER
+	GIT_PERF_AGGREGATING_LATER=t
+	export GIT_PERF_AGGREGATING_LATER
+
+	if test $# = 0 -o "$1" = -- -o -f "$1"; then
+		set -- . "$@"
+	fi
+
+	run_dirs "$@"
+	./aggregate.perl "$@"
+}
 
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
 
-if test $# = 0 -o "$1" = -- -o -f "$1"; then
-	set -- . "$@"
+mkdir -p test-results
+get_subsections "perf" >test-results/run_subsections.names
+
+if test $(wc -l <test-results/run_subsections.names) -eq 0
+then
+	(
+		run_subsection "$@"
+	)
+else
+	while read -r subsec
+	do
+		(
+			GIT_PERF_SUBSECTION="$subsec"
+			export GIT_PERF_SUBSECTION
+			echo "======== Run for subsection '$GIT_PERF_SUBSECTION' ========"
+			run_subsection "$@"
+		)
+	done <test-results/run_subsections.names
 fi
-run_dirs "$@"
-./aggregate.perl "$@"

--
https://github.com/git/git/pull/408

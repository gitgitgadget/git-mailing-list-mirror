Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2205620281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbdIWTz6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:55:58 -0400
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59944
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751490AbdIWTz5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=BxT/TYVAs0Xz8VeC1XwqfqNAKWZauD2sJtv/DHxjLWQ=;
        b=A6j2AmfBXVibepEgsJxZsqAS5P/23p+/3ZJEwVbhySsQKx4j1FguYNuNzEQGeaAA
        GODt9PfBSDiQMaUyXlx8LWQosyJMtabW8k8DHSPPH/01kDT5FT5kc6JGCBllL/2BzDo
        5dhGEpnkEUsYiLZJBGtiIEmsumPUoY+v7mtftLrk=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f8a10-6bd51c94-e861-4302-8325-71ce93a07ede-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 6/9] perf/run: update get_var_from_env_or_config() for
 subsections
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we will set some config options in subsections, let's
teach get_var_from_env_or_config() to get the config options
from the subsections if they are set there.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/run | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/t/perf/run b/t/perf/run
index 4c966c0ae420e..bd39398b9cc7d 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -102,29 +102,37 @@ get_subsections () {
 
 get_var_from_env_or_config () {
 	env_var="$1"
-	conf_var="$2"
-	# $3 can be set to a default value
+	conf_sec="$2"
+	conf_var="$3"
+	# $4 can be set to a default value
 
 	# Do nothing if the env variable is already set
 	eval "test -z \"\${$env_var+x}\"" || return
 
+	test -z "$GIT_PERF_CONFIG_FILE" && return
+
 	# Check if the variable is in the config file
-	test -n "$GIT_PERF_CONFIG_FILE" &&
-	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$conf_var") &&
-	eval "$env_var=\"$conf_value\"" || {
-		test -n "${3+x}" &&
-		eval "$env_var=\"$3\""
-	}
+	if test -n "$GIT_PERF_SUBSECTION"
+	then
+		var="$conf_sec.$GIT_PERF_SUBSECTION.$conf_var"
+		conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
+		eval "$env_var=\"$conf_value\"" && return
+	fi
+	var="$conf_sec.$conf_var"
+	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$var") &&
+	eval "$env_var=\"$conf_value\"" && return
+
+	test -n "${4+x}" && eval "$env_var=\"$4\""
 }
 
-get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf.repeatCount" 3
+get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf" "repeatCount" 3
 export GIT_PERF_REPEAT_COUNT
 
-get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf.dirsOrRevs"
+get_var_from_env_or_config "GIT_PERF_DIRS_OR_REVS" "perf" "dirsOrRevs"
 set -- $GIT_PERF_DIRS_OR_REVS "$@"
 
-get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf.makeCommand"
-get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf.makeOpts"
+get_var_from_env_or_config "GIT_PERF_MAKE_COMMAND" "perf" "makeCommand"
+get_var_from_env_or_config "GIT_PERF_MAKE_OPTS" "perf" "makeOpts"
 
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER

--
https://github.com/git/git/pull/408

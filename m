Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE47E20281
	for <e@80x24.org>; Sat, 23 Sep 2017 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdIWT4G (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 15:56:06 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:53196
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751578AbdIWTz6 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 23 Sep 2017 15:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506196556;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=+hKUpGAbdHW18k8faPbFTgLrHofhl97pWFoJatkzHJE=;
        b=LKM2cPt0LpYaOPikXsCmHbC0ChgVOGL/1R2hK6wMtg8qGMJRbIIFJhXz5nIdqN7F
        ZMj92G37iBDt8DalDsVIyx6eMRXJTd3VyRhOzXJcgLm9RGmYs18hBzZKFhB0vCW8SSI
        uT+4fcVKqxs3B7Q137TRLb7lt/Gt2W4thG1Z0+d0=
From:   Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Message-ID: <0102015eb04f89d7-11cb1e45-a3d5-49f4-9593-518411971e80-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
References: <0102015eb04f8927-439213ae-a464-4638-affa-f0d6484086c0-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2 2/9] perf/run: add get_var_from_env_or_config()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Sep 2017 19:55:56 +0000
X-SES-Outgoing: 2017.09.23-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add get_var_from_env_or_config() to easily set variables
from a config file if they are defined there and not already set.

This can also set them to a default value if one is provided.

As an example, use this function to set GIT_PERF_REPEAT_COUNT
from the perf.repeatCount config option or from the default
value.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/perf/perf-lib.sh |  3 ---
 t/perf/run         | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index b50211b2591d1..2f88fc12a9b5c 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -59,9 +59,6 @@ perf_results_dir=$TEST_OUTPUT_DIRECTORY/test-results
 mkdir -p "$perf_results_dir"
 rm -f "$perf_results_dir"/$(basename "$0" .sh).subtests
 
-if test -z "$GIT_PERF_REPEAT_COUNT"; then
-	GIT_PERF_REPEAT_COUNT=3
-fi
 die_if_build_dir_not_repo () {
 	if ! ( cd "$TEST_DIRECTORY/.." &&
 		    git rev-parse --build-dir >/dev/null 2>&1 ); then
diff --git a/t/perf/run b/t/perf/run
index 1e7c2a59e45dc..41580ac6df44a 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -34,6 +34,7 @@ unpack_git_rev () {
 	(cd "$(git rev-parse --show-cdup)" && git archive --format=tar $rev) |
 	(cd build/$rev && tar x)
 }
+
 build_git_rev () {
 	rev=$1
 	for config in config.mak config.mak.autogen config.status
@@ -92,6 +93,26 @@ run_dirs () {
 	done
 }
 
+get_var_from_env_or_config () {
+	env_var="$1"
+	conf_var="$2"
+	# $3 can be set to a default value
+
+	# Do nothing if the env variable is already set
+	eval "test -z \"\${$env_var+x}\"" || return
+
+	# Check if the variable is in the config file
+	test -n "$GIT_PERF_CONFIG_FILE" &&
+	conf_value=$(git config -f "$GIT_PERF_CONFIG_FILE" "$conf_var") &&
+	eval "$env_var=\"$conf_value\"" || {
+		test -n "${3+x}" &&
+		eval "$env_var=\"$3\""
+	}
+}
+
+get_var_from_env_or_config "GIT_PERF_REPEAT_COUNT" "perf.repeatCount" 3
+export GIT_PERF_REPEAT_COUNT
+
 GIT_PERF_AGGREGATING_LATER=t
 export GIT_PERF_AGGREGATING_LATER
 

--
https://github.com/git/git/pull/408

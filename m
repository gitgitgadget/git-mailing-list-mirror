From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH] diff: Pass 'changes found' flag to external diff tools
Date: Thu,  9 Oct 2014 14:17:50 +1100
Message-ID: <1412824670-81736-1-git-send-email-zoltan.klinger@gmail.com>
Cc: Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 05:18:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc4FW-0000yr-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 05:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbaJIDSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 23:18:39 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34416 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbaJIDSh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 23:18:37 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so10334331igb.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 20:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=JTNqS2JozGylDzxXmFJnEFcJeSlryiPSBcrYIdjFYS4=;
        b=HQWyc9i6qKxKA/I8QDAHatfNMllYHJZ57kJebzu61oID0AAbomEcmlqJG0cB9YXvZu
         7mTchuepKiT0Rf0d+duo2wVgLT/zkBFlYLDPTVNqUCnKwcOfSQJdWfKvJSl5Ji32Gpzv
         yVFWLaCpzaXQ4g/tnUPx9kWubCmcUhZD11tBYnDvJzW9yyCgvQGxCPAOB1T6gKH4WjEl
         NRiut+FiW+7kOdlYXBPCM9ZkKGB6kTJcRMG7Z2pfBKseGfMUnJwYIYCxK10FzZZF0BZX
         TikUCWVUcnS3giEDWxU3alCMqpvMY4p3InjqYYRYxgmtBMr/EHS8hJi+aYbzdtX/uiBw
         pzlg==
X-Received: by 10.50.20.4 with SMTP id j4mr3908492ige.13.1412824716930;
        Wed, 08 Oct 2014 20:18:36 -0700 (PDT)
Received: from localhost.localdomain (202-129-81-152.perm.iinet.net.au. [202.129.81.152])
        by mx.google.com with ESMTPSA id nu1sm2004855igb.0.2014.10.08.20.18.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 20:18:36 -0700 (PDT)
X-Mailer: git-send-email 2.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When GIT_EXTERNAL_DIFF is defined and git diff is called with any of the
'ignore whitespace' type command line arguments such as -w, -b or
--ignore-space-at-eol, git diff ignores these flags and invokes
GIT_EXTERNAL_DIFF for each changed file in the diff queue. If the diff
queue contains file(s) with only whitespace changes, the external diff
tool displays diffs for changes that the user specifically did not ask
for.

For external diff tools, therefore, it could be useful if git diff set a
GIT_DIFF_FOUND_CHANGES environment variable for each file in the diff
queue. This variable could be examined by the external diff tool to
decide whether to show a diff or skip the file.

To implement it:
(a) Modify diff.c to indicate to external diff tools which file
    contains changes the tool should care about:
        Only when GIT_EXTERNAL_DIFF is defined and either
        --ignore-space-change, --ignore-all-space or
        --ignore-space-at-eol option is set, run diffstat on the current
        file in the diff queue to find out the number of deleted and
        inserted changes. Based on this set the environment variable
        GIT_DIFF_FOUND_CHANGES to "1" or "0". If GIT_EXTERNAL_DIFF is
        defined but none of the 'ignore whitespace' command line
        arguments is set, set GIT_DIFF_FOUND_CHANGES to "1".

(b) Modify git-difftool--helper.sh to make use of the GIT_DIFF_FOUND_CHANGES
    variable: do not invok the external diff tool on files for which
    GIT_DIFF_FOUND_CHANGES is set to false.

(c) Update documentation and create unit tests.

Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---
 Documentation/git.txt    | 11 +++++++++--
 diff.c                   | 12 ++++++++++++
 git-difftool--helper.sh  | 39 ++++++++++++++++++++++++---------------
 t/t4020-diff-external.sh | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 17 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c6175d4..46030d0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -846,8 +846,9 @@ temporary file --- it is removed when 'GIT_EXTERNAL_DIFF' exits.
 For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
 parameter, <path>.
 +
-For each path 'GIT_EXTERNAL_DIFF' is called, two environment variables,
-'GIT_DIFF_PATH_COUNTER' and 'GIT_DIFF_PATH_TOTAL' are set.
+For each path 'GIT_EXTERNAL_DIFF' is called, three environment
+variables, 'GIT_DIFF_PATH_COUNTER', 'GIT_DIFF_PATH_TOTAL' and
+'GIT_DIFF_FOUND_CHANGES' are set.
 
 'GIT_DIFF_PATH_COUNTER'::
 	A 1-based counter incremented by one for every path.
@@ -855,6 +856,12 @@ For each path 'GIT_EXTERNAL_DIFF' is called, two environment variables,
 'GIT_DIFF_PATH_TOTAL'::
 	The total number of paths.
 
+'GIT_DIFF_FOUND_CHANGES'::
+	This variable is set to "0" if 'GIT_EXTERNAL_DIFF' is called with
+	either --ignore-space-change, --ignore-all-space or
+	--ignore-space-at-eol argument and the path has only whitespace
+	changes. Otherwise it is set to "1".
+
 other
 ~~~~~
 'GIT_MERGE_VERBOSITY'::
diff --git a/diff.c b/diff.c
index d7a5c81..a5045d5 100644
--- a/diff.c
+++ b/diff.c
@@ -2953,6 +2953,7 @@ static void run_external_diff(const char *pgm,
 
 	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
 	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
+	argv_array_pushf(&env, "GIT_DIFF_FOUND_CHANGES=%d", o->found_changes);
 
 	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
 		die(_("external diff died, stopping at %s"), name);
@@ -3034,6 +3035,9 @@ static void fill_metainfo(struct strbuf *msg,
 	}
 }
 
+static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
+			    struct diffstat_t *diffstat);
+
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
@@ -3067,6 +3071,14 @@ static void run_diff_cmd(const char *pgm,
 	}
 
 	if (pgm) {
+		o->found_changes = 1;
+		if (DIFF_OPT_TST(o, DIFF_FROM_CONTENTS)) {
+			struct diffstat_t diffstat;
+			memset(&diffstat, 0, sizeof(struct diffstat_t));
+			diff_flush_stat(p, o, &diffstat);
+			o->found_changes = (diffstat.files[0]->added || diffstat.files[0]->deleted);
+		}
+
 		run_external_diff(pgm, name, other, one, two, xfrm_msg,
 				  complete_rewrite, o);
 		return;
diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index 7ef36b9..1d3918c 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -40,27 +40,36 @@ launch_merge_tool () {
 	# the user with the real $MERGED name before launching $merge_tool.
 	if should_prompt
 	then
-		printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
-			"$GIT_DIFF_PATH_TOTAL" "$MERGED"
-		if use_ext_cmd
+		if test $GIT_DIFF_FOUND_CHANGES -eq 1
 		then
-			printf "Launch '%s' [Y/n]: " \
-				"$GIT_DIFFTOOL_EXTCMD"
+			printf "\nViewing (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
+				"$GIT_DIFF_PATH_TOTAL" "$MERGED"
+			if use_ext_cmd
+			then
+				printf "Launch '%s' [Y/n]: " \
+					"$GIT_DIFFTOOL_EXTCMD"
+			else
+				printf "Launch '%s' [Y/n]: " "$merge_tool"
+			fi
+			if read ans && test "$ans" = n
+			then
+				return
+			fi
 		else
-			printf "Launch '%s' [Y/n]: " "$merge_tool"
-		fi
-		if read ans && test "$ans" = n
-		then
-			return
+			printf "\nSkipping (%s/%s): '%s'\n" "$GIT_DIFF_PATH_COUNTER" \
+				"$GIT_DIFF_PATH_TOTAL" "$MERGED"
 		fi
 	fi
 
-	if use_ext_cmd
+	if test $GIT_DIFF_FOUND_CHANGES -eq 1
 	then
-		export BASE
-		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
-	else
-		run_merge_tool "$merge_tool"
+		if use_ext_cmd
+		then
+			export BASE
+			eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
+		else
+			run_merge_tool "$merge_tool"
+		fi
 	fi
 }
 
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 0446201..09452f2 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -206,6 +206,39 @@ test_expect_success 'GIT_EXTERNAL_DIFF path counter/total' '
 	test_cmp expect counter.txt
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF found changes' '
+	echo the quick brown fox >whitespace.txt &&
+	git add whitespace.txt &&
+	echo "  the    quick    brown    fox  " >whitespace.txt &&
+	write_script found_changes.sh <<-\EOF &&
+	echo $GIT_DIFF_FOUND_CHANGES >>changes.txt
+	EOF
+	>changes.txt &&
+	cat >expect <<-\EOF &&
+	1
+	1
+	1
+	EOF
+	GIT_EXTERNAL_DIFF=./found_changes.sh git diff &&
+	test_cmp expect changes.txt
+'
+
+test_expect_success 'GIT_EXTERNAL_DIFF ignore whitespace changes' '
+	cat >expect <<-\EOF &&
+	1
+	1
+	0
+	EOF
+	rm changes.txt &&
+	GIT_EXTERNAL_DIFF=./found_changes.sh git diff --ignore-all-space &&
+	test_cmp expect changes.txt
+'
+
+test_expect_success 'clean up whitespace leftovers' '
+	git update-index --force-remove whitespace.txt &&
+	rm whitespace.txt
+'
+
 test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
 	touch file.ext &&
 	git add file.ext &&
-- 
2.1.1

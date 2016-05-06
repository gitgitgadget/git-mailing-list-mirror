From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 2/2] rev-parse: fix some options when executed from subpath of main tree
Date: Fri,  6 May 2016 09:35:20 -0400
Message-ID: <1462541720-79553-3-git-send-email-rappazzo@gmail.com>
References: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, szeder@ira.uka.de,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 15:35:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfua-0004xq-89
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758330AbcEFNfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:35:11 -0400
Received: from mail-qg0-f68.google.com ([209.85.192.68]:36535 "EHLO
	mail-qg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbcEFNfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:35:09 -0400
Received: by mail-qg0-f68.google.com with SMTP id f74so6887406qge.3
        for <git@vger.kernel.org>; Fri, 06 May 2016 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gL5M1X0OfGPSRKJd6HJZBl0yd2MAdlJw3KMqhMfApLo=;
        b=CxfkJM2YwBOeG8jsFmT0z8ijOkJh/q6cwjNChz+JX8HESd8dNFv9c3hRRqwLQFQB1y
         iLU7KydDWsuBwlUzYSjRy/CrSxrOYXrJZ6qeDPyuO4mCNAlGtfQvDwnoT400ORydBvwd
         FqxezNebIB71jXQUk2poDuD0CbxSaLx7v0HdNe08AZShKjJUokvXMAIsc2bloSh/5iS1
         hoUBKAKzmfzufAO9JkAgzCxmBaLYK35mlSY/Ld13M0hFXVMNXB6DPGqBGc4WXqW9McNK
         AJOR4gnYUtfKDZBuj4O1V1fHpRqImhdhTS324DOcAoB4N0+ViG7Z1KOVRa30NG1i9Nem
         fxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gL5M1X0OfGPSRKJd6HJZBl0yd2MAdlJw3KMqhMfApLo=;
        b=hYeLL8xC5M7/bkJMHYbmDO32YzukbaRUgkK273JWwfg8zHbEM0jMIpP17/Zh47ejug
         netuSpDG4ZWJorrCYdXcdkkLpycPUXdvvd7T5tCHSCsECdVtwh96WcMF0hHL2Qg2e5lB
         3f4j04HjX6PpeGgkcSYWW21J9lDh/KYbrm/jgrNT/eeGDUoYQ13Yi5AsC7/pz30/RlKm
         ZxRKpL2KD354vWpLti/orxDZWoE8kOh24UDQUdSweI3sBcdPH2J2LZNRr29vv/hIxBK0
         5Ut4nemLlzFLNSNLtPVE6pG0focGtcnbFG0WWYAZc5Y0KAWHxIhhcT9Dc1RpyuLc1Kr8
         QHNA==
X-Gm-Message-State: AOPr4FWDEcFVw0McMvmqabCzfOYMpmWs5m2Ho5qsEK28WkbU97SUkECDm/lKBFkMGQ2U7Q==
X-Received: by 10.141.30.201 with SMTP id t70mr21163625qhf.3.1462541708433;
        Fri, 06 May 2016 06:35:08 -0700 (PDT)
Received: from mrappazzo-8.infor.com (rrcs-198-179-75-179.nyc.biz.rr.com. [198.179.75.179])
        by smtp.gmail.com with ESMTPSA id w17sm5702457qha.23.2016.05.06.06.35.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 06 May 2016 06:35:07 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1462541720-79553-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293779>

Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
or `--shared-index-path` from the root of the main worktree results in
a relative path to the git dir.

When executed from a subdirectory of the main tree, it can incorrectly
return a path which starts 'sub/path/.git'.  Change this to return the
proper relative path to the git directory.

Related tests marked to expect failure are updated to expect success

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/rev-parse.c      | 19 ++++++++++++++-----
 t/t1500-rev-parse.sh     |  4 ++--
 t/t1700-split-index.sh   |  2 +-
 t/t2027-worktree-list.sh |  4 ++--
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c961b74..1da2e10 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -564,10 +564,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!strcmp(arg, "--git-path")) {
+			struct strbuf sb = STRBUF_INIT;
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
-			puts(git_path("%s", argv[i + 1]));
-			i++;
+
+			puts(relative_path(xstrfmt("%s/%s", get_git_dir(), argv[++i]),
+				prefix, &sb));
+			strbuf_release(&sb);
 			continue;
 		}
 		if (as_is) {
@@ -787,8 +790,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				const char *pfx = prefix ? prefix : "";
-				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
+				struct strbuf sb = STRBUF_INIT;
+				puts(relative_path(get_git_common_dir(), prefix, &sb));
+				strbuf_release(&sb);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -811,7 +815,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
-					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
+					struct strbuf sb = STRBUF_INIT;
+
+					puts(relative_path(
+						xstrfmt("%s/sharedindex.%s", get_git_dir(), sha1_to_hex(sha1)),
+						prefix, &sb));
+					strbuf_release(&sb);
 				}
 				continue;
 			}
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 442ca46..cc89392 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -100,7 +100,7 @@ test_expect_success 'git-common-dir from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-common-dir inside sub-dir' '
+test_expect_success 'git-common-dir inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
@@ -114,7 +114,7 @@ test_expect_success 'git-path from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-path inside sub-dir' '
+test_expect_success 'git-path inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git/objects" >expect &&
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 8ca21bd..d2d9e02 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -200,7 +200,7 @@ EOF
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-parse --shared-index-path' '
+test_expect_success 'rev-parse --shared-index-path' '
 	rm -rf .git &&
 	test_create_repo . &&
 	git update-index --split-index &&
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 53cc5d3..16eec6e 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -8,7 +8,7 @@ test_expect_success 'setup' '
 	test_commit init
 '
 
-test_expect_failure 'rev-parse --git-common-dir on main worktree' '
+test_expect_success 'rev-parse --git-common-dir on main worktree' '
 	git rev-parse --git-common-dir >actual &&
 	echo .git >expected &&
 	test_cmp expected actual &&
@@ -18,7 +18,7 @@ test_expect_failure 'rev-parse --git-common-dir on main worktree' '
 	test_cmp expected2 actual2
 '
 
-test_expect_failure 'rev-parse --git-path objects linked worktree' '
+test_expect_success 'rev-parse --git-path objects linked worktree' '
 	echo "$(git rev-parse --show-toplevel)/.git/worktrees/linked-tree/objects" >expect &&
 	test_when_finished "rm -rf linked-tree && git worktree prune" &&
 	git worktree add --detach linked-tree master &&
-- 
2.8.0

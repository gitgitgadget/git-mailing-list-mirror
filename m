From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v4 2/2] rev-parse: fix some options when executed from subpath of main tree
Date: Thu, 26 May 2016 07:19:16 -0400
Message-ID: <1464261556-89722-3-git-send-email-rappazzo@gmail.com>
References: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com, szeder@ira.uka.de,
	mh@glandium.org, sunshine@sunshineco.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 13:19:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5tJz-0004oE-4f
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 13:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbcEZLTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 07:19:18 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36591 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbcEZLTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 07:19:14 -0400
Received: by mail-yw0-f196.google.com with SMTP id l126so1676810ywe.3
        for <git@vger.kernel.org>; Thu, 26 May 2016 04:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yquNLP8S1kLqcpXZVNSFQSWviIEUFTKRqKPg+k+GgK4=;
        b=gXTtii39ii9rE82HaMM0jkJNIeRzGeZBh9V0nd0gmkOLqqLsM6RLkzx5VHnMGujK0g
         aMnBHFC9yc46ObABZ8r2B1IOZBJcHyJ9Dx1UPA1A9Br4c5DLbtGRZonR3JVsuTKhEg0Q
         SRhbazMfty52fC4reto9xfRd9lE6ZfUj8IcY7Xt+pL/HsJLDhCLZ+CRLWaJrYk/VLMop
         c4TkKh1FhiWp9bS9f2mOrQqVCnNHdtBFixJJJ8/4i9w/YW1FljMPjiRpYtGTzc2AawwZ
         H1loaB1wboCIUAtx30g2PL2KXsF1Ph6bqfVg3HxLFue3ujo+aGf62c27YeLJnxamBAue
         d/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yquNLP8S1kLqcpXZVNSFQSWviIEUFTKRqKPg+k+GgK4=;
        b=cvGdRroM6HI4teryI2tXUhfkSK+7lHXMsfsRp2dydx8wubZzGSlS+u8lZ0C08d6Ceh
         op2TuIWwPK2Ipt1h+Bba0sVllTjEIODVkw5b0tD7uan/jLvcvGho/fJtf3hyPc/0ZgeK
         1YnDIABJI9At1h+xnRpLr2oVsUzBzpFuCCdC5T/6XA1uh3TC12yK4kqQBuFizGzkB06K
         Xcj9WorTSR79XYao7h05xbEFsf0L4u32Z34zMESuETddotl7HnJr+Nzqjb/o4PFub8W5
         4ORp0SiMY07rszs3HKmN8RBLzkpOeYqDU1IQxdzkcU0njSlLEixkr2IiZsVeRoig3WwA
         B1bA==
X-Gm-Message-State: ALyK8tLPJSH/mEwFhgcVWSPjJQX/ZeY6d/4XIRXTaTtD5pM8yPrqFk+iQfNbgeAmusYE6A==
X-Received: by 10.37.72.195 with SMTP id v186mr5154211yba.101.1464261553139;
        Thu, 26 May 2016 04:19:13 -0700 (PDT)
Received: from localhost.localdomain (146.sub-70-208-87.myvzw.com. [70.208.87.146])
        by smtp.gmail.com with ESMTPSA id l200sm2095979ywe.40.2016.05.26.04.19.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 26 May 2016 04:19:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295646>

Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
or `--shared-index-path` from the root of the main worktree results in
a relative path to the git dir.

When executed from a subdirectory of the main tree, it can incorrectly
return a path which starts 'sub/path/.git'.  Change this to return the
proper relative path to the git directory.

Related tests marked to expect failure are updated to expect success

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/rev-parse.c      | 22 +++++++++++++++++-----
 t/t1500-rev-parse.sh     |  4 ++--
 t/t1700-split-index.sh   |  2 +-
 t/t2027-worktree-list.sh |  4 ++--
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c961b74..40579e0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -564,10 +564,15 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!strcmp(arg, "--git-path")) {
+			struct strbuf sb = STRBUF_INIT;
+			char *path;
 			if (!argv[i + 1])
 				die("--git-path requires an argument");
-			puts(git_path("%s", argv[i + 1]));
-			i++;
+
+			path = xstrfmt("%s/%s", get_git_dir(), argv[++i]);
+			puts(relative_path(path, prefix, &sb));
+			strbuf_release(&sb);
+			free(path);
 			continue;
 		}
 		if (as_is) {
@@ -787,8 +792,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
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
@@ -811,7 +817,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 					die(_("Could not read the index"));
 				if (the_index.split_index) {
 					const unsigned char *sha1 = the_index.split_index->base_sha1;
-					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
+					struct strbuf sb = STRBUF_INIT;
+					char *path;
+
+					path = xstrfmt("%s/sharedindex.%s", get_git_dir(), sha1_to_hex(sha1));
+					puts(relative_path(path, prefix, &sb));
+					strbuf_release(&sb);
+					free(path);
 				}
 				continue;
 			}
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index f39f783..d74f09a 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -93,7 +93,7 @@ test_expect_success 'git-common-dir from worktree root' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'git-common-dir inside sub-dir' '
+test_expect_success 'git-common-dir inside sub-dir' '
 	mkdir -p path/to/child &&
 	test_when_finished "rm -rf path" &&
 	echo "$(git -C path/to/child rev-parse --show-cdup).git" >expect &&
@@ -107,7 +107,7 @@ test_expect_success 'git-path from worktree root' '
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

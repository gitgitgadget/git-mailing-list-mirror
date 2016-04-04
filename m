From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] rev-parse: fix --git-common-dir when executed from subpath of main tree
Date: Sun,  3 Apr 2016 21:42:23 -0400
Message-ID: <1459734143-95832-1-git-send-email-rappazzo@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 03:43:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amtY0-00079s-AS
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 03:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcDDBnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 21:43:16 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35464 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbcDDBnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 21:43:15 -0400
Received: by mail-qk0-f176.google.com with SMTP id o6so57611395qkc.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TKGSkqlqWd4nMuPqctSkq7smntXSG0MycmMIkxzdyFA=;
        b=OIeC6o1DYXxqGsO8/OWk9ceFbrfgpAar7etAycqli/L5vKHctWoU6TypMSP8PuZP7s
         ByDLrKQF/A1+omvodSWFNdlpLIPfNt6pXK9DF1iGnIl2ny9P1rr4GAFQoKjKbltqcaeP
         FaAdwEJxR/L5mk8ih/w2YJcOUqyNm29z3GXQeurZ9pce795Mrl/3+kP3k4h8Z5rbkt5s
         69IHgILqp5w6M2C8hqBNAymOfMEGCEjFsJmdyUAN0hwYvS3OWIqVlAlbRP2pjfih4Sc0
         yimoftFiQGR/UpLjMgfrBXU7NTetnCBA/cEi6IvD8kqMbP7Np8MmgmfwF7OP737ebrDr
         6HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TKGSkqlqWd4nMuPqctSkq7smntXSG0MycmMIkxzdyFA=;
        b=YmjL2qK9au0zc6udALrFWMQLBU7uDWQ9xzopwn/n/CeofkLNPdUETp8e9jXZRFNhYn
         KRR17YR2cUgd0EIjJz6ew7UnXb8O4y+oePtihdKMH+ykYiLvzUKW74ohHYrNED1fmIG9
         q8QdDI7pgVARfo7cy1TnqzQArM/fzqmv5ipX3WpjN8chaFAql4rwo8lnb23gPFLburH6
         YJ8TFJ/ESW+5J27oJnpp74yUadR8Lj/19RsBBJJ+wdTdeiWSPrIEdTa1pjGqitn7DUf8
         lQnLBi4VfpjyKDNFF4Y4CPLdjjbmWmpbadQcE5giNbZgx3IBfLA+DiMluPpHHix2hhtM
         kEEA==
X-Gm-Message-State: AD7BkJJjB1Y1qXJFKuF9/niVWUv9NriwgZ4erv4Fh6lym4F20lwhXR4LsX6Oa/0k4j9JGA==
X-Received: by 10.55.78.70 with SMTP id c67mr30688386qkb.37.1459734194518;
        Sun, 03 Apr 2016 18:43:14 -0700 (PDT)
Received: from MRappazzo-8.local.info (pool-100-35-125-216.nwrknj.fios.verizon.net. [100.35.125.216])
        by smtp.gmail.com with ESMTPSA id w188sm11317306qhb.37.2016.04.03.18.43.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 18:43:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290669>

Executing `git-rev-parse --git-common-dir` from the root of the main
worktree results in '.git', which is the relative path to the git dir.
When executed from a subpath of the main tree it returned somthing like:
'sub/path/.git'.  Change this to return the proper relative path to the
git directory (similar to `--show-cdup`).

Add as test to t1500-rev-parse.sh for this case and adjust another test
in t2027-worktree-list.sh to use this expectation.

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 builtin/rev-parse.c      | 14 ++++++++++++--
 t/t1500-rev-parse.sh     | 10 ++++++++++
 t/t2027-worktree-list.sh |  2 +-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c961b74..c2918e1 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -787,8 +787,18 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				const char *pfx = prefix ? prefix : "";
-				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
+				const char *git_common_dir = get_git_common_dir();
+				if (prefix && !is_absolute_path(git_common_dir)) {
+					const char *pfx = prefix;
+					while (pfx) {
+						pfx = strchr(pfx, '/');
+						if (pfx) {
+							pfx++;
+							printf("../");
+						}
+					}
+				}
+				printf("%s\n", git_common_dir);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 48ee077..2023208 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -3,6 +3,16 @@
 test_description='test git rev-parse'
 . ./test-lib.sh
 
+test_expect_success 'git-common-dir inside sub-dir' '
+   (
+		mkdir -p path/to/child &&
+		cd path/to/child &&
+		echo "$(git rev-parse --show-cdup).git" >expect &&
+		git rev-parse --git-common-dir >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_rev_parse() {
 	name=$1
 	shift
diff --git a/t/t2027-worktree-list.sh b/t/t2027-worktree-list.sh
index 1b1b65a..3780b14 100755
--- a/t/t2027-worktree-list.sh
+++ b/t/t2027-worktree-list.sh
@@ -14,7 +14,7 @@ test_expect_success 'rev-parse --git-common-dir on main worktree' '
 	test_cmp expected actual &&
 	mkdir sub &&
 	git -C sub rev-parse --git-common-dir >actual2 &&
-	echo sub/.git >expected2 &&
+	echo ../.git >expected2 &&
 	test_cmp expected2 actual2
 '
 
-- 
2.8.0

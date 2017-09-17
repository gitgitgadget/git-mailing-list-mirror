Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C18E2047F
	for <e@80x24.org>; Sun, 17 Sep 2017 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbdIQOcN (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 10:32:13 -0400
Received: from p3plsmtpa08-05.prod.phx3.secureserver.net ([173.201.193.106]:48531
        "EHLO p3plsmtpa08-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750995AbdIQOcM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 10:32:12 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Sep 2017 10:32:12 EDT
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id taUbdFEPMCs34taUfdaX7Q; Sun, 17 Sep 2017 07:24:23 -0700
From:   Max Kirillov <max@max630.net>
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, git@vger.kernel.org
Subject: [PATCH] describe: teach --match to handle branches and remotes
Date:   Sun, 17 Sep 2017 17:24:16 +0300
Message-Id: <20170917142416.30685-1-max@max630.net>
X-Mailer: git-send-email 2.11.0.1122.gc3fec58.dirty
X-CMAE-Envelope: MS4wfIAfn0lCnf3v5UgY8GY6yDe7hOTeuqjfu3Qyr90ZvuPOsKi7YVGhKbrUZbrfvqsGsMNpw0K1CRCotfx1afk9nsxToq/G4yqxjRR7giMUg3ti8N2Eqv0v
 0ru9NshdZu5yaxTvjrMEN5bC+IaNtAQcfYJ5HezXPCrLs7rpVmebZAYQuUGjBrhZS3CcYfemnB6P8XZ9TBKz2w/QlRj+4AlIvFKi4DPiqZREZvWacnfAIUrs
 XCzSkMTEel/dAnvwGtyacQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git describe` uses `--match`, it matches only tags, basically
ignoring the `--all` argument even when it is specified.

Fix it by also matching branch name and $remote_name/$remote_branch_name,
for remote-tracking references, with the specified patterns. Update
documentation accordingly and add tests.

Signed-off-by: Max Kirillov <max@max630.net>
---
Requires https://public-inbox.org/git/20170916055344.31866-1-max@max630.net/

This extends --match to branches and remote-tracking references. It is in some respect
regression, if anybody have used --all and --match together this would find another
reference, but since that combination did not make sense anyway probably it is not
a big issue.

There are ambiguity with this approach if --match=foo matches tag "foo", or branch "foo".
Probably to resolve it there should appear some --match-full option, so that --match would mean
full reference name, with prefix. It could be a room for further improvement.

From documentation I removed the usage example part, mainly to not expand the size too much, but
probably they do not really belong there.
 Documentation/git-describe.txt | 24 ++++++++++++++----------
 builtin/describe.c             | 26 ++++++++++++++++++++++----
 t/t6120-describe.sh            | 18 ++++++++++++++++++
 3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 26f19d3b07..c924c945ba 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -87,19 +87,23 @@ OPTIONS
 
 --match <pattern>::
 	Only consider tags matching the given `glob(7)` pattern,
-	excluding the "refs/tags/" prefix.  This can be used to avoid
-	leaking private tags from the repository. If given multiple times, a
-	list of patterns will be accumulated, and tags matching any of the
-	patterns will be considered. Use `--no-match` to clear and reset the
-	list of patterns.
+	excluding the "refs/tags/" prefix. If used with `--all`, it also
+	considers local branches and remote-tracking references matching the
+	pattern, excluding respectively "refs/heads/" and "refs/remotes/"
+	prefix; references of other types are never considered. If given
+	multiple times, a list of patterns will be accumulated, and tags
+	matching any of the patterns will be considered.  Use `--no-match` to
+	clear and reset the list of patterns.
 
 --exclude <pattern>::
 	Do not consider tags matching the given `glob(7)` pattern, excluding
-	the "refs/tags/" prefix. This can be used to narrow the tag space and
-	find only tags matching some meaningful criteria. If given multiple
-	times, a list of patterns will be accumulated and tags matching any
-	of the patterns will be excluded. When combined with --match a tag will
-	be considered when it matches at least one --match pattern and does not
+	the "refs/tags/" prefix. If used with `--all`, it also does not consider
+	local branches and remote-tracking references matching the pattern,
+	excluding respectively "refs/heads/" and "refs/remotes/" prefix;
+	references of other types are never considered. If given multiple times,
+	a list of patterns will be accumulated and tags matching any of the
+	patterns will be excluded. When combined with --match a tag will be
+	considered when it matches at least one --match pattern and does not
 	match any of the --exclude patterns. Use `--no-exclude` to clear and
 	reset the list of patterns.
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 94ff2fba0b..2a2e998063 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -124,6 +124,22 @@ static void add_to_known_names(const char *path,
 	}
 }
 
+/* Drops prefix. Returns NULL if the path is not expected with current settings. */
+static const char *get_path_to_match(int is_tag, int all, const char *path)
+{
+	if (is_tag)
+		return path + 10;
+	else if (all) {
+		if (starts_with(path, "refs/heads/"))
+			return path + 11; /* "refs/heads/..." */
+		else if (starts_with(path, "refs/remotes/"))
+			return path + 13; /* "refs/remotes/..." */
+		else
+			return 0;
+	} else
+		return NULL;
+}
+
 static int get_name(const char *path, const struct object_id *oid, int flag, void *cb_data)
 {
 	int is_tag = starts_with(path, "refs/tags/");
@@ -140,12 +156,13 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	 */
 	if (exclude_patterns.nr) {
 		struct string_list_item *item;
+		const char *path_to_match = get_path_to_match(is_tag, all, path);
 
-		if (!is_tag)
+		if (!path_to_match)
 			return 0;
 
 		for_each_string_list_item(item, &exclude_patterns) {
-			if (!wildmatch(item->string, path + 10, 0))
+			if (!wildmatch(item->string, path_to_match, 0))
 				return 0;
 		}
 	}
@@ -156,13 +173,14 @@ static int get_name(const char *path, const struct object_id *oid, int flag, voi
 	 */
 	if (patterns.nr) {
 		int found = 0;
+		const char *path_to_match = get_path_to_match(is_tag, all, path);
 		struct string_list_item *item;
 
-		if (!is_tag)
+		if (!path_to_match)
 			return 0;
 
 		for_each_string_list_item(item, &patterns) {
-			if (!wildmatch(item->string, path + 10, 0)) {
+			if (!wildmatch(item->string, path_to_match, 0)) {
 				found = 1;
 				break;
 			}
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 25110ea55d..fac52bd9dc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -190,6 +190,24 @@ check_describe "test1-lightweight-*" --long --tags --match="test1-*" --match="te
 
 check_describe "test1-lightweight-*" --long --tags --match="test3-*" --match="test1-*" HEAD
 
+test_expect_success 'set-up branches' '
+	git branch branch_A A &&
+	git branch branch_c c &&
+	git update-ref refs/remotes/origin/remote_branch_A "A^{commit}" &&
+	git update-ref refs/remotes/origin/remote_branch_c "c^{commit}" &&
+	git update-ref refs/original/original_branch_A test-annotated~2
+'
+
+check_describe "heads/branch_A*" --all --match="branch_*" --exclude="branch_c" HEAD
+
+check_describe "remotes/origin/remote_branch_A*" --all --match="origin/remote_branch_*" --exclude="origin/remote_branch_c" HEAD
+
+check_describe "original/original_branch_A*" --all test-annotated~1
+
+test_expect_success '--match does not work for other types' '
+	test_must_fail git describe --all --match="*original_branch_*" test-annotated~1
+'
+
 test_expect_success 'name-rev with exact tags' '
 	echo A >expect &&
 	tag_object=$(git rev-parse refs/tags/A) &&
-- 
2.11.0.1122.gc3fec58.dirty


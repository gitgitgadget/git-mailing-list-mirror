Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B481C636D3
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 09:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjBLJEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBLJE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 04:04:28 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B301286A
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 01:04:27 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 4D4DA1F5A0;
        Sun, 12 Feb 2023 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1676192667;
        bh=P4HRtZiEGcgorv+zuQqmHpxnQ9dirF0iYYu47nFBJik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4ElUNXg6QhTryMPA9JtsTQNnVxtP7sZukVZt5l1s6ZWmAzfEsccmGioLJcToIaawr
         U5oDWyOUw0uxjPeHg9EwYKQUwLqhR57Q8t0dKQl7BEjl5mvrb3qWs4ly9Ixo3/x+me
         TfoUIEzOO82LsFmjYGS51hHhKEZY2RhkRPe05VPg=
Date:   Sun, 12 Feb 2023 09:04:26 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] fetch: support hideRefs to speed up connectivity checks
Message-ID: <20230212090426.M558990@dcvr>
References: <20230209122857.M669733@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209122857.M669733@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With roughly 800 remotes all fetching into their own
refs/remotes/$REMOTE/* island, the connectivity check[1] gets
expensive for each fetch on systems which lack sufficient RAM to
cache objects.

To do a no-op fetch on one $REMOTE out of hundreds, hideRefs now
allows the no-op fetch to take ~30 seconds instead of ~20 minutes
on a noisy, RAM-constrained machine (localhost, so no network latency):

   git -c fetch.hideRefs=refs \
	-c fetch.hideRefs='!refs/remotes/$REMOTE/' \
	fetch $REMOTE

[1] `git rev-list --objects --stdin --not --all --quiet --alternate-refs'

Signed-off-by: Eric Wong <e@80x24.org>
---
 Sidenote: I'm curious about the reason $(pwd) is used in some
 places while $PWD seems fine in others, so it doesn't seem to be
 a portability problem.  I chose $PWD since it's faster.

 Documentation/git-rev-parse.txt    | 9 +++++----
 Documentation/rev-list-options.txt | 9 +++++----
 builtin/fetch.c                    | 2 ++
 builtin/rev-list.c                 | 2 +-
 revision.c                         | 3 ++-
 t/t5510-fetch.sh                   | 9 +++++++++
 t/t6018-rev-list-glob.sh           | 2 +-
 t/t6021-rev-list-exclude-hidden.sh | 2 +-
 8 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index bcd80692870..f26a7591e37 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -197,10 +197,11 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
---exclude-hidden=[receive|uploadpack]::
-	Do not include refs that would be hidden by `git-receive-pack` or
-	`git-upload-pack` by consulting the appropriate `receive.hideRefs` or
-	`uploadpack.hideRefs` configuration along with `transfer.hideRefs` (see
+--exclude-hidden=[fetch|receive|uploadpack]::
+	Do not include refs that would be hidden by `git-fetch`,
+	`git-receive-pack` or `git-upload-pack` by consulting the appropriate
+	`fetch.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs`
+	configuration along with `transfer.hideRefs` (see
 	linkgit:git-config[1]). This option affects the next pseudo-ref option
 	`--all` or `--glob` and is cleared after processing them.
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ff68e484069..5e7f3c51792 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -195,10 +195,11 @@ respectively, and they must begin with `refs/` when applied to `--glob`
 or `--all`. If a trailing '/{asterisk}' is intended, it must be given
 explicitly.
 
---exclude-hidden=[receive|uploadpack]::
-	Do not include refs that would be hidden by `git-receive-pack` or
-	`git-upload-pack` by consulting the appropriate `receive.hideRefs` or
-	`uploadpack.hideRefs` configuration along with `transfer.hideRefs` (see
+--exclude-hidden=[fetch|receive|uploadpack]::
+	Do not include refs that would be hidden by `git-fetch`,
+	`git-receive-pack` or `git-upload-pack` by consulting the appropriate
+	`fetch.hideRefs`, `receive.hideRefs` or `uploadpack.hideRefs`
+	configuration along with `transfer.hideRefs` (see
 	linkgit:git-config[1]). This option affects the next pseudo-ref option
 	`--all` or `--glob` and is cleared after processing them.
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 12978622d51..2763dd969bb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1131,6 +1131,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!connectivity_checked) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
+		opt.exclude_hidden_refs_section = "fetch";
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
 			rc = error(_("%s did not send all necessary objects\n"), url);
@@ -1324,6 +1325,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 	}
 
 	opt.quiet = 1;
+	opt.exclude_hidden_refs_section = "fetch";
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d42db0b0cc9..2ab3efd233b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -38,7 +38,7 @@ static const char rev_list_usage[] =
 "    --tags\n"
 "    --remotes\n"
 "    --stdin\n"
-"    --exclude-hidden=[receive|uploadpack]\n"
+"    --exclude-hidden=[fetch|receive|uploadpack]\n"
 "    --quiet\n"
 "  ordering output:\n"
 "    --topo-order\n"
diff --git a/revision.c b/revision.c
index 21f5f572c22..50940699e4a 100644
--- a/revision.c
+++ b/revision.c
@@ -1574,7 +1574,8 @@ void exclude_hidden_refs(struct ref_exclusions *exclusions, const char *section)
 {
 	struct exclude_hidden_refs_cb cb;
 
-	if (strcmp(section, "receive") && strcmp(section, "uploadpack"))
+	if (strcmp(section, "fetch") && strcmp(section, "receive") &&
+			strcmp(section, "uploadpack"))
 		die(_("unsupported section for hidden refs: %s"), section);
 
 	if (exclusions->hidden_refs_configured)
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c0b745e33b8..287d6c3a8af 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1163,6 +1163,15 @@ test_expect_success '--no-show-forced-updates' '
 	)
 '
 
+for section in fetch transfer
+do
+	test_expect_success "$section.hideRefs affects connectivity check" '
+		GIT_TRACE="$PWD"/trace git -c $section.hideRefs=refs -c \
+			$section.hideRefs="!refs/tags/" fetch &&
+		grep "git rev-list .*--exclude-hidden=fetch" trace
+	'
+done
+
 setup_negotiation_tip () {
 	SERVER="$1"
 	URL="$2"
diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index aabf590dda6..67d523d4057 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -187,7 +187,7 @@ test_expect_success 'rev-parse --exclude=ref with --remotes=glob' '
 	compare rev-parse "--exclude=upstream/x --remotes=upstream/*" "upstream/one upstream/two"
 '
 
-for section in receive uploadpack
+for section in fetch receive uploadpack
 do
 	test_expect_success "rev-parse --exclude-hidden=$section with --all" '
 		compare "-c transfer.hideRefs=refs/remotes/ rev-parse" "--branches --tags" "--exclude-hidden=$section --all"
diff --git a/t/t6021-rev-list-exclude-hidden.sh b/t/t6021-rev-list-exclude-hidden.sh
index 32b2b094138..e219ac86738 100755
--- a/t/t6021-rev-list-exclude-hidden.sh
+++ b/t/t6021-rev-list-exclude-hidden.sh
@@ -21,7 +21,7 @@ test_expect_success 'invalid section' '
 	test_cmp expected err
 '
 
-for section in receive uploadpack
+for section in fetch receive uploadpack
 do
 	test_expect_success "$section: passed multiple times" '
 		echo "fatal: --exclude-hidden= passed more than once" >expected &&

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DDDC433E6
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1002364EDA
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhBJUfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:35:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:56812 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhBJUfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:35:15 -0500
Received: (qmail 1078 invoked by uid 109); 10 Feb 2021 20:34:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 20:34:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23403 invoked by uid 111); 10 Feb 2021 20:34:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 15:34:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 15:34:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
Message-ID: <YCRDWT0QdUTC9ixq@coredump.intra.peff.net>
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net>
 <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
 <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
 <xmqqv9b1ylyj.fsf@gitster.c.googlers.com>
 <YCQGqeHB4rXi6dG0@coredump.intra.peff.net>
 <xmqqblcr3crp.fsf@gitster.c.googlers.com>
 <YCRCu60a2MuGooiL@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCRCu60a2MuGooiL@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 03:31:55PM -0500, Jeff King wrote:

> I'll resend the whole thing with that squashed in, plus Eric's
> documentation suggestion.

And here that is.

-- >8 --
Subject: [PATCH] mailmap: only look for .mailmap in work tree

When trying to find a .mailmap file, we will always look for it in the
current directory. This makes sense in a repository with a working tree,
since we'd always go to the toplevel directory at startup. But for a
bare repository, it can be confusing. With an option like --git-dir (or
$GIT_DIR in the environment), we don't chdir at all, and we'd read
.mailmap from whatever directory you happened to be in before starting
Git.

(Note that --git-dir without specifying a working tree historically
means "the current directory is the root of the working tree", but most
bare repositories will have core.bare set these days, meaning they will
realize there is no working tree at all).

The documentation for gitmailmap(5) says:

  If the file `.mailmap` exists at the toplevel of the repository[...]

which likewise reinforces the notion that we are looking in the working
tree.

This patch prevents us from looking for such a file when we're in a bare
repository. This does break something that used to work:

  cd bare.git
  git cat-file blob HEAD:.mailmap >.mailmap
  git shortlog

But that was never advertised in the documentation. And these days we
have mailmap.blob (which defaults to HEAD:.mailmap) to do the same thing
in a much cleaner way.

However, there's one more interesting case: we might not have a
repository at all! The git-shortlog command can be run with git-log
output fed on its stdin, and it will apply the mailmap. In that case, it
probably does make sense to read .mailmap from the current directory.
This patch will continue to do so.

That leads to one even weirder case: if you run git-shortlog to process
stdin, the input _could_ be from a different repository entirely. Should
we respect the in-tree .mailmap then? Probably yes. Whatever the source
of the input, if shortlog is running in a repository, the documentation
claims that we'd read the .mailmap from its top-level (and of course
it's reasonably likely that it _is_ from the same repo, and the user
just preferred to run git-log and git-shortlog separately for whatever
reason).

The included test covers these cases, and we now document the "no repo"
case explicitly.

We also add a test that confirms we find a top-level ".mailmap" even
when we start in a subdirectory of the working tree. This worked both
before and after this commit, but we never tested it explicitly (it
works because we always chdir to the top-level of the working tree if
there is one).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  4 ++++
 mailmap.c                      |  3 ++-
 t/t4203-mailmap.sh             | 43 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c16cc3b608..c9c7f3065c 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -113,6 +113,10 @@ MAPPING AUTHORS
 
 See linkgit:gitmailmap[5].
 
+Note that if `git shortlog` is run outside of a repository (to process
+log contents on standard input), it will look for a `.mailmap` file in
+the current directory.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/mailmap.c b/mailmap.c
index eb77c6e77c..9bb9cf8b30 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -225,7 +225,8 @@ int read_mailmap(struct string_list *map)
 	if (!git_mailmap_blob && is_bare_repository())
 		git_mailmap_blob = "HEAD:.mailmap";
 
-	err |= read_mailmap_file(map, ".mailmap");
+	if (!startup_info->have_repository || !is_bare_repository())
+		err |= read_mailmap_file(map, ".mailmap");
 	if (startup_info->have_repository)
 		err |= read_mailmap_blob(map, git_mailmap_blob);
 	err |= read_mailmap_file(map, git_mailmap_file);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 621f9962d5..93caf9a46d 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -889,4 +889,47 @@ test_expect_success 'empty syntax: setup' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up mailmap location tests' '
+	git init --bare loc-bare &&
+	git --git-dir=loc-bare --work-tree=. commit \
+		--allow-empty -m foo --author="Orig <orig@example.com>" &&
+	echo "New <new@example.com> <orig@example.com>" >loc-bare/.mailmap
+'
+
+test_expect_success 'bare repo with --work-tree finds mailmap at top-level' '
+	git -C loc-bare --work-tree=. log -1 --format=%aE >actual &&
+	echo new@example.com >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'bare repo does not look in current directory' '
+	git -C loc-bare log -1 --format=%aE >actual &&
+	echo orig@example.com >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non-git shortlog respects mailmap in current dir' '
+	git --git-dir=loc-bare log -1 >input &&
+	nongit cp "$TRASH_DIRECTORY/loc-bare/.mailmap" . &&
+	nongit git shortlog -s <input >actual &&
+	echo "     1	New" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'shortlog on stdin respects mailmap from repo' '
+	cp loc-bare/.mailmap . &&
+	git shortlog -s <input >actual &&
+	echo "     1	New" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find top-level mailmap from subdir' '
+	git clone loc-bare loc-wt &&
+	cp loc-bare/.mailmap loc-wt &&
+	mkdir loc-wt/subdir &&
+	git -C loc-wt/subdir log -1 --format=%aE >actual &&
+	echo new@example.com >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.30.1.898.g81d77b2936


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DBC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA864E9C
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhBIRa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:30:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:55168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232950AbhBIRa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:30:26 -0500
Received: (qmail 27172 invoked by uid 109); 9 Feb 2021 17:29:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Feb 2021 17:29:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8196 invoked by uid 111); 9 Feb 2021 17:29:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Feb 2021 12:29:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Feb 2021 12:29:38 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     SURA <surak8806@gmail.com>, Git Users <git@vger.kernel.org>
Subject: [PATCH] mailmap: only look for .mailmap in work tree
Message-ID: <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net>
 <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 05, 2021 at 12:02:03PM -0800, Bryan Turner wrote:

> On Fri, Feb 5, 2021 at 9:28 AM Jeff King <peff@peff.net> wrote:
> >
> > It's possible somebody is relying on this in order to read ".mailmap" in
> > a bare repository, but it seems rather unlikely. And the documentation
> > says "If the file .mailmap exists at the toplevel of the repository",
> > which I think pretty clearly means the top of the working tree.
> 
> There was a time, before the change was made to have bare repositories
> read the HEAD:.mailmap blob if one exists, when Bitbucket Server
> relied on this in order to have mailmapping. We'd unpack the
> `HEAD:.mailmap` blob to `.mailmap` in the bare repository whenever it
> changed. Now that it's automatically read out of the repository,
> though, that manual unpacking code was removed.
> 
> (Not disagreeing with your "seems rather unlikely", by the way. With
> the blob reading behavior I think it's probably true.)

Heh, thanks for the data point. Anytime I think "surely nobody would do
this, right...?" then it's almost guaranteed that somebody will pipe up. :)

I prepared the patch below, which I think is pretty reasonable. It is a
change to long-standing behavior, so of course there's a risk somebody
is relying on what I consider to be buggy behavior. And the benefit
isn't that huge, either (most of the time, we wouldn't find a stray
.mailmap file in the cwd!). But I consider it mostly a hygiene thing. I
get nervous any time Git reads unexpected files from the filesystem.

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

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  4 ++++
 mailmap.c                      |  3 ++-
 t/t4203-mailmap.sh             | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c16cc3b608..e69c823335 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -113,6 +113,10 @@ MAPPING AUTHORS
 
 See linkgit:gitmailmap[5].
 
+Note that if `git shortlog` is run outside of a repository (to process
+log contents on stdin), it will look for a `.mailmap` file in the
+current directory.
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
index 621f9962d5..bf7a8add53 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -889,4 +889,38 @@ test_expect_success 'empty syntax: setup' '
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
 test_done
-- 
2.30.1.887.ge7d57fcab0


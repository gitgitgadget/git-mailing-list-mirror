From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] mailmap from blobs
Date: Thu, 13 Dec 2012 08:04:47 -0500
Message-ID: <20121213130447.GA4353@sigill.intra.peff.net>
References: <20121212105822.GA15842@sigill.intra.peff.net>
 <7vhanr5f74.fsf@alter.siamese.dyndns.org>
 <20121212175900.GA32767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 14:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tj8TL-0002Kw-Fe
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 14:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab2LMNEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 08:04:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48570 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849Ab2LMNEt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 08:04:49 -0500
Received: (qmail 3761 invoked by uid 107); 13 Dec 2012 13:05:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Dec 2012 08:05:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2012 08:04:47 -0500
Content-Disposition: inline
In-Reply-To: <20121212175900.GA32767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211450>

On Wed, Dec 12, 2012 at 12:59:00PM -0500, Jeff King wrote:

> > Have you considered defaulting to read from HEAD:.mailmap even when
> > this new configuration is not there if core.bare is set?  I would
> > imagine that it would be the most convenient and match people's
> > expectations.
> 
> Yeah, I almost suggested that, but I figured it could wait for the
> feature to prove itself in the real world before turning it on by
> default. It _should_ be pretty harmless, though, so I don't mind turning
> it on by default.

That patch would look like this:

-- >8 --
Subject: [PATCH] mailmap: default mailmap.blob in bare repositories

The motivation for mailmap.blob is to let users of bare
repositories use the mailmap feature, as they would not have
a checkout containing the .mailmap file. We can make it even
easier for them by just looking in HEAD:.mailmap by default.

We can't know for sure that this is where they would keep a
mailmap, of course, but it is the best guess (and it matches
the non-bare behavior, which reads from HEAD:.mailmap in the
working tree). If it's missing, git will silently ignore the
setting.

We do not do the same magic in the non-bare case, because:

  1. In the common case, HEAD:.mailmap will be the same as
     the .mailmap in the working tree, which is a no-op.

  2. In the uncommon case, the user has modified .mailmap
     but not yet committed it, and would expect the working
     tree version to take precedence.

Signed-off-by: Jeff King <peff@peff.net>
---
I went with defaulting mailmap.blob, because it provides an easy path
for turning off the feature (you just override mailmap.blob).

Another way of thinking about this would be that it is the bare analog
to "read .mailmap from the working tree", and the logic should be:

  if (is_bare_repository())
          read_mailmap_blob(map, "HEAD:.mailmap");
  else
          read_mailmap_file(map, ".mailmap");
  read_mailmap_blob(map, git_mailmap_blob);
  read_mailmap_file(map, git_mailmap_file);

However, the current is not exactly "read from the root of the working
tree". It is "read from the current directory", and it works because all
of the callers run from the toplevel of the working tree (when one
exists). That means that bare repositories have always read from
$GIT_DIR/.mailmap. I doubt that was intentional, but people with bare
repositories may be depending on it.  So I think that falls into the
"how I might do it from scratch" bin.

We could still do:

  if (is_bare_repository())
          read_mailmap_blob(map, "HEAD:.mailmap");
  read_mailmap_file(map, ".mailmap");
  read_mailmap_blob(map, git_mailmap_blob);
  read_mailmap_file(map, git_mailmap_file);

but IMHO that is just making the rules more complicated to explain for
little benefit (and in fact, you lose the ability to suppress the HEAD
mailmap, which you might care about if you are hosting multiple bits of
unrelated history in the same repo).

 Documentation/config.txt |  8 +++++---
 mailmap.c                |  5 +++++
 t/t4203-mailmap.sh       | 25 +++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3760077..1a3c554 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1519,9 +1519,11 @@ mailmap.blob::
 
 mailmap.blob::
 	Like `mailmap.file`, but consider the value as a reference to a
-	blob in the repository (e.g., `HEAD:.mailmap`). If both
-	`mailmap.file` and `mailmap.blob` are given, both are parsed,
-	with entries from `mailmap.file` taking precedence.
+	blob in the repository. If both `mailmap.file` and
+	`mailmap.blob` are given, both are parsed, with entries from
+	`mailmap.file` taking precedence. In a bare repository, this
+	defaults to `HEAD:.mailmap`. In a non-bare repository, it
+	defaults to empty.
 
 man.viewer::
 	Specify the programs that may be used to display help in the
diff --git a/mailmap.c b/mailmap.c
index 5ffe48a..b16542f 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -233,7 +233,12 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 int read_mailmap(struct string_list *map, char **repo_abbrev)
 {
 	int err = 0;
+
 	map->strdup_strings = 1;
+
+	if (!git_mailmap_blob && is_bare_repository())
+		git_mailmap_blob = "HEAD:.mailmap";
+
 	err |= read_mailmap_file(map, ".mailmap", repo_abbrev);
 	err |= read_mailmap_blob(map, git_mailmap_blob, repo_abbrev);
 	err |= read_mailmap_file(map, git_mailmap_file, repo_abbrev);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index e7ea40c..aae30d9 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -218,6 +218,31 @@ test_expect_success 'mailmap.blob can be missing' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
+	git init non-bare &&
+	(
+		cd non-bare &&
+		test_commit one .mailmap "Fake Name <author@example.com>" &&
+		echo "     1	Fake Name" >expect &&
+		git shortlog -ns HEAD >actual &&
+		test_cmp expect actual &&
+		rm .mailmap &&
+		echo "     1	A U Thor" >expect &&
+		git shortlog -ns HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'mailmap.blob defaults to HEAD:.mailmap in bare repo' '
+	git clone --bare non-bare bare &&
+	(
+		cd bare &&
+		echo "     1	Fake Name" >expect &&
+		git shortlog -ns HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'cleanup after mailmap.blob tests' '
 	rm -f .mailmap
 '
-- 
1.8.0.2.4.g59402aa

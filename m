From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 8 Feb 2016 10:07:09 -0500
Message-ID: <20160208150709.GA13664@sigill.intra.peff.net>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
 <alpine.DEB.2.20.1602061518220.2964@virtualbox>
 <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:07:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSnPM-0006G4-Co
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 16:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbcBHPHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 10:07:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:39227 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753210AbcBHPHM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 10:07:12 -0500
Received: (qmail 587 invoked by uid 102); 8 Feb 2016 15:07:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:07:11 -0500
Received: (qmail 5690 invoked by uid 107); 8 Feb 2016 15:07:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 10:07:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 10:07:09 -0500
Content-Disposition: inline
In-Reply-To: <20160208141552.GC27054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285772>

On Mon, Feb 08, 2016 at 09:15:52AM -0500, Jeff King wrote:

> I wonder if we could fix this pretty simply, though, by skipping the
> "does it have a wildcard" check when we see a colon in the path. That is
> a good indication that we are using one of git's special rev syntaxes
> (either "tree:path", or ":path", or ":/search string". That breaks
> anybody who really wanted to look for "path:with:colons.*", but that
> seems a lot less likely to me.
> 
> It doesn't cover:
> 
>   git log 'HEAD^{/Merge.*}'
> 
> which is similarly affected by 28fcc0b. Perhaps "^{" should be such a
> magic string, as well. We can be liberal with such strings as they are
> really just limiting the impact of 28fcc0b; we would fall back in those
> cases to the usual "can it be resolved, or is it a path?" rule.

The patch for that might look like this. I like it for its relative
simplicity, though it does make the rules even harder to explain to a
user (whereas if we actually tried to glob each pathspec, that would
keep the rule simple and work well in practice; I'm not sure how easy
that it is to do, though, if we are dealing with things like :(magic)
pathspecs, but maybe we should simply be dealing with them syntactically
much earlier).

This breaks the second test in t2019 added by ae454f6, but I am not sure
that test is doing the right thing (I'm also not sure t2019 is the best
place for these tests; I added new ones here in a separate script).

-- >8 --
Subject: [PATCH] check_filename: tighten requirements for dwim-wildcards

Commit 28fcc0b (pathspec: avoid the need of "--" when
wildcard is used, 2015-05-02) introduced a convenience to
our dwim-parsing: when "--" is not present, we guess that
items with wildcard characters are probably pathspecs.

This makes a lot of cases simpler (e.g., "git log '*.c'"),
but makes others harder. While revision expressions do not
typically have wildcard characters in them (because they are
not valid in refnames), there are a few constructs where we
take more arbitrary strings, such as:

  - pathnames in tree:path syntax (or :0:path) for the
    index)

  - :/foo and ^{/foo} for searching commit messages;
    likewise "^{}" is extensible and may learn new formats
    in the future

  - @{foo}, which can take arbitrary approxidate text (which
    is not itself that likely to have wildcards, but @{} is
    also a potential generic extension mechanism).

When we see these constructs, they are almost certainly an
attempt at a revision, and not a pathspec; we should not
give them the magic "wildcard characters mean a pathspec"
treatment.

We can afford to be fairly slack in our parsing here. We are
not making a real decision on "this is or is not definitely
a revision" here, but rather just deciding whether or not
the extra "wildcards mean pathspecs" magic kicks in.

Signed-off-by: Jeff King <peff@peff.net>
---
 setup.c                      | 21 ++++++++++++++++++++-
 t/t6133-pathspec-rev-dwim.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)
 create mode 100755 t/t6133-pathspec-rev-dwim.sh

diff --git a/setup.c b/setup.c
index 2c4b22c..03ee4eb 100644
--- a/setup.c
+++ b/setup.c
@@ -130,6 +130,25 @@ int path_inside_repo(const char *prefix, const char *path)
 	return 0;
 }
 
+static int dwim_as_wildcard(const char *arg)
+{
+	const char *p;
+
+	if (no_wildcard(arg))
+		return 0;
+	if (strstr(arg, "^{"))
+		return 0; /* probably "^{something}" */
+	if (strstr(arg, "@{"))
+		return 0; /* probably "ref@{something}" */
+
+	/* catch "tree:path", but not ":(magic)" */
+	p = strchr(arg, ':');
+	if (p && p[1] != '(')
+		return 0;
+
+	return 1;
+}
+
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
@@ -139,7 +158,7 @@ int check_filename(const char *prefix, const char *arg)
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
-	} else if (!no_wildcard(arg))
+	} else if (dwim_as_wildcard(arg))
 		return 1;
 	else if (prefix)
 		name = prefix_filename(prefix, strlen(prefix), arg);
diff --git a/t/t6133-pathspec-rev-dwim.sh b/t/t6133-pathspec-rev-dwim.sh
new file mode 100755
index 0000000..8f68937
--- /dev/null
+++ b/t/t6133-pathspec-rev-dwim.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='test dwim of revs versus pathspecs in revision parser'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit base &&
+	echo content >"br[ack]ets" &&
+	git add . &&
+	test_tick &&
+	git commit -m brackets
+'
+
+test_expect_success 'wildcard dwims to pathspec' '
+	git log -- "*.t" >expect &&
+	git log    "*.t" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success ':(magic) dwims to pathspec' '
+	git log -- ":(literal)br[ack]ets" >expect &&
+	git log    ":(literal)br[ack]ets" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tree:path dwims to rev' '
+	git show "HEAD:br[ack]ets" -- >expect &&
+	git show "HEAD:br[ack]ets"    >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '^{foo} dwims to rev' '
+	git log "HEAD^{/b.*}" -- >expect &&
+	git log "HEAD^{/b.*}"    >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '@{foo} dwims to rev' '
+	git log "HEAD@{now [or thereabouts]}" -- >expect &&
+	git log "HEAD@{now [or thereabouts]}"    >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.1.526.gd04f550

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8452022A
	for <e@80x24.org>; Tue,  8 Nov 2016 05:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbcKHFep (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 00:34:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:40065 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbcKHFeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 00:34:44 -0500
Received: (qmail 6231 invoked by uid 109); 8 Nov 2016 05:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 05:33:36 +0000
Received: (qmail 19112 invoked by uid 111); 8 Nov 2016 05:34:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 00:34:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 00:33:34 -0500
Date:   Tue, 8 Nov 2016 00:33:34 -0500
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
Message-ID: <20161108053333.jta7bmqsyvy2ijoh@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net>
 <CAGyf7-HWAMF8S+Bw3wcwJCS1Subc28KHjpSCc1__0qn-GSMyvA@mail.gmail.com>
 <20161108003034.apydvv3bav3s7ehq@sigill.intra.peff.net>
 <CAGyf7-FYvUgvOZm0xvFAJx=8hSc4ji=YQ5dUm3B1unU_WOcjeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-FYvUgvOZm0xvFAJx=8hSc4ji=YQ5dUm3B1unU_WOcjeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 05:12:43PM -0800, Bryan Turner wrote:

> > The obvious solution is one of:
> >
> >   1. Stop calling normalize() at all when we do not have a relative base
> >      and the path is not absolute. This restores the original quirky
> >      behavior (plus makes the "foo/../../bar" case work).

Actually, I think we want to keep normalizing, as it is possible for
relative paths to normalize correctly (e.g., "foo/../bar"). We just need
to ignore the error, which is easy.

The patch is below, and is the absolute minimum I think we'd need for
v2.11.

Beyond that, we could go further:

  a. Actually make a real absolute path based on getcwd(), which would
     protect against later chdir() calls, and possibly help with
     duplicate suppression. I'm not sure there are actually any
     triggerable bugs here, so I went for the minimal fix.

  b. Pick a more sane base for the absolute path, like $GIT_DIR. If we
     did so, then people using relative paths in
     GIT_ALTERNATE_OBJECT_DIRECTORIES from a bare repo would continue to
     work, and people in non-bare repositories would have to add an
     extra ".." to most of their paths. So a slight regression, but
     saner overall semantics.

     Making it relative to the object directory ($GIT_DIR/objects, or
     even whatever is in $GIT_OBJECT_DIRECTORY) makes even more sense
     to me, but would regress even the bare case (and would probably be
     "interesting" along with the tmp-objdir stuff, which sets
     $GIT_OBJECT_DIRECTORY on the fly, as that would invalidate
     $GIT_ALTERNATE_OBJECT_DIRECTORIES).

I'm inclined to leave those to anybody interested post-v2.11 (or never,
if nobody cares). But it would be pretty trivial to do (a) as part of
this initial fix if anybody feels strongly.

> Is there anything I can do to help? I'm happy to test out changes.

The patch at the end of his mail obviously passes the newly-added tests
for me, but please confirm that it fixes your test suite.

I gather your suite is about noticing behavior changes between different
versions. For cases where we know there is an obvious right behavior, it
would be nice if you could contribute them as patches to git's test
suite. This case was overlooked because there was no test coverage at
all.

Barring that, running your suite and giving easily-reproducible problem
reports is valuable. The earlier the better. So I am happy to see this
on -rc0, and not on the final release. Periodically running it on
"master" during the development cycle would have caught it even sooner.

> At the moment I have limited ability to actually try to submit patches
> myself. I really need to sit down and setup a working development
> environment for Git. (My current dream, if I could get such an
> environment running, is to follow up on your git blame-tree work.

I would be happy for somebody to pick that up, too. It has been powering
GitHub's tree-view for several years now, but I know there are some
rough edges as well as opportunities to optimize it.

-- >8 --
Subject: [PATCH] alternates: re-allow relative paths from environment

Commit 670c359da (link_alt_odb_entry: handle normalize_path
errors, 2016-10-03) regressed the handling of relative paths
in the GIT_ALTERNATE_OBJECT_DIRECTORIES variable. It's not
entirely clear this was ever meant to work, but it _has_
worked for several years, so this commit restores the
original behavior.

When we get a path in GIT_ALTERNATE_OBJECT_DIRECTORIES, we
add it the path to the list of alternate object directories
as if it were found in objects/info/alternates, but with one
difference: we do not provide the link_alt_odb_entry()
function with a base for relative paths. That function
doesn't turn it into an absolute path, and we end up feeding
the relative path to the strbuf_normalize_path() function.

Most relative paths break out of the top-level directory
(e.g., "../foo.git/objects"), and thus normalizing fails.
Prior to 670c359da, we simply ignored the error, and due to
the way normalize_path_copy() was implemented it happened to
return the original path in this case. We then accessed the
alternate objects using this relative path.

By storing the relative path in the alt_odb list, the path
is relative to wherever we happen to be at the time we do an
object lookup. That means we look from $GIT_DIR in a bare
repository, and from the top of the worktree in a non-bare
repository.

If this were being designed from scratch, it would make
sense to pick a stable location (probably $GIT_DIR, or even
the object directory) and use that as the relative base,
turning the result into an absolute path.  However, given
the history, at this point the minimal fix is to match the
pre-670c359da behavior.

We can do this simply by ignoring the error when we have no
relative base and using the original value (which we now
reliably have, thanks to strbuf_normalize_path()).

That still leaves us with a relative path that foils our
duplicate detection, and may act strangely if we ever
chdir() later in the process. We could solve that by storing
an absolute path based on getcwd(). That may be a good
future direction; for now we'll do just the minimum to fix
the regression.

The new t5615 script demonstrates the fix in its final three
tests. Since we didn't have any tests of the alternates
environment variable at all, it also adds some tests of
absolute paths.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c              |  2 +-
 t/t5615-alternate-env.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100755 t/t5615-alternate-env.sh

diff --git a/sha1_file.c b/sha1_file.c
index 5457314e6..9c86d1924 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -296,7 +296,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	}
 	strbuf_addstr(&pathbuf, entry);
 
-	if (strbuf_normalize_path(&pathbuf) < 0) {
+	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
 		error("unable to normalize alternate object path: %s",
 		      pathbuf.buf);
 		strbuf_release(&pathbuf);
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
new file mode 100755
index 000000000..22d9d8178
--- /dev/null
+++ b/t/t5615-alternate-env.sh
@@ -0,0 +1,71 @@
+#!/bin/sh
+
+test_description='handling of alternates in environment variables'
+. ./test-lib.sh
+
+check_obj () {
+	alt=$1; shift
+	while read obj expect
+	do
+		echo "$obj" >&3 &&
+		echo "$obj $expect" >&4
+	done 3>input 4>expect &&
+	GIT_ALTERNATE_OBJECT_DIRECTORIES=$alt \
+		git "$@" cat-file --batch-check='%(objectname) %(objecttype)' \
+		<input >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'create alternate repositories' '
+	git init --bare one.git &&
+	one=$(echo one | git -C one.git hash-object -w --stdin) &&
+	git init --bare two.git &&
+	two=$(echo two | git -C two.git hash-object -w --stdin)
+'
+
+test_expect_success 'objects inaccessible without alternates' '
+	check_obj "" <<-EOF
+	$one missing
+	$two missing
+	EOF
+'
+
+test_expect_success 'access alternate via absolute path' '
+	check_obj "$(pwd)/one.git/objects" <<-EOF
+	$one blob
+	$two missing
+	EOF
+'
+
+test_expect_success 'access multiple alternates' '
+	check_obj "$(pwd)/one.git/objects:$(pwd)/two.git/objects" <<-EOF
+	$one blob
+	$two blob
+	EOF
+'
+
+# bare paths are relative from $GIT_DIR
+test_expect_success 'access alternate via relative path (bare)' '
+	git init --bare bare.git &&
+	check_obj "../one.git/objects" -C bare.git <<-EOF
+	$one blob
+	EOF
+'
+
+# non-bare paths are relative to top of worktree
+test_expect_success 'access alternate via relative path (worktree)' '
+	git init worktree &&
+	check_obj "../one.git/objects" -C worktree <<-EOF
+	$one blob
+	EOF
+'
+
+# path is computed after moving to top-level of worktree
+test_expect_success 'access alternate via relative path (subdir)' '
+	mkdir subdir &&
+	check_obj "one.git/objects" -C subdir <<-EOF
+	$one blob
+	EOF
+'
+
+test_done
-- 
2.11.0.rc0.263.g6f44bc3


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFBAC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjASXPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjASXPM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:15:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E7A12F10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:13:30 -0800 (PST)
Received: (qmail 17164 invoked by uid 109); 19 Jan 2023 23:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 23:13:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4774 invoked by uid 111); 19 Jan 2023 23:13:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Jan 2023 18:13:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Jan 2023 18:13:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 7/6] fsck: do not assume NUL-termination of buffers
Message-ID: <Y8nOmZHv7T843uBn@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 08:39:55PM -0500, Jeff King wrote:

> On Wed, Jan 18, 2023 at 03:35:06PM -0500, Jeff King wrote:
> 
> > The other option is having the fsck code avoid looking past the size it
> > was given. I think the intent is that this should work, from commits
> > like 4d0d89755e (Make sure fsck_commit_buffer() does not run out of the
> > buffer, 2014-09-11). We do use skip_prefix() and parse_oid_hex(), which
> > won't respect the size, but I think[1] that's OK because we'll have
> > parsed up to the end-of-header beforehand (and those functions would
> > never match past there).
> > 
> > Which would mean that 9a1a3a4d4c (mktag: allow omitting the header/body
> > \n separator, 2021-01-05) and acf9de4c94 (mktag: use fsck instead of
> > custom verify_tag(), 2021-01-05) were buggy, and we can just fix them.
> > 
> > [1] But I said "I think" above because it can get pretty subtle. There's
> >     some more discussion in this thread:
> > 
> >       https://lore.kernel.org/git/20150625155128.C3E9738005C@gemini.denx.de/
> > 
> >     but I haven't yet convinced myself it's safe. This is exactly the
> >     kind of analysis I wish I had the power to nerd-snipe René into.
> 
> I poked at this a bit more, and it definitely isn't safe.

So here's the result of my digging on this. The good news is that this
one commit on top of the rest of the series should make everything safe.
I'm sorry the explanation is a bit long, but I wanted to capture a bit
of the history, the subtle assumptions, and how I approached analyzing
and fixing it.

There are a few paths forward here:

  - apply this on top of the earlier 6 patches. This is the simplest
    thing, and my preference. It does mean that t3800 temporarily has a
    read-one-char-past-buffer bug that is detected by ASan after patch 6
    but before this patch is applied.

  - put this fix first. Unfortunately the tests rely on having patch 6
    in order to be able to feed a non-NUL-terminated buffer to fsck.
    Options there are:

      - split this patch into two: code fix goes at the beginning of the
        series, and then the tests come at the end. The downside here is
        that it's very hard to run the tests on the pre-fixed code to
        verify that they are finding problems (you'd have to revert the
        fix, or re-order patches to get the broken state)

      - introduce a test-helper that lets you feed a buffer to
        fsck_buffer(). That can demonstrate the problem and fix
        independently of any hash-object changes. But it ends up being a
        fair bit of boilerplate, and ultimately we want to test
        hash-object anyway.

  - decide the whole "make fsck work with arbitrary buffers" thing is
    too subtle and error-prone. I don't think this, or else I wouldn't
    have made this patch. But I think it's an argument that can be made
    (and is roughly the approach we decided to take way back in the 2015
    thread linked above). The solution there is to make sure we
    NUL-terminate everything. As I said before, this is tricky because
    of mmap. But we could probably just skip using mmap in index_core()
    for non-blobs (which don't tend to be very big), and then assume
    fsck on individual blobs is safe (it is, because they won't have
    been marked as gitmodules, etc for more detailed scanning).

    I think it could work. I kind of prefer just making the fsck
    functions safe. Even though the way they do left-to-right scanning
    is error-prone, at least the ugliness is contained inside them,
    rather than this "sure, I take a ptr/len combo, but make sure you
    allocate an extra NUL byte!" assumption that currently exists.

Anyway, here's the patch. I'm happy to repost the whole 7-patch series,
too, but since the earlier ones didn't change in my preferred path
forward, this seemed easier for now. ;)

-- >8 --
Subject: [PATCH] fsck: do not assume NUL-termination of buffers

The fsck code operates on an object buffer represented as a pointer/len
combination. However, the parsing of commits and tags is a little bit
loose; we mostly scan left-to-right through the buffer, without checking
whether we've gone past the length we were given.

This has traditionally been OK because the buffers we feed to fsck
always have an extra NUL after the end of the object content, which ends
any left-to-right scan. That has always been true for objects we read
from the odb, and we made it true for incoming index-pack/unpack-objects
checks in a1e920a0a7 (index-pack: terminate object buffers with NUL,
2014-12-08).

However, we recently added an exception: hash-object asks index_fd() to
do fsck checks. That _may_ have an extra NUL (if we read from a pipe
into a strbuf), but it might not (if we read the contents from the
file). Nor can we just teach it to always add a NUL. We may mmap the
on-disk file, which will not have any extra bytes (if it's a multiple of
the page size). Not to mention that this is a rather subtle assumption
for the fsck code to make.

Instead, let's make sure that the fsck parsers don't ever look past the
size of the buffer they've been given. This _almost_ works already,
thanks to earlier work in 4d0d89755e (Make sure fsck_commit_buffer()
does not run out of the buffer, 2014-09-11). The theory there is that we
check up front whether we have the end of header double-newline
separator. And then any left-to-right scanning we do is OK as long as it
stops when it hits that boundary.

However, we later softened that in 84d18c0bcf (fsck: it is OK for a tag
and a commit to lack the body, 2015-06-28), which allows the
double-newline header to be missing, but does require that the header
ends in a newline. That was OK back then, because of the NUL-termination
guarantees (including the one from a1e920a0a7 mentioned above).

Because 84d18c0bcf guarantees that any header line does end in a
newline, we are still OK with most of the left-to-right scanning. We
only need to take care after completing a line, to check that there is
another line (and we didn't run out of buffer).

Most of these checks are just need to check "buffer < buffer_end" (where
buffer is advanced as we parse) before scanning for the next header
line. But here are a few notes:

  - we don't technically need to check for remaining buffer before
    parsing the very first line ("tree" for a commit, or "object" for a
    tag), because verify_headers() rejects a totally empty buffer. But
    we'll do so in the name of consistency and defensiveness.

  - there are some calls to strchr('\n'). These are actually OK by the
    "the final header line must end in a newline" guarantee from
    verify_headers(). They will always find that rather than run off the
    end of the buffer. Curiously, they do check for a NULL return and
    complain, but I believe that condition can never be reached.

    However, I converted them to use memchr() with a proper size and
    retained the NULL checks. Using memchr() is not much longer and
    makes it more obvious what is going on. Likewise, retaining the NULL
    checks serves as a defensive measure in case my analysis is wrong.

  - commit 9a1a3a4d4c (mktag: allow omitting the header/body \n
    separator, 2021-01-05), does check for the end-of-buffer condition,
    but does so with "!*buffer", relying explicitly on the NUL
    termination. We can accomplish the same thing with a pointer
    comparison. I also folded it into the follow-on conditional that
    checks the contents of the buffer, for consistency with the other
    checks.

  - fsck_ident() uses parse_timestamp(), which is based on strtoumax().
    That function will happily skip past leading whitespace, including
    newlines, which makes it a risk. We can fix this by scanning to the
    first digit ourselves, and then using parse_timestamp() to do the
    actual numeric conversion.

    Note that as a side effect this fixes the fact that we missed
    zero-padded timestamps like "<email>   0123" (whereas we would
    complain about "<email> 0123"). I doubt anybody cares, but I
    mention it here for completeness.

  - fsck_tree() does not need any modifications. It relies on
    decode_tree_entry() to do the actual parsing, and that function
    checks both that there are enough bytes in the buffer to represent
    an entry, and that there is a NUL at the appropriate spot (one
    hash-length from the end; this may not be the NUL for the entry we
    are parsing, but we know that in the worst case, everything from our
    current position to that NUL is a filename, so we won't run out of
    bytes).

In addition to fixing the code itself, we'd like to make sure our rather
subtle assumptions are not violated in the future. So this patch does
two more things:

  - add comments around verify_headers() documenting the link between
    what it checks and the memory safety of the callers. I don't expect
    this code to be modified frequently, but this may help somebody from
    accidentally breaking things.

  - add a thorough set of tests covering truncations at various key
    spots (e.g., for a "tree $oid" line, in the middle of the word
    "tree", right after it, after the space, in the middle of the $oid,
    and right at the end of the line. Most of these are fine already (it
    is only truncating right at the end of the line that is currently
    broken). And some of them are not even possible with the current
    code (we parse "tree " as a unit, so truncating before the space is
    equivalent). But I aimed here to consider the code a black box and
    look for any truncations that would be a problem for a left-to-right
    parser.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c                 |  67 ++++++++++++++++----
 t/t1451-fsck-buffer.sh | 140 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+), 13 deletions(-)
 create mode 100755 t/t1451-fsck-buffer.sh

diff --git a/fsck.c b/fsck.c
index c2c8facd2d..2b18717ee8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -748,6 +748,23 @@ static int fsck_tree(const struct object_id *tree_oid,
 	return retval;
 }
 
+/*
+ * Confirm that the headers of a commit or tag object end in a reasonable way,
+ * either with the usual "\n\n" separator, or at least with a trailing newline
+ * on the final header line.
+ *
+ * This property is important for the memory safety of our callers. It allows
+ * them to scan the buffer linewise without constantly checking the remaining
+ * size as long as:
+ *
+ *   - they check that there are bytes left in the buffer at the start of any
+ *     line (i.e., that the last newline they saw was not the final one we
+ *     found here)
+ *
+ *   - any intra-line scanning they do will stop at a newline, which will worst
+ *     case hit the newline we found here as the end-of-header. This makes it
+ *     OK for them to use helpers like parse_oid_hex(), or even skip_prefix().
+ */
 static int verify_headers(const void *data, unsigned long size,
 			  const struct object_id *oid, enum object_type type,
 			  struct fsck_options *options)
@@ -808,6 +825,20 @@ static int fsck_ident(const char **ident,
 	if (*p != ' ')
 		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
 	p++;
+	/*
+	 * Our timestamp parser is based on the C strto*() functions, which
+	 * will happily eat whitespace, including the newline that is supposed
+	 * to prevent us walking past the end of the buffer. So do our own
+	 * scan, skipping linear whitespace but not newlines, and then
+	 * confirming we found a digit. We _could_ be even more strict here,
+	 * as we really expect only a single space, but since we have
+	 * traditionally allowed extra whitespace, we'll continue to do so.
+	 */
+	while (*p == ' ' || *p == '\t')
+		p++;
+	if (!isdigit(*p))
+		return report(options, oid, type, FSCK_MSG_BAD_DATE,
+			      "invalid author/committer line - bad date");
 	if (*p == '0' && p[1] != ' ')
 		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp(p, &end, 10)))
@@ -834,20 +865,26 @@ static int fsck_commit(const struct object_id *oid,
 	unsigned author_count;
 	int err;
 	const char *buffer_begin = buffer;
+	const char *buffer_end = buffer + size;
 	const char *p;
 
+	/*
+	 * We _must_ stop parsing immediately if this reports failure, as the
+	 * memory safety of the rest of the function depends on it. See the
+	 * comment above the definition of verify_headers() for more details.
+	 */
 	if (verify_headers(buffer, size, oid, OBJ_COMMIT, options))
 		return -1;
 
-	if (!skip_prefix(buffer, "tree ", &buffer))
+	if (buffer >= buffer_end || !skip_prefix(buffer, "tree ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
 	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
 		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
-	while (skip_prefix(buffer, "parent ", &buffer)) {
+	while (buffer < buffer_end && skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
 			err = report(options, oid, OBJ_COMMIT, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
@@ -856,7 +893,7 @@ static int fsck_commit(const struct object_id *oid,
 		buffer = p + 1;
 	}
 	author_count = 0;
-	while (skip_prefix(buffer, "author ", &buffer)) {
+	while (buffer < buffer_end && skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
 		err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
 		if (err)
@@ -868,7 +905,7 @@ static int fsck_commit(const struct object_id *oid,
 		err = report(options, oid, OBJ_COMMIT, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
-	if (!skip_prefix(buffer, "committer ", &buffer))
+	if (buffer >= buffer_end || !skip_prefix(buffer, "committer ", &buffer))
 		return report(options, oid, OBJ_COMMIT, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, oid, OBJ_COMMIT, options);
 	if (err)
@@ -899,13 +936,19 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	int ret = 0;
 	char *eol;
 	struct strbuf sb = STRBUF_INIT;
+	const char *buffer_end = buffer + size;
 	const char *p;
 
+	/*
+	 * We _must_ stop parsing immediately if this reports failure, as the
+	 * memory safety of the rest of the function depends on it. See the
+	 * comment above the definition of verify_headers() for more details.
+	 */
 	ret = verify_headers(buffer, size, oid, OBJ_TAG, options);
 	if (ret)
 		goto done;
 
-	if (!skip_prefix(buffer, "object ", &buffer)) {
+	if (buffer >= buffer_end || !skip_prefix(buffer, "object ", &buffer)) {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
@@ -916,11 +959,11 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	}
 	buffer = p + 1;
 
-	if (!skip_prefix(buffer, "type ", &buffer)) {
+	if (buffer >= buffer_end || !skip_prefix(buffer, "type ", &buffer)) {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
 		goto done;
 	}
-	eol = strchr(buffer, '\n');
+	eol = memchr(buffer, '\n', buffer_end - buffer);
 	if (!eol) {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
@@ -932,11 +975,11 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 		goto done;
 	buffer = eol + 1;
 
-	if (!skip_prefix(buffer, "tag ", &buffer)) {
+	if (buffer >= buffer_end || !skip_prefix(buffer, "tag ", &buffer)) {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
 		goto done;
 	}
-	eol = strchr(buffer, '\n');
+	eol = memchr(buffer, '\n', buffer_end - buffer);
 	if (!eol) {
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
 		goto done;
@@ -952,18 +995,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
 	}
 	buffer = eol + 1;
 
-	if (!skip_prefix(buffer, "tagger ", &buffer)) {
+	if (buffer >= buffer_end || !skip_prefix(buffer, "tagger ", &buffer)) {
 		/* early tags do not contain 'tagger' lines; warn only */
 		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
 		if (ret)
 			goto done;
 	}
 	else
 		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
-	if (!*buffer)
-		goto done;
 
-	if (!starts_with(buffer, "\n")) {
+	if (buffer < buffer_end && !starts_with(buffer, "\n")) {
 		/*
 		 * The verify_headers() check will allow
 		 * e.g. "[...]tagger <tagger>\nsome
diff --git a/t/t1451-fsck-buffer.sh b/t/t1451-fsck-buffer.sh
new file mode 100755
index 0000000000..9ac270abab
--- /dev/null
+++ b/t/t1451-fsck-buffer.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+
+test_description='fsck on buffers without NUL termination
+
+The goal here is to make sure that the various fsck parsers never look
+past the end of the buffer they are given, even when encountering broken
+or truncated objects.
+
+We have to use "hash-object" for this because most code paths that read objects
+append an extra NUL for safety after the buffer. But hash-object, since it is
+reading straight from a file (and possibly even mmap-ing it) cannot always do
+so.
+
+These tests _might_ catch such overruns in normal use, but should be run with
+ASan or valgrind for more confidence.
+'
+. ./test-lib.sh
+
+# the general idea for tags and commits is to build up the "base" file
+# progressively, and then test new truncations on top of it.
+reset () {
+	test_expect_success 'reset input to empty' '
+		>base
+	'
+}
+
+add () {
+	content="$1"
+	type=${content%% *}
+	test_expect_success "add $type line" '
+		echo "$content" >>base
+	'
+}
+
+check () {
+	type=$1
+	fsck=$2
+	content=$3
+	test_expect_success "truncated $type ($fsck, \"$content\")" '
+		# do not pipe into hash-object here; we want to increase
+		# the chance that it uses a fixed-size buffer or mmap,
+		# and a pipe would be read into a strbuf.
+		{
+			cat base &&
+			echo "$content"
+		} >input &&
+		test_must_fail git hash-object -t "$type" input 2>err &&
+		grep "$fsck" err
+	'
+}
+
+test_expect_success 'create valid objects' '
+	git commit --allow-empty -m foo &&
+	commit=$(git rev-parse --verify HEAD) &&
+	tree=$(git rev-parse --verify HEAD^{tree})
+'
+
+reset
+check commit missingTree ""
+check commit missingTree "tr"
+check commit missingTree "tree"
+check commit badTreeSha1 "tree "
+check commit badTreeSha1 "tree 1234"
+add "tree $tree"
+
+# these expect missingAuthor because "parent" is optional
+check commit missingAuthor ""
+check commit missingAuthor "par"
+check commit missingAuthor "parent"
+check commit badParentSha1 "parent "
+check commit badParentSha1 "parent 1234"
+add "parent $commit"
+
+check commit missingAuthor ""
+check commit missingAuthor "au"
+check commit missingAuthor "author"
+ident_checks () {
+	check $1 missingEmail "$2 "
+	check $1 missingEmail "$2 name"
+	check $1 badEmail "$2 name <"
+	check $1 badEmail "$2 name <email"
+	check $1 missingSpaceBeforeDate "$2 name <email>"
+	check $1 badDate "$2 name <email> "
+	check $1 badDate "$2 name <email> 1234"
+	check $1 badTimezone "$2 name <email> 1234 "
+	check $1 badTimezone "$2 name <email> 1234 +"
+}
+ident_checks commit author
+add "author name <email> 1234 +0000"
+
+check commit missingCommitter ""
+check commit missingCommitter "co"
+check commit missingCommitter "committer"
+ident_checks commit committer
+add "committer name <email> 1234 +0000"
+
+reset
+check tag missingObject ""
+check tag missingObject "obj"
+check tag missingObject "object"
+check tag badObjectSha1 "object "
+check tag badObjectSha1 "object 1234"
+add "object $commit"
+
+check tag missingType ""
+check tag missingType "ty"
+check tag missingType "type"
+check tag badType "type "
+check tag badType "type com"
+add "type commit"
+
+check tag missingTagEntry ""
+check tag missingTagEntry "ta"
+check tag missingTagEntry "tag"
+check tag badTagName "tag "
+add "tag foo"
+
+check tag missingTagger ""
+check tag missingTagger "ta"
+check tag missingTagger "tagger"
+ident_checks tag tagger
+
+# trees are a binary format and can't use our earlier helpers
+test_expect_success 'truncated tree (short hash)' '
+	printf "100644 foo\0\1\1\1\1" >input &&
+	test_must_fail git hash-object -t tree input 2>err &&
+	grep badTree err
+'
+
+test_expect_success 'truncated tree (missing nul)' '
+	# these two things are indistinguishable to the parser. The important
+	# thing about this is example is that there are enough bytes to
+	# make up a hash, and that there is no NUL (and we confirm that the
+	# parser does not walk past the end of the buffer).
+	printf "100644 a long filename, or a hash with missing nul?" >input &&
+	test_must_fail git hash-object -t tree input 2>err &&
+	grep badTree err
+'
+
+test_done
-- 
2.39.1.616.gd06fca9e99


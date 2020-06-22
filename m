Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8BDC433DF
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C543B2075A
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgFVVrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:47:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:39320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgFVVrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:47:48 -0400
Received: (qmail 1902 invoked by uid 109); 22 Jun 2020 21:47:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Jun 2020 21:47:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8552 invoked by uid 111); 22 Jun 2020 21:47:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Jun 2020 17:47:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Jun 2020 17:47:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/4] fast-export: allow dumping anonymization mappings
Message-ID: <20200622214745.GA3302779@coredump.intra.peff.net>
References: <20200619132304.GA2540657@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619132304.GA2540657@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 09:23:04AM -0400, Jeff King wrote:

> This series gives an alternate way to achieve the same effect, but much
> better in that it works for _any_ ref (so if you are trying to reproduce
> the effect of "rev-list origin/foo..bar" in the anonymized repo, you can
> easily do so). Ditto for paths, so that "rev-list -- foo.c" can be
> reproduced in the anonymized repo.

Here's a v2 which I think addresses all of the comments. I have to admit
that after writing my last email to Junio, I am wondering whether it
would be sufficient and simpler to let the user specify a static mapping
of tokens (that could just be applied anywhere).

I'll take a look at that, but since I worked up this version, here it is
in the meantime.

The interesting changes are:

  - path output is now quoted, making it unambiguous. The intent is for
    humans to look at it, but it's not much extra work to make it
    machine readable, too.

  - the path dumping was in the wrong spot. It was happening in the
    generic function that's used for "path-like" things, including
    refnames. So the path mapping dump had extra cruft in it.

  - got rid of the maybe_dump_anon() helper

  - tests now avoid hard-coding expected counts

  - the path-dump test now checks the expected count

  [1/4]: fast-export: allow dumping the refname mapping
  [2/4]: fast-export: anonymize "master" refname
  [3/4]: fast-export: refactor path printing to not rely on stdout
  [4/4]: fast-export: allow dumping the path mapping

 Documentation/git-fast-export.txt | 34 +++++++++++++++
 builtin/fast-export.c             | 69 +++++++++++++++++++++++++------
 t/t9351-fast-export-anonymize.sh  | 44 ++++++++++++++++----
 3 files changed, 125 insertions(+), 22 deletions(-)

Range-diff from v1:

1:  82a17ae976 ! 1:  7ba5582d66 fast-export: allow dumping the refname mapping
    @@ builtin/fast-export.c: static int has_unshown_parent(struct commit *commit)
     +	kh_put_strset(seen->set, xstrdup(str), &hashret);
     +	return 0;
     +}
    -+
    -+static void maybe_dump_anon(FILE *out, struct seen_set *seen,
    -+			    const char *orig, const char *anon)
    -+{
    -+	if (!out)
    -+		return;
    -+	if (!check_and_mark_seen(seen, orig))
    -+		fprintf(out, "%s %s\n", orig, anon);
    -+}
     +
      struct anonymized_entry {
      	struct hashmap_entry hash;
    @@ builtin/fast-export.c: static const char *anonymize_refname(const char *refname)
      	}
      
      	anonymize_path(&anon, refname, &refs, anonymize_ref_component);
    -+	maybe_dump_anon(anonymized_refnames_handle, &seen,
    ++
    ++	if (anonymized_refnames_handle &&
    ++	    !check_and_mark_seen(&seen, full_refname))
    ++		fprintf(anonymized_refnames_handle, "%s %s\n",
     +			full_refname, anon.buf);
    ++
      	return anon.buf;
      }
      
    @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'stream omits tag message'
     +	# we make no guarantees of the exact anonymized names,
     +	# so just check that we have the right number and
     +	# that a sample line looks sane.
    ++	expected_count=$(git for-each-ref | wc -l) &&
     +	# Note that master is not anonymized, and so not included
     +	# in the mapping.
    -+	test_line_count = 6 refs.out &&
    ++	expected_count=$((expected_count - 1)) &&
    ++	test_line_count = $expected_count refs.out &&
     +	grep "^refs/heads/other refs/heads/" refs.out
     +'
     +
2:  be56b375cc ! 2:  d88f7c83a5 fast-export: anonymize "master" refname
    @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'stream omits path names'
      	! grep mytag stream
      '
     @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'refname mapping can be dumped' '
    - 	# we make no guarantees of the exact anonymized names,
      	# so just check that we have the right number and
      	# that a sample line looks sane.
    + 	expected_count=$(git for-each-ref | wc -l) &&
     -	# Note that master is not anonymized, and so not included
     -	# in the mapping.
    --	test_line_count = 6 refs.out &&
    -+	test_line_count = 7 refs.out &&
    +-	expected_count=$((expected_count - 1)) &&
    + 	test_line_count = $expected_count refs.out &&
      	grep "^refs/heads/other refs/heads/" refs.out
      '
    - 
     @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'import stream to new repository' '
      test_expect_success 'result has two branches' '
      	git for-each-ref --format="%(refname)" refs/heads >branches &&
-:  ---------- > 3:  164f1e1eab fast-export: refactor path printing to not rely on stdout
3:  a4e9f1f2ac ! 4:  b0aa59f07e fast-export: allow dumping the path mapping
    @@ Commit message
     
         We recently taught fast-export to dump the refname mapping. Let's do the
         same thing for paths, which can reuse most of the same infrastructure.
    -    Note that the output format isn't unambiguous here (because paths could
    -    contain spaces). That's OK because this is meant to be examined by a
    -    human.
     
         We could also just introduce a "dump mapping" file that shows every
         mapping we make. But it would be a bit more awkward to work with, as the
    @@ Documentation/git-fast-export.txt: by keeping the marks the same across runs.
     +	Output the mapping of real paths to anonymized paths to <file>.
     +	The output will contain one line per path that appears in the
     +	output stream, with the original path, a space, and its
    -+	anonymized counterpart. See the section on `ANONYMIZING` below.
    ++	anonymized counterpart. Paths may be quoted if they contain a
    ++	space, or unusual characters; see `core.quotePath` in
    ++	linkgit:git-config(1). See also `ANONYMIZING` below.
     +
      --reference-excluded-parents::
      	By default, running a command such as `git fast-export
    @@ builtin/fast-export.c: static struct string_list tag_refs = STRING_LIST_INIT_NOD
      static struct revision_sources revision_sources;
      
      static int parse_opt_signed_tag_mode(const struct option *opt,
    -@@ builtin/fast-export.c: static void anonymize_path(struct strbuf *out, const char *path,
    - 			   struct hashmap *map,
    - 			   void *(*generate)(const void *, size_t *))
    - {
    -+	static struct seen_set seen;
    -+	const char *full_path = path;
    +@@ builtin/fast-export.c: static void print_path(const char *path)
    + 		print_path_1(stdout, path);
    + 	else {
    + 		static struct hashmap paths;
    ++		static struct seen_set seen;
    + 		static struct strbuf anon = STRBUF_INIT;
    + 
    + 		anonymize_path(&anon, path, &paths, anonymize_path_component);
    ++		if (anonymized_paths_handle &&
    ++		    !check_and_mark_seen(&seen, path)) {
    ++			print_path_1(anonymized_paths_handle, path);
    ++			fputc(' ', anonymized_paths_handle);
    ++			print_path_1(anonymized_paths_handle, anon.buf);
    ++			fputc('\n', anonymized_paths_handle);
    ++		}
     +
    - 	while (*path) {
    - 		const char *end_of_component = strchrnul(path, '/');
    - 		size_t len = end_of_component - path;
    -@@ builtin/fast-export.c: static void anonymize_path(struct strbuf *out, const char *path,
    - 		if (*path)
    - 			strbuf_addch(out, *path++);
    + 		print_path_1(stdout, anon.buf);
    + 		strbuf_reset(&anon);
      	}
    -+
    -+	maybe_dump_anon(anonymized_paths_handle, &seen, full_path, out->buf);
    - }
    - 
    - static inline void *mark_to_ptr(uint32_t mark)
     @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
      	     *import_filename = NULL,
      	     *import_filename_if_exists = NULL;
    @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
      		printf("feature done\n");
     
      ## t/t9351-fast-export-anonymize.sh ##
    +@@ t/t9351-fast-export-anonymize.sh: test_expect_success 'setup simple repo' '
    + 	git checkout -b other HEAD^ &&
    + 	mkdir subdir &&
    + 	test_commit subdir/bar &&
    +-	test_commit subdir/xyzzy &&
    ++	test_commit quoting "subdir/this needs quoting" &&
    + 	git tag -m "annotated tag" mytag
    + '
    + 
    +@@ t/t9351-fast-export-anonymize.sh: test_expect_success 'stream omits path names' '
    + 	! grep foo stream &&
    + 	! grep subdir stream &&
    + 	! grep bar stream &&
    +-	! grep xyzzy stream
    ++	! grep quoting stream
    + '
    + 
    + test_expect_success 'stream omits refnames' '
     @@ t/t9351-fast-export-anonymize.sh: test_expect_success 'refname mapping can be dumped' '
      	grep "^refs/heads/other refs/heads/" refs.out
      '
      
     +test_expect_success 'path mapping can be dumped' '
     +	git fast-export --anonymize --all \
     +		--dump-anonymized-paths=paths.out >/dev/null &&
    -+	# do not assume a particular anonymization scheme or order;
    -+	# just sanity check that a sample line looks sensible.
    -+	grep "^foo " paths.out
    ++	# as above, avoid depending on the exact scheme, but
    ++	# but check that we have the right number of mappings,
    ++	# and spot-check one sample.
    ++	expected_count=$(
    ++		git rev-list --objects --all |
    ++		git cat-file --batch-check="%(objecttype) %(rest)" |
    ++		sed -ne "s/^blob //p" |
    ++		sort -u |
    ++		wc -l
    ++	) &&
    ++	test_line_count = $expected_count paths.out &&
    ++	grep "^\"subdir/this needs quoting\" " paths.out
     +'
     +
      # NOTE: we chdir to the new, anonymized repository

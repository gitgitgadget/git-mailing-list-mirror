Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0CC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 08:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjD0INf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 04:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0INe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 04:13:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD3F2D79
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 01:13:32 -0700 (PDT)
Received: (qmail 20654 invoked by uid 109); 27 Apr 2023 08:13:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Apr 2023 08:13:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17234 invoked by uid 111); 27 Apr 2023 08:13:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Apr 2023 04:13:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Apr 2023 04:13:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 0/4] fixing some parse_commit() timestamp corner cases
Message-ID: <20230427081330.GA1461786@coredump.intra.peff.net>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
 <20230425055458.GC4015649@coredump.intra.peff.net>
 <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com>
 <xmqqttx43q08.fsf@gitster.g>
 <20230426113658.GC130148@coredump.intra.peff.net>
 <xmqqildiveu6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqildiveu6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2023 at 08:32:49AM -0700, Junio C Hamano wrote:

> > Note that will exclude a few cases that we do allow now, like:
> >
> >   committer name <email> \v123456 +0000\n
> >
> > Right now that parses as "123456", but we'd reject it as "0" after such
> > a patch.
> 
> I would say that it is a good thing.
> 
> The only (somewhat) end-user controlled things on the line are the
> name and email, and even there name is sanitized to remove "crud".
> The user-supplied timestamp goes through date.c::parse_date(),
> ending up with what date.c::date_string() formats, so there will not
> be syntactically incorrect timestamp there.  So we can be strict
> format-wise on the timestamp field, once we identify where it begins,
> which is the point of scanning backwards for '>'.
> 
> Unless the user does "hash-object" and deliberately creates a
> malformed commit object---they can keep both halves just fine in
> such a case as long as we do reject such a timestamp correctly.

I think we'd ideally consider the behavior against hypothetical bugs in
other implementations (including us in the future!). So yeah, I don't
think we ever generated a syntactically incorrect timestamp, and it
would be hard for a user to create one. But all things being equal, I'd
prefer to keep parsing something like:

  committer name <email> 123456\n

which is missing its timezone (and seems like a plausible sort of bug).
But I'm OK to draw the line at "if your implementation is sticking
control characters in the header, then tough luck".

So here's a v3. I was tempted to add the fix on top of the existing
patch, since it's somewhat its own case, and could be explained
separately. But they really are two versions of the same problem, so I
just rolled it all into patch 3.

Patch 4 needed small updates to its comment to match. The first two
patches are the same.

  [1/4]: t4212: avoid putting git on left-hand side of pipe
  [2/4]: parse_commit(): parse timestamp from end of line
  [3/4]: parse_commit(): handle broken whitespace-only timestamp
  [4/4]: parse_commit(): describe more date-parsing failure modes

 commit.c               | 57 ++++++++++++++++++++++++++++++++++++------
 t/t4212-log-corrupt.sh | 51 +++++++++++++++++++++++++++++++++++--
 2 files changed, 98 insertions(+), 10 deletions(-)

1:  7a2fa8daac = 1:  57401571b6 t4212: avoid putting git on left-hand side of pipe
2:  d90c720075 = 2:  54fa983d66 parse_commit(): parse timestamp from end of line
3:  1a47c87c07 ! 3:  894815d82d parse_commit(): handle broken whitespace-only timestamp
    @@ Commit message
         line, as well as the "\n\n" separator, and mistake the subject for the
         timestamp.
     
    -    The new test demonstrates such a case. I also added a test to check this
    -    case against the pretty-print formatter, which uses split_ident_line().
    -    It's not subject to the same bug, because it insists that there be one
    -    or more digits in the timestamp.
    +    We can solve this by trimming the whitespace ourselves, making sure that
    +    it has some non-whitespace to parse. Note that we need to be a bit
    +    careful about the definition of "whitespace" here, as our isspace()
    +    doesn't match exotic characters like vertical tab or formfeed. We can
    +    work around that by checking for an actual number (see the in-code
    +    comment). This is slightly more restrictive than the current code, but
    +    in practice the results are either the same (we reject "foo" as "0", but
    +    so would parse_timestamp()) or extremely unlikely even for broken
    +    commits (parse_timestamp() would allow "\v123" as "123", but we'll know
    +    make it "0").
     
    +    I did also allow "-" here, which may be controversial, as we don't
    +    currently support negative timestamps. My reasoning was two-fold. One,
    +    the design of parse_timestamp() is such that we should be able to easily
    +    switch it to handling signed values, and this otherwise creates a
    +    hard-to-find gotcha that anybody doing that work would get tripped up
    +    on. And two, the status quo is that we currently parse them, though the
    +    result of course ends up as a very large unsigned value (which is likely
    +    to just get clamped to "0" for display anyway, since our date routines
    +    can't handle it).
    +
    +    The new test checks the commit parser (via "--until") for both vanilla
    +    spaces and the vertical-tab case. I also added a test to check these
    +    against the pretty-print formatter, which uses split_ident_line().  It's
    +    not subject to the same bug, because it already insists that there be
    +    one or more digits in the timestamp.
    +
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## commit.c ##
    @@ commit.c: static timestamp_t parse_commit_date(const char *buf, const char *tail
      
     -	/* dateptr < eol && *eol == '\n', so parsing will stop at eol */
     +	/*
    -+	 * Trim leading whitespace; parse_timestamp() will do this itself, but
    -+	 * if we have _only_ whitespace, it will walk right past the newline
    -+	 * while doing so.
    ++	 * Trim leading whitespace, but make sure we have at least one
    ++	 * non-whitespace character, as parse_timestamp() will otherwise walk
    ++	 * right past the newline we found in "eol" when skipping whitespace
    ++	 * itself.
    ++	 *
    ++	 * In theory it would be sufficient to allow any character not matched
    ++	 * by isspace(), but there's a catch: our isspace() does not
    ++	 * necessarily match the behavior of parse_timestamp(), as the latter
    ++	 * is implemented by system routines which match more exotic control
    ++	 * codes, or even locale-dependent sequences.
    ++	 *
    ++	 * Since we expect the timestamp to be a number, we can check for that.
    ++	 * Anything else (e.g., a non-numeric token like "foo") would just
    ++	 * cause parse_timestamp() to return 0 anyway.
     +	 */
     +	while (dateptr < eol && isspace(*dateptr))
     +		dateptr++;
    -+	if (dateptr == eol)
    ++	if (!isdigit(*dateptr) && *dateptr != '-')
     +		return 0;
     +
     +	/*
    -+	 * We know there is at least one non-whitespace character, so we'll
    -+	 * begin parsing there and stop at worst case at eol.
    ++	 * We know there is at least one digit (or dash), so we'll begin
    ++	 * parsing there and stop at worst case at eol.
     +	 */
      	return parse_timestamp(dateptr, NULL, 10);
      }
    @@ t/t4212-log-corrupt.sh: test_expect_success 'absurdly far-in-future date' '
      	git log -1 --format=%ad $commit
      '
      
    -+test_expect_success 'create commit with whitespace committer date' '
    ++test_expect_success 'create commits with whitespace committer dates' '
     +	# It is important that this subject line is numeric, since we want to
     +	# be sure we are not confused by skipping whitespace and accidentally
     +	# parsing the subject as a timestamp.
     +	#
     +	# Do not use munge_author_date here. Besides not hitting the committer
     +	# line, it leaves the timezone intact, and we want nothing but
     +	# whitespace.
    ++	#
    ++	# We will make two munged commits here. The first, ws_commit, will
    ++	# be purely spaces. The second contains a vertical tab, which is
    ++	# considered a space by strtoumax(), but not by our isspace().
     +	test_commit 1234567890 &&
     +	git cat-file commit HEAD >commit.orig &&
     +	sed "s/>.*/>    /" <commit.orig >commit.munge &&
    -+	ws_commit=$(git hash-object --literally -w -t commit commit.munge)
    ++	ws_commit=$(git hash-object --literally -w -t commit commit.munge) &&
    ++	sed "s/>.*/>   $(printf "\013")/" <commit.orig >commit.munge &&
    ++	vt_commit=$(git hash-object --literally -w -t commit commit.munge)
     +'
     +
     +test_expect_success '--until treats whitespace date as sentinel' '
     +	echo $ws_commit >expect &&
     +	git rev-list --until=1980-01-01 $ws_commit >actual &&
    ++	test_cmp expect actual &&
    ++
    ++	echo $vt_commit >expect &&
    ++	git rev-list --until=1980-01-01 $vt_commit >actual &&
     +	test_cmp expect actual
     +'
     +
    @@ t/t4212-log-corrupt.sh: test_expect_success 'absurdly far-in-future date' '
     +	# test bogus timestamps with git-log, 2014-02-24) for more discussion.
     +	echo : >expect &&
     +	git log -1 --format="%at:%ct" $ws_commit >actual &&
    ++	test_cmp expect actual &&
    ++	git log -1 --format="%at:%ct" $vt_commit &&
     +	test_cmp expect actual
     +'
     +
4:  193a01a32a < -:  ---------- parse_commit(): describe more date-parsing failure modes
-:  ---------- > 4:  ff7e9ddc7c parse_commit(): describe more date-parsing failure modes

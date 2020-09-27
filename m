Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D22DC4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAD4207BC
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgI0Ijf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:39:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:42364 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730450AbgI0Ijf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:39:35 -0400
Received: (qmail 29126 invoked by uid 109); 27 Sep 2020 08:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4020 invoked by uid 111); 27 Sep 2020 08:39:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:39:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:39:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: [PATCH v2 0/8] parsing trailers with shortlog
Message-ID: <20200927083933.GA2222823@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 03:01:20AM -0400, Jeff King wrote:

> Somebody mentioned at the inclusion summit that it would be nice for
> mentoring/pairing relationships if we could more easily give credit to
> multiple authors of a commit. When people ask about adding multiple
> "author" headers, we usually recommend that they use a "co-authored-by"
> trailer. But you can't convince shortlog to count it for anything. :)
> 
> So this series adds support for counting trailers to shortlog. You can
> do a number of fun things with it, like:

Here's a re-roll with some cosmetic fixups. All except the first address
the points raised by Eric and Martin (thanks, both):

  - put the --group=<type> unordered list into a delimited block, so
    that the follow-on paragraph about multiple --group options isn't
    indented with "trailer" item

  - reword --group docs for clarity

  - use existing HAS_MULTI_BITS

  - add trailing commas in enum

  - complete truncated trailer_iterator comment

  - fix misleading "refactor" commit message in patch 2

Range diff is below.

  [1/8]: shortlog: change "author" variables to "ident"
  [2/8]: shortlog: add grouping option
  [3/8]: trailer: add interface for iterating over commit trailers
  [4/8]: shortlog: match commit trailers with --group
  [5/8]: shortlog: de-duplicate trailer values
  [6/8]: shortlog: rename parse_stdin_ident()
  [7/8]: shortlog: parse trailer idents
  [8/8]: shortlog: allow multiple groups to be specified

 Documentation/git-shortlog.txt |  31 ++++-
 builtin/log.c                  |   1 +
 builtin/shortlog.c             | 213 ++++++++++++++++++++++++++++-----
 shortlog.h                     |   8 +-
 t/t4201-shortlog.sh            | 141 ++++++++++++++++++++++
 trailer.c                      |  36 ++++++
 trailer.h                      |  45 ++++++-
 7 files changed, 444 insertions(+), 31 deletions(-)

1:  675e8cea10 = 1:  3b658cba7c shortlog: change "author" variables to "ident"
2:  72d94a2601 ! 2:  3ed8a55597 shortlog: refactor committer/author grouping
    @@ Metadata
     Author: Jeff King <peff@peff.net>
     
      ## Commit message ##
    -    shortlog: refactor committer/author grouping
    +    shortlog: add grouping option
     
    -    In preparation for adding more grouping types, let's
    -    refactor the committer/author grouping code. In particular:
    +    In preparation for adding more grouping types, let's refactor the
    +    committer/author grouping code and add a user-facing option that binds
    +    them together. In particular:
     
    -      - the master option is now "--group", to make it clear
    +      - the main option is now "--group", to make it clear
             that the various group types are mutually exclusive. The
             "--committer" option is an alias for "--group=committer".
     
    @@ Documentation/git-shortlog.txt: OPTIONS
      	Each pretty-printed commit will be rewrapped before it is shown.
      
     +--group=<type>::
    -+	By default, `shortlog` collects and collates author identities;
    -+	using `--group` will collect other fields.
    -+	`<type>` is one of:
    ++	Group commits based on `<type>`. If no `--group` option is
    ++	specified, the default is `author`. `<type>` is one of:
     ++
    -+ - `author`, commits are grouped by author (this is the default)
    ++ - `author`, commits are grouped by author
     + - `committer`, commits are grouped by committer (the same as `-c`)
     +
      -c::
      --committer::
    - 	Collect and show committer identities instead of authors.
    +-	Collect and show committer identities instead of authors.
     +	This is an alias for `--group=committer`.
      
      -w[<width>[,<indent1>[,<indent2>]]]::
    @@ shortlog.h: struct shortlog {
     +
     +	enum {
     +		SHORTLOG_GROUP_AUTHOR = 0,
    -+		SHORTLOG_GROUP_COMMITTER
    ++		SHORTLOG_GROUP_COMMITTER,
     +	} group;
      
      	char *common_repo_prefix;
3:  bec4ec1433 ! 3:  d314578bde trailer: add interface for iterating over commit trailers
    @@ trailer.h: void trailer_info_release(struct trailer_info *info);
     + * message "msg". The "msg" pointer must remain valid until the iterator is
     + * released.
     + *
    -+ * After initializing, we are not yet pointing
    ++ * After initializing, note that key/val will not yet point to any trailer.
    ++ * Call advance() to parse the first one (if any).
     + */
     +void trailer_iterator_init(struct trailer_iterator *iter, const char *msg);
     +
4:  7e6ee8317f ! 4:  fdb1dbd164 shortlog: match commit trailers with --group
    @@ Commit message
      ## Documentation/git-shortlog.txt ##
     @@ Documentation/git-shortlog.txt: OPTIONS
      +
    -  - `author`, commits are grouped by author (this is the default)
    +  - `author`, commits are grouped by author
       - `committer`, commits are grouped by committer (the same as `-c`)
     + - `trailer:<field>`, the `<field>` is interpreted as a case-insensitive
     +   commit message trailer (see linkgit:git-interpret-trailers[1]). For
    @@ builtin/shortlog.c: static int parse_wrap_args(const struct option *opt, const c
     
      ## shortlog.h ##
     @@ shortlog.h: struct shortlog {
    - 
      	enum {
      		SHORTLOG_GROUP_AUTHOR = 0,
    --		SHORTLOG_GROUP_COMMITTER
    -+		SHORTLOG_GROUP_COMMITTER,
    -+		SHORTLOG_GROUP_TRAILER
    + 		SHORTLOG_GROUP_COMMITTER,
    ++		SHORTLOG_GROUP_TRAILER,
      	} group;
     +	char *trailer;
      
5:  8bc6a94239 = 5:  6374604756 shortlog: de-duplicate trailer values
6:  16294b5d16 = 6:  dfabab9957 shortlog: rename parse_stdin_ident()
7:  82c637c0a2 = 7:  bbe87d0e2a shortlog: parse trailer idents
8:  4cacdecaa0 ! 8:  ca782fa92e shortlog: allow multiple groups to be specified
    @@ Commit message
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## Documentation/git-shortlog.txt ##
    +@@ Documentation/git-shortlog.txt: OPTIONS
    + 	Group commits based on `<type>`. If no `--group` option is
    + 	specified, the default is `author`. `<type>` is one of:
    + +
    ++--
    +  - `author`, commits are grouped by author
    +  - `committer`, commits are grouped by committer (the same as `-c`)
    +  - `trailer:<field>`, the `<field>` is interpreted as a case-insensitive
     @@ Documentation/git-shortlog.txt: Shortlog will attempt to parse each trailer value as a `name <email>`
      identity. If successful, the mailmap is applied and the email is omitted
      unless the `--email` option is specified. If the value cannot be parsed
      as an identity, it will be taken literally and completely.
    ++--
     ++
     +If `--group` is specified multiple times, commits are counted under each
     +value (but again, only once per unique value in that commit). For
    @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_stdou
      
     
      ## builtin/shortlog.c ##
    -@@ builtin/shortlog.c: static int parse_ident(struct shortlog *log,
    - 	return 0;
    - }
    - 
    -+static inline int has_multi_bits(unsigned n)
    -+{
    -+	return (n & (n - 1)) != 0;
    -+}
    -+
    - static void read_from_stdin(struct shortlog *log)
    - {
    - 	struct strbuf ident = STRBUF_INIT;
     @@ builtin/shortlog.c: static void read_from_stdin(struct shortlog *log)
      	static const char *committer_match[2] = { "Commit: ", "committer " };
      	const char **match;
      
     -	switch (log->group) {
    -+	if (has_multi_bits(log->groups))
    ++	if (HAS_MULTI_BITS(log->groups))
     +		die(_("using multiple --group options with stdin is not supported"));
     +
     +	switch (log->groups) {
    @@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit
     -		insert_one_record(log, ident.buf, oneline_str);
     -		break;
     -	case SHORTLOG_GROUP_COMMITTER:
    -+		if (!has_multi_bits(log->groups) ||
    ++		if (!HAS_MULTI_BITS(log->groups) ||
     +		    !strset_check_and_add(&dups, ident.buf))
     +			insert_one_record(log, ident.buf, oneline_str);
     +	}
    @@ builtin/shortlog.c: void shortlog_add_commit(struct shortlog *log, struct commit
     -	case SHORTLOG_GROUP_TRAILER:
     -		insert_records_from_trailers(log, commit, &ctx, oneline_str);
     -		break;
    -+		if (!has_multi_bits(log->groups) ||
    ++		if (!HAS_MULTI_BITS(log->groups) ||
     +		    !strset_check_and_add(&dups, ident.buf))
     +			insert_one_record(log, ident.buf, oneline_str);
     +	}
    @@ shortlog.h: struct shortlog {
      	enum {
     -		SHORTLOG_GROUP_AUTHOR = 0,
     -		SHORTLOG_GROUP_COMMITTER,
    --		SHORTLOG_GROUP_TRAILER
    +-		SHORTLOG_GROUP_TRAILER,
     -	} group;
     -	char *trailer;
     +		SHORTLOG_GROUP_AUTHOR = (1 << 0),
     +		SHORTLOG_GROUP_COMMITTER = (1 << 1),
    -+		SHORTLOG_GROUP_TRAILER = (1 << 2)
    ++		SHORTLOG_GROUP_TRAILER = (1 << 2),
     +	} groups;
     +	struct string_list trailers;
      

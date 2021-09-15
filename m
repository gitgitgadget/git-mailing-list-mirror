Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43216C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211CE610A6
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhIOSfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:35:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:48340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhIOSfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:35:13 -0400
Received: (qmail 360 invoked by uid 109); 15 Sep 2021 18:33:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Sep 2021 18:33:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26768 invoked by uid 111); 15 Sep 2021 18:33:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Sep 2021 14:33:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Sep 2021 14:33:52 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/11] limit memory allocations for v2 servers
Message-ID: <YUI8kBkK6SJYJcDO@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUE1alo58cGyTw6/@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK, hopefully third time's the charm. The changes from v2 are pretty
minor:

 - test typos noticed by Eric (none affected the outcome of the tests)

 - I added "object-format=$(test_oid algo)" to the input of a few of the
   new tests even where it doesn't change the outcome, for consistency
   with the existing tests

 - dropped out-dated "collect" comment noticed by Junio

 - explained the command=ls-refs=foo case a little further, including
   specific references in how it violates the spec

Range-diff is below.

  [01/11]: serve: rename is_command() to parse_command()
  [02/11]: serve: return capability "value" from get_capability()
  [03/11]: serve: add "receive" method for v2 capabilities table
  [04/11]: serve: provide "receive" function for object-format capability
  [05/11]: serve: provide "receive" function for session-id capability
  [06/11]: serve: drop "keys" strvec
  [07/11]: ls-refs: ignore very long ref-prefix counts
  [08/11]: docs/protocol-v2: clarify some ls-refs ref-prefix details
  [09/11]: serve: reject bogus v2 "command=ls-refs=foo"
  [10/11]: serve: reject commands used as capabilities
  [11/11]: ls-refs: reject unknown arguments

 Documentation/technical/protocol-v2.txt |   6 +-
 ls-refs.c                               |  22 ++++-
 serve.c                                 | 120 +++++++++++++-----------
 t/t5701-git-serve.sh                    |  75 +++++++++++++++
 4 files changed, 164 insertions(+), 59 deletions(-)

 1:  e642ced1e8 =  1:  71003eb21a serve: rename is_command() to parse_command()
 2:  75d119ae49 =  2:  1e86c31477 serve: return capability "value" from get_capability()
 3:  9fb21cab1d =  3:  12a159d5c8 serve: add "receive" method for v2 capabilities table
 4:  5b661c9ed5 =  4:  f5c29b5cdf serve: provide "receive" function for object-format capability
 5:  34e0ce5c12 =  5:  063cb60d1e serve: provide "receive" function for session-id capability
 6:  8e42fa9aec !  6:  0ed0b946ea serve: drop "keys" strvec
    @@ serve.c: static int process_request(void)
      
      	packet_reader_init(&reader, 0, NULL, 0,
     @@ serve.c: static int process_request(void)
    - 			/* collect request; a sequence of keys and values */
    + 		case PACKET_READ_EOF:
    + 			BUG("Should have already died when seeing EOF");
    + 		case PACKET_READ_NORMAL:
    +-			/* collect request; a sequence of keys and values */
      			if (parse_command(reader.line, &command) ||
      			    receive_client_capability(reader.line))
     -				strvec_push(&keys, reader.line);
 7:  de7ac11ad3 !  7:  a9392d0e68 ls-refs: ignore very long ref-prefix counts
    @@ t/t5701-git-serve.sh: test_expect_success 'refs/heads prefix' '
     +	# from ls-refs.c.
     +	{
     +		echo command=ls-refs &&
    -+		echo object-format=$(test_oid algo)
    ++		echo object-format=$(test_oid algo) &&
     +		echo 0001 &&
     +		perl -le "print \"ref-prefix refs/heads/\$_\" for (1..65536)" &&
     +		echo 0000
 8:  3f78422fd3 =  8:  0a982f676a docs/protocol-v2: clarify some ls-refs ref-prefix details
 9:  6c55a7412d !  9:  553db6f83e serve: reject bogus v2 "command=ls-refs=foo"
    @@ Commit message
         When we see a line from the client like "command=ls-refs", we parse
         everything after the equals sign as a capability, which we check against
         our capabilities table. If we don't recognize the command (e.g.,
    -    "command=foo"), we'll reject it. But we use the same parser that checks
    -    for regular capabilities like "object-format=sha256". And so we'll
    -    accept "ls-refs=foo", even though everything after the equals is bogus,
    -    and simply ignored.
    +    "command=foo"), we'll reject it.
     
    -    This isn't really hurting anything, but the request does violate the
    -    spec. Let's tighten it up to prevent any surprising behavior.
    +    But in parse_command(), we use the same get_capability() parser for
    +    parsing non-command lines. So if we see "command=ls-refs=foo", we will
    +    feed "ls-refs=foo" to get_capability(), which will say "OK, that's
    +    ls-refs, with value 'foo'". But then we simply ignore the value
    +    entirely.
    +
    +    The client is violating the spec here, which says:
    +
    +          command = PKT-LINE("command=" key LF)
    +          key = 1*(ALPHA | DIGIT | "-_")
    +
    +    I.e., the key is not even allowed to have an equals sign in it. Whereas
    +    a real non-command capability does allow a value:
    +
    +          capability = PKT-LINE(key[=value] LF)
    +
    +    So by reusing the same get_capability() parser, we are mixing up the
    +    "key" and "capability" tokens. However, since that parser tells us
    +    whether it saw an "=", we can still use it; we just reject any input
    +    that produces a non-NULL value field.
    +
    +    The current behavior isn't really hurting anything (the client should
    +    never send such a request, and if it does, we just ignore the "value"
    +    part). But since it does violate the spec, let's tighten it up to
    +    prevent any surprising behavior.
     
         Signed-off-by: Jeff King <peff@peff.net>
     
    @@ t/t5701-git-serve.sh: test_expect_success 'request invalid command' '
      '
      
     +test_expect_success 'requested command is command=value' '
    -+	test-tool pkt-line pack >in <<-\EOF &&
    ++	test-tool pkt-line pack >in <<-EOF &&
     +	command=ls-refs=whatever
     +	object-format=$(test_oid algo)
     +	0000
10:  bbb12669b9 ! 10:  93216b9eaa serve: reject commands used as capabilities
    @@ t/t5701-git-serve.sh: test_expect_success 'request invalid command' '
      '
      
     +test_expect_success 'request capability as command' '
    -+	test-tool pkt-line pack >in <<-\EOF &&
    ++	test-tool pkt-line pack >in <<-EOF &&
     +	command=agent
    ++	object-format=$(test_oid algo)
     +	0000
     +	EOF
     +	test_must_fail test-tool serve-v2 --stateless-rpc 2>err <in &&
     +	grep invalid.command.*agent err
     +'
     +
     +test_expect_success 'request command as capability' '
    -+	test-tool pkt-line pack >in <<-\EOF &&
    ++	test-tool pkt-line pack >in <<-EOF &&
     +	command=ls-refs
    ++	object-format=$(test_oid algo)
     +	fetch
     +	0000
     +	EOF
    @@ t/t5701-git-serve.sh: test_expect_success 'request invalid command' '
     +'
     +
      test_expect_success 'requested command is command=value' '
    - 	test-tool pkt-line pack >in <<-\EOF &&
    + 	test-tool pkt-line pack >in <<-EOF &&
      	command=ls-refs=whatever
11:  375a85b9a6 = 11:  30802eeb54 ls-refs: reject unknown arguments

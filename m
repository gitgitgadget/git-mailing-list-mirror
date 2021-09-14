Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F4C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60F361185
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbhINXwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:52:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:47560 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhINXwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:52:25 -0400
Received: (qmail 28492 invoked by uid 109); 14 Sep 2021 23:51:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 23:51:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30602 invoked by uid 111); 14 Sep 2021 23:51:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 19:51:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 19:51:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 0/11] limit memory allocations for v2 servers
Message-ID: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a re-roll of my series to limit the memory a v2 server is willing
to allocate on behalf of a client. See v1:

  https://lore.kernel.org/git/YUC%2F6n1hhUbMJiLw@coredump.intra.peff.net/

for an overview. The existing patches are mostly small fixups pointed
out by reviewers (thanks!), but I did take Martin's TOO_MANY_PREFIXES
suggestion in patch 7 (without the change to the name of the constant it
seemed too clever to me, but with it it seems just the right amount of
clever).

There are two new patches here:

 - patch 8 explicitly documents the v2 ref-prefix "best effort" behavior

 - patch 11 teaches ls-refs to reject bogus arguments, which violates
   the spec (the current behavior caused a broken test to go unnoticed)

Full range-diff is below the diffstat.

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
 serve.c                                 | 119 +++++++++++++-----------
 t/t5701-git-serve.sh                    |  73 +++++++++++++++
 4 files changed, 162 insertions(+), 58 deletions(-)

 1:  eb8e7b21a1 =  1:  eb8e7b21a1 serve: rename is_command() to parse_command()
 2:  8cc66cae41 =  2:  8cc66cae41 serve: return capability "value" from get_capability()
 3:  3343f9bb0a =  3:  3343f9bb0a serve: add "receive" method for v2 capabilities table
 4:  c4cc80fe7a !  4:  0319b69881 serve: provide "receive" function for object-format capability
    @@ Commit message
         all capabilities (because they might not have sent an object-format line
         at all, and we still have to check that the default matches our
         repository algorithm). Since the check_algorithm() function would now be
    -    done to a single if() statement, I've just inlined it in its only
    +    down to a single if() statement, I've just inlined it in its only
         caller.
     
         There should be no change of behavior here, except for two
 5:  c8527ca5a7 =  5:  efe207c35c serve: provide "receive" function for session-id capability
 6:  250e4723ba !  6:  463aa7faa3 serve: drop "keys" strvec
    @@ serve.c: static int process_request(void)
      			else
      				die("unknown capability '%s'", reader.line);
      
    -+
    - 			/* Consume the peeked line */
    - 			packet_reader_read(&reader);
    - 			break;
     @@ serve.c: static int process_request(void)
      			 * If no command and no keys were given then the client
      			 * wanted to terminate the connection.
 7:  1218d62247 !  7:  da2043f42f ls-refs: ignore very long ref-prefix counts
    @@ ls-refs.c: static void ensure_config_read(void)
      }
      
     +/*
    -+ * The maximum number of "ref-prefix" lines we'll allow the client to send.
    -+ * If they go beyond this, we'll avoid using the prefix feature entirely.
    ++ * If we see this many or more "ref-prefix" lines from the client, we consider
    ++ * it "too many" and will avoid using the prefix feature entirely.
     + */
    -+#define MAX_ALLOWED_PREFIXES 65536
    ++#define TOO_MANY_PREFIXES 65536
     +
      /*
       * Check if one of the prefixes is a prefix of the ref.
       * If no prefixes were provided, all refs match.
    -@@ ls-refs.c: static int ls_refs_config(const char *var, const char *value, void *data)
    - int ls_refs(struct repository *r, struct packet_reader *request)
    - {
    - 	struct ls_refs_data data;
    -+	int too_many_prefixes = 0;
    - 
    - 	memset(&data, 0, sizeof(data));
    - 	strvec_init(&data.prefixes);
     @@ ls-refs.c: int ls_refs(struct repository *r, struct packet_reader *request)
      			data.peel = 1;
      		else if (!strcmp("symrefs", arg))
      			data.symrefs = 1;
     -		else if (skip_prefix(arg, "ref-prefix ", &out))
     -			strvec_push(&data.prefixes, out);
     +		else if (skip_prefix(arg, "ref-prefix ", &out)) {
    -+			if (too_many_prefixes) {
    -+				/* ignore any further ones */
    -+			} else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
    -+				strvec_clear(&data.prefixes);
    -+				too_many_prefixes = 1;
    -+			} else {
    ++			if (data.prefixes.nr < TOO_MANY_PREFIXES)
     +				strvec_push(&data.prefixes, out);
    -+			}
     +		}
      		else if (!strcmp("unborn", arg))
      			data.unborn = allow_unborn;
      	}
    + 
    + 	if (request->status != PACKET_READ_FLUSH)
    + 		die(_("expected flush after ls-refs arguments"));
    + 
    ++	/*
    ++	 * If we saw too many prefixes, we must avoid using them at all; as
    ++	 * soon as we have any prefix, they are meant to form a comprehensive
    ++	 * list.
    ++	 */
    ++	if (data.prefixes.nr >= TOO_MANY_PREFIXES)
    ++		strvec_clear(&data.prefixes);
    ++
    + 	send_possibly_unborn_head(&data);
    + 	if (!data.prefixes.nr)
    + 		strvec_push(&data.prefixes, "");
     
      ## t/t5701-git-serve.sh ##
     @@ t/t5701-git-serve.sh: test_expect_success 'refs/heads prefix' '
    @@ t/t5701-git-serve.sh: test_expect_success 'refs/heads prefix' '
      
     +test_expect_success 'ignore very large set of prefixes' '
     +	# generate a large number of ref-prefixes that we expect
    -+	# to match nothing; the value here exceeds MAX_ALLOWED_PREFIXES
    ++	# to match nothing; the value here exceeds TOO_MANY_PREFIXES
     +	# from ls-refs.c.
     +	{
     +		echo command=ls-refs &&
     +		echo object-format=$(test_oid algo)
     +		echo 0001 &&
    -+		perl -le "print \"refs/heads/$_\" for (1..65536+1)" &&
    ++		perl -le "print \"ref-prefix refs/heads/\$_\" for (1..65536)" &&
     +		echo 0000
     +	} |
     +	test-tool pkt-line pack >in &&
 -:  ---------- >  8:  ee540a4ef7 docs/protocol-v2: clarify some ls-refs ref-prefix details
 8:  b1567fdc82 =  9:  481c07cfac serve: reject bogus v2 "command=ls-refs=foo"
 9:  9786b9a11f = 10:  dff965c1d2 serve: reject commands used as capabilities
 -:  ---------- > 11:  f7339f924b ls-refs: reject unknown arguments

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A71C77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 07:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDLH02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDLH0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 03:26:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522F30CB
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 00:26:23 -0700 (PDT)
Received: (qmail 18380 invoked by uid 109); 12 Apr 2023 07:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 07:26:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17481 invoked by uid 111); 12 Apr 2023 07:26:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 03:26:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 03:26:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 1/7] v0 protocol: fix infinite loop when parsing
 multi-valued capabilities
Message-ID: <20230412072622.GA1695073@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
 <20230412062924.GA1681312@coredump.intra.peff.net>
 <20230412064651.GA1681676@coredump.intra.peff.net>
 <20230412072510.GA1694877@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412072510.GA1694877@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 03:25:10AM -0400, Jeff King wrote:

> So I think it's worth fixing, and even worth beefing up the test to
> include this case, but sadly there's no specific case to check for. So I
> just rolled it into the fix in patch 1.
> 
> Here's that patch (and I'll send a range-diff in a second). The rest are
> the same, modulo a small textual conflict in patch 7 that touches a
> nearby line, but I'll refrain from re-sending the rest of them until
> I've gotten more review.

And here's the range-diff.

1:  c379efdcc0 ! 1:  3958a89100 v0 protocol: fix infinite loop when parsing multi-valued capabilities
    @@ Commit message
         feature_list only inside our function, and not the caller, that
         increment is lost next time the function is called.
     
    -    The simplest solution is to account for those skipped bytes by
    -    incrementing *offset, rather than assigning to it. (The other possible
    -    solution is to add an extra level of pointer indirection to feature_list
    -    so that the caller knows we moved it forward, but that seems more
    -    complicated).
    +    One solution would be to account for those skipped bytes by incrementing
    +    *offset, rather than assigning to it. But wait, there's more!
    +
    +    We also increment feature_list if we have a near-miss. Say we are
    +    looking for "symref" and find "almost-symref". In that case we'll point
    +    feature_list to the "y" in "almost-symref" and restart our search. But
    +    that again means our offset won't be correct, as it won't account for
    +    the bytes between the start of the string and that "y".
    +
    +    So instead, let's just record the beginning of the feature_list string
    +    in a separate pointer that we never touch. That offset we take in and
    +    return is meant to be using that point as a base, and now we'll do so
    +    consistently.
     
         Since the bug can't be reproduced using the current version of
         git-upload-pack, we'll instead hard-code an input which triggers the
    @@ Commit message
         Signed-off-by: Jeff King <peff@peff.net>
     
      ## connect.c ##
    +@@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
    + 
    + const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
    + {
    ++	const char *orig_start = feature_list;
    + 	int len;
    + 
    + 	if (!feature_list)
     @@ connect.c: const char *parse_feature_value(const char *feature_list, const char *feature, i
      				if (lenp)
      					*lenp = 0;
      				if (offset)
     -					*offset = found + len - feature_list;
    -+					*offset += found + len - feature_list;
    ++					*offset = found + len - orig_start;
      				return value;
      			}
      			/* feature with a value (e.g., "agent=git/1.2.3") */
    @@ connect.c: const char *parse_feature_value(const char *feature_list, const char
      					*lenp = end;
      				if (offset)
     -					*offset = value + end - feature_list;
    -+					*offset += value + end - feature_list;
    ++					*offset = value + end - orig_start;
      				return value;
      			}
      			/*
    @@ t/t5512-ls-remote.sh: test_expect_success 'ls-remote prefixes work with all prot
     +	symrefs="symref=refs/remotes/origin/HEAD:refs/remotes/origin/main" &&
     +	symrefs="$symrefs symref=HEAD:refs/heads/main" &&
     +
    ++	# Likewise we want to make sure our parser is not fooled by the string
    ++	# "symref" appearing as part of an earlier cap. But there is no way to
    ++	# do that via upload-pack, as arbitrary strings can appear only in a
    ++	# "symref" value itself (where we skip past the values as a whole)
    ++	# and "agent" (which always appears after "symref", so putting our
    ++	# parser in a confused state is less interesting).
    ++	caps="some other caps including a-fake-symref-cap" &&
    ++
     +	test-tool pkt-line pack >input.q <<-EOF &&
    -+	$oid HEADQ$symrefs
    ++	$oid HEADQ$caps $symrefs
     +	$oid refs/heads/main
     +	$oid refs/remotes/origin/HEAD
     +	$oid refs/remotes/origin/main
2:  2a8e6943e5 = 2:  4cb0739770 t5512: stop referring to "v1" protocol
3:  7e411ed56b = 3:  4fe3be0476 t5512: stop using jgit for capabilities^{} test
4:  65387a02bf = 4:  77875ff7f6 t5512: add v2 support for "ls-remote --symref" test
5:  3409bd94b0 = 5:  642608ac2d t5512: allow any protocol version for filtered symref test
6:  c42a25ceca = 6:  20c78c9e41 t5512: test "ls-remote --heads --symref" filtering with v0 and v2
7:  86067753cb ! 7:  48a46fc6fc v0 protocol: use size_t for capability length/offset
    @@ connect.c: struct ref **get_remote_refs(int fd_out, struct packet_reader *reader
     -const char *parse_feature_value(const char *feature_list, const char *feature, int *lenp, int *offset)
     +const char *parse_feature_value(const char *feature_list, const char *feature, size_t *lenp, size_t *offset)
      {
    + 	const char *orig_start = feature_list;
     -	int len;
     +	size_t len;
      

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29ADFC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiKBHmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBHmK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:42:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BA24F30
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:42:08 -0700 (PDT)
Received: (qmail 8932 invoked by uid 109); 2 Nov 2022 07:42:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 07:42:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2871 invoked by uid 111); 2 Nov 2022 07:42:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 03:42:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 03:42:07 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: [PATCH 1/2] ref-filter: fix parsing of signatures without blank lines
Message-ID: <Y2IfT0UFJ7H/mHMz@coredump.intra.peff.net>
References: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When ref-filter is asked to show %(content:subject), etc, we end up in
find_subpos() to parse out the three major parts: the subject, the body,
and the signature (if any).

When searching for the blank line between the subject and body, if we
don't find anything, we try to treat the whole message as the subject,
with no body. But our idea of "the whole message" needs to take into
account the signature, too. Since 9f75ce3d8f (ref-filter: handle CRLF at
end-of-line more gracefully, 2020-10-29), the code instead goes all the
way to the end of the buffer, which produces confusing output.

Here's an example. If we have a tag message like this:

  this is the subject
  -----BEGIN SSH SIGNATURE-----
  ...some stuff...
  -----END SSH SIGNATURE-----

then the current parser will put the start of the body at the end of the
whole buffer. This produces two buggy outcomes:

  - since the subject length is computed as (body - subject), showing
    %(contents:subject) will print both the subject and the signature,
    rather than just the single line

  - since the body length is computed as (sig - body), and the body now
    starts _after_ the signature, we end up with a negative length!
    Fortunately we never access out-of-bounds memory, because the
    negative length is fed to xmemdupz(), which casts it to a size_t,
    and xmalloc() bails trying to allocate an absurdly large value.

    In theory it would be possible for somebody making a malicious tag
    to wrap it around to a more reasonable value, but it would require a
    tag on the order of 2^63 bytes. And even if they did, all they get
    is an out of bounds string read. So the security implications are
    probably not interesting.

We can fix both by correctly putting the start of the body at the same
index as the start of the signature (effectively making the body empty).

Note that this is a real issue with signatures generated with gpg.format
set to "ssh", which would look like the example above. In the new tests
here I use a hard-coded tag message, for a few reasons:

  - regardless of what the ssh-signing code produces now or in the
    future, we should be testing this particular case

  - skipping the actual signature makes the tests simpler to write (and
    allows them to run on more systems)

  - t6300 has helpers for working with gpg signatures; for the purposes
    of this bug, "BEGIN PGP" is just as good a demonstration, and this
    simplifies the tests

Curiously, the same issue doesn't happen with real gpg signatures (and
there are even existing tests in t6300 with cover this). Those have a
blank line between the header and the content, like:

  this is the subject
  -----BEGIN PGP SIGNATURE-----

  ...some stuff...
  -----END PGP SIGNATURE-----

Because we search for the subject/body separator line with a strstr(),
we find the blank line in the signature, even though it's outside of
what we'd consider the body. But that puts us unto a separate code path,
which realizes that we're now in the signature and adjusts the line back
to "sigstart". So this patch is basically just making the "no line found
at all" case match that. And note that "sigstart" is always defined (if
there is no signature, it points to the end of the buffer as you'd
expect).

Reported-by: Martin Englund <martin@englund.nu>
Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            |  2 +-
 t/t6300-for-each-ref.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 914908fac5..6c2148c01e 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1380,7 +1380,7 @@ static void find_subpos(const char *buf,
 	/* check if message uses CRLF */
 	} else if (! (eol = strstr(*sub, "\r\n\r\n"))) {
 		/* treat whole message as subject */
-		eol = strrchr(*sub, '\0');
+		eol = sigstart;
 	}
 	buf = eol;
 	*sublen = buf - *sub;
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index dcaab7265f..d7e70027e6 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1406,4 +1406,19 @@ test_expect_success 'for-each-ref reports broken tags' '
 		refs/tags/broken-tag-*
 '
 
+test_expect_success 'set up tag with signature and no blank lines' '
+	git tag -F - fake-sig-no-blanks <<-\EOF
+	this is the subject
+	-----BEGIN PGP SIGNATURE-----
+	not a real signature, but we just care about the
+	subject/body parsing. It is important here that
+	there are no blank lines in the signature.
+	-----END PGP SIGNATURE-----
+	EOF
+'
+
+test_atom refs/tags/fake-sig-no-blanks contents:subject 'this is the subject'
+test_atom refs/tags/fake-sig-no-blanks contents:body ''
+test_atom refs/tags/fake-sig-no-blanks contents:signature "$sig"
+
 test_done
-- 
2.38.1.677.g4206adeb26


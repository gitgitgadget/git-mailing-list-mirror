Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A9C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiKBHoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKBHoC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:44:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0270B4A4
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:44:01 -0700 (PDT)
Received: (qmail 8946 invoked by uid 109); 2 Nov 2022 07:44:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Nov 2022 07:44:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2926 invoked by uid 111); 2 Nov 2022 07:44:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Nov 2022 03:44:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Nov 2022 03:44:00 -0400
From:   Jeff King <peff@peff.net>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Martin Englund <martin@englund.nu>, git@vger.kernel.org
Subject: [PATCH 2/2] ref-filter: fix parsing of signatures with CRLF and no
 body
Message-ID: <Y2IfwL96Ku/dGuJR@coredump.intra.peff.net>
References: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2IeqOT5Ao1Qa0Zl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit fixes a bug when parsing tags that have CRLF line endings, a
signature, and no body, like this (the "^M" are marking the CRs):

  this is the subject^M
  -----BEGIN PGP SIGNATURE-----^M
  ^M
  ...some stuff...^M
  -----END PGP SIGNATURE-----^M

When trying to find the start of the body, we look for a blank line
separating the subject and body. In this case, there isn't one. But we
search for it using strstr(), which will find the blank line in the
signature.

In the non-CRLF code path, we check whether the line we found is past
the start of the signature, and if so, put the body pointer at the start
of the signature (effectively making the body empty). But the CRLF code
path doesn't catch the same case, and we end up with the body pointer in
the middle of the signature field. This has two visible problems:

  - printing %(contents:subject) will show part of the signature, too,
    since the subject length is computed as (body - subject)

  - the length of the body is (sig - body), which makes it negative.
    Asking for %(contents:body) causes us to cast this to a very large
    size_t when we feed it to xmemdupz(), which then complains about
    trying to allocate too much memory.

These are essentially the same bugs fixed in the previous commit, except
that they happen when there is a CRLF blank line in the signature,
rather than no blank line at all. Both are caused by the refactoring in
9f75ce3d8f (ref-filter: handle CRLF at end-of-line more gracefully,
2020-10-29).

We can fix this by doing the same "sigstart" check that we do in the
non-CRLF case. And rather than repeat ourselves, we can just use
short-circuiting OR to collapse both cases into a single conditional.
I.e., rather than:

  if (strstr("\n\n"))
    ...found blank, check if it's in signature...
  else if (strstr("\r\n\r\n"))
    ...found blank, check if it's in signature...
  else
    ...no blank line found...

we can collapse this to:

  if (strstr("\n\n")) ||
      strstr("\r\n\r\n")))
    ...found blank, check if it's in signature...
  else
    ...no blank line found...

The tests show the problem and the fix. Though it wasn't broken, I
included contents:signature here to make sure it still behaves as
expected, but note the shell hackery needed to make it work. A
less-clever option would be to skip using test_atom and just "append_cr
>expected" ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c            |  6 +++---
 t/t6300-for-each-ref.sh | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6c2148c01e..9dc2cd1451 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1375,10 +1375,10 @@ static void find_subpos(const char *buf,
 	/* subject is first non-empty line */
 	*sub = buf;
 	/* subject goes to first empty line before signature begins */
-	if ((eol = strstr(*sub, "\n\n"))) {
+	if ((eol = strstr(*sub, "\n\n")) ||
+	    (eol = strstr(*sub, "\r\n\r\n"))) {
 		eol = eol < sigstart ? eol : sigstart;
-	/* check if message uses CRLF */
-	} else if (! (eol = strstr(*sub, "\r\n\r\n"))) {
+	} else {
 		/* treat whole message as subject */
 		eol = sigstart;
 	}
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d7e70027e6..fa38b87441 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -1421,4 +1421,29 @@ test_atom refs/tags/fake-sig-no-blanks contents:subject 'this is the subject'
 test_atom refs/tags/fake-sig-no-blanks contents:body ''
 test_atom refs/tags/fake-sig-no-blanks contents:signature "$sig"
 
+test_expect_success 'set up tag with CRLF signature' '
+	append_cr <<-\EOF |
+	this is the subject
+	-----BEGIN PGP SIGNATURE-----
+
+	not a real signature, but we just care about
+	the subject/body parsing. It is important here
+	that there is a blank line separating this
+	from the signature header.
+	-----END PGP SIGNATURE-----
+	EOF
+	git tag -F - --cleanup=verbatim fake-sig-crlf
+'
+
+test_atom refs/tags/fake-sig-crlf contents:subject 'this is the subject'
+test_atom refs/tags/fake-sig-crlf contents:body ''
+
+# CRLF is retained in the signature, so we have to pass our expected value
+# through append_cr. But test_atom requires a shell string, which means command
+# substitution, and the shell will strip trailing newlines from the output of
+# the substitution. Hack around it by adding and then removing a dummy line.
+sig_crlf="$(printf "%s" "$sig" | append_cr; echo dummy)"
+sig_crlf=${sig_crlf%dummy}
+test_atom refs/tags/fake-sig-crlf contents:signature "$sig_crlf"
+
 test_done
-- 
2.38.1.677.g4206adeb26

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Test atomic git-commit --interactive
Date: Tue, 10 May 2011 15:43:34 -0400
Message-ID: <20110510194334.GA14456@sigill.intra.peff.net>
References: <BANLkTikwjZkzMxksBsVTFRYdhE3L6ZQM0A@mail.gmail.com>
 <1305054751-12327-1-git-send-email-conrad.irwin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Conrad Irwin <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 21:44:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJsqp-0000ut-3b
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 21:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207Ab1EJTnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 15:43:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38463
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850Ab1EJTni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 15:43:38 -0400
Received: (qmail 25214 invoked by uid 107); 10 May 2011 19:45:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 15:45:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 15:43:34 -0400
Content-Disposition: inline
In-Reply-To: <1305054751-12327-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173351>

On Tue, May 10, 2011 at 12:12:31PM -0700, Conrad Irwin wrote:

> +test_expect_success PERL \
> +	"--interactive doesn't change index if editor aborts" \
> +	"EDITOR=false echo zoo >file && \

This EDITOR bit does nothing, since it sets the value only for the
"echo" command. The test happens to do what you want, though, since we
set EDITOR to ":" in test-lib.sh, and that is also a fine value for your
test (it's probably a better test, anyway; it simulates the user
aborting with an empty message instead of the editor crashing).

Even though the implicit EDITOR works, I think it makes sense to be
explicit that it is something we are relying on. So we need to put it in
front of the "git commit" invocation, like:

  EDITOR=: test_must_fail git commit --interactive

Unfortunately, some shells do behave reasonably when setting single-shot
environment variables with functions, so we are stuck with:

  (EDITOR=: && export EDITOR &&
   test_must_fail git commit --interactive)

> +	test_must_fail git diff --exit-code > diff1 && \

You can drop the backslash-continuation on lines that end with "&&" or
"|", which makes things a bit more readable.

You do still need ones for:

  test_expect_success "description" \
                      "actual test"

The usual style for our tests is:

  test_expect_success 'description' '
          actual test
  '

but this particular script does not follow that, so it's probably more
sensible to follow the surrounding style as you did.

> +	(echo u ; echo '*' ; echo q) |\
> +	test_must_fail git commit --interactive && \
> +	git diff > diff2 && \

Minor style nit: we usually write ">file" without the space.

> +	git diff --no-index diff1 diff2"

When comparing results with a simple diff, we generally use "test_cmp",
so that unrelated tests do not rely on "git diff --no-index".

So the result should look like:

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 7f7f7c7..ccb0b95 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -131,6 +131,16 @@ test_expect_success PERL \
 	"interactive add" \
 	"echo 7 | git commit --interactive | grep 'What now'"
 
+test_expect_success PERL \
+	"--interactive doesn't change index if editor aborts" \
+	"echo zoo >file &&
+	test_must_fail git diff --exit-code >diff1 &&
+	(echo u ; echo '*' ; echo q) |
+	(EDITOR=: && export EDITOR &&
+	 test_must_fail git commit --interactive) &&
+	git diff >diff2 &&
+	test_cmp diff1 diff2"
+
 test_expect_success \
 	"showing committed revisions" \
 	"git rev-list HEAD >current"

-Peff

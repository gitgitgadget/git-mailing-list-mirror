From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7510: Skip all if GPG isn't installed
Date: Wed, 25 Jun 2014 17:42:17 -0400
Message-ID: <20140625214217.GA13564@sigill.intra.peff.net>
References: <1403585536-32185-1-git-send-email-brian@gernhardtsoftware.com>
 <xmqqfvis8zaw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:42:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzuxV-0007C2-7T
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbaFYVmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:42:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:51153 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753181AbaFYVmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:42:21 -0400
Received: (qmail 30799 invoked by uid 102); 25 Jun 2014 21:42:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 16:42:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 17:42:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfvis8zaw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252467>

On Wed, Jun 25, 2014 at 02:16:55PM -0700, Junio C Hamano wrote:

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
> > Since the setup requires the GPG prerequisite, it doesn't make much
> > sense to try and run any tests without it.  So rather than using a
> > prereq on each individual test and possibly forgetting it on new ones
> > (as just happened), skip the entire file if GPG isn't found.
> >
> > Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> > ---
> 
> I think by "just happend" you mean aa4b78d4 (pretty: avoid reading
> past end-of-string with "%G", 2014-06-16), which adds one that is
> not protected (Cc'ed peff).

If that is the one Brian means (and that is the only one I see in pu),
leaving it off was intentional. You do not need to have the GPG
prerequisite to verify the handling of %G and %GX, as the point is that
they are not actually gpg format placeholders.

That being said, I did botch the commit, because not having GPG means
we would not create any commits, and therefore "git log -1" fails for
the wrong reason.

The "right" fix is actually to make sure there is at least one commit in
that final test (e.g., by adding one base commit before the others).
Then it can run regardless of whether the GPG tests ran. And in that
sense, Brian's patch is working in the opposite direction.

Thinking on the explanation I gave above, though, I think it means the
test would probably be better placed in t6006 along with the other
format-specifier tests. That fixes the problem, and means that Brian's
simplification (to just skip all tests) becomes the right thing to do.

> As there are a few additional test pieces to this file in flight
> that come from another topic (which by the way protects them with
> the prerequiste), I'd rather fix it up with the necessary GPG
> prerequisite, at least for now, instead of doing it this way.

The patch below should fix it with minimal fuss. I think Brian's patch
makes sense on top, but I agree it would be nice to wait until the
existing topics settle.

> Another thing we may want to take into account is that we would also
> want to make sure that builds of Git without GPG installed still
> behave sensibly (with some definition of sensible) when faced with
> GPG signatures in existing commit objects and tag objects.

Yeah, I agree that is a good thing to test.

> If that will happen in this same script, then skipping all by
> requiring GPG upfront may not be a good change, but it is likely that
> we would want a NOGPG prerequisite for "No GPG installed" case and
> have a separate test script, in which case, this will just skip all
> without GPG, and the other new one will just skip all without NOGPG.
> We'll see.

I think it may make more sense to just configure gpg.program to "false"
for the NOGPG case. Then you get coverage both on systems with it
installed, and without (you could also just test it on GPG systems, and
drop the "ship commits in fast-import form" part of the plan).

Anyway, that is all outside the scope of the immediate problem. Here's
the patch to fix jk/pretty-G-format-fixes.

-- >8 --
Subject: move "%G" format test from t7510 to t6006

The final test in t7510 checks that "--format" placeholders
that look similar to GPG placeholders (but that we don't
actually understand) are passed through. That test was
placed in t7510, since the other GPG placeholder tests are
there. However, it does not have a GPG prerequisite, because
it is not actually checking any signed commits.

This causes the test to erroneously fail when gpg is not
installed on a system, however. Not because we need signed
commits, but because we need _any_ commit to run "git log".
If we don't have gpg installed, t7510 doesn't create any
commits at all.

We can fix this by moving the test into t6006. This is
arguably a better place anyway, because it is where we test
most of the other placeholders (we do not test GPG
placeholders there because of the infrastructure needed to
make signed commits).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6006-rev-list-format.sh | 6 ++++++
 t/t7510-signed-commit.sh   | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index c277db6..88ed319 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -468,4 +468,10 @@ test_expect_success 'single-character name is parsed correctly' '
 	test_cmp expect actual
 '
 
+test_expect_success 'unused %G placeholders are passed through' '
+	echo "%GX %G" >expect &&
+	git log -1 --format="%GX %G" >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 9810242..e97477a 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -147,10 +147,4 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
-test_expect_success 'unused %G placeholders are passed through' '
-	echo "%GX %G" >expect &&
-	git log -1 --format="%GX %G" >actual &&
-	test_cmp expect actual
-'
-
 test_done
-- 
2.0.0.566.gfe3e6b2

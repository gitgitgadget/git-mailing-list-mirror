From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange
Date: Thu, 19 Jul 2012 07:49:38 -0400
Message-ID: <20120719114938.GB29774@sigill.intra.peff.net>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
 <20120717041603.GD20945@sigill.intra.peff.net>
 <000e01cd6481$bbd63970$3382ac50$@vrana.cz>
 <7v7gu1y7tg.fsf@alter.siamese.dyndns.org>
 <20120718062329.GA12942@sigill.intra.peff.net>
 <20120718070626.GA20938@sigill.intra.peff.net>
 <7vd33swuti.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Vrana <jakub@vrana.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 13:49:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrpEp-0000B8-Lr
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 13:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab2GSLtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 07:49:43 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41681
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab2GSLtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2012 07:49:41 -0400
Received: (qmail 28368 invoked by uid 107); 19 Jul 2012 11:49:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jul 2012 07:49:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2012 07:49:38 -0400
Content-Disposition: inline
In-Reply-To: <7vd33swuti.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201732>

On Wed, Jul 18, 2012 at 03:47:21PM -0700, Junio C Hamano wrote:

> > I don't care too deeply either way, and it is technically a behavior
> > change. So there is a chance of regression for something that nobody has
> > actually complained about.
> 
> Thanks. I share the same feeling, but the code after the patch looks
> much nicer, which is somewhat sad.

If we're not going to do it, perhaps we should at least include the
tests I wrote (modified for the current behavior), since there was no
coverage in this area previously. Patch is below.

> > To be honest, I doubt many people are using
> > external diff at all these days; textconv is closer to what most people
> > want, and is much easier to use.
> 
> It depends on the payload and the output you want.  I wouldn't think
> it is fair to challenge anybody to come up with a solution based on
> the textconv machinery to replicate what the compare-cooking.perl in
> the 'todo' branch (used as an external diff driver for
> whats-cooking.txt) does.

Oh, absolutely. The compare-cooking script is a great example of what
you can do with the flexibility that external diff offers. But based on
my experience and reading the list, the much more common request is to
produce a meaningful diff of two binary word processor documents. :)

Googling around, the other common use seems to be to stuff the output
into a visual diff tool. Though I think that "git difftool" is a better
approach for that.

-Peff

-- >8 --
Subject: [PATCH] diff: test precedence of external diff drivers

There are three ways to specify an external diff command:
GIT_EXTERNAL_DIFF in the environment, diff.external in the
config, or a "diff" gitattribute. The current order of
precedence is:

  1. gitattribute

  2. GIT_EXTERNAL_DIFF

  3. diff.external

Usually our rule is that environment variables should take
precedence over on-disk config (i.e., option 2 should come
before option 1). However, this situation is trickier than
some, because option 1 is more specific to the individual
file than option 2 (which affects all files), so it might be
preferable. So the current behavior can be seen as
implementing "do the specific thing if we can, but fall back
to this general thing".

This is probably not what we would do if we were writing git
from scratch, but it has been this way for several years,
and is not worth changing. So let's at least document that
this is the way it's supposed to work with a test.

While we're there, let's also make sure that diff.external
(which was not previously tested at all) works by running it
through the same tests as GIT_EXTERNAL_DIFF.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4020-diff-external.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 5a5f68c..2e7d73f 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -65,6 +65,33 @@ test_expect_success SYMLINKS 'typechange diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'diff.external' '
+	git reset --hard &&
+	echo third >file &&
+	test_config diff.external echo &&
+	git diff | {
+		read path oldfile oldhex oldmode newfile newhex newmode &&
+		test "z$path" = zfile &&
+		test "z$oldmode" = z100644 &&
+		test "z$newhex" = "z$_z40" &&
+		test "z$newmode" = z100644 &&
+		oh=$(git rev-parse --verify HEAD:file) &&
+		test "z$oh" = "z$oldhex"
+	}
+'
+
+test_expect_success 'diff.external should apply only to diff' '
+	test_config diff.external echo &&
+	git log -p -1 HEAD |
+	grep "^diff --git a/file b/file"
+'
+
+test_expect_success 'diff.external and --no-ext-diff' '
+	test_config diff.external echo &&
+	git diff --no-ext-diff |
+	grep "^diff --git a/file b/file"
+'
+
 test_expect_success 'diff attribute' '
 	git reset --hard &&
 	echo third >file &&
@@ -132,6 +159,19 @@ test_expect_success 'diff attribute and --no-ext-diff' '
 
 '
 
+test_expect_success 'GIT_EXTERNAL_DIFF trumps diff.external' '
+	>.gitattributes &&
+	test_config diff.external "echo ext-global" &&
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-env
+'
+
+test_expect_success 'attributes trump GIT_EXTERNAL_DIFF and diff.external' '
+	test_config diff.foo.command "echo ext-attribute" &&
+	test_config diff.external "echo ext-global" &&
+	echo "file diff=foo" >.gitattributes &&
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-attribute
+'
+
 test_expect_success 'no diff with -diff' '
 	echo >.gitattributes "file -diff" &&
 	git diff | grep Binary
-- 
1.7.10.5.40.g059818d

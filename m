From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: respect --no-ext-diff with typechange
Date: Wed, 18 Jul 2012 03:06:26 -0400
Message-ID: <20120718070626.GA20938@sigill.intra.peff.net>
References: <000301cd63b2$e39a2130$aace6390$@vrana.cz>
 <20120717041603.GD20945@sigill.intra.peff.net>
 <000e01cd6481$bbd63970$3382ac50$@vrana.cz>
 <7v7gu1y7tg.fsf@alter.siamese.dyndns.org>
 <20120718062329.GA12942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Vrana <jakub@vrana.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 18 09:06:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOLD-00083q-MT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab2GRHGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:06:30 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36829
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471Ab2GRHG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:06:29 -0400
Received: (qmail 15592 invoked by uid 107); 18 Jul 2012 07:06:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 03:06:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 03:06:26 -0400
Content-Disposition: inline
In-Reply-To: <20120718062329.GA12942@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201653>

On Wed, Jul 18, 2012 at 02:23:29AM -0400, Jeff King wrote:

> >  * The use of userdiff_find_by_path() in run_diff_cmd() may be iffy;
> >    it is probably OK to override diff.external with a more specific
> >    per-path configuration, but I think an external diff specified by
> >    the GIT_EXTERNAL_DIFF environment may want to trump the
> >    configured per-path one, as an environment is a stronger one-shot
> >    request.
> 
> I think this date all the way back to f1af60b (Support 'diff=pgm'
> attribute, 2007-04-22). There's a tradeoff here; usually environment
> variables trump config, but you end up using a large hammer (here is how
> to diff _all_ files externally) to hit a small nail (here is how to diff
> _just_ this file).  I suspect it isn't that big a problem in practice
> because people tend to use either one mechanism or the other.
> 
> The most sensible thing to me is probably $GIT_EXTERNAL_DIFF, followed
> by attributes, followed by diff.external. That uses the more specific
> diff pulled from the on-disk config, but allows you to do one-shot overrides
> with the environment as long as you are careful to restrict your command
> (e.g., "GIT_EXTERNAL_DIFF=foo-differ git diff -- file.foo").

Here's a patch implementing that. This is definitely how I would have
done it if I were starting from scratch. My only hesitation now is that
I don't care too deeply either way, and it is technically a behavior
change. So there is a chance of regression for something that nobody has
actually complained about. To be honest, I doubt many people are using
external diff at all these days; textconv is closer to what most people
want, and is much easier to use.

-- >8 --
Subject: [PATCH] diff: fix precedence of external diff options

There are three ways to specify an external diff command:
GIT_EXTERNAL_DIFF in the environment, diff.external in the
config, or a "diff" gitattribute. The current order of
precedence is:

  1. gitattribute

  2. GIT_EXTERNAL_DIFF

  3. diff.external

But usually our rule is that environment variables should
take precedence over on-disk config (i.e., option 2 should
come before option 1). This situation is trickier than some,
because option 1 is more specific to the individual file
than option 2 (which affects all files), so it might be
preferable. So the current behavior can be seen as
implementing "do the specific thing if we can, but fall back
to this general thing".

However, since you can already implement that behavior (by
combining attributes with a diff.external setting), and
because environment variables can be useful for one-shot
overrides (e.g., "GIT_EXTERNAL_DIFF=foo git diff -- bar" to
override bar's gitattribute setting), let's switch the
precedence of options 1 and 2 above.

While we're adding tests to t4020 for the precedence, let's
also make sure that diff.external works at all by running it
through the same tests as GIT_EXTERNAL_DIFF.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                   | 35 +++++++++++++++--------------------
 t/t4020-diff-external.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 62cbe14..ed2de96 100644
--- a/diff.c
+++ b/diff.c
@@ -238,18 +238,20 @@ static char *quote_two(const char *one, const char *two)
 	return strbuf_detach(&res, NULL);
 }
 
-static const char *external_diff(void)
+static const char *external_diff(const char *path)
 {
-	static const char *external_diff_cmd = NULL;
-	static int done_preparing = 0;
+	const char *r;
+	struct userdiff_driver *drv;
 
-	if (done_preparing)
-		return external_diff_cmd;
-	external_diff_cmd = getenv("GIT_EXTERNAL_DIFF");
-	if (!external_diff_cmd)
-		external_diff_cmd = external_diff_cmd_cfg;
-	done_preparing = 1;
-	return external_diff_cmd;
+	r = getenv("GIT_EXTERNAL_DIFF");
+	if (r)
+		return r;
+
+	drv = userdiff_find_by_path(path);
+	if (drv && drv->external)
+		return drv->external;
+
+	return external_diff_cmd_cfg;
 }
 
 static struct diff_tempfile {
@@ -2992,13 +2994,6 @@ static void run_diff_cmd(const char *pgm,
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
 	int must_show_header = 0;
 
-
-	if (DIFF_OPT_TST(o, ALLOW_EXTERNAL)) {
-		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
-		if (drv && drv->external)
-			pgm = drv->external;
-	}
-
 	if (msg) {
 		/*
 		 * don't use colors when the header is intended for an
@@ -3059,7 +3054,7 @@ static void strip_prefix(int prefix_length, const char **namep, const char **oth
 
 static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
-	const char *pgm = external_diff();
+	const char *pgm = NULL;
 	struct strbuf msg;
 	struct diff_filespec *one = p->one;
 	struct diff_filespec *two = p->two;
@@ -3073,8 +3068,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
-		pgm = NULL;
+	if (DIFF_OPT_TST(o, ALLOW_EXTERNAL))
+		pgm = external_diff(attr_path);
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		run_diff_cmd(pgm, name, NULL, attr_path,
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 5a5f68c..80f5b64 100755
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
@@ -132,6 +159,20 @@ test_expect_success 'diff attribute and --no-ext-diff' '
 
 '
 
+test_expect_success 'diff attribute trumps diff.external' '
+	test_config diff.foo.command "echo ext-attribute" &&
+	test_config diff.external "echo ext-global" &&
+	echo "file diff=foo" >.gitattributes &&
+	git diff | grep ext-attribute
+'
+
+test_expect_success 'GIT_EXTERNAL_DIFF trumps attributes and diff.external' '
+	test_config diff.foo.command "echo ext-attribute" &&
+	test_config diff.external "echo ext-global" &&
+	echo "file diff=foo" >.gitattributes &&
+	GIT_EXTERNAL_DIFF="echo ext-env" git diff | grep ext-env
+'
+
 test_expect_success 'no diff with -diff' '
 	echo >.gitattributes "file -diff" &&
 	git diff | grep Binary
-- 
1.7.10.5.40.gbbc17de

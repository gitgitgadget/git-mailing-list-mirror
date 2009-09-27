From: Jeff King <peff@peff.net>
Subject: Re: 'git branch --no-merge' is ambiguous
Date: Sun, 27 Sep 2009 03:33:06 -0400
Message-ID: <20090927073305.GA15393@coredump.intra.peff.net>
References: <4ABC9B69.5010205@viscovery.net>
 <m2ljk250f7.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 09:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MroFx-0004EG-K9
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 09:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZI0HdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 03:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753340AbZI0HdG
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 03:33:06 -0400
Received: from peff.net ([208.65.91.99]:43039 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbZI0HdF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 03:33:05 -0400
Received: (qmail 18620 invoked by uid 107); 27 Sep 2009 07:36:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 27 Sep 2009 03:36:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Sep 2009 03:33:06 -0400
Content-Disposition: inline
In-Reply-To: <m2ljk250f7.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129195>

On Fri, Sep 25, 2009 at 08:44:44PM +0200, Andreas Schwab wrote:

> parse_long_opt always matches both --opt and --no-opt for any option
> "opt", and only get_value checks whether --no-opt is actually valid.
> Since the options for git branch contains both "no-merged" and "merged"
> there are two matches for --no-merge, but no exact match.  With this
> patch the negation of a NONEG option is rejected earlier, but it changes
> the error message from "option `no-opt' isn't available" to "unknown
> option `no-opt'".

Thanks. Reading through the code, I came to the same conclusion: we
shouldn't be looking at --no-* at all if we are NONEG. I think the
change in error message is acceptable.

It is a little bit annoying that builtin-branch needs to have this as
two separate options in the first place. But it wants to be able to do
--no-merged with an argument, which is not currently possible with just
a negation of --merged. I don't know if it is worth adding an
OPT_NEGARG.

Below is what I'm going to commit.  Can I get your Signed-off-by?

-- >8 --
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] parse-opt: ignore negation of OPT_NONEG for ambiguity checks

parse_long_opt always matches both --opt and --no-opt for any option
"opt", and only get_value checks whether --no-opt is actually valid.
Since the options for git branch contains both "no-merged" and "merged"
there are two matches for --no-merge, but no exact match.  With this
patch the negation of a NONEG option is rejected earlier, but it changes
the error message from "option `no-opt' isn't available" to "unknown
option `no-opt'".

[jk: added test]

Signed-off-by: Jeff King <peff@peff.net>
---
 parse-options.c          |    3 +++
 t/t0040-parse-options.sh |   20 ++++++++++++++++++++
 test-parse-options.c     |    5 +++++
 3 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index a64a4d6..f559411 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -230,6 +230,9 @@ is_abbreviated:
 				abbrev_flags = flags;
 				continue;
 			}
+			/* negation allowed? */
+			if (options->flags & PARSE_OPT_NONEG)
+				continue;
 			/* negated and abbreviated very much? */
 			if (!prefixcmp("no-", arg)) {
 				flags |= OPT_UNSET;
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index bbc821e..3d450ed 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -33,6 +33,8 @@ Magic arguments
     --quux                means --quux
     -NUM                  set integer to NUM
     +                     same as -b
+    --ambiguous           positive ambiguity
+    --no-ambiguous        negative ambiguity
 
 Standard options
     --abbrev[=<n>]        use <n> digits to display SHA-1s
@@ -315,4 +317,22 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+boolean: 0
+integer: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
+	test-parse-options --no-ambig >output 2>output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index efa734b..acd1a2b 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -8,6 +8,7 @@ static int abbrev = 7;
 static int verbose = 0, dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
+static int ambiguous;
 
 static int length_callback(const struct option *opt, const char *arg, int unset)
 {
@@ -59,6 +60,10 @@ int main(int argc, const char **argv)
 			number_callback),
 		{ OPTION_BOOLEAN, '+', NULL, &boolean, NULL, "same as -b",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH },
+		{ OPTION_BOOLEAN, 0, "ambiguous", &ambiguous, NULL,
+		  "positive ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
+		{ OPTION_BOOLEAN, 0, "no-ambiguous", &ambiguous, NULL,
+		  "negative ambiguity", PARSE_OPT_NOARG | PARSE_OPT_NONEG },
 		OPT_GROUP("Standard options"),
 		OPT__ABBREV(&abbrev),
 		OPT__VERBOSE(&verbose),
-- 
1.6.5.rc2.197.g25cf3

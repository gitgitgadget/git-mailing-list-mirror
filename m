From: Jeff King <peff@peff.net>
Subject: Re: I think git show is broken
Date: Tue, 28 Aug 2012 17:29:34 -0400
Message-ID: <20120828212934.GA396@sigill.intra.peff.net>
References: <503D022B.6070001@redlion.net>
 <503D046B.7090606@redlion.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Matthew Caron <Matt.Caron@redlion.net>
X-From: git-owner@vger.kernel.org Tue Aug 28 23:29:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6TM5-0002wW-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 23:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab2H1V3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 17:29:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41186 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939Ab2H1V3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 17:29:38 -0400
Received: (qmail 25569 invoked by uid 107); 28 Aug 2012 21:29:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Aug 2012 17:29:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Aug 2012 17:29:34 -0400
Content-Disposition: inline
In-Reply-To: <503D046B.7090606@redlion.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204453>

On Tue, Aug 28, 2012 at 01:48:27PM -0400, Matthew Caron wrote:

> On 08/28/2012 01:38 PM, Matthew Caron wrote:
> >(otherwise, there was a very strange change made to its functionality,
> >which the documentation does not reflect)
> 
> Never mind.
> 
> I was looking in the wrong spot. The issue is not with
> --pretty=oneline, it's with --quiet. In 1.7.0.4, --quiet worked like
> -s. It no longer does in 1.7.9.5. Switching to -s cures the problem.

Yes, that is what's going on. But it's still a regression. There was
some discussion of what --quiet should do here:

  http://thread.gmane.org/gmane.comp.version-control.git/171357

which resulted in a patch that took away --quiet. But then this thread:

  http://thread.gmane.org/gmane.comp.version-control.git/174665

resulted in restoring it as a synonym for "-s". Unfortunately there's a
bug in that fix, which you are seeing. Patch is below.

-- >8 --
Subject: [PATCH] log: fix --quiet synonym for -s

Originally the "--quiet" option was parsed by the
diff-option parser into the internal QUICK option. This had
the effect of silencing diff output from the log (which was
not intended, but happened to work and people started to
use it). But it also had other odd side effects at the diff
level (for example, it would suppress the second commit in
"git show A B").

To fix this, commit 1c40c36 converted log to parse-options
and handled the "quiet" option separately, not passing it
on to the diff code. However, it simply ignored the option,
which was a regression for people using it as a synonym for
"-s". Commit 01771a8 then fixed that by interpreting the
option to add DIFF_FORMAT_NO_OUTPUT to the list of output
formats.

However, that commit did not fix it in all cases. It sets
the flag after setup_revisions is called. Naively, this
makes sense because you would expect the setup_revisions
parser to overwrite our output format flag if "-p" or
another output format flag is seen.

However, that is not how the NO_OUTPUT flag works. We
actually store it in the bit-field as just another format.
At the end of setup_revisions, we call diff_setup_done,
which post-processes the bitfield and clears any other
formats if we have set NO_OUTPUT. By setting the flag after
setup_revisions is done, diff_setup_done does not have a
chance to make this tweak, and we end up with other format
options still set.

As a result, the flag would have no effect in "git log -p
--quiet" or "git show --quiet".  Fix it by setting the
format flag before the call to setup_revisions.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c   |  2 +-
 t/t7007-show.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..c22469c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -109,9 +109,9 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	argc = setup_revisions(argc, argv, rev, opt);
 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
+	argc = setup_revisions(argc, argv, rev, opt);
 
 	/* Any arguments at this point are not recognized */
 	if (argc > 1)
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index a40cd36..e41fa00 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -108,4 +108,16 @@ test_expect_success 'showing range' '
 	test_cmp expect actual.filtered
 '
 
+test_expect_success '-s suppresses diff' '
+	echo main3 >expect &&
+	git show -s --format=%s main3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--quiet suppresses diff' '
+	echo main3 >expect &&
+	git show --quiet --format=%s main3 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.11.5.10.g3c8125b

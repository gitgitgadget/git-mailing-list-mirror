From: Jeff King <peff@peff.net>
Subject: Re: git-grep: option parsing conflicts with prefix-dash searches
Date: Sat, 6 Feb 2010 23:44:15 -0500
Message-ID: <20100207044415.GA6622@coredump.intra.peff.net>
References: <alpine.LSU.2.01.1002052351060.30204@obet.zrqbmnf.qr>
 <7vsk9fs1j9.fsf@alter.siamese.dyndns.org>
 <20100206035143.GA31784@sigill.intra.peff.net>
 <7v7hqrdkxb.fsf@alter.siamese.dyndns.org>
 <20100206115817.GA11605@sigill.intra.peff.net>
 <7v8wb64623.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 05:44:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndz0O-0003DE-H7
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 05:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab0BGEoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 23:44:15 -0500
Received: from peff.net ([208.65.91.99]:56366 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834Ab0BGEoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 23:44:15 -0500
Received: (qmail 14294 invoked by uid 107); 7 Feb 2010 04:44:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 06 Feb 2010 23:44:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Feb 2010 23:44:15 -0500
Content-Disposition: inline
In-Reply-To: <7v8wb64623.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139217>

On Sat, Feb 06, 2010 at 09:39:32AM -0800, Junio C Hamano wrote:

> > I think so. It was the first thing the original poster in this thread
> > tried. It is also something I have tried (and still do, then grumblingly
> > retype "-e pattern"). And it certainly makes sense from a user
> > perspective; it is the same end-of-options signal that most other
> > programs take.
> 
> Ok, then let's take that (perhaps before 1.7.0 perhaps after).

Here it is with a commit message and some tests. While it is a minor
change, we are pretty late in the release cycle, so perhaps it is best
to leave it post-1.7.0 just to be on the safe side.

-- >8 --
Subject: [PATCH] accept "git grep -- pattern"

Currently the only way to "quote" a grep pattern that might
begin with a dash is to use "git grep -e pattern". This
works just fine, and is also the way right way to do it on
many traditional grep implemenations.

Some people prefer to use "git grep -- pattern", however, as
"--" is the usual "end of options" marker, and at least GNU
grep and Solaris 10 grep support this. This patch makes that
syntax work.

There is a slight behavior change, in that "git grep -- $X"
used to be interpreted as "grep for -- in $X". However, that
usage is questionable. "--" is usually the end-of-options
marker, so "git grep" was unlike many other greps in
treating it as a literal pattern (e.g., both GNU grep and
Solaris 10 grep will treat "grep --" as missing a pattern).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-grep.c  |   10 ++++++++++
 t/t7002-grep.sh |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 26d4deb..63d4b95 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -861,6 +861,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
 
+	/*
+	 * skip a -- separator; we know it cannot be
+	 * separating revisions from pathnames if
+	 * we haven't even had any patterns yet
+	 */
+	if (argc > 0 && !opt.pattern_list && !strcmp(argv[0], "--")) {
+		argv++;
+		argc--;
+	}
+
 	/* First unrecognized non-option token */
 	if (argc > 0 && !opt.pattern_list) {
 		append_grep_pattern(&opt, argv[0], "command line", 0,
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index 7144f81..0b583cb 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -434,4 +434,37 @@ test_expect_success 'grep -Fi' '
 	test_cmp expected actual
 '
 
+test_expect_success 'setup double-dash tests' '
+cat >double-dash <<EOF &&
+--
+->
+other
+EOF
+git add double-dash
+'
+
+cat >expected <<EOF
+double-dash:->
+EOF
+test_expect_success 'grep -- pattern' '
+	git grep -- "->" >actual &&
+	test_cmp expected actual
+'
+test_expect_success 'grep -- pattern -- pathspec' '
+	git grep -- "->" -- double-dash >actual &&
+	test_cmp expected actual
+'
+test_expect_success 'grep -e pattern -- path' '
+	git grep -e "->" -- double-dash >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+double-dash:--
+EOF
+test_expect_success 'grep -e -- -- path' '
+	git grep -e -- -- double-dash >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.0.rc1.58.g769126

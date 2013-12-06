From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] rev-parse: correctly diagnose revision errors before "--"
Date: Fri, 6 Dec 2013 16:13:46 -0500
Message-ID: <20131206211346.GA20536@sigill.intra.peff.net>
References: <20131206211222.GB20482@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 22:13:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp2if-0003gC-7S
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 22:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab3LFVNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 16:13:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:51819 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751579Ab3LFVNs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 16:13:48 -0500
Received: (qmail 8462 invoked by uid 102); 6 Dec 2013 21:13:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Dec 2013 15:13:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Dec 2013 16:13:46 -0500
Content-Disposition: inline
In-Reply-To: <20131206211222.GB20482@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238951>

Rev-parse understands that a "--" may separate revisions and
filenames, and that anything after the "--" is taken as-is.
However, it does not understand that anything before the
token must be a revision (which is the usual rule
implemented by the setup_revisions parser).

Since rev-parse prefers revisions to files when parsing
before the "--", we end up with the correct result (if such
an argument is a revision, we parse it as one, and if it is
not, it is an error either way).  However, we misdiagnose
the errors:

  $ git rev-parse foobar -- >/dev/null
  fatal: ambiguous argument 'foobar': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

  $ >foobar
  $ git rev-parse foobar -- >/dev/null
  fatal: bad flag '--' used after filename

In both cases, we should know that the real error is that
"foobar" is meant to be a revision, but could not be
resolved.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-parse.c            | 10 ++++++++++
 t/t1506-rev-parse-diagnosis.sh | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1d9ecaf..bb694ab 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -488,6 +488,7 @@ N_("git rev-parse --parseopt [options] -- [<args>...]\n"
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0, quiet = 0, revs_count = 0, type = 0;
+	int has_dashdash = 0;
 	int output_prefix = 0;
 	unsigned char sha1[20];
 	const char *name = NULL;
@@ -501,6 +502,13 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	if (argc > 1 && !strcmp("-h", argv[1]))
 		usage(builtin_rev_parse_usage);
 
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--")) {
+			has_dashdash = 1;
+			break;
+		}
+	}
+
 	prefix = setup_git_directory();
 	git_config(git_default_config, NULL);
 	for (i = 1; i < argc; i++) {
@@ -788,6 +796,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 		}
 		if (verify)
 			die_no_single_rev(quiet);
+		if (has_dashdash)
+			die("bad revision '%s'", arg);
 		as_is = 1;
 		if (!show_file(arg, output_prefix))
 			continue;
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index f950c10..613d9bf 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -196,4 +196,28 @@ test_expect_success 'dotdot is not an empty set' '
 	test_cmp expect actual
 '
 
+test_expect_success 'arg before dashdash must be a revision (missing)' '
+	test_must_fail git rev-parse foobar -- 2>stderr &&
+	test_i18ngrep "bad revision" stderr
+'
+
+test_expect_success 'arg before dashdash must be a revision (file)' '
+	>foobar &&
+	test_must_fail git rev-parse foobar -- 2>stderr &&
+	test_i18ngrep "bad revision" stderr
+'
+
+test_expect_success 'arg before dashdash must be a revision (ambiguous)' '
+	>foobar &&
+	git update-ref refs/heads/foobar HEAD &&
+	{
+		# we do not want to use rev-parse here, because
+		# we are testing it
+		cat .git/refs/heads/foobar &&
+		printf "%s\n" --
+	} >expect &&
+	git rev-parse foobar -- >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.5.524.g6743da6

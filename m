From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v12 3/5] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Sat, 2 Apr 2016 23:33:11 +0000
Message-ID: <01020153d952be68-ee055619-664d-4502-92e9-6aa524e2354b-000000@eu-west-1.amazonses.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 01:33:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amV2f-0002Ng-GH
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 01:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbcDBXdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 19:33:15 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:40579
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038AbcDBXdO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Apr 2016 19:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459639991;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=JPesFGMtFzS1htVEj8fSf7Ih31Yvil3u6xgazOt5kag=;
	b=MSEK7LPh0JotAxlyn/G2S2F3Kq1zlrHDqA5ecdRfX6GMtAMq7XG5D8w3WhD7eg5m
	fXYa1qLBf9RkKof+0Suw4MUUuB4/DmC3zVgpzxlm+3x0j1znO1q2nkf1Ju534H2eEnV
	CvW2gyN3prCZd4Z9lL3YXX8b+lNBrPuEBUCC7jdY=
In-Reply-To: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.02-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290613>

The reason to make it respect "unspecified" values is to give the
ability to differentiate whether `--option` or `--no-option` was
specified at all. "unspecified" values should be in the form of negative
values. If initial value is set to negative and `--option` specified
then it will reflect the number of occurrences (counting done from 0),
if `--no-option` is specified then it will reflect 0 and if nothing at
all is given then it will retain its negative value.

This change will not affect existing users of COUNTUP, because they all
use the initial value of 0 (or more).

Note that builtin/clean.c initializes the variable used with
OPT__FORCE (which uses OPT_COUNTUP()) to a negative value, but it is set
to either 0 or 1 by reading the configuration before the code calls
parse_options(), i.e. as far as parse_options() is concerned, the
initial value of the variable is not negative.

To test this behavior "verbose" is set to "unspecified" while quiet is
set to 0 which will test the new behavior with all sets of values.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The discussion about this patch:
[1] : http://thread.gmane.org/gmane.comp.version-control.git/289027

Previous version of the patch:
[v11] : http://thread.gmane.org/gmane.comp.version-control.git/288820
[v10] : http://thread.gmane.org/gmane.comp.version-control.git/288820
[v9] : http://thread.gmane.org/gmane.comp.version-control.git/288820
[v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061

Changes wrt previous version (v11):
 - Use bits of commit message provided by Junio.

Please Note: The diff might seem improper especially the part where I
have introduced some continuous lines but this is a logical error by git
diff (nothing could be done about it) and thus the changes will be
clearly visible with the original file itself.
---
 Documentation/technical/api-parse-options.txt |  8 ++++--
 parse-options.c                               |  2 ++
 t/t0040-parse-options.sh                      | 39 ++++++++++++++++++++-------
 test-parse-options.c                          |  3 ++-
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5f0757d..8908bf7 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -144,8 +144,12 @@ There are some macros to easily define options:
 
 `OPT_COUNTUP(short, long, &int_var, description)`::
 	Introduce a count-up option.
-	`int_var` is incremented on each use of `--option`, and
-	reset to zero with `--no-option`.
+	Each use of `--option` increments `int_var`, starting from zero
+	(even if initially negative), and `--no-option` resets it to
+	zero. To determine if `--option` or `--no-option` was set at
+	all, set `int_var` to a negative value, and if it is still
+	negative after parse_options(), then neither `--option` nor
+	`--no-option` was seen.
 
 `OPT_BIT(short, long, &int_var, description, mask)`::
 	Introduce a boolean option.
diff --git a/parse-options.c b/parse-options.c
index 47a9192..312a85d 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -110,6 +110,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_COUNTUP:
+		if (*(int *)opt->value < 0)
+			*(int *)opt->value = 0;
 		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
 		return 0;
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 302c315..bfd8dea 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -63,7 +63,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -211,7 +211,7 @@ magnitude: 0
 timestamp: 0
 string: 123
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -234,7 +234,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -263,7 +263,7 @@ magnitude: 0
 timestamp: 0
 string: 123
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -302,7 +302,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -322,7 +322,7 @@ magnitude: 0
 timestamp: 1
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 1
 dry run: no
 file: (not set)
@@ -344,7 +344,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -373,7 +373,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -398,7 +398,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -429,7 +429,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
@@ -454,6 +454,25 @@ dry run: no
 file: (not set)
 EOF
 
+test_expect_success 'OPT_COUNTUP() resets to 0 with --no- flag' '
+	test-parse-options --no-verbose >output 2>output.err &&
+	test_must_be_empty output.err &&
+	test_cmp expect output
+'
+
+cat >expect <<EOF
+boolean: 0
+integer: 0
+magnitude: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: -1
+quiet: 0
+dry run: no
+file: (not set)
+EOF
+
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
 	test-parse-options --no-ambig >output 2>output.err &&
 	test_must_be_empty output.err &&
diff --git a/test-parse-options.c b/test-parse-options.c
index 86afa98..f02c275 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -7,7 +7,8 @@ static int integer = 0;
 static unsigned long magnitude = 0;
 static unsigned long timestamp;
 static int abbrev = 7;
-static int verbose = 0, dry_run = 0, quiet = 0;
+static int verbose = -1; /* unspecified */
+static int dry_run = 0, quiet = 0;
 static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;

--
https://github.com/git/git/pull/218

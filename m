From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v14 4/6] parse-options.c: make OPTION_COUNTUP respect
 "unspecified" values
Date: Tue, 12 Apr 2016 23:02:17 +0000
Message-ID: <010201540cb60971-0bf3b786-4acd-4317-bd3c-3397dc2b51f9-000000@eu-west-1.amazonses.com>
References: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 01:02:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7KS-0002iZ-T4
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934397AbcDLXC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:02:28 -0400
Received: from a6-247.smtp-out.eu-west-1.amazonses.com ([54.240.6.247]:35715
	"EHLO a6-247.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934390AbcDLXCT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 19:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1460502137;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=A9iK062X5JgZAyFfYOX1TRukYavl15rmjlsc+5Ya98A=;
	b=JQ6GMQgvHb79qq4wk9lFKCL2aD7FIxa+yPCHKJ6cM/G/2MdSzYnMvP1bwfhe9vQJ
	lHILk/IQZ9Kx1Cfu6s1uqj6Zo03dHu5qdm10jJY97xoGAzi8gYC4OnqvdmNt1soiure
	GqubMI9BWHYmqbjf8DpSu1q64U7UF51Gg3W2yZSg=
In-Reply-To: <010201540cb60832-9402a692-3caa-47a1-9e8e-ae5a1bc7eb2f-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.04.12-54.240.6.247
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291313>

OPT_COUNTUP() merely increments the counter upon --option, and resets it
to 0 upon --no-option, which means that there is no "unspecified" value
with which a client can initialize the counter to determine whether or
not --[no]-option was seen at all.

Make OPT_COUNTUP() treat any negative number as an "unspecified" value
to address this shortcoming. In particular, if a client initializes the
counter to -1, then if it is still -1 after parse_options(), then
neither --option nor --no-option was seen; If it is 0, then --no-option
was seen last, and if it is 1 or greater, than --option was seen last.

This change does not affect the behavior of existing clients because
they all use the initial value of 0 (or more).

Note that builtin/clean.c initializes the variable used with
OPT__FORCE (which uses OPT_COUNTUP()) to a negative value, but it is set
to either 0 or 1 by reading the configuration before the code calls
parse_options(), i.e. as far as parse_options() is concerned, the
initial value of the variable is not negative.

To test this behavior, in test-parse-options.c, "verbose" is set to
"unspecified" while quiet is set to 0 which will test the new behavior
with all sets of values.

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

Changes wrt previous version (v13):
 - Some tests failed in v12 as the newly introduced tests weren't
   updated by the behaviour of this patch.

Please Note: The diff might seem improper especially the part where I
have introduced some continuous lines but this is a logical error by git
diff (nothing could be done about it) and thus the changes will be
clearly visible with the original file itself.
---
 Documentation/technical/api-parse-options.txt |  8 +++--
 parse-options.c                               |  2 ++
 t/t0040-parse-options.sh                      | 43 +++++++++++++++++++--------
 test-parse-options.c                          |  3 +-
 4 files changed, 41 insertions(+), 15 deletions(-)

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
index c913d1c..d3f52f6 100755
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
@@ -483,7 +502,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 3
 dry run: no
 file: (not set)
@@ -502,7 +521,7 @@ magnitude: 0
 timestamp: 0
 string: (not set)
 abbrev: 7
-verbose: 0
+verbose: -1
 quiet: 0
 dry run: no
 file: (not set)
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

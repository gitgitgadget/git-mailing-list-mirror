From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] test-parse-options: --expect=<string> option to simplify tests
Date: Thu,  5 May 2016 14:50:56 -0700
Message-ID: <20160505215056.28224-4-gitster@pobox.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <20160505215056.28224-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 23:51:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRAw-0001w1-NS
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757934AbcEEVvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:51:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755959AbcEEVvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:51:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B8B918848;
	Thu,  5 May 2016 17:51:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RgBx
	ou+A356nICVcwzI34Arb20I=; b=tDBoi6Zb3Yc8ZV64UYg23VYOTWXZQ4w/utvk
	+oreIYUo9hvxPDKAz0nmuOq6z6I+IOHBQopO8HgX0eLXEh7fnLgg8TX9bUzwJ/Lk
	lxpURGJD7bSPGJEs6AU9Gwtp2edKBkZ6D2ZaMepqb8iP9xis633DfZcoG/YyFyAJ
	0+JnFuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eY1XG6
	OM3Mcv2kD5eG1vQRpOYQ8up9Gux+5rN4s0S1INEhKwT1xX/m+ymJMBSRU7yTG9wh
	kGfsBkTzyQRGcZOH/MrZFLCNMcTNnMN89IFurmRgwiiIfjttXx2LyCAcVqy7EB7/
	CkldCoNgo5Qo5FyrJvrEacU16F/wS1RXQ174I=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24E4518847;
	Thu,  5 May 2016 17:51:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A5B618846;
	Thu,  5 May 2016 17:51:03 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-505-gdbd0e1d
In-Reply-To: <20160505215056.28224-1-gitster@pobox.com>
X-Pobox-Relay-ID: 768B23E8-130B-11E6-BA0F-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293709>

Existing tests in t0040 follow a rather verbose pattern:

        cat >expect <<\EOF
        boolean: 0
        integer: 0
        magnitude: 0
        timestamp: 0
        string: (not set)
        abbrev: 7
        verbose: 0
        quiet: 3
        dry run: no
        file: (not set)
        EOF

        test_expect_success 'multiple quiet levels' '
                test-parse-options -q -q -q >output 2>output.err &&
                test_must_be_empty output.err &&
                test_cmp expect output
        '

But the only thing this test cares about is if "quiet: 3" is in the
output.  We should be able to write the above 18 lines with just
four lines, like this:

	test_expect_success 'multiple quiet levels' '
		test-parse-options --expect="quiet: 3" -q -q -q
	'

Teach the new --expect=<string> option to test-parse-options helper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0040-parse-options.sh |  1 +
 test-parse-options.c     | 68 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index dbaee55..d678fbf 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -45,6 +45,7 @@ Standard options
     -v, --verbose         be verbose
     -n, --dry-run         dry run
     -q, --quiet           be quiet
+    --expect <string>     expected output in the variable dump
 
 EOF
 
diff --git a/test-parse-options.c b/test-parse-options.c
index 3db4332..010f3b2 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -14,6 +14,7 @@ static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
 static struct string_list list;
+static struct string_list expect;
 
 static struct {
 	int called;
@@ -40,6 +41,62 @@ static int number_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+/*
+ * See if expect->string ("label: value") has a line in output that
+ * begins with "label:", and if the line in output matches it.
+ */
+static int match_line(struct string_list_item *expect, struct strbuf *output)
+{
+	const char *label = expect->string;
+	const char *colon = strchr(label, ':');
+	const char *scan = output->buf;
+	size_t label_len, expect_len;
+
+	if (!colon)
+		die("Malformed --expect value: %s", label);
+	label_len = colon - label;
+
+	while (scan < output->buf + output->len) {
+		const char *next;
+		scan = memmem(scan, output->buf + output->len - scan,
+			      label, label_len);
+		if (!scan)
+			return 0;
+		if (scan == output->buf || scan[-1] == '\n')
+			break;
+		next = strchr(scan + label_len, '\n');
+		if (!next)
+			return 0;
+		scan = next + 1;
+	}
+
+	/*
+	 * scan points at a line that begins with the label we are
+	 * looking for.  Does it match?
+	 */
+	expect_len = strlen(expect->string);
+
+	if (output->buf + output->len <= scan + expect_len)
+		return 0; /* value not long enough */
+	if (memcmp(scan, expect->string, expect_len))
+		return 0; /* does not match */
+
+	return (scan + expect_len < output->buf + output->len &&
+		scan[expect_len] == '\n');
+}
+
+static int show_expected(struct string_list *list, struct strbuf *output)
+{
+	struct string_list_item *expect;
+	int found_mismatch = 0;
+
+	for_each_string_list_item(expect, list) {
+		if (!match_line(expect, output))
+			found_mismatch = 1;
+	}
+	return found_mismatch;
+}
+
 int main(int argc, char **argv)
 {
 	const char *prefix = "prefix/";
@@ -87,6 +144,8 @@ int main(int argc, char **argv)
 		OPT__VERBOSE(&verbose, "be verbose"),
 		OPT__DRY_RUN(&dry_run, "dry run"),
 		OPT__QUIET(&quiet, "be quiet"),
+		OPT_STRING_LIST(0, "expect", &expect, "string",
+				"expected output in the variable dump"),
 		OPT_END(),
 	};
 	int i;
@@ -117,7 +176,10 @@ int main(int argc, char **argv)
 	for (i = 0; i < argc; i++)
 		strbuf_addf(&output, "arg %02d: %s\n", i, argv[i]);
 
-	printf("%s", output.buf);
-
-	return 0;
+	if (expect.nr)
+		return show_expected(&expect, &output);
+	else {
+		printf("%s", output.buf);
+		return 0;
+	}
 }
-- 
2.8.2-505-gdbd0e1d

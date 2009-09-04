From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] apply --whitespace=warn/error: diagnose blank at EOF
Date: Fri,  4 Sep 2009 03:55:13 -0700
Message-ID: <1252061718-11579-5-git-send-email-gitster@pobox.com>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 12:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWSF-0003iL-0l
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756737AbZIDKzg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 06:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbZIDKze
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:55:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbZIDKza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 06:55:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7763943D29
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qRmc
	Kf4klbyE3OqowbCAM96CKpc=; b=H9VYVSQycp+1K9jxgR/NtnOm8qwtsBkzHqVK
	6WEQrsUgnxndj7Nb0o1Xerd0IUgSURi6V6qw7uIPBc0pX94uQx8GLwyziMOrcq6Q
	nCLxzKksQIQfde8UtN9o3szSh/Dp4SLXF8ci2cdLHFxSmvxQgNWi3h3jdHRGCtL7
	MRR00d0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=SQNV7o
	WWfdaG9B6JATkz8xMNqUdsY7ZdnH040eAyOp/H2AgvocqfwLA66RYjHXkFZev0yg
	hFs9vNYb0kHq4VYEa/dGs5KqES3JVvfHkKHm9Bv1h2oLyily0kzUhXAQVBA07Fcp
	szODHIE1TFAk4kHL6sL28KieOxOPPY9Sapfec=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D66D43D28
	for <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7401A43D27 for
 <git@vger.kernel.org>; Fri,  4 Sep 2009 06:55:31 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.2.313.g0425f
In-Reply-To: <1252061718-11579-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 77790EDC-9941-11DE-8756-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127713>

"git apply" strips new blank lines at EOF under --whitespace=fix option,
but neigher --whitespace=warn nor --whitespace=error paid any attention to
these errors.

Introduce a new whitespace error class, blank-at-eof, to make the
whitespace error handling more consistent.

The patch adds a new "linenr" field to the struct fragment in order to
record which line the hunk started in the input file, but this is needed
solely for reporting purposes.  The detection of this class of whitespace
errors cannot be done while parsing a patch like we do for all the other
classes of whitespace errors.  It instead has to wait until we find where
to apply the hunk, but at that point, we do not have an access to the
original line number in the input file anymore, hence the new field.

Depending on your point of view, this may be a bugfix that makes warn and
error in line with fix.  Or you could call it a new feature.  The line
between them is somewhat fuzzy in this case.

Strictly speaking, triggering more errors than before is a change in
behaviour that is not backward compatible, even though the reason for the
change is because the code was not checking for an error that it should
have.  People who do not want added blank lines at EOF to trigger an error
can disable the new error class.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    2 ++
 builtin-apply.c          |   27 ++++++++++++++++++---------
 cache.h                  |    3 ++-
 t/t4124-apply-ws-rule.sh |   26 ++++++++++++++++++++++++++
 ws.c                     |    6 ++++++
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 113d9d1..871384e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,6 +389,8 @@ core.whitespace::
   error (enabled by default).
 * `indent-with-non-tab` treats a line that is indented with 8 or more
   space characters as an error (not enabled by default).
+* `blank-at-eof` treats blank lines added at the end of file as an error
+  (enabled by default).
 * `cr-at-eol` treats a carriage-return at the end of line as
   part of the line terminator, i.e. with it, `trailing-space`
   does not trigger if the character before such a carriage-return
diff --git a/builtin-apply.c b/builtin-apply.c
index 80ddf55..37d3bc0 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -126,6 +126,7 @@ struct fragment {
 	const char *patch;
 	int size;
 	int rejected;
+	int linenr;
 	struct fragment *next;
 };
 
@@ -1193,6 +1194,7 @@ static int parse_single_patch(char *line, unsigned long size, struct patch *patc
 		int len;
 
 		fragment = xcalloc(1, sizeof(*fragment));
+		fragment->linenr = linenr;
 		len = parse_fragment(line, size, patch, fragment);
 		if (len <= 0)
 			die("corrupt patch at line %d", linenr);
@@ -2079,17 +2081,24 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	}
 
 	if (applied_pos >= 0) {
-		if (ws_error_action == correct_ws_error &&
-		    new_blank_lines_at_end &&
-		    preimage.nr + applied_pos == img->nr) {
+		if (new_blank_lines_at_end &&
+		    preimage.nr + applied_pos == img->nr &&
+		    (ws_rule & WS_BLANK_AT_EOF) &&
+		    ws_error_action != nowarn_ws_error) {
+			record_ws_error(WS_BLANK_AT_EOF, "+", 1, frag->linenr);
+			if (ws_error_action == correct_ws_error) {
+				while (new_blank_lines_at_end--)
+					remove_last_line(&postimage);
+			}
 			/*
-			 * If the patch application adds blank lines
-			 * at the end, and if the patch applies at the
-			 * end of the image, remove those added blank
-			 * lines.
+			 * We would want to prevent write_out_results()
+			 * from taking place in apply_patch() that follows
+			 * the callchain led us here, which is:
+			 * apply_patch->check_patch_list->check_patch->
+			 * apply_data->apply_fragments->apply_one_fragment
 			 */
-			while (new_blank_lines_at_end--)
-				remove_last_line(&postimage);
+			if (ws_error_action == die_on_ws_error)
+				apply = 0;
 		}
 
 		/*
diff --git a/cache.h b/cache.h
index 099a32e..7152fea 100644
--- a/cache.h
+++ b/cache.h
@@ -845,7 +845,8 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
 #define WS_SPACE_BEFORE_TAB	02
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_CR_AT_EOL           010
-#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
+#define WS_BLANK_AT_EOF        020
+#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|WS_BLANK_AT_EOF)
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index ba2b7f9..89b71e1 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -189,4 +189,30 @@ test_expect_success 'blank at EOF with --whitespace=fix (3)' '
 	test_cmp expect one
 '
 
+test_expect_success 'blank at EOF with --whitespace=warn' '
+	{ echo a; echo b; echo c; } >one &&
+	git add one &&
+	echo >>one &&
+	cat one >expect &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	git apply --whitespace=warn patch 2>error &&
+	test_cmp expect one &&
+	grep "new blank line at EOF" error
+'
+
+test_expect_success 'blank at EOF with --whitespace=error' '
+	{ echo a; echo b; echo c; } >one &&
+	git add one &&
+	cat one >expect &&
+	echo >>one &&
+	git diff -- one >patch &&
+
+	git checkout one &&
+	test_must_fail git apply --whitespace=error patch 2>error &&
+	test_cmp expect one &&
+	grep "new blank line at EOF" error
+'
+
 test_done
diff --git a/ws.c b/ws.c
index 7a7ff13..d56636b 100644
--- a/ws.c
+++ b/ws.c
@@ -15,6 +15,7 @@ static struct whitespace_rule {
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
 	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
 	{ "cr-at-eol", WS_CR_AT_EOL },
+	{ "blank-at-eof", WS_BLANK_AT_EOF },
 };
 
 unsigned parse_whitespace_rule(const char *string)
@@ -113,6 +114,11 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "indent with spaces");
 	}
+	if (ws & WS_BLANK_AT_EOF) {
+		if (err.len)
+			strbuf_addstr(&err, ", ");
+		strbuf_addstr(&err, "new blank line at EOF");
+	}
 	return strbuf_detach(&err, NULL);
 }
 
-- 
1.6.4.2.313.g0425f

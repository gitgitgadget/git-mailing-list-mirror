From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] log --format: teach %C(auto,black) to paint it black only on
 terminals
Date: Mon, 17 Dec 2012 00:40:55 -0800
Message-ID: <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Srb\, Michal" <michal.srb11@imperial.ac.uk>,
	Jeff King <peff@peff.net>
To: "git\@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:41:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWGI-0007JW-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 09:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab2LQIk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 03:40:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56657 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab2LQIk6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2012 03:40:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E0699D6E;
	Mon, 17 Dec 2012 03:40:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5KmPFpQfaWp9
	Hi7IqfrT+bBVqpI=; b=O/63iTNCtNYzOFz2XKZ8QwQflgzZ+hjafu9faOIpAZIm
	e5sxQU3vsoUJOt1lwgGd7aFEG91PbgPXky7TQCfb/M34IO8bmAFNpNnyvsMdu4hN
	6mQhrLMw25xOOCiokMOe2qCHITBZC0fb7qIE/Jhu6j+JK3MixWVdBoxnA3pAcSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OeZZvK
	wEDiF7/ODvnqoXW+CK0oYnRFXTbfA4uuvTHhazDaFE7CmgR+hkwcHkNY80d1RXO5
	hv83bq25ssnpgAm+uqKx6C0Ofl7bCqNsCS5GdT+tXw7Kuvz7iiACPmVRamW3Hejl
	/Ms2zgP3VifqDcSdOFoZy4iz7g4Oc/OnuLJOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AD5E9D6D;
	Mon, 17 Dec 2012 03:40:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCFE29D6B; Mon, 17 Dec 2012
 03:40:56 -0500 (EST)
In-Reply-To: <7v7gojtbgr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 15 Dec 2012 10:30:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79BAFD2C-4825-11E2-BB9F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211659>

Traditionally, %C(color attr) always emitted the ANSI color
sequence; it was up to the scripts that wanted to conditionally
color their output to omit %C(...) specifier when they do not want
colors.

Optionally allow "auto," to be prefixed to the color, so that the
output is colored iff it goes to the terminal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This time with minimum test and documentation.

 Documentation/pretty-formats.txt |  4 +++-
 pretty.c                         | 13 ++++++++++---
 t/t6006-rev-list-format.sh       | 30 ++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d9edded..2af017c 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -144,7 +144,9 @@ The placeholders are:
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
 - '%Creset': reset color
-- '%C(...)': color specification, as described in color.branch.* config option
+- '%C(...)': color specification, as described in color.branch.* config option;
+  adding `auto,` at the beginning will emit color only when the
+  output is going to a terminal
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index dba6828..b9fd972 100644
--- a/pretty.c
+++ b/pretty.c
@@ -960,12 +960,19 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 	switch (placeholder[0]) {
 	case 'C':
 		if (placeholder[1] == '(') {
-			const char *end = strchr(placeholder + 2, ')');
+			const char *begin = placeholder + 2;
+			const char *end = strchr(begin, ')');
 			char color[COLOR_MAXLEN];
+
 			if (!end)
 				return 0;
-			color_parse_mem(placeholder + 2,
-					end - (placeholder + 2),
+			if (!memcmp(begin, "auto,", 5)) {
+				if (!want_color(-1))
+					return end - placeholder + 1;
+				begin += 5;
+			}
+			color_parse_mem(begin,
+					end - begin,
 					"--pretty format", color);
 			strbuf_addstr(sb, color);
 			return end - placeholder + 1;
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index f94f0c4..bfcc1c6 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -11,12 +11,12 @@ touch foo && git add foo && git commit -m "added foo" &&
 '
 
 # usage: test_format name format_string <expected_output
-test_format() {
+test_format () {
 	cat >expect.$1
 	test_expect_success "format $1" "
-git rev-list --pretty=format:'$2' master >output.$1 &&
-test_cmp expect.$1 output.$1
-"
+		git rev-list --pretty=format:'$2'${3:+ $3} master >output.$1 &&
+		test_cmp expect.$1 output.$1
+	"
 }
 
 test_format percent %%h <<'EOF'
@@ -124,6 +124,28 @@ commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 [1;31;43mfoo[m
 EOF
 
+test_format advanced-colors-auto \
+	'%C(auto,red yellow bold)foo%C(auto,reset)' --color <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+foo
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+foo
+EOF
+
+# %C(auto,...) should trump --color=always
+#
+# NEEDSWORK: --color=never should also be tested but we need to run a
+# similar test under pseudo-terminal with test_terminal which is too
+# much hassle for its worth.
+
+test_format advanced-colors-forced \
+	'%C(auto,red yellow bold)foo%C(auto,reset)' --color=always <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+foo
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+foo
+EOF
+
 cat >commit-msg <<'EOF'
 Test printing of complex bodies
 
-- 
1.8.1.rc2.126.ge9b7782

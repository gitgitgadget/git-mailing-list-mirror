From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] War on blank-at-eof
Date: Sat, 05 Sep 2009 23:13:51 -0700
Message-ID: <7v63bwob1c.fsf@alter.siamese.dyndns.org>
References: <1252061718-11579-1-git-send-email-gitster@pobox.com>
 <alpine.WNT.2.00.0909051534380.7040@GWNotebook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Sun Sep 06 08:14:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkB0q-0001J5-6u
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 08:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbZIFGN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 02:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbZIFGN5
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 02:13:57 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbZIFGN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 02:13:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 281094666C;
	Sun,  6 Sep 2009 02:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=QlMVgNWVhR5/xPlX+3MYkvN3Er0=; b=gTcOKWa97lkvpp7hNAbxd8g
	lcFtuOCJmucXdULTy19EKRZVQ7oKLGyE1AsfbY9XXTwnUUE4ctxArOkufvy9c23E
	Cby9Ytb6OyEtH9knjO20H3WMZmTB6S/gFZRii/hOGuk6UZM0gRKOCIueqcOwg1uT
	v62MrQSsOu9UOgA0A364=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=m1zabQPvIVnc8fH8cNoc+NsYDe8iaplzKjYjMDJRpw7mgk1Qf
	QMw8C7iSEtMyoLyEq2HTzjTcVUAqmGdvuERTDGfUVrrQHd6m/dsKT8jl5rzr5zRQ
	0duKI53vFYPBZi7gu500C5YSwJoCMHHuV50OdXesIjm6S2Wcv/caElzAMo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A85C4666B;
	Sun,  6 Sep 2009 02:13:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A3ED246669; Sun,  6 Sep 2009
 02:13:53 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75D9C1A4-9AAC-11DE-B3CA-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127834>

Thell Fowler <git@tbfowler.name> writes:

> While thinking about what appeared in:
>
> http://article.gmane.org/gmane.comp.version-control.git/124138

Oh, I forgot all about that one.  The suggestion does include two very
good points, one being "git apply" which I did, and the other being what I
completely forgot.  Introduction of blank-at-eol and blank-at-eof, and
make trailing-space a convenience synonym that triggers both.

Thanks for a reminder.  The following patch can come on top of the
series.

-- >8 --
Subject: core.whitespace: split trailing-space into blank-at-{eol,eof}

People who configured trailing-space depended on it to catch both extra
white space at the end of line, and extra blank lines at the end of file.
Earlier attempt to introduce only blank-at-eof gave them an escape hatch
to keep the old behaviour, but it is a regression until they explicitly
specify the new error class.

This introduces a blank-at-eol that only catches extra white space at the
end of line, and makes the traditional trailing-space a convenient synonym
to catch both blank-at-eol and blank-at-eof.  This way, people who used
trailing-space continue to catch both classes of errors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    5 ++++-
 cache.h                  |    5 +++--
 ws.c                     |   24 +++++++++++++++---------
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 871384e..0e245a7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -382,7 +382,7 @@ core.whitespace::
 	consider them as errors.  You can prefix `-` to disable
 	any of them (e.g. `-trailing-space`):
 +
-* `trailing-space` treats trailing whitespaces at the end of the line
+* `blank-at-eol` treats trailing whitespaces at the end of the line
   as an error (enabled by default).
 * `space-before-tab` treats a space character that appears immediately
   before a tab character in the initial indent part of the line as an
@@ -391,11 +391,14 @@ core.whitespace::
   space characters as an error (not enabled by default).
 * `blank-at-eof` treats blank lines added at the end of file as an error
   (enabled by default).
+* `trailing-space` is a short-hand to cover both `blank-at-eol` and
+  `blank-at-eof`.
 * `cr-at-eol` treats a carriage-return at the end of line as
   part of the line terminator, i.e. with it, `trailing-space`
   does not trigger if the character before such a carriage-return
   is not a whitespace (not enabled by default).
 
+
 core.fsyncobjectfiles::
 	This boolean will enable 'fsync()' when writing object files.
 +
diff --git a/cache.h b/cache.h
index 7152fea..ee12e74 100644
--- a/cache.h
+++ b/cache.h
@@ -841,12 +841,13 @@ void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, i
  * whitespace rules.
  * used by both diff and apply
  */
-#define WS_TRAILING_SPACE	01
+#define WS_BLANK_AT_EOL         01
 #define WS_SPACE_BEFORE_TAB	02
 #define WS_INDENT_WITH_NON_TAB	04
 #define WS_CR_AT_EOL           010
 #define WS_BLANK_AT_EOF        020
-#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|WS_BLANK_AT_EOF)
+#define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
+#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB)
 extern unsigned whitespace_rule_cfg;
 extern unsigned whitespace_rule(const char *);
 extern unsigned parse_whitespace_rule(const char *);
diff --git a/ws.c b/ws.c
index d56636b..cd03bc0 100644
--- a/ws.c
+++ b/ws.c
@@ -15,6 +15,7 @@ static struct whitespace_rule {
 	{ "space-before-tab", WS_SPACE_BEFORE_TAB },
 	{ "indent-with-non-tab", WS_INDENT_WITH_NON_TAB },
 	{ "cr-at-eol", WS_CR_AT_EOL },
+	{ "blank-at-eol", WS_BLANK_AT_EOL },
 	{ "blank-at-eof", WS_BLANK_AT_EOF },
 };
 
@@ -101,9 +102,19 @@ unsigned whitespace_rule(const char *pathname)
 char *whitespace_error_string(unsigned ws)
 {
 	struct strbuf err;
+
 	strbuf_init(&err, 0);
-	if (ws & WS_TRAILING_SPACE)
+	if ((ws & WS_TRAILING_SPACE) == WS_TRAILING_SPACE)
 		strbuf_addstr(&err, "trailing whitespace");
+	else {
+		if (ws & WS_BLANK_AT_EOL)
+			strbuf_addstr(&err, "trailing whitespace");
+		if (ws & WS_BLANK_AT_EOF) {
+			if (err.len)
+				strbuf_addstr(&err, ", ");
+			strbuf_addstr(&err, "new blank line at EOF");
+		}
+	}
 	if (ws & WS_SPACE_BEFORE_TAB) {
 		if (err.len)
 			strbuf_addstr(&err, ", ");
@@ -114,11 +125,6 @@ char *whitespace_error_string(unsigned ws)
 			strbuf_addstr(&err, ", ");
 		strbuf_addstr(&err, "indent with spaces");
 	}
-	if (ws & WS_BLANK_AT_EOF) {
-		if (err.len)
-			strbuf_addstr(&err, ", ");
-		strbuf_addstr(&err, "new blank line at EOF");
-	}
 	return strbuf_detach(&err, NULL);
 }
 
@@ -146,11 +152,11 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
 	}
 
 	/* Check for trailing whitespace. */
-	if (ws_rule & WS_TRAILING_SPACE) {
+	if (ws_rule & WS_BLANK_AT_EOL) {
 		for (i = len - 1; i >= 0; i--) {
 			if (isspace(line[i])) {
 				trailing_whitespace = i;
-				result |= WS_TRAILING_SPACE;
+				result |= WS_BLANK_AT_EOL;
 			}
 			else
 				break;
@@ -266,7 +272,7 @@ int ws_fix_copy(char *dst, const char *src, int len, unsigned ws_rule, int *erro
 	/*
 	 * Strip trailing whitespace
 	 */
-	if ((ws_rule & WS_TRAILING_SPACE) &&
+	if ((ws_rule & WS_BLANK_AT_EOL) &&
 	    (2 <= len && isspace(src[len-2]))) {
 		if (src[len - 1] == '\n') {
 			add_nl_to_tail = 1;
-- 
1.6.4.2.313.g0425f

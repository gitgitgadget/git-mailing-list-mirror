From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: cannot convert from utf8 to UTF-8
Date: Thu, 18 Oct 2012 22:50:45 -0700
Message-ID: <7vy5j3j9hm.fsf@alter.siamese.dyndns.org>
References: <1532361.Y42DjGJIX1@leto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cristian Tibirna <ctibirna@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Fri Oct 19 07:51:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TP5U6-0003jR-1N
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 07:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894Ab2JSFuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 01:50:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab2JSFuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 01:50:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E97E6B7E;
	Fri, 19 Oct 2012 01:50:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cTlvaQUvEqJFqBu8uGa6av8gt+M=; b=kS/iNk
	UN2uiwocTKp7j+v5y/ULwFCP0VH+UDK0CwYEXhtQOTkgCr7CMKhSH1TJpfhDtgmM
	o8uhX9R7gsy6Ej7gSoP4YYwWDI+UWRR67ZhfHhzrzyWubbaXmRmBzmmPmcaiB0sg
	sFBqcqXFVeuLyb35f/3sTTPzUf78RtUvVye3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xZZLINBGjB1ZRuGuV548SposH/xM03wk
	FeWf88jZEuINXKvmU0hdgNtlOXwZ2CNZcOfGzHa3O6r6t7zxPMLUDkqt6ySvs9wj
	EHWjN0pKxTXKRJacjCgO416R3hN5bmb6U/rudpN8kckiSZpXWvjD1a4jC7rDdCo4
	QFbN/jTPaLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0ACD36B7D;
	Fri, 19 Oct 2012 01:50:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23D516B7C; Fri, 19 Oct 2012
 01:50:48 -0400 (EDT)
In-Reply-To: <1532361.Y42DjGJIX1@leto> (Cristian Tibirna's message of "Thu,
 18 Oct 2012 20:03:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE8AACB8-19B0-11E2-BDC3-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208039>

Cristian Tibirna <ctibirna@giref.ulaval.ca> writes:

> This error:
>
> fatal: cannot convert from utf8 to UTF-8
> ...
> This is in part our fault: during the standardisation of our git environment, 
> we (re)enforced UTF-8 encodings by setting "i18n.commitenconding" and 
> "i18n.logOutputEncoding" to "utf8".
> ...
> I know "utf8" is not an accepted denomination ("UTF-8" or "utf-8" should be 
> used, according to IANA standards),...

Perhaps like this.

-- >8 --
Subject: [PATCH] reencode_string(): introduce and use same_encoding()

Callers of reencode_string() that re-encodes a string from one
encoding to another all used ad-hoc way to bypass the case where the
input and the output encodings are the same.  Some did strcmp(),
some did strcasecmp(), yet some others when converting to UTF-8 used
is_encoding_utf8().

Introduce same_encoding() helper function to make these callers
use the same logic.  Notably, is_encoding_utf8() has a work-around
for common misconfiguration to use "utf8" to name UTF-8 encoding,
which does not match "UTF-8" hence strcasecmp() would not consider
the same.  Make use of it in this helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/mailinfo.c | 2 +-
 notes.c            | 2 +-
 pretty.c           | 2 +-
 sequencer.c        | 2 +-
 utf8.c             | 7 +++++++
 utf8.h             | 1 +
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git c/builtin/mailinfo.c w/builtin/mailinfo.c
index da23140..e4e39d6 100644
--- c/builtin/mailinfo.c
+++ w/builtin/mailinfo.c
@@ -483,7 +483,7 @@ static void convert_to_utf8(struct strbuf *line, const char *charset)
 
 	if (!charset || !*charset)
 		return;
-	if (!strcasecmp(metainfo_charset, charset))
+	if (same_encoding(metainfo_charset, charset))
 		return;
 	out = reencode_string(line->buf, metainfo_charset, charset);
 	if (!out)
diff --git c/notes.c w/notes.c
index bc454e1..ee8f01f 100644
--- c/notes.c
+++ w/notes.c
@@ -1231,7 +1231,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	}
 
 	if (output_encoding && *output_encoding &&
-			strcmp(utf8, output_encoding)) {
+	    !is_encoding_utf8(output_encoding)) {
 		char *reencoded = reencode_string(msg, output_encoding, utf8);
 		if (reencoded) {
 			free(msg);
diff --git c/pretty.c w/pretty.c
index 8b1ea9f..e87fe9f 100644
--- c/pretty.c
+++ w/pretty.c
@@ -504,7 +504,7 @@ char *logmsg_reencode(const struct commit *commit,
 		return NULL;
 	encoding = get_header(commit, "encoding");
 	use_encoding = encoding ? encoding : utf8;
-	if (!strcmp(use_encoding, output_encoding))
+	if (same_encoding(use_encoding, output_encoding))
 		if (encoding) /* we'll strip encoding header later */
 			out = xstrdup(commit->buffer);
 		else
diff --git c/sequencer.c w/sequencer.c
index e3723d2..73c396b 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -60,7 +60,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 
 	out->reencoded_message = NULL;
 	out->message = commit->buffer;
-	if (strcmp(encoding, git_commit_encoding))
+	if (same_encoding(encoding, git_commit_encoding))
 		out->reencoded_message = reencode_string(commit->buffer,
 					git_commit_encoding, encoding);
 	if (out->reencoded_message)
diff --git c/utf8.c w/utf8.c
index a544f15..6a52834 100644
--- c/utf8.c
+++ w/utf8.c
@@ -423,6 +423,13 @@ int is_encoding_utf8(const char *name)
 	return 0;
 }
 
+int same_encoding(const char *src, const char *dst)
+{
+	if (is_encoding_utf8(src) && is_encoding_utf8(dst))
+		return 1;
+	return !strcasecmp(src, dst);
+}
+
 /*
  * Given a buffer and its encoding, return it re-encoded
  * with iconv.  If the conversion fails, returns NULL.
diff --git c/utf8.h w/utf8.h
index 3c0ae76..93ef600 100644
--- c/utf8.h
+++ w/utf8.h
@@ -7,6 +7,7 @@ int utf8_width(const char **start, size_t *remainder_p);
 int utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
+int same_encoding(const char *, const char *);
 
 int strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);

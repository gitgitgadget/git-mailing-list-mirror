From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] diff.c: split emit_line() from the first char and the
 rest of the line
Date: Mon, 14 Sep 2009 23:15:04 -0700
Message-ID: <1252995306-32329-3-git-send-email-gitster@pobox.com>
References: <1252995306-32329-1-git-send-email-gitster@pobox.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 08:15:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnRKD-00057k-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 08:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbZIOGPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 02:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753778AbZIOGPP
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 02:15:15 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbZIOGPN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 02:15:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D8F8432A57;
	Tue, 15 Sep 2009 02:15:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Q/28
	5b5oTr9YqdI4YiS/5aAnXzc=; b=KTY6m4fQBx3Ro6QUHCpONSPo9QxKEPO5iFhy
	woaHT/mRj+pCTXAG24IHyx4gpPDtGHHNmrmgaDM++tc+1TWmi6h/xozquiDBggMZ
	8OfBi8hlGyMv+EAFRRFBouWF4HEtt8aW347SQUvXguAuyR3v+P/XfN5bm1nc13uB
	EISBn7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	seLThqRG3ewJ521N7kzH3rW62qWfBczD9XYlumu0MDlFl4M2Bmjppyms5JYv+XXU
	dgPucVOV1fQ6GSWcJHTBawFgTQzbOJ9HmwLv9JbagOOIfKCbCts+eX/uUkVgG6O2
	r3YUit8m+Lg4H24TkhqEr9uqhP0oZoZdSGTMsY3yFsg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C815632A56;
	Tue, 15 Sep 2009 02:15:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F2C032A54; Tue, 15 Sep
 2009 02:15:14 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.54.g4aad
In-Reply-To: <1252995306-32329-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 228892F4-A1BF-11DE-BAC5-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128517>

A new helper function emit_line_0() takes the first line of diff output
(typically "-", " ", or "+") separately from the remainder of the line.
No other functional changes.

This change will make it easier to reuse the logic when emitting the
rewrite diff, as we do not want to copy a line only to add "+"/"-"/" "
immediately before its first character when we produce rewrite diff
output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 7548966..b5c2574 100644
--- a/diff.c
+++ b/diff.c
@@ -377,7 +377,8 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 	ecbdata->blank_at_eof_in_postimage = (at - l2) + 1;
 }
 
-static void emit_line(FILE *file, const char *set, const char *reset, const char *line, int len)
+static void emit_line_0(FILE *file, const char *set, const char *reset,
+			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 
@@ -389,6 +390,7 @@ static void emit_line(FILE *file, const char *set, const char *reset, const char
 		len--;
 
 	fputs(set, file);
+	fputc(first, file);
 	fwrite(line, len, 1, file);
 	fputs(reset, file);
 	if (has_trailing_carriage_return)
@@ -397,6 +399,12 @@ static void emit_line(FILE *file, const char *set, const char *reset, const char
 		fputc('\n', file);
 }
 
+static void emit_line(FILE *file, const char *set, const char *reset,
+		      const char *line, int len)
+{
+	emit_line_0(file, set, reset, line[0], line+1, len-1);
+}
+
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
 {
 	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
-- 
1.6.5.rc1.54.g4aad

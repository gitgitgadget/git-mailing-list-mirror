From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/4] builtin/commit.c: extract ignore_non_trailer() helper function
Date: Tue, 28 Oct 2014 14:36:51 -0700
Message-ID: <1414532212-9016-4-git-send-email-gitster@pobox.com>
References: <1414532212-9016-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 22:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjElM-0007Wl-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 22:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbaJ1V5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 17:57:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754951AbaJ1V5F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 17:57:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AC2E1AFD3;
	Tue, 28 Oct 2014 17:57:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=utM9
	LFfhtZ6Ul0qSN2TM51Fx+rY=; b=MqU8dsnoQZFogHptqCzJa8731++Km5/qWkhp
	k8dGvQtiDmzfH47uT6w0aKTSVUP5Zdq6/9aPRnRUZ1y2quyDDoYr9XaP7bu8xSDq
	wZJIWfYMyeerRnaxa94eioDyXOkcRFE2DFE2zFjIJ94bcXRGOxrlMVgQ2bEUmcgX
	v2nkIG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bIOgeu
	UdLs49szGKHK2UZPT3bZVVNG0n6kt/uLBQSOPM3AIPBpS0fXYyeHoxWgrBzwhN3e
	p7aVecy1jzq8hobeCc5XSpwIopf0KoiPJ5jxk6lCzJfY8HMze+z+ZoL31QyFp4rk
	xYCueqxn5qUTLOlOgnNGDN7g5zeY0GpwMHTWY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 017A71AFD2;
	Tue, 28 Oct 2014 17:57:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 470F21AAB0;
	Tue, 28 Oct 2014 17:37:02 -0400 (EDT)
X-Mailer: git-send-email 2.1.2-620-g33c52cb
In-Reply-To: <1414532212-9016-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8DD7BE3E-5EEA-11E4-A530-527C6E758C04-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a helper function from prepare_to_commit() to determine
where to place a new Signed-off-by: line, which is essentially the
true "end" of the log message, ignoring the trailing "Conflicts:"
line and everything below it.

The detection _should_ make sure the "Conflicts:" line it finds is
truly the conflict hint block by checking everything that follows is
a HT indented pathname to avoid false positive, but this logic will
be revamped in a later patch to ignore comments and blanks anyway,
so it is left as-is in this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 59 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fedb45a..cd455aa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -593,6 +593,37 @@ static char *cut_ident_timestamp_part(char *string)
 	return ket;
 }
 
+/*
+ * Inspect sb and determine the true "end" of the log message, in
+ * order to find where to put a new Signed-off-by: line.  Ignored are
+ * trailing "Conflict:" block.
+ *
+ * Returns the number of bytes from the tail to ignore, to be fed as
+ * the second parameter to append_signoff().
+ */
+static int ignore_non_trailer(struct strbuf *sb)
+{
+	int ignore_footer = 0;
+	int i, eol, previous = 0;
+	const char *nl;
+
+	for (i = 0; i < sb->len; i++) {
+		nl = memchr(sb->buf + i, '\n', sb->len - i);
+		if (nl)
+			eol = nl - sb->buf;
+		else
+			eol = sb->len;
+		if (!prefixcmp(sb->buf + previous, "\nConflicts:\n")) {
+			ignore_footer = sb->len - previous;
+			break;
+		}
+		while (i < eol)
+			i++;
+		previous = eol;
+	}
+	return ignore_footer;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -718,32 +749,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (clean_message_contents)
 		stripspace(&sb, 0);
 
-	if (signoff) {
-		/*
-		 * See if we have a Conflicts: block at the end. If yes, count
-		 * its size, so we can ignore it.
-		 */
-		int ignore_footer = 0;
-		int i, eol, previous = 0;
-		const char *nl;
-
-		for (i = 0; i < sb.len; i++) {
-			nl = memchr(sb.buf + i, '\n', sb.len - i);
-			if (nl)
-				eol = nl - sb.buf;
-			else
-				eol = sb.len;
-			if (!prefixcmp(sb.buf + previous, "\nConflicts:\n")) {
-				ignore_footer = sb.len - previous;
-				break;
-			}
-			while (i < eol)
-				i++;
-			previous = eol;
-		}
-
-		append_signoff(&sb, ignore_footer, 0);
-	}
+	if (signoff)
+		append_signoff(&sb, ignore_non_trailer(&sb), 0);
 
 	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
 		die_errno(_("could not write commit template"));
-- 
2.1.2-620-g33c52cb

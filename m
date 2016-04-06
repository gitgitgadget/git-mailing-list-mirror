From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/11] rerere: move code related to "forget" together
Date: Wed,  6 Apr 2016 16:05:33 -0700
Message-ID: <1459983935-25267-10-git-send-email-gitster@pobox.com>
References: <1459204942-26601-1-git-send-email-gitster@pobox.com>
 <1459983935-25267-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 01:06:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anwWR-0008RF-D6
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 01:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428AbcDFXFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 19:05:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752191AbcDFXFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 19:05:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F3DC75373F;
	Wed,  6 Apr 2016 19:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=k7G6
	GPGBD+GvNxdvqzgrYVvtBzg=; b=s8LiNq0nK1NjwWkLSv3RVMEryjfh+JG1/mG/
	D6XlrBLTgLoUFVOSOvdA2xylqreIPeBFDCtPDxpvtiSOnUJwn60nrrt98VG8OvHI
	1kFt2DM4Cp1Dl/fwB/nchIAzahvb7Ljm5cnjjzZ6PrE7sJVv5bgRkX2TyyH16ZcG
	7FSaCmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=HYP3Q2
	SaFSPzS22oRExpI6Jp5qdNFfQXoMu+si5bTpR8blP3Azwl+ObbsCSOOc8AC1KFv8
	Il8orweizUXgdMkSYKQhYw5SWTHAQ8JBWQJjnjHRBRchdLEt/oFTbPkXB/2j0hT9
	O/E8/6dTXxPIaw8V6XQrn+HBCwbq2DETPMrfg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC0F95373E;
	Wed,  6 Apr 2016 19:05:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 58B7B5373C;
	Wed,  6 Apr 2016 19:05:52 -0400 (EDT)
X-Mailer: git-send-email 2.3.8-32-g0ce02b3
In-Reply-To: <1459983935-25267-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1C18C36E-FC4C-11E5-A915-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290893>

"rerere forget" is the only user of handle_cache() helper, which in
turn is the only user of rerere_io that reads from an in-core buffer
whose getline method is implemented as rerere_mem_getline().  Gather
them together.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 194 +++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 97 insertions(+), 97 deletions(-)

diff --git a/rerere.c b/rerere.c
index 3d4dd33..2b870e0 100644
--- a/rerere.c
+++ b/rerere.c
@@ -517,103 +517,6 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 }
 
 /*
- * Subclass of rerere_io that reads from an in-core buffer that is a
- * strbuf
- */
-struct rerere_io_mem {
-	struct rerere_io io;
-	struct strbuf input;
-};
-
-/*
- * ... and its getline() method implementation
- */
-static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
-{
-	struct rerere_io_mem *io = (struct rerere_io_mem *)io_;
-	char *ep;
-	size_t len;
-
-	strbuf_release(sb);
-	if (!io->input.len)
-		return -1;
-	ep = memchr(io->input.buf, '\n', io->input.len);
-	if (!ep)
-		ep = io->input.buf + io->input.len;
-	else if (*ep == '\n')
-		ep++;
-	len = ep - io->input.buf;
-	strbuf_add(sb, io->input.buf, len);
-	strbuf_remove(&io->input, 0, len);
-	return 0;
-}
-
-static int handle_cache(const char *path, unsigned char *sha1, const char *output)
-{
-	mmfile_t mmfile[3] = {{NULL}};
-	mmbuffer_t result = {NULL, 0};
-	const struct cache_entry *ce;
-	int pos, len, i, hunk_no;
-	struct rerere_io_mem io;
-	int marker_size = ll_merge_marker_size(path);
-
-	/*
-	 * Reproduce the conflicted merge in-core
-	 */
-	len = strlen(path);
-	pos = cache_name_pos(path, len);
-	if (0 <= pos)
-		return -1;
-	pos = -pos - 1;
-
-	while (pos < active_nr) {
-		enum object_type type;
-		unsigned long size;
-
-		ce = active_cache[pos++];
-		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
-			break;
-		i = ce_stage(ce) - 1;
-		if (!mmfile[i].ptr) {
-			mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
-			mmfile[i].size = size;
-		}
-	}
-	for (i = 0; i < 3; i++)
-		if (!mmfile[i].ptr && !mmfile[i].size)
-			mmfile[i].ptr = xstrdup("");
-
-	/*
-	 * NEEDSWORK: handle conflicts from merges with
-	 * merge.renormalize set, too
-	 */
-	ll_merge(&result, path, &mmfile[0], NULL,
-		 &mmfile[1], "ours",
-		 &mmfile[2], "theirs", NULL);
-	for (i = 0; i < 3; i++)
-		free(mmfile[i].ptr);
-
-	memset(&io, 0, sizeof(io));
-	io.io.getline = rerere_mem_getline;
-	if (output)
-		io.io.output = fopen(output, "w");
-	else
-		io.io.output = NULL;
-	strbuf_init(&io.input, 0);
-	strbuf_attach(&io.input, result.ptr, result.size, result.size);
-
-	/*
-	 * Grab the conflict ID and optionally write the original
-	 * contents with conflict markers out.
-	 */
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
-	strbuf_release(&io.input);
-	if (io.io.output)
-		fclose(io.io.output);
-	return hunk_no;
-}
-
-/*
  * Look at a cache entry at "i" and see if it is not conflicting,
  * conflicting and we are willing to handle, or conflicting and
  * we are unable to handle, and return the determination in *type.
@@ -1005,6 +908,103 @@ int rerere(int flags)
 	return status;
 }
 
+/*
+ * Subclass of rerere_io that reads from an in-core buffer that is a
+ * strbuf
+ */
+struct rerere_io_mem {
+	struct rerere_io io;
+	struct strbuf input;
+};
+
+/*
+ * ... and its getline() method implementation
+ */
+static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
+{
+	struct rerere_io_mem *io = (struct rerere_io_mem *)io_;
+	char *ep;
+	size_t len;
+
+	strbuf_release(sb);
+	if (!io->input.len)
+		return -1;
+	ep = memchr(io->input.buf, '\n', io->input.len);
+	if (!ep)
+		ep = io->input.buf + io->input.len;
+	else if (*ep == '\n')
+		ep++;
+	len = ep - io->input.buf;
+	strbuf_add(sb, io->input.buf, len);
+	strbuf_remove(&io->input, 0, len);
+	return 0;
+}
+
+static int handle_cache(const char *path, unsigned char *sha1, const char *output)
+{
+	mmfile_t mmfile[3] = {{NULL}};
+	mmbuffer_t result = {NULL, 0};
+	const struct cache_entry *ce;
+	int pos, len, i, hunk_no;
+	struct rerere_io_mem io;
+	int marker_size = ll_merge_marker_size(path);
+
+	/*
+	 * Reproduce the conflicted merge in-core
+	 */
+	len = strlen(path);
+	pos = cache_name_pos(path, len);
+	if (0 <= pos)
+		return -1;
+	pos = -pos - 1;
+
+	while (pos < active_nr) {
+		enum object_type type;
+		unsigned long size;
+
+		ce = active_cache[pos++];
+		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
+			break;
+		i = ce_stage(ce) - 1;
+		if (!mmfile[i].ptr) {
+			mmfile[i].ptr = read_sha1_file(ce->sha1, &type, &size);
+			mmfile[i].size = size;
+		}
+	}
+	for (i = 0; i < 3; i++)
+		if (!mmfile[i].ptr && !mmfile[i].size)
+			mmfile[i].ptr = xstrdup("");
+
+	/*
+	 * NEEDSWORK: handle conflicts from merges with
+	 * merge.renormalize set, too?
+	 */
+	ll_merge(&result, path, &mmfile[0], NULL,
+		 &mmfile[1], "ours",
+		 &mmfile[2], "theirs", NULL);
+	for (i = 0; i < 3; i++)
+		free(mmfile[i].ptr);
+
+	memset(&io, 0, sizeof(io));
+	io.io.getline = rerere_mem_getline;
+	if (output)
+		io.io.output = fopen(output, "w");
+	else
+		io.io.output = NULL;
+	strbuf_init(&io.input, 0);
+	strbuf_attach(&io.input, result.ptr, result.size, result.size);
+
+	/*
+	 * Grab the conflict ID and optionally write the original
+	 * contents with conflict markers out.
+	 */
+	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
+	strbuf_release(&io.input);
+	if (io.io.output)
+		fclose(io.io.output);
+	return hunk_no;
+}
+
 static int rerere_forget_one_path(const char *path, struct string_list *rr)
 {
 	const char *filename;
-- 
2.8.1-273-ga2cd0f9

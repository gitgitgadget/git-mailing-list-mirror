From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/11] rerere: move code related to "forget" together
Date: Mon, 28 Mar 2016 15:42:20 -0700
Message-ID: <1459204942-26601-10-git-send-email-gitster@pobox.com>
References: <1442275050-30497-1-git-send-email-gitster@pobox.com>
 <1459204942-26601-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 00:43:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akfsE-0005OR-Cl
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 00:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbcC1Wmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755504AbcC1Wmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E6E954FFC5;
	Mon, 28 Mar 2016 18:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/idu
	nqzOj6V4rO2L8/oLkcpCnuI=; b=UXNwu1AkImCB20Da2Q3SWAlcpj7OLt6MyhfZ
	RwHswtxNYxa3AKYXj/N/gvmC2vGtDtCQx78ZtuBq/t1Z5zZrDpDTwXEnvcH1F08M
	XuHH9MqVVkvyJ6YGuda0qwI14sVh+INOfdsdEQ8fI3IFiB400c2a1imBc/BCbQgK
	oLLnvEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=vizQGU
	fhi5n8rig6cD2HYzwntsFsPS+Dz3GF5lR4cLMxOuCt86RVZrVsNnQEmmo0aqqIuP
	NA+DnItrmakAX4wxCIvNNLwnNEgCON2IX7YBE+sUgJKLPhDkoHZAEGO8TJvDTC7H
	Mg8RHkv0DpGIzbmtfkfM7COWs117ZlJQszJFU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DEBA14FFC4;
	Mon, 28 Mar 2016 18:42:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4E0774FFC2;
	Mon, 28 Mar 2016 18:42:39 -0400 (EDT)
X-Mailer: git-send-email 2.8.0-215-g046a488
In-Reply-To: <1459204942-26601-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 600F5FF0-F536-11E5-BFE8-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290078>

"rerere forget" is the only user of handle_cache() helper, which in
turn is the only user of rerere_io that reads from an in-core buffer
whose getline method is implemented as rerere_mem_getline().  Gather
them together.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * New in v2.

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
2.8.0-215-g046a488

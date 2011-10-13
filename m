From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH 1/2] bundle: allowing to read from an unseekable fd
Date: Thu, 13 Oct 2011 15:32:43 -0700
Message-ID: <7vpqi034l0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 00:33:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RETpk-0004x6-PH
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 00:33:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab1JMWcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 18:32:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47930 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473Ab1JMWcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 18:32:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3350E5BA7;
	Thu, 13 Oct 2011 18:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	AXYRUngkE7PeeBYEHhrafPt83I=; b=DTUlF8GIDGCqUzG6lTXs6qg9++XgQvIDC
	CsaXgCLQl5bMKUdguzeO5st1lT/i9ALb5XnVN7K9Pb5mQsH9N8dncdH+IWBsFlgU
	V2VmzliKTyrj8rL0KbeCiu7c8hC3RjtVPW0Icbi/GPsmFX2sqEUU4BSAp+1lAbnN
	LT0mUBqiTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=MRHmRnvqWkwyqR7InBJBg5BxIg/14k+aWCnwmhgDA/fxa9uID2kOnub4
	1g634kMH4CwWrIYSK/8f6p4f/c3QTsyFx9C080Ws2ZjGiiZabloBX/nGPK4V1znn
	f9jiGZG5UPv4u9+gFwLJsi7c+Ut4rZ6WG/l79DrdFEvm7MbiVTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AEF75BA6;
	Thu, 13 Oct 2011 18:32:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E5F85BA5; Thu, 13 Oct 2011
 18:32:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44FC6F4A-F5EB-11E0-BC2D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183526>

The current code opens a given file with fopen(), reads it until the end
of the header and runs ftell(), and reopens the same file with open() and
seeks to skip the header. This structure makes it hard to retarget the
code to read from input that is not seekable, such as a network socket.

This patch by itself does not reach that goal yet, but I think it is a
right step in that direction.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It would be nice if we can avoid byte-by-byte reading from the file
   descriptor by over-reading into the strbuf and pass the remainder to
   the caller of read_bundle_header(), but I suspect that it would require
   us to carry the "here is the remainder from the previous read" buffer
   around throughout the transport layer. Parsing of the header wouldn't
   be performance critical compared to the computation cost of actually
   reading the rest of the bundle, hopefully, so...

 bundle.c |   99 ++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 64 insertions(+), 35 deletions(-)

diff --git a/bundle.c b/bundle.c
index f48fd7d..3aa715c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,49 +23,78 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 	list->nr++;
 }
 
-/* returns an fd */
+/* Eventually this should go to strbuf.[ch] */
+static int strbuf_readline_fd(struct strbuf *sb, int fd)
+{
+	strbuf_reset(sb);
+
+	while (1) {
+		char ch;
+		ssize_t len = xread(fd, &ch, 1);
+		if (len < 0)
+			return -1;
+		strbuf_addch(sb, ch);
+		if (ch == '\n')
+			break;
+	}
+	return 0;
+}
+
 int read_bundle_header(const char *path, struct bundle_header *header)
 {
-	char buffer[1024];
-	int fd;
-	long fpos;
-	FILE *ffd = fopen(path, "rb");
+	struct strbuf buf = STRBUF_INIT;
+	int fd = open(path, O_RDONLY);
+	int status = 0;
 
-	if (!ffd)
+	if (fd < 0)
 		return error("could not open '%s'", path);
-	if (!fgets(buffer, sizeof(buffer), ffd) ||
-			strcmp(buffer, bundle_signature)) {
-		fclose(ffd);
-		return error("'%s' does not look like a v2 bundle file", path);
+
+	/* The bundle header begins with the signature */
+	if (strbuf_readline_fd(&buf, fd) ||
+	    strcmp(buf.buf, bundle_signature)) {
+		error("'%s' does not look like a v2 bundle file", path);
+		status = -1;
+		goto abort;
 	}
-	while (fgets(buffer, sizeof(buffer), ffd)
-			&& buffer[0] != '\n') {
-		int is_prereq = buffer[0] == '-';
-		int offset = is_prereq ? 1 : 0;
-		int len = strlen(buffer);
+
+	/* The bundle header ends with an empty line */
+	while (!strbuf_readline_fd(&buf, fd) &&
+	       buf.len && buf.buf[0] != '\n') {
 		unsigned char sha1[20];
-		struct ref_list *list = is_prereq ? &header->prerequisites
-			: &header->references;
-		char delim;
-
-		if (len && buffer[len - 1] == '\n')
-			buffer[len - 1] = '\0';
-		if (get_sha1_hex(buffer + offset, sha1)) {
-			warning("unrecognized header: %s", buffer);
-			continue;
+		int is_prereq = 0;
+
+		if (*buf.buf == '-') {
+			is_prereq = 1;
+			strbuf_remove(&buf, 0, 1);
+		}
+		strbuf_rtrim(&buf);
+
+		/*
+		 * Tip lines have object name, SP, and refname.
+		 * Prerequisites have object name that is optionally
+		 * followed by SP and subject line.
+		 */
+		if (get_sha1_hex(buf.buf, sha1) ||
+		    (40 <= buf.len && !isspace(buf.buf[40])) ||
+		    (!is_prereq && buf.len <= 40)) {
+			error("unrecognized header: %s%s (%d)",
+			      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
+			status = -1;
+			break;
+		} else {
+			if (is_prereq)
+				add_to_ref_list(sha1, "", &header->prerequisites);
+			else
+				add_to_ref_list(sha1, buf.buf + 41, &header->references);
 		}
-		delim = buffer[40 + offset];
-		if (!isspace(delim) && (delim != '\0' || !is_prereq))
-			die ("invalid header: %s", buffer);
-		add_to_ref_list(sha1, isspace(delim) ?
-				buffer + 41 + offset : "", list);
 	}
-	fpos = ftell(ffd);
-	fclose(ffd);
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
-		return error("could not open '%s'", path);
-	lseek(fd, fpos, SEEK_SET);
+
+ abort:
+	if (status) {
+		close(fd);
+		fd = -1;
+	}
+	strbuf_release(&buf);
 	return fd;
 }
 
-- 
1.7.7.289.gd0d4bb

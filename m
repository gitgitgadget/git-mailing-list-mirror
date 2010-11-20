From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] vcs-svn: Internal fast_export_save_blob helper
Date: Sat, 20 Nov 2010 13:25:09 -0600
Message-ID: <20101120192509.GC17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:25:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt3t-0001PX-2K
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab0KTTZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:25:18 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63385 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764Ab0KTTZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:25:17 -0500
Received: by gyb11 with SMTP id 11so598467gyb.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=t7fKCk0SKMAJB4YDjKwxtGeKFvWqQ7082bdV+AEXsUg=;
        b=tRKMmwGabBj4XqObVVtXte7rih+4sLLjm3oCjqdIsIjaZG0zX9mRpDoSQvYQFK4XpB
         S5iyAg1W9M7AI58XZcXMtVkp5vwMF9hvJWdKqRCGgdNJYP5PQyZkwacGUCXmyMr+ccAW
         6tnkV1UDNfekKyaHejs9N6ya5VcB0MTzz+dXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=S6eDx08TyUWXjU3Yte2+Y5ys9kdlADMaZFzYthoobLrs7R3gAKRikcLuc6xNhpVmEW
         oYiVuSDs9Xq279UnjYjW/1fVr2G3ClM4No96fNLvgReerQFWqqVlB990i3aJ6clTigT0
         v1TgNtawO9RFpO9Rz8ExE7sk+V7nf3NaP65pQ=
Received: by 10.91.18.35 with SMTP id v35mr4656186agi.147.1290281116284;
        Sat, 20 Nov 2010 11:25:16 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h74sm1984443yhj.21.2010.11.20.11.25.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:25:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161832>

Introduce fast_export_save_blob, meant to be used after printing

	cat-blob :n

to the fast-import stream.  It reads a response from fd 3 in cat-file
--batch format.  To avoid deadlock, it uses file descriptor-level
calls (no stdio) and reads only one character at a time (though the
latter restriction could and should be relaxed somehow --- O_NONBLOCK,
perhaps).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The effect of this one is almost completely undone by a later patch. :)

Probably it would be better to use stdio with O_NONBLOCK, after all
(David, sorry I forgot about our conversations on this before).  This
series uses file descriptors to be conservative, because I do not have
much of a desire to test for proper O_NONBLOCK support on the relevant
platforms yet.

 vcs-svn/fast_export.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6cfa256..3feef66 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -8,8 +8,10 @@
 #include "line_buffer.h"
 #include "repo_tree.h"
 #include "string_pool.h"
+#include "strbuf.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
+#define REPORT_FILENO 3
 
 static uint32_t first_commit_done;
 
@@ -63,6 +65,91 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
+static int ends_with(const char *s, size_t len, const char *suffix)
+{
+	const size_t suffixlen = strlen(suffix);
+	if (len < suffixlen)
+		return 0;
+	return !memcmp(s + len - suffixlen, suffix, suffixlen);
+}
+
+static int parse_cat_response_line(const char *header, size_t *len)
+{
+	size_t headerlen = strlen(header);
+	const char *type;
+	const char *end;
+
+	if (ends_with(header, headerlen, " missing"))
+		return error("cat-blob reports missing blob: %s", header);
+	type = memmem(header, headerlen, " blob ", strlen(" blob "));
+	if (!type)
+		return error("cat-blob header has wrong object type: %s", header);
+	*len = strtoumax(type + strlen(" blob "), (char **) &end, 10);
+	if (end == type + strlen(" blob "))
+		return error("cat-blob header does not contain length: %s", header);
+	if (*end)
+		return error("cat-blob header contains garbage after length: %s", header);
+	return 0;
+}
+
+static struct strbuf response_line = STRBUF_INIT;
+static const char *get_response_line(void)
+{
+	/*
+	 * NEEDSWORK: Does not actually need to read one byte at a time.
+	 * Some platforms have O_NONBLOCK.  On others we could read 8 chars
+	 * at a time until a potential appearance of " blob ".
+	 */
+	strbuf_reset(&response_line);
+	for (;;) {
+		char buf[1];
+		if (xread(REPORT_FILENO, buf, 1) < 0) {
+			error("cannot read cat-blob result: %s", strerror(errno));
+			return NULL;
+		}
+		if (*buf == '\n')
+			return response_line.buf;
+		strbuf_addch(&response_line, *buf);
+	}
+}
+
+static int copy_bytes(FILE *out, size_t len)
+{
+	char buf[4096];
+	ssize_t nread;
+	for (; len; len -= nread) {
+		nread = xread(REPORT_FILENO, buf,
+					len < sizeof(buf) ? len : sizeof(buf));
+		if (nread < 0)
+			return error("cannot copy cat-blob result: %s",
+					strerror(errno));
+		if (!nread)
+			return error("0-length read...");
+		if (fwrite(buf, 1, nread, out) != nread)
+			return error("cannot write cat-blob results: %s",
+					strerror(errno));
+	}
+}
+
+static int fast_export_save_blob(FILE *out)
+{
+	size_t len = len;
+	const char *header, *tail;
+
+	header = get_response_line();
+	if (!header || parse_cat_response_line(header, &len))
+		return -1;
+	copy_bytes(out, len);
+
+	/* Discard trailing newline. */
+	tail = get_response_line();
+	if (!tail)
+		return -1;
+	if (*tail)
+		return error("line following cat-blob response contains garbage: %s", tail);
+	return 0;
+}
+
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
 {
 	if (mode == REPO_MODE_LNK) {
-- 
1.7.2.3

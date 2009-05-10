From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] builtin-mktree.c: use a helper function to handle one
 line of input
Date: Sun, 10 May 2009 11:49:48 -0700
Message-ID: <1241981391-19639-4-git-send-email-gitster@pobox.com>
References: <1241981391-19639-1-git-send-email-gitster@pobox.com>
 <1241981391-19639-2-git-send-email-gitster@pobox.com>
 <1241981391-19639-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 10 20:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3E6Q-0004rg-3Z
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 20:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbZEJSuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 14:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbZEJSuA
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 14:50:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbZEJSt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 14:49:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 18A331616F
	for <git@vger.kernel.org>; Sun, 10 May 2009 14:50:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 929EF1616C for
 <git@vger.kernel.org>; Sun, 10 May 2009 14:49:59 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.9.g6345d
In-Reply-To: <1241981391-19639-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5D34B490-3D93-11DE-AB7E-D766E3C8547C-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118736>

The main() function used to do the whole thing; this moves the handling of
a single input line to a separate function to make it easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-mktree.c |   82 +++++++++++++++++++++++++++--------------------------
 1 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/builtin-mktree.c b/builtin-mktree.c
index 2b3145b..133ab4b 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -67,10 +67,48 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
+static void mktree_line(char *buf, size_t len, int line_termination)
+{
+	char *ptr, *ntr;
+	unsigned mode;
+	enum object_type type;
+	char *path;
+	unsigned char sha1[20];
+
+	ptr = buf;
+	/*
+	 * Read non-recursive ls-tree output format:
+	 *     mode SP type SP sha1 TAB name
+	 */
+	mode = strtoul(ptr, &ntr, 8);
+	if (ptr == ntr || !ntr || *ntr != ' ')
+		die("input format error: %s", buf);
+	ptr = ntr + 1; /* type */
+	ntr = strchr(ptr, ' ');
+	if (!ntr || buf + len <= ntr + 40 ||
+	    ntr[41] != '\t' ||
+	    get_sha1_hex(ntr + 1, sha1))
+		die("input format error: %s", buf);
+	type = sha1_object_info(sha1, NULL);
+	if (type < 0)
+		die("object %s unavailable", sha1_to_hex(sha1));
+	*ntr++ = 0; /* now at the beginning of SHA1 */
+	if (type != type_from_string(ptr))
+		die("object type %s mismatch (%s)", ptr, typename(type));
+
+	path = ntr + 41;  /* at the beginning of name */
+	if (line_termination && path[0] == '"') {
+		struct strbuf p_uq = STRBUF_INIT;
+		if (unquote_c_style(&p_uq, path, NULL))
+			die("invalid quoting");
+		path = strbuf_detach(&p_uq, NULL);
+	}
+	append_to_tree(mode, sha1, path);
+}
+
 int cmd_mktree(int ac, const char **av, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
-	struct strbuf p_uq = STRBUF_INIT;
 	unsigned char sha1[20];
 	int line_termination = '\n';
 	const struct option option[] = {
@@ -80,45 +118,9 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 
 	ac = parse_options(ac, av, option, mktree_usage, 0);
 
-	while (strbuf_getline(&sb, stdin, line_termination) != EOF) {
-		char *ptr, *ntr;
-		unsigned mode;
-		enum object_type type;
-		char *path;
-
-		ptr = sb.buf;
-		/*
-		 * Read non-recursive ls-tree output format:
-		 *     mode SP type SP sha1 TAB name
-		 */
-		mode = strtoul(ptr, &ntr, 8);
-		if (ptr == ntr || !ntr || *ntr != ' ')
-			die("input format error: %s", sb.buf);
-		ptr = ntr + 1; /* type */
-		ntr = strchr(ptr, ' ');
-		if (!ntr || sb.buf + sb.len <= ntr + 40 ||
-		    ntr[41] != '\t' ||
-		    get_sha1_hex(ntr + 1, sha1))
-			die("input format error: %s", sb.buf);
-		type = sha1_object_info(sha1, NULL);
-		if (type < 0)
-			die("object %s unavailable", sha1_to_hex(sha1));
-		*ntr++ = 0; /* now at the beginning of SHA1 */
-		if (type != type_from_string(ptr))
-			die("object type %s mismatch (%s)", ptr, typename(type));
-
-		path = ntr + 41;  /* at the beginning of name */
-		if (line_termination && path[0] == '"') {
-			strbuf_reset(&p_uq);
-			if (unquote_c_style(&p_uq, path, NULL)) {
-				die("invalid quoting");
-			}
-			path = p_uq.buf;
-		}
-
-		append_to_tree(mode, sha1, path);
-	}
-	strbuf_release(&p_uq);
+	while (strbuf_getline(&sb, stdin, line_termination) != EOF)
+		mktree_line(sb.buf, sb.len, line_termination);
+
 	strbuf_release(&sb);
 
 	write_tree(sha1);
-- 
1.6.3.9.g6345d

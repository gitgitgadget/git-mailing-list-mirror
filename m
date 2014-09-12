From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 3/6] Make sure fsck_commit_buffer() does not run out of
 the buffer
Date: Fri, 12 Sep 2014 10:07:59 +0200 (CEST)
Message-ID: <c69f1e2649fd0a79e8362702203633251bcc9ea4.1410509168.git.johannes.schindelin@gmx.de>
References: <cover.1410445430.git.johannes.schindelin@gmx.de> <cover.1410509168.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 12 10:08:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSLtw-0005EV-M5
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaILIII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:08:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:49706 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961AbaILIIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:08:02 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MUDXS-1XsEja1lyc-00QzuB;
 Fri, 12 Sep 2014 10:08:00 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1410509168.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:3AN0l3s0slfarck1Eby3vXK+pRMho8/fkWUGTPaa9m5TZZNnl+W
 SX3d5rzttvL/NF8KtHyjP9XHFwyfuSIHviiKRrWjNffGw4vNsD+aEd+l0bhT6miT4+lauG9
 5To6xlE+rupJDk8ILsaYpLKb+gjB+X+uUyH2Y74sSDMdk8eYmJOPGxbtondD+brjAMdJUG4
 ox5U+IHvLwYOM/tbE1hAA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256909>

So far, we assumed that the buffer is NUL terminated, but this is not
a safe assumption, now that we opened the fsck_object() API to pass a
buffer directly.

So let's make sure that there is at least an empty line in the buffer.
That way, our checks would fail if the empty line was encountered
prematurely, and consequently we can get away with the current string
comparisons even with non-NUL-terminated buffers are passed to
fsck_object().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fsck.c b/fsck.c
index dd77628..73da6f8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -237,6 +237,26 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
+static int require_end_of_header(const void *data, unsigned long size,
+	struct object *obj, fsck_error error_func)
+{
+	const char *buffer = (const char *)data;
+	unsigned long i;
+
+	for (i = 0; i < size; i++) {
+		switch (buffer[i]) {
+		case '\0':
+			return error_func(obj, FSCK_ERROR,
+				"unterminated header: NUL at offset %d", i);
+		case '\n':
+			if (i + 1 < size && buffer[i + 1] == '\n')
+				return 0;
+		}
+	}
+
+	return error_func(obj, FSCK_ERROR, "unterminated header");
+}
+
 static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
 {
 	char *end;
@@ -284,6 +304,9 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	unsigned parent_count, parent_line_count = 0;
 	int err;
 
+	if (require_end_of_header(buffer, size, &commit->object, error_func))
+		return -1;
+
 	if (!skip_prefix(buffer, "tree ", &buffer))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
-- 
2.0.0.rc3.9669.g840d1f9

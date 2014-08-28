From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 3/6] Make sure fsck_commit_buffer() does not run out of the
 buffer
Date: Thu, 28 Aug 2014 16:46:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1408281646450.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 28 16:47:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN0yh-0007Gp-0N
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbaH1Oqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:46:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:57550 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaH1Oqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 10:46:52 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LiWzQ-1WkfPp0nS0-00cjwS;
 Thu, 28 Aug 2014 16:46:49 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Fl4ybzxrOsp7qU5sbm5rCt7kn0BXuOL2md64bN5ODaaILWYu0c7
 2J/W02OWumKrLm0df/ihgssjTeUQ7lePFU+PpB58Ejwi5RZ6YBIVaIG8XmX3KuAdl2/3pYN
 UDCKV7RsPaktHl+CnycEIleCytE8w1SD14sCNFzCdzWQt5ZxSZAvbK7g9v6CNRQMSJ6a9r7
 Y7zLb9eDFYT81qfS9stEA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256085>

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
index dd77628..db6aaa4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -237,6 +237,26 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
+static int must_have_empty_line(const void *data, unsigned long size,
+	struct object *obj, fsck_error error_func)
+{
+	const char *buffer = (const char *)data;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		switch (buffer[i]) {
+		case '\0':
+			return error_func(obj, FSCK_ERROR,
+				"invalid message: NUL at offset %d", i);
+		case '\n':
+			if (i + 1 < size && buffer[i + 1] == '\n')
+				return 0;
+		}
+	}
+
+	return error_func(obj, FSCK_ERROR, "invalid buffer: missing empty line");
+}
+
 static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
 {
 	char *end;
@@ -284,6 +304,9 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 	unsigned parent_count, parent_line_count = 0;
 	int err;
 
+	if (must_have_empty_line(buffer, size, &commit->object, error_func))
+		return -1;
+
 	if (!skip_prefix(buffer, "tree ", &buffer))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
-- 
2.0.0.rc3.9669.g840d1f9

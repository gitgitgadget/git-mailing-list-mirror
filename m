From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Fix commit_tree() buffer leak
Date: Tue, 12 Aug 2008 00:35:11 +0200
Message-ID: <1218494111-13388-1-git-send-email-s-beyer@gmx.net>
Cc: Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 00:36:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSfzw-00054e-EC
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbYHKWfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbYHKWfS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:35:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:43305 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755568AbYHKWfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:35:16 -0400
Received: (qmail invoked by alias); 11 Aug 2008 22:35:14 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp025) with SMTP; 12 Aug 2008 00:35:14 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/D7SsdaejDIYI0PZyIhtRWaWwRCs3eA3kAFA30+j
	dT6rzz/YQEfeV4
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSfyp-0003Ub-Ah; Tue, 12 Aug 2008 00:35:11 +0200
X-Mailer: git-send-email 1.6.0.rc2.274.ga7606
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92013>

The commit_tree() strbuf has a minimum size of 8k and it has not been
released yet.  This patch releases the buffer.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
   Hi,

   I haven't checked if there really is some git command that
   calls commit_tree() several times, but for the case and for
   libification's sake this patch seemed useful.

   Regards,
     Stephan

 builtin-commit-tree.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 7a9a309..f773db5 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -48,6 +48,7 @@ static const char commit_utf8_warn[] =
 int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret)
 {
+	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
 
@@ -86,7 +87,9 @@ int commit_tree(const char *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
-	return write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
+	strbuf_release(&buffer);
+	return result;
 }
 
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
-- 
1.6.0.rc2.274.ga7606

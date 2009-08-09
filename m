From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 7/8] Allow helpers to report in "list" command that the ref
 is unchanged
Date: Sun, 9 Aug 2009 15:28:26 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908091527250.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 21:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaE4i-0005Sd-PG
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 21:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbZHIT21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 15:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbZHIT21
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 15:28:27 -0400
Received: from iabervon.org ([66.92.72.58]:33241 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbZHIT2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 15:28:25 -0400
Received: (qmail 12229 invoked by uid 1000); 9 Aug 2009 19:28:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2009 19:28:26 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125372>

Helpers may use a line like "? name unchanged" to specify that there
is nothing new at that name, without any git-specific code to
determine the correct response.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |    4 +++-
 transport-helper.c                   |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e9aa67e..2c5130f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -70,7 +70,9 @@ CAPABILITIES
 REF LIST ATTRIBUTES
 -------------------
 
-None are defined yet, but the caller must accept any which are supplied.
+'unchanged'::
+	This ref is unchanged since the last import or fetch, although
+	the helper cannot necessarily determine what value that produced.
 
 Documentation
 -------------
diff --git a/transport-helper.c b/transport-helper.c
index cd85edc..8134ff4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -166,6 +166,22 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static int has_attribute(const char *attrs, const char *attr) {
+	int len;
+	if (!attrs)
+		return 0;
+
+	len = strlen(attr);
+	for (;;) {
+		const char *space = strchrnul(attrs, ' ');
+		if (len == space - attrs && !strncmp(attrs, attr, len))
+			return 1;
+		if (!*space)
+			return 0;
+		attrs = space + 1;
+	}
+}
+
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
 	struct child_process *helper;
@@ -202,6 +218,12 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
 			get_sha1_hex(buf.buf, (*tail)->old_sha1);
+		if (eon) {
+			if (has_attribute(eon + 1, "unchanged")) {
+				(*tail)->status |= REF_STATUS_UPTODATE;
+				read_ref((*tail)->name, (*tail)->old_sha1);
+			}
+		}
 		tail = &((*tail)->next);
 	}
 	strbuf_release(&buf);
-- 
1.6.4.183.g77eb9.dirty

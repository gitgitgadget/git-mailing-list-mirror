From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] builtin-commit: fix reflog message generation
Date: Thu, 8 Nov 2007 12:15:26 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711081215140.4362@racer.site>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 08 13:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6IY-0007nB-RN
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758873AbXKHMPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757842AbXKHMPd
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:15:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:48922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758651AbXKHMPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:15:32 -0500
Received: (qmail invoked by alias); 08 Nov 2007 12:15:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp044) with SMTP; 08 Nov 2007 13:15:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bmDAqXl1b6A0UJ2vt6aIPCoqbOc5qCXtUW07j8C
	dyFvqJMg2QfO8e
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711081213580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64005>


Instead of strdup()ing, we can just reuse the buffer in which the
commit message is stored, and which is supposed to hold the reflog
message anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index f108e90..bba9b82 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -488,7 +488,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	int header_len, parent_count = 0;
 	struct strbuf sb;
 	const char *index_file, *reflog_msg;
-	char *nl, *header_line;
+	char *nl;
 	unsigned char commit_sha1[20];
 	struct ref_lock *ref_lock;
 
@@ -585,12 +585,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 					   0);
 
 	nl = strchr(sb.buf + header_len, '\n');
-	header_line = xstrndup(sb.buf + header_len,
-			       nl - (sb.buf + header_len));
-	strbuf_release(&sb);
-	strbuf_addf(&sb, "%s: %s\n", reflog_msg, header_line);
-	strbuf_addch(&sb, '\0');
-	free(header_line);
+	if (nl)
+		strbuf_setlen(&sb, nl + 1 - sb.buf);
+	else
+		strbuf_addch(&sb, '\n');
+	strbuf_remove(&sb, 0, header_len);
+	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
+	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
 	if (!ref_lock)
 		die("cannot lock HEAD ref");
-- 
1.5.3.5.1634.g0fa78

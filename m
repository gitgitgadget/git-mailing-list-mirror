From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 1/8] Use a clearer style to issue commands to remote
 helpers
Date: Sun, 9 Aug 2009 15:28:11 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908091526350.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 21:28:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaE42-0005Dq-IQ
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 21:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZHIT2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 15:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbZHIT2M
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 15:28:12 -0400
Received: from iabervon.org ([66.92.72.58]:33225 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbZHIT2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 15:28:10 -0400
Received: (qmail 12180 invoked by uid 1000); 9 Aug 2009 19:28:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2009 19:28:11 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125366>

This style is overkill for some commands, but it's worthwhile to use
the same style to issue all commands, and it's useful to avoid
open-coding string lengths.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

This is really a clarity improvement for the previous series, but it's
here to establish the nicer style before introducing more commands.

 transport-helper.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 43fdc0a..cb255e4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -37,7 +37,10 @@ static struct child_process *get_helper(struct transport *transport)
 		die("Unable to run helper: git %s", helper->argv[0]);
 	data->helper = helper;
 
-	write_in_full(data->helper->in, "capabilities\n", 13);
+	strbuf_addstr(&buf, "capabilities\n");
+	write_in_full(helper->in, buf.buf, buf.len);
+	strbuf_reset(&buf);
+
 	file = fdopen(helper->out, "r");
 	while (1) {
 		if (strbuf_getline(&buf, file, '\n') == EOF)
@@ -78,11 +81,12 @@ static int fetch_with_fetch(struct transport *transport,
 		const struct ref *posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
-		write_in_full(helper->in, "fetch ", 6);
-		write_in_full(helper->in, sha1_to_hex(posn->old_sha1), 40);
-		write_in_full(helper->in, " ", 1);
-		write_in_full(helper->in, posn->name, strlen(posn->name));
-		write_in_full(helper->in, "\n", 1);
+
+		strbuf_addf(&buf, "fetch %s %s\n",
+			    sha1_to_hex(posn->old_sha1), posn->name);
+		write_in_full(helper->in, buf.buf, buf.len);
+		strbuf_reset(&buf);
+
 		if (strbuf_getline(&buf, file, '\n') == EOF)
 			exit(128); /* child died, message supplied already */
 	}
@@ -119,7 +123,10 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 	FILE *file;
 
 	helper = get_helper(transport);
-	write_in_full(helper->in, "list\n", 5);
+
+	strbuf_addstr(&buf, "list\n");
+	write_in_full(helper->in, buf.buf, buf.len);
+	strbuf_reset(&buf);
 
 	file = fdopen(helper->out, "r");
 	while (1) {
-- 
1.6.4.183.g77eb9.dirty

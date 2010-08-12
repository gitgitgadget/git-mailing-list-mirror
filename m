From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Simplify send_git_request()
Date: Thu, 12 Aug 2010 18:25:23 +0300
Message-ID: <1281626723-20178-1-git-send-email-ilari.liusvaara@elisanet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 12 17:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjZbn-0003Tw-Tz
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 17:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab0HLPWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 11:22:14 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:54690 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab0HLPWO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 11:22:14 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 8FB4918D824
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:22:12 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00205498A1; Thu, 12 Aug 2010 18:22:12 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 685A127D86
	for <git@vger.kernel.org>; Thu, 12 Aug 2010 18:22:11 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.rc2.10.g714149
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153380>

Send_git_request() of remote-ext.c is more complicated than it needs to
be. Simplify it by using sprintf() and write_in_full().

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
 builtin/remote-ext.c |   54 +++++++------------------------------------------
 1 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index e9852ca..d861f0a 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -169,8 +169,6 @@ static void send_git_request(int stdin_fd, const char *serv, const char *repo,
 {
 	size_t bufferspace;
 	size_t wpos = 0;
-	size_t spos = 0;
-	size_t tmp;
 	char* buffer;
 
 	/*
@@ -186,53 +184,17 @@ static void send_git_request(int stdin_fd, const char *serv, const char *repo,
 		die("Request too large to send");
 	buffer = xmalloc(bufferspace);
 
-	/* Packet length. */
-	sprintf(buffer + wpos, "%04x", (unsigned)bufferspace);
-	wpos += 4;
+	/* Make the packet. */
+	wpos = sprintf(buffer, "%04x%s %s%c", (unsigned)bufferspace,
+		serv, repo, 0);
 
-	/* Service. */
-	tmp = strlen(serv);
-	memcpy(buffer + wpos, serv, tmp);
-	wpos += tmp;
-
-	/* Space. */
-	buffer[wpos++] = ' ';
-
-	/* Repo. */
-	tmp = strlen(repo);
-	memcpy(buffer + wpos, repo, tmp);
-	wpos += tmp;
-
-	/* NUL. */
-	buffer[wpos++] = '\0';
-
-	/* Vhost if any. */
-	if (vhost) {
-		/* Header name. */
-		strcpy(buffer + wpos, "host=");
-		wpos += 5;
-
-		/* Actual vhost */
-		tmp = strlen(vhost);
-		memcpy(buffer + wpos, vhost, tmp);
-		wpos += tmp;
-
-		/* NUL. */
-		buffer[wpos++] = '\0';
-	}
+	/* Add vhost if any. */
+	if (vhost)
+		sprintf(buffer + wpos, "host=%s%c", vhost, 0);
 
 	/* Send the request */
-	while (spos < wpos) {
-		ssize_t r;
-		r = write(stdin_fd, buffer + spos, wpos - spos);
-		if (r < 0 && errno != EINTR && errno != EAGAIN &&
-			errno != EWOULDBLOCK)
-			die_errno("Failed to send request");
-		else if (r < 0)
-			continue;	/* Try again. */
-		else
-			spos += r;
-	}
+	if (write_in_full(stdin_fd, buffer, bufferspace) < 0)
+		die_errno("Failed to send request");
 
 	free(buffer);
 }
-- 
1.7.2.1.9.g1ccab.dirty

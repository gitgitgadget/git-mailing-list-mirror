From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v2 02/16] pkt-line: Make packet_read_line easier to debug
Date: Mon, 12 Oct 2009 19:25:01 -0700
Message-ID: <1255400715-10508-3-git-send-email-spearce@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:34:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxXD8-0004cs-2j
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 04:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758818AbZJMCZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 22:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758802AbZJMCZz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 22:25:55 -0400
Received: from george.spearce.org ([209.20.77.23]:35584 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782AbZJMCZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 22:25:53 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 8F93138221; Tue, 13 Oct 2009 02:25:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D4321381FF
	for <git@vger.kernel.org>; Tue, 13 Oct 2009 02:25:16 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255400715-10508-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130105>

When there is an error parsing the 4 byte length component we now
NUL terminate the string and display it as part of the die message,
this may hint as to what data was misunderstood by the application.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pkt-line.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 2333d96..350f173 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -125,11 +125,13 @@ static int packet_length(unsigned *ret_len, const char *linelen)
 int packet_read_line(int fd, char *buffer, unsigned size)
 {
 	unsigned len;
-	char linelen[4];
+	char linelen[5];
 
 	safe_read(fd, linelen, 4);
-	if (packet_length(&len, linelen))
-		die("protocol error: bad line length character");
+	if (packet_length(&len, linelen)) {
+		linelen[4] = '\0';
+		die("protocol error: bad line length character: %s", linelen);
+	}
 	if (!len)
 		return 0;
 	len -= 4;
-- 
1.6.5.52.g0ff2e

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v3 02/17] pkt-line: Make packet_read_line easier to debug
Date: Wed, 14 Oct 2009 20:36:39 -0700
Message-ID: <1255577814-14745-3-git-send-email-spearce@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHFM-0007IV-3S
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762424AbZJODhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762414AbZJODhe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:37:34 -0400
Received: from george.spearce.org ([209.20.77.23]:33021 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762142AbZJODhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:37:33 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 6BEDB38265; Thu, 15 Oct 2009 03:36:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 59AF9381FF
	for <git@vger.kernel.org>; Thu, 15 Oct 2009 03:36:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130358>

When there is an error parsing the 4 byte length component we now
NUL terminate the string and display it as part of the die message,
this may hint as to what data was misunderstood by the application.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 pkt-line.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index bd603f8..893dd3c 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -124,12 +124,14 @@ static int packet_length(const char *linelen)
 int packet_read_line(int fd, char *buffer, unsigned size)
 {
 	int len;
-	char linelen[4];
+	char linelen[5];
 
 	safe_read(fd, linelen, 4);
 	len = packet_length(linelen);
-	if (len < 0)
-		die("protocol error: bad line length character");
+	if (len < 0) {
+		linelen[4] = '\0';
+		die("protocol error: bad line length character: %s", linelen);
+	}
 	if (!len)
 		return 0;
 	len -= 4;
-- 
1.6.5.52.g0ff2e

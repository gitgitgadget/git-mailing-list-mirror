From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to debug
Date: Wed, 28 Oct 2009 17:00:25 -0700
Message-ID: <1256774448-7625-4-git-send-email-spearce@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3IRp-0000RN-3x
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbZJ2AAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbZJ2AAr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:00:47 -0400
Received: from george.spearce.org ([209.20.77.23]:36220 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbZJ2AAq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:00:46 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 10A2238239; Thu, 29 Oct 2009 00:00:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 8FEA43811E
	for <git@vger.kernel.org>; Thu, 29 Oct 2009 00:00:49 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256774448-7625-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131515>

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
1.6.5.2.181.gd6f41

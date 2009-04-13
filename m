From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Do not fill paragraphs in the commit message viewer after any sob.
Date: Tue, 14 Apr 2009 01:26:10 +0200
Message-ID: <1239665170-24090-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Apr 14 01:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtVZG-0003CV-R5
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 01:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964AbZDMX0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 19:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbZDMX0O
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 19:26:14 -0400
Received: from mail.dewire.com ([83.140.172.130]:6452 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbZDMX0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 19:26:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CD82D14915DF;
	Tue, 14 Apr 2009 01:26:12 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWNaYKZ2puM9; Tue, 14 Apr 2009 01:26:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 07230148899B;
	Tue, 14 Apr 2009 01:26:12 +0200 (CEST)
X-Mailer: git-send-email 1.6.2.2.446.gfbdc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116503>

The fill-paragraph rules are ad-hoc and this seems like an improvement.
Sometimes we add strange extra tags after the sob lines, so don't
pretty-format these.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../ui/internal/history/CommitMessageViewer.java   |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
index d21555c..fc83782 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitMessageViewer.java
@@ -181,12 +181,18 @@ private void format() {
 		makeGrayText(d, styles);
 		d.append("\n");
 		String msg = commit.getFullMessage();
-		if (fill)
-			msg = msg.replaceAll("([\\w.; \t])\n(\\w)","$1 $2");
+		Pattern p = Pattern.compile("\n([A-Z](?:[A-Za-z]+-)+by: [^\n]+)");
+		if (fill) {
+			Matcher spm = p.matcher(msg);
+			if (spm.find()) {
+				String subMsg = msg.substring(0, spm.end());
+				msg = subMsg.replaceAll("([\\w.,; \t])\n(\\w)", "$1 $2")
+						+ msg.substring(spm.end());
+			}
+		}
 		int h0 = d.length();
 		d.append(msg);
 
-		Pattern p = Pattern.compile("\n([A-Z](?:[A-Za-z]+-)+by: [^\n]+)");
 		Matcher matcher = p.matcher(msg);
 		while (matcher.find()) {
 			styles.add(new StyleRange(h0 + matcher.start(), matcher.end()-matcher.start(), null,  null, SWT.ITALIC));
-- 
1.6.2.2.446.gfbdc0

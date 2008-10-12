From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [JGIT PATCH 2/4] jgit programs: Use i18n.logOutputEncoding or user's locale for output
Date: Mon, 13 Oct 2008 00:50:58 +0200
Message-ID: <1223851860-13068-3-git-send-email-robin.rosenberg@dewire.com>
References: <1223851860-13068-1-git-send-email-robin.rosenberg@dewire.com>
 <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Oct 13 00:54:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp9pB-0001nz-33
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 00:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbYJLWwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 18:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYJLWwy
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 18:52:54 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19062 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753914AbYJLWwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 18:52:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 892948026D0;
	Mon, 13 Oct 2008 00:52:52 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2DfCPjY52sbj; Mon, 13 Oct 2008 00:52:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 12AC18026D3;
	Mon, 13 Oct 2008 00:52:18 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2.308.gef4a
In-Reply-To: <1223851860-13068-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98064>

We should present the data in the user's locale to make it readable.

This prevents garbage from being displayed for user's whose locale is not
UTF-8, when non-ascii appears in most cases. If the characters cannot be
converted garbage will appear in any case.

When jgit gains the capability to present blob data this code must be
replaced to handle data and metadata differently.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
index a68d87c..d1bf9e0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
@@ -86,8 +86,15 @@ final void setCommandName(final String name) {
 
 	void init(final Repository repo) {
 		try {
-			out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(
-					System.out, "UTF-8")));
+			String outputEncoding = repo.getConfig().getString("i18n", null,
+					"logOutputEncoding");
+			System.out.println("Encoding = "+ outputEncoding);
+			if (outputEncoding != null)
+				out = new PrintWriter(new BufferedWriter(
+						new OutputStreamWriter(System.out, outputEncoding)));
+			else
+				out = new PrintWriter(new BufferedWriter(
+						new OutputStreamWriter(System.out)));
 		} catch (IOException e) {
 			throw die("cannot create output stream");
 		}
-- 
1.6.0.2.308.gef4a

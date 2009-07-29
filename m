From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 5/5] Include the file path when FileBasedConfig.load throws an exception
Date: Wed, 29 Jul 2009 08:50:27 -0700
Message-ID: <1248882627-7285-6-git-send-email-spearce@spearce.org>
References: <1248882627-7285-1-git-send-email-spearce@spearce.org>
 <1248882627-7285-2-git-send-email-spearce@spearce.org>
 <1248882627-7285-3-git-send-email-spearce@spearce.org>
 <1248882627-7285-4-git-send-email-spearce@spearce.org>
 <1248882627-7285-5-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBQp-0000Sa-0q
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 17:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131AbZG2Puf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 11:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbZG2Pue
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 11:50:34 -0400
Received: from george.spearce.org ([209.20.77.23]:45992 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbZG2Puc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 11:50:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 54C6938215; Wed, 29 Jul 2009 15:50:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 73C03381FE;
	Wed, 29 Jul 2009 15:50:30 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
In-Reply-To: <1248882627-7285-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124362>

This may help an end-user debug the problem, if they know what file
the error occurred in.  We have to wrap the exception here because
the methods throwing the original error do not have access to the
file path, and cannot include it in the message.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
index adf85c6..518b31d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/FileBasedConfig.java
@@ -98,6 +98,12 @@ public void load() throws IOException, ConfigInvalidException {
 			fromText(RawParseUtils.decode(NB.readFully(getFile())));
 		} catch (FileNotFoundException noFile) {
 			clear();
+		} catch (IOException e) {
+			final IOException e2 = new IOException("Cannot read " + getFile());
+			e2.initCause(e);
+			throw e2;
+		} catch (ConfigInvalidException e) {
+			throw new ConfigInvalidException("Cannot read " + getFile(), e);
 		}
 	}
 
-- 
1.6.4.rc3.201.gd9d59

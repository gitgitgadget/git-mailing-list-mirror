From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 04/23] New constructor without RefSpec for TrackingRefUpdate
Date: Sat, 28 Jun 2008 00:06:28 +0200
Message-ID: <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7b-0000rw-Oj
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbYF0WHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbYF0WHK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425AbYF0WHH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:07 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330044fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kab89P0JbzSs6mPgPRFHDXNIuH+7vLwDXWhDudHZPrA=;
        b=dLxVQV4ztONRIumfEjZdRmb35JyvaQ/C4LQdH1OL1jWuqKDLEuiWUwwLeJSeKSzEwi
         ylMifAOSQONXi/3/rh053/478aEbDWRJe1+YKV6nzsDQNLL73a6nin1yNQVowUU8r0EN
         901TsjHqQLVSIm/fnX7GK8ST7LuWMDIeEiwms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aZXOu5sY/umXDjq9C8MWNX4kT+AERcqjdRoMr3o35V/GizZEXfcTkDMFSORhHYL/Lr
         o3USnUzu59vodgBBZHUXfvmfg1mgTEuoUBY+Gf4EophRuJRooGDjxJcIexz3Lw27D+sL
         dmwSrMRZyAsi2UBwPct4qfk2thteD+a9D0rbU=
Received: by 10.86.60.15 with SMTP id i15mr667503fga.8.1214604426486;
        Fri, 27 Jun 2008 15:07:06 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 4sm3385022fge.5.2008.06.27.15.07.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86643>

New constructor operates directly on RefSpec components: remote name,
local name, force flag.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/TrackingRefUpdate.java  |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
index 771e77a..a84b38a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
@@ -55,9 +55,16 @@ public class TrackingRefUpdate {
 
 	TrackingRefUpdate(final Repository db, final RefSpec spec,
 			final AnyObjectId nv, final String msg) throws IOException {
-		remoteName = spec.getSource();
-		update = db.updateRef(spec.getDestination());
-		update.setForceUpdate(spec.isForceUpdate());
+		this(db, spec.getDestination(), spec.getSource(), spec.isForceUpdate(),
+				nv, msg);
+	}
+
+	TrackingRefUpdate(final Repository db, final String localName,
+			final String remoteName, final boolean forceUpdate,
+			final AnyObjectId nv, final String msg) throws IOException {
+		this.remoteName = remoteName;
+		update = db.updateRef(localName);
+		update.setForceUpdate(forceUpdate);
 		update.setNewObjectId(nv);
 		update.setRefLogMessage(msg, true);
 	}
-- 
1.5.5.3

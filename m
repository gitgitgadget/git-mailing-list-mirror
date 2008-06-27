From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 03/23] Refactor TrackingRefUpdate to not hold RefSpec
Date: Sat, 28 Jun 2008 00:06:27 +0200
Message-ID: <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7a-0000rw-Ug
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440AbYF0WHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756346AbYF0WHG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbYF0WHD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so330044fgg.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U3uKSjFlhhuKVONGrCJ8BRbbaZcbS2EUolIgUOgFI/4=;
        b=p6RaJTJ2hzfEMgWEEDaV9T5T7o/e4f9jgXHz6Fp4NsB9hiB70frTIIt0D+KkqSHmUx
         eFaZLPtwgU/aThfCZDlHEZXJ/n6HWTkvAneoFTHxnWhiH0Fhr7oCJSsDrIKnCOiUBuQg
         CfzTgGoXbL+ieHgz7KBygTCHQV2SRJfril/ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sXGQLf8/S2ZLNCdbU7yTwwmLZc6U29DII3gDIxwTePVFbt7PJLTCbIWmFO0kpy5DP4
         tZcL8V4E+ITdT6Kd8G1hAPqXgVEWvQS+vfY4nROIBwTpEYFEKhBaDdVWe4f30r3NAOzr
         k30HyCRZJBMIRFvuDPjWnxe+bxw39aUQiweDM=
Received: by 10.86.76.20 with SMTP id y20mr720042fga.53.1214604422698;
        Fri, 27 Jun 2008 15:07:02 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm3773061fgg.0.2008.06.27.15.07.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86644>

Just remoteName is needed, not a whole RefSpec.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/TrackingRefUpdate.java  |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
index 56234a1..771e77a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
@@ -49,14 +49,14 @@ import org.spearce.jgit.revwalk.RevWalk;
 
 /** Update of a locally stored tracking branch. */
 public class TrackingRefUpdate {
-	private final RefSpec spec;
+	private final String remoteName;
 
 	private final RefUpdate update;
 
-	TrackingRefUpdate(final Repository db, final RefSpec s,
+	TrackingRefUpdate(final Repository db, final RefSpec spec,
 			final AnyObjectId nv, final String msg) throws IOException {
-		spec = s;
-		update = db.updateRef(s.getDestination());
+		remoteName = spec.getSource();
+		update = db.updateRef(spec.getDestination());
 		update.setForceUpdate(spec.isForceUpdate());
 		update.setNewObjectId(nv);
 		update.setRefLogMessage(msg, true);
@@ -70,7 +70,7 @@ public class TrackingRefUpdate {
 	 * @return the name used within the remote repository.
 	 */
 	public String getRemoteName() {
-		return spec.getSource();
+		return remoteName;
 	}
 
 	/**
-- 
1.5.5.3

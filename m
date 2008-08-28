From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 3/3] Fix RemoteRefUpdate to delete local tracking ref upon successful deletion
Date: Thu, 28 Aug 2008 04:32:49 +0200
Message-ID: <1219890769-20119-4-git-send-email-marek.zawirski@gmail.com>
References: <1219890769-20119-1-git-send-email-marek.zawirski@gmail.com>
 <1219890769-20119-2-git-send-email-marek.zawirski@gmail.com>
 <1219890769-20119-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Thu Aug 28 04:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXL2-0007FK-D8
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbYH1CdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbYH1CdI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:33:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:4996 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbYH1CdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:33:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so131302fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S+bTgh75F4teXnvZl5jrYu6tVyj5uosjH6n3ptD9oXc=;
        b=yAGbyHepraZN6yeF6rSurSGXpp8N2YKezdDzsH5OSYl2vUCIdCSge/RTlEtd/Qnsiy
         eQFtv1FTzsDqwfMEFYn5l/Y8sLFstg3XgOO+H/rW99zYIoXmpjihA2sC5IvblRn3xQWc
         uQzn8Ims7o17Ev06nhzL8wZmEhjg/wayvXGtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rjVRVJ9cNEd0hkqlBjbNByr2m5NwrDCANvf7Mh3MTLVK6p2RTFgaelSPLQhcy8MZp1
         yLrRGjDBDti7KIcRTjewVlegS1nDy2XBe0td/rToat4ddKRd40obhOiHHmNXqyAmgnEl
         Aa7WRaBB7NakoLZA9VcL3tmu3p1MENuLX7UNs=
Received: by 10.86.4.2 with SMTP id 2mr602270fgd.63.1219890784485;
        Wed, 27 Aug 2008 19:33:04 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id 3sm471906fge.3.2008.08.27.19.33.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 19:33:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219890769-20119-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94024>

When remote ref update specification is a deletion, local tracking ref
should also be deleted, not updated.

Reported-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../spearce/jgit/transport/RemoteRefUpdate.java    |    5 ++++-
 .../spearce/jgit/transport/TrackingRefUpdate.java  |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
index 623599f..c79f7dc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteRefUpdate.java
@@ -336,6 +336,9 @@ protected void setMessage(final String message) {
 	 *             when I/O error occurred during update
 	 */
 	protected void updateTrackingRef(final RevWalk walk) throws IOException {
-		trackingRefUpdate.update(walk);
+		if (isDelete())
+			trackingRefUpdate.delete(walk);
+		else
+			trackingRefUpdate.update(walk);
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
index a84b38a..ac74728 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TrackingRefUpdate.java
@@ -127,4 +127,8 @@ public Result getResult() {
 	void update(final RevWalk walk) throws IOException {
 		update.update(walk);
 	}
+
+	void delete(final RevWalk walk) throws IOException {
+		update.delete(walk);
+	}
 }
-- 
1.5.6.3

From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 07/20] Refactor PackIndexV2 - extract binarySearchLevelTwo()
Date: Sun, 15 Jun 2008 23:45:36 +0200
Message-ID: <1213566349-25395-8-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-5-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-6-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804m-0001nA-TD
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbYFOVq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYFOVq1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:29549 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbYFOVqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:23 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958539ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=A3XC8Zl1HhWh6CxJwYc46TAqIq0XI4dVkYC2oUKwKhw=;
        b=wFKpgIZ7Yb8D13h3W/ZwJjmnoY4FUyExYGhBVWP47OEbfLy7dHdyE/tO6lznOhMCe5
         mtmIAJCQh3LOB/0wibRqkbXou6jAJeX3Pj7yjShrQ6OZb6zwyE7X2a17mho7gH6+drbC
         NiOHKT9Q+DzYEN0Os1MmRSdDGt+RQTZ28aFGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RTh9dtQpGjnA4I5Qp5igLNrYqKknQ83kH3tUk4NFJbt6IcJdA0zUBnJF2r5mPcbca3
         UuZaaJyUNspNT89EWqVphEo6qLsTs16YOT4arTjhubVTcOByjlMyt0NpLLocC23eppv5
         O92qHiv4zWUFD4wLJvfPjHwFUsCRj+M3ipgOE=
Received: by 10.150.145.20 with SMTP id s20mr9420773ybd.242.1213566382993;
        Sun, 15 Jun 2008 14:46:22 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm15709230qbw.2.2008.06.15.14.46.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:22 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-7-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85132>

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   23 +++++++++++++-------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index ae70f11..a0b9827 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -153,6 +153,20 @@ class PackIndexV2 extends PackIndex {
 	@Override
 	long findOffset(final AnyObjectId objId) {
 		final int levelOne = objId.getFirstByte();
+		final int levelTwo = binarySearchLevelTwo(objId, levelOne);
+		if (levelTwo == -1)
+			return -1;
+		final long p = NB.decodeUInt32(offset32[levelOne], levelTwo << 2);
+		if ((p & IS_O64) != 0)
+			return NB.decodeUInt64(offset64, (8 * (int) (p & ~IS_O64)));
+		return p;
+	}
+
+	public Iterator<MutableEntry> iterator() {
+		return new EntriesIteratorV2();
+	}
+
+	private int binarySearchLevelTwo(final AnyObjectId objId, final int levelOne) {
 		final int[] data = names[levelOne];
 		int high = offset32[levelOne].length >> 2;
 		if (high == 0)
@@ -167,20 +181,13 @@ class PackIndexV2 extends PackIndex {
 			if (cmp < 0)
 				high = mid;
 			else if (cmp == 0) {
-				final long p = NB.decodeUInt32(offset32[levelOne], mid4);
-				if ((p & IS_O64) != 0)
-					return NB.decodeUInt64(offset64, (8 * (int) (p & ~IS_O64)));
-				return p;
+				return mid;
 			} else
 				low = mid + 1;
 		} while (low < high);
 		return -1;
 	}
 
-	public Iterator<MutableEntry> iterator() {
-		return new EntriesIteratorV2();
-	}
-
 	private class EntriesIteratorV2 extends EntriesIterator {
 		private int levelOne;
 
-- 
1.5.5.1

From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Method invokes inefficient Number constructor; use static
 valueOf instead
Date: Thu, 19 Mar 2009 10:14:59 +0100
Message-ID: <49C20D13.2050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 19 10:16:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkEMg-00021a-09
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 10:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbZCSJPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 05:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZCSJPH
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 05:15:07 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:48969 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbZCSJPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 05:15:05 -0400
Received: by ewy9 with SMTP id 9so323239ewy.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 02:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ey5fCRTCg5HqXEGA+0Dim34gTpX4E6Baw9GPm+AcJqA=;
        b=JvRRVO8dCiokzzp58n50+uva7x3z0zJ3z6lCdz2b6ppzrVAo4JgtqdyoY46ksV7w32
         5koWsqBP/bME5fX9pmX2zzXqMRWERx8J+O9DZ8xANBML8pQiwy+icJ+4vQUp8BLw2pLg
         b/avvUTwfZURpktdND/U13uYngo9wQi5y6bP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=WcRpk7OiS6hEvZ7LXo4j4cAyfxV7hbbYuWQVkNpPTC1Zb8zYJoaKq40iYYVyGK26gQ
         cURGuanGtm8PRPp04XFmGTVZkgTkCYoRqVFoO6GTR7uYwxCmJvJ0IOcLE2boBITZ/XYK
         8KPaHpLikfS158Ma5d+kHkcKbrrXSCxpf2clU=
Received: by 10.210.112.4 with SMTP id k4mr1744677ebc.0.1237454101663;
        Thu, 19 Mar 2009 02:15:01 -0700 (PDT)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 10sm960850eyz.59.2009.03.19.02.15.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Mar 2009 02:15:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113738>

>From FindBugs:
Using new Integer(int) is guaranteed to always result in a new object
whereas Integer.valueOf(int) allows caching of values to be done by the
compiler, class library, or JVM. Using of cached values avoids object
allocation and the code will be faster.
Values between -128 and 127 are guaranteed to have corresponding cached
instances and using valueOf is approximately 3.5 times faster than using
constructor. For values outside the constant range the performance of
both styles is the same.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../jgit/errors/NoClosingBracketException.java     |    4 ++--
 .../src/org/spearce/jgit/transport/IndexPack.java  |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java
index 8fe9ab1..b325b45 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/NoClosingBracketException.java
@@ -64,7 +64,7 @@ super(createMessage(indexOfOpeningBracket, openingBracket,
 	private static String createMessage(final int indexOfOpeningBracket,
 			final String openingBracket, final String closingBracket) {
 		return String.format("No closing %s found for %s at index %s.",
-				closingBracket, openingBracket, new Integer(
-						indexOfOpeningBracket));
+				closingBracket, openingBracket,
+				Integer.valueOf(indexOfOpeningBracket));
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
index e0e4855..04ef59d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/IndexPack.java
@@ -383,7 +383,7 @@ private void resolveDeltas(final ProgressMonitor progress)
 	private void resolveDeltas(final PackedObjectInfo oe) throws IOException {
 		final int oldCRC = oe.getCRC();
 		if (baseById.containsKey(oe)
-				|| baseByPos.containsKey(new Long(oe.getOffset())))
+				|| baseByPos.containsKey(Long.valueOf(oe.getOffset())))
 			resolveDeltas(oe.getOffset(), oldCRC, Constants.OBJ_BAD, null, oe);
 	}
 
@@ -448,7 +448,7 @@ private void resolveDeltas(final long pos, final int oldCRC, int type,
 	private void resolveChildDeltas(final long pos, int type, byte[] data,
 			PackedObjectInfo oe) throws IOException {
 		final ArrayList<UnresolvedDelta> a = baseById.remove(oe);
-		final ArrayList<UnresolvedDelta> b = baseByPos.remove(new Long(pos));
+		final ArrayList<UnresolvedDelta> b = baseByPos.remove(Long.valueOf(pos));
 		int ai = 0, bi = 0;
 		if (a != null && b != null) {
 			while (ai < a.size() && bi < b.size()) {
@@ -679,7 +679,7 @@ private void indexOneObject() throws IOException {
 				ofs <<= 7;
 				ofs += (c & 127);
 			}
-			final Long base = new Long(pos - ofs);
+			final Long base = Long.valueOf(pos - ofs);
 			ArrayList<UnresolvedDelta> r = baseByPos.get(base);
 			if (r == null) {
 				r = new ArrayList<UnresolvedDelta>(8);
-- 
1.6.1.2

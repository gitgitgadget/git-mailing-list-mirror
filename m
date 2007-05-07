From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 05/10] Speed up ObjectId a little.
Date: Mon, 07 May 2007 23:29:39 +0200
Message-ID: <20070507212939.21546.80786.stgit@lathund.dewire.com>
References: <20070507212636.21546.29280.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 07 23:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlAmd-0003ym-VU
	for gcvg-git@gmane.org; Mon, 07 May 2007 23:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966802AbXEGVaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 17:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966608AbXEGVaH
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 17:30:07 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12253 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S966802AbXEGVaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 17:30:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 453EE8028B2;
	Mon,  7 May 2007 23:23:56 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24643-10; Mon,  7 May 2007 23:23:55 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id D3F9E800783;
	Mon,  7 May 2007 23:23:55 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 767CB2926D;
	Mon,  7 May 2007 23:30:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id fcqFdt4i-Zsh; Mon,  7 May 2007 23:29:47 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 92DF3294E6;
	Mon,  7 May 2007 23:29:39 +0200 (CEST)
In-Reply-To: <20070507212636.21546.29280.stgit@lathund.dewire.com>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46487>

ObjectId size if fixed so we can exploit this fact.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 .../src/org/spearce/jgit/lib/ObjectId.java         |   29 ++++++++++++++---------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 45e23e6..fea0d91 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -86,7 +86,7 @@ public class ObjectId implements Comparable {
 	private static int compare(final byte[] a, final byte[] b) {
 		if (a==b)
 			return 0;
-		for (int k = 0; k < a.length && k < b.length; k++) {
+		for (int k = 0; k < Constants.OBJECT_ID_LENGTH; k++) {
 			final int ak = a[k] & 0xff;
 			final int bk = b[k] & 0xff;
 			if (ak < bk)
@@ -94,7 +94,11 @@ public class ObjectId implements Comparable {
 			else if (ak > bk)
 				return 1;
 		}
-		return a.length == b.length ? 0 : a.length < b.length ? -1 : 1;
+		if (a.length != Constants.OBJECT_ID_LENGTH)
+			throw new IllegalArgumentException("Looks like a bad object id");
+		if (b.length != Constants.OBJECT_ID_LENGTH)
+			throw new IllegalArgumentException("Looks like a bad object id");
+		return 0;
 	}
 
 	private final byte[] id;
@@ -106,9 +110,11 @@ public class ObjectId implements Comparable {
 		}
 
 		id = new byte[Constants.OBJECT_ID_LENGTH];
+		char[] bs = new char[Constants.OBJECT_ID_LENGTH*2];
+		i.getChars(0,Constants.OBJECT_ID_LENGTH*2,bs,0);
 		for (int j = 0, k = 0; k < Constants.OBJECT_ID_LENGTH; k++) {
-			final char c1 = i.charAt(j++);
-			final char c2 = i.charAt(j++);
+			final char c1 = bs[j++];
+			final char c2 = bs[j++];
 			int b;
 
 			if ('0' <= c1 && c1 <= '9') {
@@ -181,7 +187,7 @@ public class ObjectId implements Comparable {
 	}
 
 	public void copyTo(final OutputStream w) throws IOException {
-		for (int k = 0; k < id.length; k++) {
+		for (int k = 0; k < Constants.OBJECT_ID_LENGTH; k++) {
 			final int b = id[k];
 			final int b1 = (b >> 4) & 0xf;
 			final int b2 = b & 0xf;
@@ -191,7 +197,7 @@ public class ObjectId implements Comparable {
 	}
 
 	public void copyTo(final Writer w) throws IOException {
-		for (int k = 0; k < id.length; k++) {
+		for (int k = 0; k < Constants.OBJECT_ID_LENGTH; k++) {
 			final int b = id[k];
 			final int b1 = (b >> 4) & 0xf;
 			final int b2 = b & 0xf;
@@ -201,14 +207,15 @@ public class ObjectId implements Comparable {
 	}
 
 	public String toString() {
-		final StringBuffer r = new StringBuffer(2 * id.length);
-		for (int k = 0; k < id.length; k++) {
+		byte s[] = new byte[Constants.OBJECT_ID_LENGTH*2];
+		int i = 0;
+		for (int k = 0; k < Constants.OBJECT_ID_LENGTH; k++) {
 			final int b = id[k];
 			final int b1 = (b >> 4) & 0xf;
 			final int b2 = b & 0xf;
-			r.append(b1 < 10 ? (char) ('0' + b1) : (char) ('a' + b1 - 10));
-			r.append(b2 < 10 ? (char) ('0' + b2) : (char) ('a' + b2 - 10));
+			s[i++] = (b1 < 10 ? (byte) ('0' + b1) : (byte) ('a' + b1 - 10));
+			s[i++] = (b2 < 10 ? (byte) ('0' + b2) : (byte) ('a' + b2 - 10));
 		}
-		return r.toString();
+		return new String(s,0);
 	}
 }

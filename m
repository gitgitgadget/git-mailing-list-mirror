From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH JGIT 1/2] Calculate CRC32 on Pack Index v2
Date: Wed, 25 Mar 2009 14:21:54 +0800
Message-ID: <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com>
References: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com>
Cc: git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 07:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmMWb-0003wL-H7
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 07:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753860AbZCYGWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 02:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753762AbZCYGWF
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 02:22:05 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:47396 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbZCYGWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 02:22:02 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3871137wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 23:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=kYU2Bc8/ljMrE5RrS0PQL/Br2xjMlVrmN0baF7xGexg=;
        b=Z5krz2L/VG48IE71yl6fB3qiQKoWspnceC76xamkZTZVfQHVcVrTnl/lYnW7SXKaY+
         X4mQDTo9YrSJacrsaClA1wV1gPRtqNRuM/ohXeTtHXhl6/39HJ72OJLA6PJ6cZam7DZi
         EDRC5NrFcxmz88wa01p/uz9nzIM4PKuJn8A5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=B/QsF4wmvlIHa6hrxKawdUDyfDDK577N00JLD/Glsa5AP4WcYVQsgAHIe7YP5AsnA7
         z55kTFEO9cNvLCkyPyOzyf9G4cPrmVV3yyJpKAeEHVcurL0uiPYAAAvYMZuU2GKVDX6h
         cVXdBMNrJknBpUTPN6Ms8Z9mMG5Xw5Y77z8H8=
Received: by 10.143.32.7 with SMTP id k7mr3764321wfj.162.1237962120604;
        Tue, 24 Mar 2009 23:22:00 -0700 (PDT)
Received: from localhost.localdomain ([116.49.52.167])
        by mx.google.com with ESMTPS id 30sm15182156wfg.54.2009.03.24.23.21.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 23:22:00 -0700 (PDT)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114567>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackWriter.java       |    2 +
 .../spearce/jgit/util/CountingOutputStream.java    |   32 +++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
index 601ce71..d8b50e6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
@@ -687,11 +687,13 @@ public class PackWriter {
 
 		assert !otp.isWritten();
 
+		countingOut.resetCRC32();
 		otp.setOffset(countingOut.getCount());
 		if (otp.isDeltaRepresentation())
 			writeDeltaObject(otp);
 		else
 			writeWholeObject(otp);
+		otp.setCRC((int) countingOut.getCRC32());
 
 		writeMonitor.update(1);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
index b0b5f7d..b4ae915 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/CountingOutputStream.java
@@ -40,12 +40,16 @@ package org.spearce.jgit.util;
 import java.io.FilterOutputStream;
 import java.io.IOException;
 import java.io.OutputStream;
+import java.util.zip.CRC32;
 
 /**
- * Counting output stream decoration. Counts bytes written to stream.
+ * Counting output stream decoration. Counts bytes written to stream and 
+ * calculate CRC32 checksum.
  */
 public class CountingOutputStream extends FilterOutputStream {
 	private long count;
+	
+	private CRC32 crc;
 
 	/**
 	 * Create counting stream being decorated to provided real output stream.
@@ -55,6 +59,7 @@ public class CountingOutputStream extends FilterOutputStream {
 	 */
 	public CountingOutputStream(OutputStream out) {
 		super(out);
+		crc = new CRC32();
 	}
 
 	@Override
@@ -79,10 +84,35 @@ public class CountingOutputStream extends FilterOutputStream {
 		return count;
 	}
 
+    /**
+     * Resets CRC-32 to initial value.
+     */
+	public void resetCRC32() {
+		crc.reset();
+	}
+
+    /**
+     * Returns CRC-32 value.
+     * @return CRC32
+     */
+	public long getCRC32() {
+		return crc.getValue();
+	}
+
+
 	/**
 	 * Reset counter to zero value.
 	 */
 	public void reset() {
 		count = 0;
+		crc.reset();
+	}
+	
+	/**
+	 * {@inheritDoc}
+	 */
+	public void close() throws IOException {
+		crc = null;
+		super.close();
 	}
 }
-- 
1.6.2

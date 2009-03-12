From: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
Subject: [PATCH JGIT] Allow writeObject() write to OutputStream
Date: Thu, 12 Mar 2009 16:02:10 +0800
Message-ID: <1236844931-12807-1-git-send-email-j16sdiz+freenet@gmail.com>
Cc: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 09:04:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhftb-0001Rw-6j
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 09:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbZCLICV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 04:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbZCLICU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 04:02:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:40433 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbZCLICS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 04:02:18 -0400
Received: by wa-out-1112.google.com with SMTP id v33so262544wah.21
        for <git@vger.kernel.org>; Thu, 12 Mar 2009 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=ElccPAviCodZe8nVw/oTf2KbcdIu7fi+2OnGt03gYEc=;
        b=JUiiLqOIEJOsKyVAykc0G3Q8Xl9K02m1iZ3WoRcSgOnEVPH0L83vfg6vQBDcfgXeEJ
         XtXIq65ek40RLClDGgb5SeGFJbehspbRpa2ZHHkWrSn32PZ/9YwWa79qmLfTm2A00G1N
         r47fU4k1VuLx/1QQCepSxxe5Scaw8vhit17XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=eRn40zvJ3S7WFh3GyxIjYGUUYHDSgAcyuWBeTeK6PnSzOcQdOyteEjMWhaBqcn7mjb
         Iu9bVcWOVXSxfZlazSOvt4OpFNV5TDqhXNn7xQVFW3F+aGbBoNVIwvZJn+n+OuUuzFoq
         GfXrs97eV8jjvRv8zYY0mKNPn2/xBLsQMCr6c=
Received: by 10.114.193.15 with SMTP id q15mr5847285waf.199.1236844935874;
        Thu, 12 Mar 2009 01:02:15 -0700 (PDT)
Received: from localhost.localdomain ([116.49.52.167])
        by mx.google.com with ESMTPS id n40sm352830wag.48.2009.03.12.01.02.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Mar 2009 01:02:15 -0700 (PDT)
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113019>


Signed-off-by: Daniel Cheng (aka SDiZ) <j16sdiz+freenet@gmail.com>
---

This patch make factor out the object writing code in ObjectWriter,
allow it to write to any OutputStream. 
Subclass class may then override
  writeObject(final int type, long len, InputStream is, boolean store)
to make it write to alternative locations.

There are some discussion on devl@freenetproject.org to use raw 
(uncompressed) object to freenet. This patch allow the testing.

 .../src/org/spearce/jgit/lib/ObjectWriter.java     |   93 +++++++++++---------
 1 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
index 546cc68..97acae4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectWriter.java
@@ -45,6 +45,7 @@
 import java.io.FileOutputStream;
 import java.io.IOException;
 import java.io.InputStream;
+import java.io.OutputStream;
 import java.io.OutputStreamWriter;
 import java.security.MessageDigest;
 import java.util.zip.Deflater;
@@ -297,8 +298,52 @@ public ObjectId computeBlobSha1(final long len, final InputStream is)
 		return writeObject(Constants.OBJ_BLOB, len, is, false);
 	}
 
-	ObjectId writeObject(final int type, long len, final InputStream is,
-			boolean store) throws IOException {
+	protected ObjectId writeObject(final int type, long len,
+			final InputStream is, final OutputStream deflateStream)
+			throws IOException {
+		md.reset();
+
+		byte[] header;
+		int n;
+
+		header = Constants.encodedTypeString(type);
+		md.update(header);
+		if (deflateStream != null)
+			deflateStream.write(header);
+
+		md.update((byte) ' ');
+		if (deflateStream != null)
+			deflateStream.write((byte) ' ');
+
+		header = Constants.encodeASCII(len);
+		md.update(header);
+		if (deflateStream != null)
+			deflateStream.write(header);
+
+		md.update((byte) 0);
+		if (deflateStream != null)
+			deflateStream.write((byte) 0);
+
+		while (len > 0
+				&& (n = is.read(buf, 0, (int) Math.min(len, buf.length))) > 0) {
+			md.update(buf, 0, n);
+			if (deflateStream != null)
+				deflateStream.write(buf, 0, n);
+			len -= n;
+		}
+
+		if (len != 0)
+			throw new IOException("Input did not match supplied length. " + len
+					+ " bytes are missing.");
+
+		if (deflateStream != null)
+			deflateStream.close();
+
+		return ObjectId.fromRaw(md.digest());
+	}
+
+	protected ObjectId writeObject(final int type, long len,
+			final InputStream is, boolean store) throws IOException {
 		final File t;
 		final DeflaterOutputStream deflateStream;
 		final FileOutputStream fileStream;
@@ -312,7 +357,6 @@ ObjectId writeObject(final int type, long len, final InputStream is,
 			fileStream = null;
 		}
 
-		md.reset();
 		if (store) {
 			def.reset();
 			deflateStream = new DeflaterOutputStream(fileStream, def);
@@ -320,46 +364,9 @@ ObjectId writeObject(final int type, long len, final InputStream is,
 			deflateStream = null;
 
 		try {
-			byte[] header;
-			int n;
-
-			header = Constants.encodedTypeString(type);
-			md.update(header);
-			if (deflateStream != null)
-				deflateStream.write(header);
-
-			md.update((byte) ' ');
-			if (deflateStream != null)
-				deflateStream.write((byte) ' ');
-
-			header = Constants.encodeASCII(len);
-			md.update(header);
-			if (deflateStream != null)
-				deflateStream.write(header);
-
-			md.update((byte) 0);
-			if (deflateStream != null)
-				deflateStream.write((byte) 0);
-
-			while (len > 0
-					&& (n = is.read(buf, 0, (int) Math.min(len, buf.length))) > 0) {
-				md.update(buf, 0, n);
-				if (deflateStream != null)
-					deflateStream.write(buf, 0, n);
-				len -= n;
-			}
-
-			if (len != 0)
-				throw new IOException("Input did not match supplied length. "
-						+ len + " bytes are missing.");
-
-			if (deflateStream != null ) {
-				deflateStream.close();
-				if (t != null)
-					t.setReadOnly();
-			}
-
-			id = ObjectId.fromRaw(md.digest());
+			id = writeObject(type, len, is, deflateStream);
+			if (t != null)
+				t.setReadOnly();
 		} finally {
 			if (id == null && deflateStream != null) {
 				try {
-- 
1.6.2

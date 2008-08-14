From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 4/7] Extract lockAndWriteFile method in RefDatabase for reuse
Date: Thu, 14 Aug 2008 20:13:46 +1000
Message-ID: <1218708829-8175-5-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218708829-8175-2-git-send-email-charleso@charleso.org>
 <1218708829-8175-3-git-send-email-charleso@charleso.org>
 <1218708829-8175-4-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZs4-0003J8-PM
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbYHNKO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYHNKO3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:44651 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642AbYHNKO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so333673rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=Yz2ss22v/MDZNeE5aaTyROzzMyTR8PKaHfhYcoK3J08=;
        b=RDylYAWmPlnLWMRS2uA1653ytmfcdB+pUj4zOflfbtly7Xr3dWFCQw+uVNTWV3VpVa
         iZU49Eoh3lW3/q4y/iUBMK3GGqxRX8yDJT59A5LfF7J9XPDcL8pQD6MvHHmsT7PlgwgM
         mGQ1Y8BjLQ1HDmcJrP7pSWXcb/bwvIFBqKl2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=Fkaovv8lc5OXLESMcn7/JCkOJGT45j40P5iTflXKjygstgkXH6Bhwo52XGAfpUNlJD
         mspMLrf3exg1YLLxz1jMynoFLFzXseJnzPH9O7zkrhxHeqkb4bTJmM5YIr7rnuBu6q4D
         p3TLl/MfGky6fa4jdYtTjmmMLjUyXvSTBOBcQ=
Received: by 10.114.154.12 with SMTP id b12mr944941wae.153.1218708866078;
        Thu, 14 Aug 2008 03:14:26 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:25 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-4-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92347>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   25 ++++++++++++--------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 3e68a8d..3d8280d 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -158,16 +158,7 @@ class RefDatabase {
 	 */
 	void link(final String name, final String target) throws IOException {
 		final byte[] content = ("ref: " + target + "\n").getBytes(CHAR_ENC);
-		final LockFile lck = new LockFile(fileForRef(name));
-		if (!lck.lock())
-			throw new ObjectWritingException("Unable to lock " + name);
-		try {
-			lck.write(content);
-		} catch (IOException ioe) {
-			throw new ObjectWritingException("Unable to write " + name, ioe);
-		}
-		if (!lck.commit())
-			throw new ObjectWritingException("Unable to write " + name);
+		lockAndWriteFile(fileForRef(name), content);
 		setModified();
 		db.fireRefsMaybeChanged();
 	}
@@ -427,6 +418,20 @@ class RefDatabase {
 		}
 	}
 
+	private void lockAndWriteFile(File file, byte[] content) throws IOException {
+		String name = file.getName();
+		final LockFile lck = new LockFile(file);
+		if (!lck.lock())
+			throw new ObjectWritingException("Unable to lock " + name);
+		try {
+			lck.write(content);
+		} catch (IOException ioe) {
+			throw new ObjectWritingException("Unable to write " + name, ioe);
+		}
+		if (!lck.commit())
+			throw new ObjectWritingException("Unable to write " + name);
+	}
+
 	private static String readLine(final File file)
 			throws FileNotFoundException, IOException {
 		final BufferedReader br = openReader(file);
-- 
1.6.0.rc2.35.g04c6e

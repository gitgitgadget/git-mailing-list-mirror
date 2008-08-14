From: Charles O'Farrell <charleso@charleso.org>
Subject: [PATCH 5/7] Added removePackedRef method to RefDatabase for packed branch deletion
Date: Thu, 14 Aug 2008 20:13:47 +1000
Message-ID: <1218708829-8175-6-git-send-email-charleso@charleso.org>
References: <1218708829-8175-1-git-send-email-charleso@charleso.org>
 <1218708829-8175-2-git-send-email-charleso@charleso.org>
 <1218708829-8175-3-git-send-email-charleso@charleso.org>
 <1218708829-8175-4-git-send-email-charleso@charleso.org>
 <1218708829-8175-5-git-send-email-charleso@charleso.org>
Cc: Charles O'Farrell <charleso@charleso.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 12:16:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTZsA-0003J8-Eh
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 12:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741AbYHNKOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 06:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbYHNKOc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 06:14:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:50988 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741AbYHNKOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 06:14:31 -0400
Received: by wa-out-1112.google.com with SMTP id j37so199004waf.23
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender;
        bh=EntYLk9mJr5hOGFAAprWxcnza0kxyCGYf56sMFQ4Bmw=;
        b=WvFRzg1Vc/q3keVzJhuuTQrVh66OuhM+S6pDLGUWgcV9y8BpESEz6SR+5HsDWdLVk4
         ivpnPrxBR0mfAtW1mqzXg21O5QgLaGqWxu5skIELoKWjUGt6/C9Nb6uajURWcVd8JRGb
         cSQB7kyNOuOnZEmOFIk4wqcHOx71OkmFD3yb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :sender;
        b=vUh3V7ZqH0fFbRR/Qn6WcZ3V0bpBDUcchMatAhccvJ6I1QixspYdDjifq+cQju0143
         JupYuP81qSldLPS6KnPnIJ7+KqQCvJGnaA6XaxRtqYLIqNLFNGT1PwUoOgThoFlZLJjZ
         Bn7b74Xm575mhC2ZviFUnZ9QZHCEodPAcNu14=
Received: by 10.114.166.1 with SMTP id o1mr943543wae.119.1218708870809;
        Thu, 14 Aug 2008 03:14:30 -0700 (PDT)
Received: from localhost.localdomain ( [123.200.240.102])
        by mx.google.com with ESMTPS id a8sm2909044poa.12.2008.08.14.03.14.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 03:14:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e
In-Reply-To: <1218708829-8175-5-git-send-email-charleso@charleso.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92350>

Signed-off-by: Charles O'Farrell <charleso@charleso.org>
---
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   16 +++++++++++++++-
 .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 3d8280d..0293ace 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -121,7 +121,7 @@ class RefDatabase {
 	}
 
 	/**
-	 * Create a command to update (or create) a ref in this repository.
+	 * Create a command to update, create or delete a ref in this repository.
 	 * 
 	 * @param name
 	 *            name of the ref the caller wants to modify.
@@ -432,6 +432,20 @@ class RefDatabase {
 			throw new ObjectWritingException("Unable to write " + name);
 	}
 
+	void removePackedRef(String name) throws IOException {
+		packedRefs.remove(name);
+		writePackedRefs();
+	}
+
+	private void writePackedRefs() throws IOException {
+		new RefWriter(packedRefs.values()) {
+			@Override
+			protected void writeFile(String name, byte[] content) throws IOException {
+				lockAndWriteFile(new File(db.getDirectory(), name), content);
+			}
+		}.writePackedRefs();
+	}
+
 	private static String readLine(final File file)
 			throws FileNotFoundException, IOException {
 		final BufferedReader br = openReader(file);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 6f7961e..7679e53 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -493,7 +493,7 @@ public class Repository {
 	}
 
 	/**
-	 * Create a command to update (or create) a ref in this repository.
+	 * Create a command to update, create or delete a ref in this repository.
 	 * 
 	 * @param ref
 	 *            name of the ref the caller wants to modify.
-- 
1.6.0.rc2.35.g04c6e

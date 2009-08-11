From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: [JGIT PATCH] Improve error handling for writing FETCH_HEAD
Date: Tue, 11 Aug 2009 07:48:06 +0200
Message-ID: <1249969686-11232-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Aug 11 16:23:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MasGU-0001V1-GY
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 16:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbZHKOXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 10:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753878AbZHKOXh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 10:23:37 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:53590 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbZHKOXg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 10:23:36 -0400
Received: by ewy10 with SMTP id 10so3813723ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HfmFeb/2Ala9CmMbDbZnG1aBV91isdvlpRg0Ffklox8=;
        b=RJ7ndEG44CGpYrJPJ+FYlDXLngM8OOsOXwT7uAuJN9iK3A5SwfrkC4xPDY7B2ZaXfW
         lLyEA+5AARBOhidsU9hzZdVD2GqmPxluL/DV/iV+4lXaqy7zGBzOZ2KokELzfKCvpvti
         KZojRb4NKAV789EMIYyvk3dJhbBJEpzVR0aws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nKc7lZeZ+v5wn8wDrk/Dc/Lt/B8GAMHW56tmNrcbif81qxW2kP/OSff/DH36WQ9uRv
         yNA4dhrr+zjskjgcNmvZTe+ta/NSadjU6vdYcMrG+jXs+RsMOMmT60OJ+coe568adVjP
         vccmN9cM5mF1+glLdPbJIEqy1hq6YfROgBvco=
Received: by 10.211.178.8 with SMTP id f8mr379262ebp.75.1249969691557;
        Mon, 10 Aug 2009 22:48:11 -0700 (PDT)
Received: from localhost.localdomain (h59n1fls34o811.telia.com [213.67.102.59])
        by mx.google.com with ESMTPS id 10sm1924884eyd.47.2009.08.10.22.48.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 22:48:11 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125562>

PrintWriter hides error handling from us and we want it. We
also want \n as line terminator so Writer is just as simple. Try-
finally blocks added for cleanup on failure.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../spearce/jgit/transport/FetchHeadRecord.java    |   25 +++++++++---------
 .../org/spearce/jgit/transport/FetchProcess.java   |   27 ++++++++++---------
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
index d957028..62ec38a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchHeadRecord.java
@@ -41,7 +41,8 @@
 import static org.spearce.jgit.lib.Constants.R_REMOTES;
 import static org.spearce.jgit.lib.Constants.R_TAGS;
 
-import java.io.PrintWriter;
+import java.io.IOException;
+import java.io.Writer;
 
 import org.spearce.jgit.lib.ObjectId;
 
@@ -54,7 +55,7 @@
 
 	URIish sourceURI;
 
-	void write(final PrintWriter pw) {
+	void write(final Writer pw) throws IOException {
 		final String type;
 		final String name;
 		if (sourceName.startsWith(R_HEADS)) {
@@ -71,16 +72,16 @@ void write(final PrintWriter pw) {
 			name = sourceName;
 		}
 
-		pw.print(newValue.name());
-		pw.print('\t');
+		pw.write(newValue.name());
+		pw.write('\t');
 		if (notForMerge)
-			pw.print("not-for-merge");
-		pw.print('\t');
-		pw.print(type);
-		pw.print(" '");
-		pw.print(name);
-		pw.print("' of ");
-		pw.print(sourceURI);
-		pw.println();
+			pw.write("not-for-merge");
+		pw.write('\t');
+		pw.write(type);
+		pw.write(" '");
+		pw.write(name);
+		pw.write("' of ");
+		pw.write(sourceURI.toString());
+		pw.write("\n");
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
index 08d7d65..c899c8c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/FetchProcess.java
@@ -41,7 +41,7 @@
 import java.io.File;
 import java.io.IOException;
 import java.io.OutputStreamWriter;
-import java.io.PrintWriter;
+import java.io.Writer;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.Collections;
@@ -264,20 +264,21 @@ private void removeFetchHeadRecord(final ObjectId want) {
 	private void updateFETCH_HEAD(final FetchResult result) throws IOException {
 		final LockFile lock = new LockFile(new File(transport.local
 				.getDirectory(), "FETCH_HEAD"));
-		if (lock.lock()) {
-			final PrintWriter pw = new PrintWriter(new OutputStreamWriter(lock
-					.getOutputStream())) {
-				@Override
-				public void println() {
-					print('\n');
+		try {
+			if (lock.lock()) {
+				final Writer w = new OutputStreamWriter(lock.getOutputStream());
+				try {
+					for (final FetchHeadRecord h : fetchHeadUpdates) {
+						h.write(w);
+						result.add(h);
+					}
+				} finally {
+					w.close();
 				}
-			};
-			for (final FetchHeadRecord h : fetchHeadUpdates) {
-				h.write(pw);
-				result.add(h);
+				lock.commit();
 			}
-			pw.close();
-			lock.commit();
+		} finally {
+			lock.unlock();
 		}
 	}
 
-- 
1.6.3.2.199.g7340d

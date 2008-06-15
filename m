From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 03/20] Add openObjectInAllPacks() to Repository, exposing packed objects storage
Date: Sun, 15 Jun 2008 23:45:32 +0200
Message-ID: <1213566349-25395-4-git-send-email-marek.zawirski@gmail.com>
References: <1213566349-25395-1-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-2-git-send-email-marek.zawirski@gmail.com>
 <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:47:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K804D-0001bl-HL
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYFOVqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbYFOVqS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:46:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:29549 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbYFOVqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:46:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2958539ywe.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=K3UE5LbmiG8foYnMurYY0uuvqD5Z70obZefB3HN+Lk0=;
        b=a0YLQtvCWqouh0gEAWm3BzCjP/lHa3LJ7PBwSvILJCvMqquQg+ReFGucuxbezPDbnk
         Yp2TxoJRs0/8tS6YJ+hu/yI15NyOP/CM+hgD3kN4hZEiohxyqeuibT34x209x3pj7moD
         h765MUkj0FPlhNcT4DBT4LR6nseQj+oMR2DF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=syzGodkbH8XiIUNRHMa+zl2YTKQrxBl+LOyfHzafeQR+rboUQ/ws+DUBlJRNzMGzVL
         gH4EH+0CMoEu9Ae2iFFRp35moLJgyVUk7yjv8Av+/NTibx8y+1SjZ4IH9t060TQ+R++U
         5+rguvWZ89kUMxzbXIH7MtTJoDpgBeo5JG+A0=
Received: by 10.150.219.3 with SMTP id r3mr9453803ybg.65.1213566364603;
        Sun, 15 Jun 2008 14:46:04 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 27sm2157847qbw.19.2008.06.15.14.46.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 14:46:03 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1213566349-25395-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85130>

Gives client a way to access specified object from any pack where it is
stored (this may be useful when an object is stored in more than 1 pack).

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/Repository.java       |   42 ++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 3efe60b..64f93ff 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -48,6 +48,7 @@ import java.io.IOException;
 import java.util.ArrayList;
 import java.util.Collection;
 import java.util.HashMap;
+import java.util.LinkedList;
 import java.util.Map;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
@@ -292,6 +293,47 @@ public class Repository {
 	}
 
 	/**
+	 * Open object in all packs containing specified object.
+	 * 
+	 * @param objectId
+	 *            id of object to search for
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @return collection of loaders for this object, from all packs containing
+	 *         this object
+	 * @throws IOException
+	 */
+	public Collection<PackedObjectLoader> openObjectInAllPacks(
+			final AnyObjectId objectId, final WindowCursor curs)
+			throws IOException {
+		Collection<PackedObjectLoader> result = new LinkedList<PackedObjectLoader>();
+		openObjectInAllPacks(objectId, result, curs);
+		return result;
+	}
+
+	/**
+	 * Open object in all packs containing specified object.
+	 * 
+	 * @param objectId
+	 *            id of object to search for
+	 * @param resultLoaders
+	 *            result collection of loaders for this object, filled with
+	 *            loaders from all packs containing specified object
+	 * @param curs
+	 *            temporary working space associated with the calling thread.
+	 * @throws IOException
+	 */
+	void openObjectInAllPacks(final AnyObjectId objectId,
+			final Collection<PackedObjectLoader> resultLoaders,
+			final WindowCursor curs) throws IOException {
+		for (PackFile pack : packs) {
+			final PackedObjectLoader loader = pack.get(curs, objectId);
+			if (loader != null)
+				resultLoaders.add(loader);
+		}
+	}
+
+	/**
 	 * @param id
 	 *            SHA'1 of a blob
 	 * @return an {@link ObjectLoader} for accessing the data of a named blob
-- 
1.5.5.1

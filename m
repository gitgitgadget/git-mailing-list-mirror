From: mr.gaffo@gmail.com
Subject: [PATCH JGit 02/19] Create abstract method on ObjectDatabase for accessing the list of local pack files.
Date: Sun, 13 Sep 2009 13:44:18 -0500
Message-ID: <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:52:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmuBJ-0004wT-Dk
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbZIMSwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZIMSwE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:52:04 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:58214 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbZIMSwC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:52:02 -0400
Received: by ywh4 with SMTP id 4so3395489ywh.5
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=odXqHeTdBLMKEuVLQucaASUXFOO2yjGQrOc5Xht2L4s=;
        b=DM3ITHXvVPcGoYqwABv2BjOXSAm8Wqk7NMopsHunQFAYk3ZvvGjQxUlgujJoPCMLHw
         c7UBBNKWK3qFboHeO26Ipc7U+fRgSkc+J4vhmGueTGRV1kdSl3cqbk0+tATxSYLHELE4
         NcSNcFmG8G/AwGLYrK9Q7jCjWMh+T43WJee0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i4Xu9cLfz8LnxIApXRgGFb9BhaHs3diOVBIo/n8XPoL8V8rsP14nfBe3uMxktWlZu0
         ZW/iMY6NFc/5lxKd6sIThhycuPafpAeaWWDuWlSWOkJvnLs7yA+rcQZXOIR6zP7b8K7q
         rJatkZUilFBaqmou6vd33WBMJlQOiwoC9HpAU=
Received: by 10.101.127.10 with SMTP id e10mr5552578ann.85.1252867485154;
        Sun, 13 Sep 2009 11:44:45 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128399>

From: mike.gaffney <mike.gaffney@asolutions.com>

Implemented the method for AlternateRepository database as a passthrough

Implemented the method for ObjectDirectory as a toList of the current
cached private PackList.

Hopefully this will allow easier reference to the list of packs for
others like the server side of fetch.
---
 .../jgit/lib/AlternateRepositoryDatabase.java      |    6 ++++++
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |   11 ++++++++++-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |    5 +++++
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
index ee4c4cf..68ad488 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
@@ -39,6 +39,7 @@
 
 import java.io.IOException;
 import java.util.Collection;
+import java.util.List;
 
 /**
  * An ObjectDatabase of another {@link Repository}.
@@ -124,4 +125,9 @@ void openObjectInAllPacks1(final Collection<PackedObjectLoader> out,
 	protected void closeAlternates(final ObjectDatabase[] alt) {
 		// Do nothing; these belong to odb to close, not us.
 	}
+
+	@Override
+	public List<PackFile> listLocalPacks() {
+		return odb.listLocalPacks();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index a547052..722c802 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -39,6 +39,7 @@
 
 import java.io.IOException;
 import java.util.Collection;
+import java.util.List;
 import java.util.concurrent.atomic.AtomicReference;
 
 /**
@@ -64,7 +65,15 @@
 	protected ObjectDatabase() {
 		alternates = new AtomicReference<ObjectDatabase[]>();
 	}
-
+	
+	/**
+	 * The list of Packs THIS repo contains
+	 * 
+	 * @return List<PackFile> of package names contained in this repo. 
+	 * 		   Should be an empty list if there are none.
+	 */
+	public abstract List<PackFile> listLocalPacks();
+	
 	/**
 	 * Does this database exist yet?
 	 *
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
index 859824d..fe219c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDirectory.java
@@ -508,4 +508,9 @@ boolean tryAgain(final long currLastModified) {
 			return true;
 		}
 	}
+
+	@Override
+	public List<PackFile> listLocalPacks() {
+		return new ArrayList<PackFile>(Arrays.asList(packList.get().packs));
+	}
 }
-- 
1.6.4.2

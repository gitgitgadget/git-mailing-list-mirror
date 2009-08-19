From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH JGIT] Ensure created test repositories use canonical paths
Date: Wed, 19 Aug 2009 09:18:11 -0400
Message-ID: <1250687891-17916-1-git-send-email-fonseca@diku.dk>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 15:21:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdl68-0000xs-Fl
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 15:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZHSNSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 09:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbZHSNSX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 09:18:23 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:9359 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbZHSNSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 09:18:22 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1464952qwh.37
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 06:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=c3k7C0QSIlPgkYY//vDRV+YYFKeNpt0sqE9ZjIwxEBQ=;
        b=W7u9RVWzUh5o2f7Q/I8uOvXIWtIxxGrLaF1TwJaVGwNKCAp8SW0S+wGZ1YeMrMoyfT
         teMigSHc832HIq/vwN1b0ISSipjT+eDjd18TXfuejMlmco+LkX07R4NRYYclclK3nN9D
         bM50sjjPkcYB+JiZrNFo69c1qLA7D0utj3EaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=VCWK5/d7oB+I759l334WGINBe7lXC0KhY0DXkBgoSRy4pdwOeB6pv6SdygF4InGuLl
         /HNe7Q5F6Cotk5Um3uxzE7jy4kyHr2PjtN4821DDGrSmLdJ95zzZPTrwd1oIOliiW281
         qIXUqHW2csdPA/4Ok+2gj4cxC8brOlvQifNcQ=
Received: by 10.224.50.137 with SMTP id z9mr6414696qaf.83.1250687903678;
        Wed, 19 Aug 2009 06:18:23 -0700 (PDT)
Received: from localhost.localdomain (bas1-montreal42-1178046713.dsl.bell.ca [70.55.144.249])
        by mx.google.com with ESMTPS id 6sm40334qwk.22.2009.08.19.06.18.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 06:18:23 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.rc3.195.g2b05f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126544>

Fixes breakage in the RepositoryCacheTest when running tests using:

	mvn -f ./jgit-maven/jgit/pom.xml test

which in turn will lead to test repositories using paths, such as:

	/path/to/jgit/./jgit-maven/jgit/trash/trash1250647279819.186/.git

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index b1adde9..d1aef78 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -217,7 +217,7 @@ public void setUp() throws Exception {
 		final String name = getClass().getName() + "." + getName();
 		recursiveDelete(trashParent, true, name, false); // Cleanup old failed stuff
 		trash = new File(trashParent,"trash"+System.currentTimeMillis()+"."+(testcount++));
-		trash_git = new File(trash, ".git");
+		trash_git = new File(trash, ".git").getCanonicalFile();
 		if (shutdownhook == null) {
 			shutdownhook = new Thread() {
 				@Override
@@ -307,7 +307,7 @@ protected Repository createNewEmptyRepo() throws IOException {
 	protected Repository createNewEmptyRepo(boolean bare) throws IOException {
 		final File newTestRepo = new File(trashParent, "new"
 				+ System.currentTimeMillis() + "." + (testcount++)
-				+ (bare ? "" : "/") + ".git");
+				+ (bare ? "" : "/") + ".git").getCanonicalFile();
 		assertFalse(newTestRepo.exists());
 		final Repository newRepo = new Repository(newTestRepo);
 		newRepo.create();
-- 
1.6.4.rc3.195.g2b05f

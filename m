From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Fix nullpointer exceptions in Quickdiff
Date: Fri, 11 Jul 2008 23:34:47 +0200
Message-ID: <200807112334.47552.robin.rosenberg@dewire.com>
References: <1215729672-26906-1-git-send-email-robin.rosenberg@dewire.com> <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:41:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQMZ-00063i-1q
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 23:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbYGKVkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755123AbYGKVkF
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 17:40:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18541 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbYGKVkD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 17:40:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A4C48802869;
	Fri, 11 Jul 2008 23:40:00 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xYeu1lwxEMo5; Fri, 11 Jul 2008 23:40:00 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 23AB4802846;
	Fri, 11 Jul 2008 23:40:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1215729672-26906-2-git-send-email-robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88181>


--- 
I saw some problem when resources were no longer in the worspace, such as during a bisectg. 
This one should probably just be squashed into patch 1.

-- robin

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
index ebed0cf..3724304 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitDocument.java
@@ -43,7 +43,10 @@ class GitDocument extends Document implements RepositoryListener {
 	void populate() throws IOException {
 		set("");
 		final IProject project = resource.getProject();
-		final String gitPath = RepositoryMapping.getMapping(project).getRepoRelativePath(resource);
+		RepositoryMapping mapping = RepositoryMapping.getMapping(project);
+		if (mapping == null)
+			return;
+		final String gitPath = mapping.getRepoRelativePath(resource);
 		final Repository repository = getRepository();
 		repository.addRepositoryChangedListener(this);
 		String baseline = GitQuickDiffProvider.baseline.get(repository);
@@ -63,7 +66,9 @@ class GitDocument extends Document implements RepositoryListener {
 	}
 
 	void dispose() {
-		getRepository().removeRepositoryChangedListener(this);
+		Repository repository = getRepository();
+		if (repository != null)
+			repository.removeRepositoryChangedListener(this);
 	}
 
 	public void refsChanged(final RefsChangedEvent e) {
@@ -81,6 +86,8 @@ class GitDocument extends Document implements RepositoryListener {
 	private Repository getRepository() {
 		IProject project = resource.getProject();
 		RepositoryMapping mapping = RepositoryMapping.getMapping(project);
-		return mapping.getRepository();
+		if (mapping != null)
+			return mapping.getRepository();
+		return null;
 	}
 }
-- 
1.5.6.2.220.g44701

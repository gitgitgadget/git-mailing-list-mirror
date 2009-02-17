From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 14/12] Allow project decorations regardless of repository root location
Date: Tue, 17 Feb 2009 18:52:42 +0100
Message-ID: <1234893162-23254-1-git-send-email-torarnv@gmail.com>
References: <1234893101-23143-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:53:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZU8J-0006cZ-1t
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 18:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbZBQRvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2009 12:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbZBQRvy
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 12:51:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:24440 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbZBQRvy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 12:51:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so490234fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 09:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=G5bx1TPY36HE/BBtYcamV1w4OxazBAHUU3gJSdmjgfw=;
        b=aihrcQEoEl3CHUFdVM8ZCumG/o7QzMfAAh6ilC/weJNC9QMy9cioR6zlz/RS2vBb81
         FShmvXTwxV1aeJDD144egjZs4dyzK9eHTyY+RUETfR8CG+PcK8iKmdxD41alKUfE67Rw
         FLrENAhqDdiRw0r+Dply+VD6sCIsuGHixzSLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ehq7TFFKjcoedd29FXevtPRRVwrDTlzzC2rnz1pjAlJu7SZ7fEvdHPgw9xtDAxN3X2
         meq/m7BUH/5nKYUL2PcoEi75ZMAU/041T1azz9ne+WEX8jWF2194PIutHyWRvwlqeTMP
         U2F0A3l7Qq6VIJ8ZRoIvrLDxxg9k0jjP1N1aA=
Received: by 10.103.212.2 with SMTP id o2mr61327muq.69.1234893112162;
        Tue, 17 Feb 2009 09:51:52 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id j6sm1871174mue.34.2009.02.17.09.51.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Feb 2009 09:51:51 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id B95FF468001; Tue, 17 Feb 2009 18:52:42 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234893101-23143-1-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110425>

If the repository root is more than one level above the project
directory we use the AdaptableFileTreeIterator to recurse the
repository tree until we find a directory that can be mapped
to a container in the workspace. The iterator is then adapted to
a ContainerTreeIterator and decorations are applied like usual.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../decorators/DecoratableResourceAdapter.java     |   39 ++++++++++++=
+-------
 1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/DecoratableResourceAdapter.java b/org.spearce.egit.ui/src/org/spe=
arce/egit/ui/internal/decorators/DecoratableResourceAdapter.java
index e2fe54b..5c68d5b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/D=
ecoratableResourceAdapter.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/D=
ecoratableResourceAdapter.java
@@ -13,15 +13,17 @@
=20
 package org.spearce.egit.ui.internal.decorators;
=20
+import java.io.File;
 import java.io.IOException;
 import java.util.Collections;
 import java.util.Set;
=20
 import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
-import org.eclipse.core.resources.IWorkspace;
+import org.eclipse.core.resources.IWorkspaceRoot;
 import org.eclipse.jface.preference.IPreferenceStore;
 import org.eclipse.team.core.Team;
+import org.spearce.egit.core.AdaptableFileTreeIterator;
 import org.spearce.egit.core.ContainerTreeIterator;
 import org.spearce.egit.core.ContainerTreeIterator.ResourceEntry;
 import org.spearce.egit.core.project.RepositoryMapping;
@@ -39,6 +41,7 @@
 import org.spearce.jgit.revwalk.RevWalk;
 import org.spearce.jgit.treewalk.EmptyTreeIterator;
 import org.spearce.jgit.treewalk.TreeWalk;
+import org.spearce.jgit.treewalk.WorkingTreeIterator;
 import org.spearce.jgit.treewalk.filter.AndTreeFilter;
 import org.spearce.jgit.treewalk.filter.PathFilterGroup;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
@@ -210,13 +213,21 @@ public boolean include(TreeWalk treeWalk)
 		}
=20
 		private boolean shouldRecurse(TreeWalk treeWalk) {
-			final ContainerTreeIterator workspaceIterator =3D treeWalk.getTree(
-					T_WORKSPACE, ContainerTreeIterator.class);
-			final ResourceEntry resourceEntry =3D workspaceIterator !=3D null ?=
 workspaceIterator
-					.getResourceEntry()
-					: null;
-			IResource visitingResource =3D resourceEntry.getResource();
+			final WorkingTreeIterator workspaceIterator =3D treeWalk.getTree(
+					T_WORKSPACE, WorkingTreeIterator.class);
+
+			if (workspaceIterator instanceof AdaptableFileTreeIterator)
+				return true;
+
+			ResourceEntry resourceEntry =3D null;
+			if (workspaceIterator !=3D null)
+				resourceEntry =3D ((ContainerTreeIterator) workspaceIterator)
+						.getResourceEntry();
+
+			if (resourceEntry =3D=3D null)
+				return true;
=20
+			IResource visitingResource =3D resourceEntry.getResource();
 			if (targetDepth =3D=3D -1) {
 				if (visitingResource.equals(resource)
 						|| visitingResource.getParent().equals(resource))
@@ -319,14 +330,16 @@ private TreeWalk createThreeWayTreeWalk() throws =
IOException {
=20
 		// Working directory
 		IProject project =3D resource.getProject();
-		IWorkspace workspace =3D resource.getWorkspace();
-		if (repository.getWorkDir().equals(project.getLocation().toFile()))
+		IWorkspaceRoot workspaceRoot =3D resource.getWorkspace().getRoot();
+		File repoRoot =3D repository.getWorkDir();
+
+		if (repoRoot.equals(project.getLocation().toFile()))
 			treeWalk.addTree(new ContainerTreeIterator(project));
+		else if (repoRoot.equals(workspaceRoot.getLocation().toFile()))
+			treeWalk.addTree(new ContainerTreeIterator(workspaceRoot));
 		else
-			treeWalk.addTree(new ContainerTreeIterator(workspace.getRoot()));
-
-		// TODO: Add fallback for projects with the repository more than
-		// one parent up, for example by using a stack of DummyIterators
+			treeWalk.addTree(new AdaptableFileTreeIterator(repoRoot,
+					workspaceRoot));
=20
 		return treeWalk;
 	}
--=20
1.6.1.2.309.g2ea3

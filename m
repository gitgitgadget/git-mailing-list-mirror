From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [JGIT PATCH] Teach tree iterators to iterate from the workspace root
Date: Wed,  4 Feb 2009 16:36:22 +0100
Message-ID: <1233761782-842-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 04 16:37:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUjof-0002bJ-9T
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 16:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbZBDPgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbZBDPgA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 10:36:00 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:58346 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbZBDPf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 10:35:59 -0500
Received: by ewy14 with SMTP id 14so3439037ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 07:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=TUZJ08Cip/7RaTo+dPzIubFFrTu3sFibPo9aGmxbz6s=;
        b=QLtSvH0tMhZ0pBWQrcFkCqaOgC5D/Sa3FygHhUSpRC2kNmtXm1ZUX6gz+DUezS0clP
         iKKtt5M7eD6WvRwPeRALW0dSeH1nBH1QNHwWAsXz0INbwf8KsIm2n+O62ZZsJ052Y3b+
         Wr+/ohspbcLFdo8xmq5onmFAHH2DDSAc9IbU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=UwhkNkRrThKMIINkypAJMjYzewxyZ+ecu3c7Zx/IPom6s+rnPaTc946nVIBWGwhewN
         UIJP7tTJn+k4PuoW8yeZeMgMeUpYo/S7sD0juldSC4vbKxcrBJGojEMDM45KUHOWGwkf
         uN5PBdoWJIw0duAYWXACKo9Agi0+mOCCla+Ac=
Received: by 10.211.196.13 with SMTP id y13mr2871370ebp.135.1233761757900;
        Wed, 04 Feb 2009 07:35:57 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 10sm1592192eyz.50.2009.02.04.07.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 07:35:57 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id B817C468001; Wed,  4 Feb 2009 16:36:22 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108381>

This is needed to be able to do treewalks of projects that
have their repository in the project's parent directory.

We always filter out '.git' entries when building the entry list,
no matter where we are in the tree, because we assume that the
checks in the ResourceEntry and FileEntry constructors for a
'.git' folder ensure that we never navigate into submodules.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../spearce/egit/core/ContainerTreeIterator.java   |   26 ++++++++++++=
++++++-
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |    2 +-
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerT=
reeIterator.java b/org.spearce.egit.core/src/org/spearce/egit/core/Cont=
ainerTreeIterator.java
index 61717f5..6d6b72e 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIter=
ator.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIter=
ator.java
@@ -15,6 +15,7 @@
 import org.eclipse.core.resources.IContainer;
 import org.eclipse.core.resources.IFile;
 import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IWorkspaceRoot;
 import org.eclipse.core.runtime.CoreException;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
@@ -53,7 +54,7 @@ private static String computePrefix(final IContainer =
base) {
 	private final IContainer node;
=20
 	/**
-	 * Construct a new iterator from the workspace.
+	 * Construct a new iterator from a container in the workspace.
 	 * <p>
 	 * The iterator will support traversal over the named container, but =
only if
 	 * it is contained within a project which has the Git repository prov=
ider
@@ -70,6 +71,23 @@ public ContainerTreeIterator(final IContainer base) =
{
 		init(entries());
 	}
=20
+	/**
+	 * Construct a new iterator from the workspace root.
+	 * <p>
+	 * The iterator will support traversal over workspace projects that h=
ave
+	 * a Git repository provider connected and is mapped into a Git repos=
itory.
+	 * During the iteration the paths will be automatically generated to =
match
+	 * the proper repository paths for this container's children.
+	 *
+	 * @param root
+	 *            the workspace root to walk over.
+	 */
+	public ContainerTreeIterator(final IWorkspaceRoot root) {
+		super("");
+		node =3D root;
+		init(entries());
+	}
+
 	private ContainerTreeIterator(final WorkingTreeIterator p,
 			final IContainer base) {
 		super(p);
@@ -119,6 +137,7 @@ ResourceEntry(final IResource f) {
 				else
 					mode =3D FileMode.REGULAR_FILE;
 				break;
+			case IResource.PROJECT:
 			case IResource.FOLDER: {
 				final IContainer c =3D (IContainer) f;
 				if (c.findMember(".git") !=3D null)
@@ -140,7 +159,10 @@ public FileMode getMode() {
=20
 		@Override
 		public String getName() {
-			return rsrc.getName();
+			if (rsrc.getType() =3D=3D IResource.PROJECT)
+				return rsrc.getLocation().lastSegment();
+			else
+				return rsrc.getName();
 		}
=20
 		@Override
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTree=
Iterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingT=
reeIterator.java
index 6fce150..07ce2ed 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterato=
r.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/WorkingTreeIterato=
r.java
@@ -324,7 +324,7 @@ protected void init(final Entry[] list) {
 			final String name =3D e.getName();
 			if (".".equals(name) || "..".equals(name))
 				continue;
-			if (parent =3D=3D null && ".git".equals(name))
+			if (".git".equals(name))
 				continue;
 			if (i !=3D o)
 				entries[o] =3D e;
--=20
1.6.1.2.309.g2ea3

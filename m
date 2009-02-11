From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 02/12] Use Set instead of array to keep track of change listeners
Date: Wed, 11 Feb 2009 19:40:04 +0100
Message-ID: <1234377614-23798-3-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:41:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK19-0004zp-WA
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbZBKSji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755718AbZBKSjg
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:39:36 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:56125 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616AbZBKSja (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:39:30 -0500
Received: by fxm13 with SMTP id 13so1002022fxm.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Wq4vBCEgnYedQyUh+/aaEC5MXtrCfUGOWacKsFmMc+c=;
        b=nglOohjVhF8JxQkT7EjovVbwq3Ol8/hNYqvpNV9XNFhHgijAnwaw1KoG6yrtWZ6yk3
         gsdiUGPR5y8CyJrphYSCQG/Bag9WleGj2CewrYSIEu9o3bFxZrY3iw71JoQtN6wAk8xs
         Dsq/XEXikR+qCJxL518ZNu3FbnjB9rOHig9BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Dz8veqFKXIQW9vYzfRoJO6OCCIOQbbEpK40hjgBpQeyQgsGU0L9XlHkUrrOMRdvg6D
         F3bfTNMMy1bdLGWzXNtpzgebk0ECJhsE3Td5Nx7L7ELqzJCHgR25dX3xX0hKBb/Xfyqg
         4fHA/AMUFyM4gU/GAH2Ow8Nb5rXmiw2j/OV8Q=
Received: by 10.86.80.5 with SMTP id d5mr862292fgb.39.1234377568533;
        Wed, 11 Feb 2009 10:39:28 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 4sm3657322fgg.25.2009.02.11.10.38.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:38:54 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id F2ACF17800A; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-2-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109481>

Also, add method for removing listeners.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../spearce/egit/core/project/GitProjectData.java  |   40 ++++++++++++=
-------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/Gi=
tProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/pro=
ject/GitProjectData.java
index db5f20b..b12a85f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjec=
tData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjec=
tData.java
@@ -52,7 +52,7 @@
=20
 	private static final Map<File, WeakReference> repositoryCache =3D new=
 HashMap<File, WeakReference>();
=20
-	private static RepositoryChangeListener[] repositoryChangeListeners =3D=
 {};
+	private static Set<RepositoryChangeListener> repositoryChangeListener=
s =3D new HashSet<RepositoryChangeListener>();
=20
 	@SuppressWarnings("synthetic-access")
 	private static final IResourceChangeListener rcl =3D new RCL();
@@ -112,16 +112,18 @@ public static synchronized void addRepositoryChan=
geListener(
 			final RepositoryChangeListener objectThatCares) {
 		if (objectThatCares =3D=3D null)
 			throw new NullPointerException();
-		for (int k =3D repositoryChangeListeners.length - 1; k >=3D 0; k--) =
{
-			if (repositoryChangeListeners[k] =3D=3D objectThatCares)
-				return;
-		}
-		final int p =3D repositoryChangeListeners.length;
-		final RepositoryChangeListener[] n;
-		n =3D new RepositoryChangeListener[p + 1];
-		System.arraycopy(repositoryChangeListeners, 0, n, 0, p);
-		n[p] =3D objectThatCares;
-		repositoryChangeListeners =3D n;
+		repositoryChangeListeners.add(objectThatCares);
+	}
+
+	/**
+	 * Remove a registered {@link RepositoryChangeListener}
+	 *=20
+	 * @param objectThatCares
+	 *            The listener to remove
+	 */
+	public static synchronized void removeRepositoryChangeListener(
+			final RepositoryChangeListener objectThatCares) {
+		repositoryChangeListeners.remove(objectThatCares);
 	}
=20
 	/**
@@ -131,13 +133,21 @@ public static synchronized void addRepositoryChan=
geListener(
 	 *            the repository which has had changes occur within it.
 	 */
 	static void fireRepositoryChanged(final RepositoryMapping which) {
-		final RepositoryChangeListener[] e =3D getRepositoryChangeListeners(=
);
-		for (int k =3D e.length - 1; k >=3D 0; k--)
-			e[k].repositoryChanged(which);
+		for (RepositoryChangeListener listener : getRepositoryChangeListener=
s())
+			listener.repositoryChanged(which);
 	}
=20
+	/**
+	 * Get a copy of the current set of repository change listeners
+	 * <p>
+	 * The array has no references, so is safe for iteration and modifica=
tion
+	 *=20
+	 * @return a copy of the current repository change listeners
+	 */
 	private static synchronized RepositoryChangeListener[] getRepositoryC=
hangeListeners() {
-		return repositoryChangeListeners;
+		return repositoryChangeListeners
+				.toArray(new RepositoryChangeListener[repositoryChangeListeners
+						.size()]);
 	}
=20
 	/**
--=20
1.6.1.2.309.g2ea3

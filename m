From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 02/11] Use Set instead of array to keep track of change listeners
Date: Thu,  5 Feb 2009 02:00:09 +0100
Message-ID: <1233795618-20249-3-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
 <1233795618-20249-2-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:01:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUscM-0000fv-UJ
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbZBEA74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 19:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756115AbZBEA7y
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 19:59:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:6763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbZBEA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:52 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1576fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BRdmS5f3nhh5rJn4lo183Y60SWervdVPm2dTvkH2m0M=;
        b=L9r8NCxWpK/rVp6I8mlcf4XvW3T37XsFIt73B70mU0cLOHE7MggQ2i0ccYxtuLSOIQ
         ShYrcuWBqoITHwdnikcKLrzoBI+vEQJS3wtpNZR9wfHtO6DOn/8KKJfoczrJcM9joyt8
         G8gxzGPshQDRzFORhrszlkPi1LD/FQbDVWMc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fHGtGcsTd1cgCqw+MGhQrv7Auh/D6GPmIrczelUBZu9hNQidIPnR+E38BmiMx9WEN7
         snfi8jkzvHtzEw/Q4ZDSVCTKqvJ+KKj4DpbnJiTJV/1dtI6nAJMnCqtG9i/ouz+AoXAJ
         tUZkFVyVAFG7ns/HoTVViOFU7LVQc45g8grTI=
Received: by 10.86.82.6 with SMTP id f6mr1096841fgb.42.1233795590270;
        Wed, 04 Feb 2009 16:59:50 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d4sm12510fga.38.2009.02.04.16.59.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:49 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 65BE517800A; Thu,  5 Feb 2009 02:00:18 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-2-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108477>

Also, add method for removing listeners, and remove unused
private method for getting the current listeners.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../spearce/egit/core/project/GitProjectData.java  |   33 +++++++++---=
--------
 1 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/Gi=
tProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/pro=
ject/GitProjectData.java
index db5f20b..4ca4f8e 100644
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
@@ -131,13 +133,8 @@ public static synchronized void addRepositoryChang=
eListener(
 	 *            the repository which has had changes occur within it.
 	 */
 	static void fireRepositoryChanged(final RepositoryMapping which) {
-		final RepositoryChangeListener[] e =3D getRepositoryChangeListeners(=
);
-		for (int k =3D e.length - 1; k >=3D 0; k--)
-			e[k].repositoryChanged(which);
-	}
-
-	private static synchronized RepositoryChangeListener[] getRepositoryC=
hangeListeners() {
-		return repositoryChangeListeners;
+		for (RepositoryChangeListener listener : repositoryChangeListeners)
+			listener.repositoryChanged(which);
 	}
=20
 	/**
--=20
1.6.1.2.309.g2ea3

From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 4/7 v3] Handle peeling of loose refs.
Date: Sat, 15 Nov 2008 00:24:58 +0100
Message-ID: <1226705099-18066-4-git-send-email-robin.rosenberg@dewire.com>
References: <20081111183248.GR2932@spearce.org>
 <1226705099-18066-1-git-send-email-robin.rosenberg@dewire.com>
 <1226705099-18066-2-git-send-email-robin.rosenberg@dewire.com>
 <1226705099-18066-3-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Nov 15 00:26:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L183h-0004bR-PD
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYKNXZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:25:22 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752198AbYKNXZV
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:25:21 -0500
Received: from mail.dewire.com ([83.140.172.130]:13644 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbYKNXZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 18:25:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C2732147D4E1;
	Sat, 15 Nov 2008 00:25:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id luXkJoB1Ap8r; Sat, 15 Nov 2008 00:25:06 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 948FF147D4E3;
	Sat, 15 Nov 2008 00:25:00 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a.dirty
In-Reply-To: <1226705099-18066-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101032>

=46or packed refs we got peeling automatically from packed-refs,
but for loose tags we have to follow the tags and get the leaf
object in order to comply with the documentation.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java |   35 ++++++++++++=
++-----
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   32 ++++++++++++=
++++--
 .../src/org/spearce/jgit/lib/Repository.java       |   13 +++++++
 .../spearce/jgit/transport/BasePackConnection.java |    2 +-
 .../spearce/jgit/transport/TransportAmazonS3.java  |    2 +-
 .../org/spearce/jgit/transport/TransportHttp.java  |    2 +-
 .../org/spearce/jgit/transport/TransportSftp.java  |    2 +-
 .../jgit/transport/WalkRemoteObjectDatabase.java   |    2 +-
 8 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java b/org.s=
pearce.jgit/src/org/spearce/jgit/lib/Ref.java
index 2f102af..0e98f46 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Ref.java
@@ -126,6 +126,8 @@ public boolean isPacked() {
=20
 	private final String origName;
=20
+	private final boolean peeled;
+
 	/**
 	 * Create a new ref pairing.
 	 *=20
@@ -140,10 +142,7 @@ public boolean isPacked() {
 	 *            does not exist yet.
 	 */
 	public Ref(final Storage st, final String origName, final String refN=
ame, final ObjectId id) {
-		storage =3D st;
-		this.origName =3D origName;
-		name =3D refName;
-		objectId =3D id;
+		this(st, origName, refName, id, null, false);
 	}
=20
 	/**
@@ -158,7 +157,7 @@ public Ref(final Storage st, final String origName,=
 final String refName, final=20
 	 *            does not exist yet.
 	 */
 	public Ref(final Storage st, final String refName, final ObjectId id)=
 {
-		this(st, refName, refName, id);
+		this(st, refName, refName, id, null, false);
 	}
=20
 	/**
@@ -175,15 +174,18 @@ public Ref(final Storage st, final String refName=
, final ObjectId id) {
 	 *            does not exist yet.
 	 * @param peel
 	 *            peeled value of the ref's tag. May be null if this is n=
ot a
-	 *            tag or the peeled value is not known.
+	 *            tag or not yet peeled (in which case the next parameter=
 should be null)
+	 * @param peeled
+	 * 			  true if peel represents a the peeled value of the object
 	 */
 	public Ref(final Storage st, final String origName, final String refN=
ame, final ObjectId id,
-			final ObjectId peel) {
+			final ObjectId peel, final boolean peeled) {
 		storage =3D st;
 		this.origName =3D origName;
 		name =3D refName;
 		objectId =3D id;
 		peeledObjectId =3D peel;
+		this.peeled =3D peeled;
 	}
=20
 	/**
@@ -199,10 +201,12 @@ public Ref(final Storage st, final String origNam=
e, final String refName, final=20
 	 * @param peel
 	 *            peeled value of the ref's tag. May be null if this is n=
ot a
 	 *            tag or the peeled value is not known.
+	 * @param peeled
+	 * 			  true if peel represents a the peeled value of the object
 	 */
 	public Ref(final Storage st, final String refName, final ObjectId id,
-			final ObjectId peel) {
-		this(st, refName, refName, id, peel);
+			final ObjectId peel, boolean peeled) {
+		this(st, refName, refName, id, peel, peeled);
 	}
=20
 	/**
@@ -238,10 +242,19 @@ public ObjectId getObjectId() {
 	 *         refer to an annotated tag.
 	 */
 	public ObjectId getPeeledObjectId() {
+		if (!peeled)
+			return null;
 		return peeledObjectId;
 	}
=20
 	/**
+	 * @return whether the Ref represents a peeled tag
+	 */
+	public boolean isPeeled() {
+		return peeled;
+	}
+
+	/**
 	 * How was this ref obtained?
 	 * <p>
 	 * The current storage model of a Ref may influence how the ref must =
be
@@ -259,4 +272,8 @@ public String toString() {
 			o =3D "(" + origName + ")";
 		return "Ref[" + o + name + "=3D" + ObjectId.toString(getObjectId()) =
+ "]";
 	}
+
+	void setPeeledObjectId(final ObjectId id) {
+		peeledObjectId =3D id;
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java=
 b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 5a1b85f..494aecb 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -271,7 +271,8 @@ private void readOneLooseRef(final Map<String, Ref>=
 avail,
 					return;
 				}
=20
-				ref =3D new Ref(Ref.Storage.LOOSE, origName, refName, id);
+				ref =3D new Ref(Ref.Storage.LOOSE, origName, refName, id, null, fa=
lse); // unpeeled
+
 				looseRefs.put(ref.getName(), ref);
 				looseRefsMTime.put(ref.getName(), ent.lastModified());
 				avail.put(ref.getName(), ref);
@@ -288,6 +289,28 @@ private void readOneLooseRef(final Map<String, Ref=
> avail,
 		}
 	}
=20
+	Ref peel(final Ref ref) {
+		if (ref.isPeeled())
+			return ref;
+		ObjectId peeled =3D null;
+		try {
+			Object target =3D db.mapObject(ref.getObjectId(), ref.getName());
+			while (target instanceof Tag) {
+				final Tag tag =3D (Tag)target;
+				peeled =3D tag.getObjId();
+				if (Constants.TYPE_TAG.equals(tag.getType()))
+					target =3D db.mapObject(tag.getObjId(), ref.getName());
+				else
+					break;
+			}
+		} catch (IOException e) {
+			// Ignore a read error. =C2=A0Callers will also get the same error
+			// if they try to use the result of getPeeledObjectId.
+		}
+		return new Ref(ref.getStorage(), ref.getName(), ref.getObjectId(), p=
eeled, true);
+
+	}
+
 	private File fileForRef(final String name) {
 		if (name.startsWith(REFS_SLASH))
 			return new File(refsDir, name.substring(REFS_SLASH.length()));
@@ -350,7 +373,7 @@ private Ref readRefBasic(final String origName, fin=
al String name, final int dep
 			if (r =3D=3D null)
 				return new Ref(Ref.Storage.LOOSE, origName, target, null);
 			if (!origName.equals(r.getName()))
-				r =3D new Ref(Ref.Storage.LOOSE_PACKED, origName, r.getName(), r.g=
etObjectId(), r.getPeeledObjectId());
+				r =3D new Ref(Ref.Storage.LOOSE_PACKED, origName, r.getName(), r.g=
etObjectId(), r.getPeeledObjectId(), true);
 			return r;=20
 		}
=20
@@ -364,6 +387,9 @@ private Ref readRefBasic(final String origName, fin=
al String name, final int dep
 		}
=20
 		ref =3D new Ref(Ref.Storage.LOOSE, origName, name, id);
+
+		looseRefs.put(origName, ref);
+		ref =3D new Ref(Ref.Storage.LOOSE, origName, id);
 		looseRefs.put(name, ref);
 		looseRefsMTime.put(name, mtime);
 		return ref;
@@ -397,7 +423,7 @@ private void refreshPackedRefs() {
=20
 						final ObjectId id =3D ObjectId.fromString(p.substring(1));
 						last =3D new Ref(Ref.Storage.PACKED, last.getName(), last
-								.getName(), last.getObjectId(), id);
+								.getName(), last.getObjectId(), id, true);
 						newPackedRefs.put(last.getName(), last);
 						continue;
 					}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java =
b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 26748e2..4d6e6fd 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -939,6 +939,19 @@ public String getBranch() throws IOException {
 	}
=20
 	/**
+	 * Peel a possibly unpeeled ref and updates it. If the ref cannot be =
peeled
+	 * the peeled id is set to {@link ObjectId#zeroId()}
+	 *=20
+	 * @param ref
+	 *            The ref to peel
+	 * @return The same, an updated ref with peeled info or a new instanc=
e with
+	 *         more information
+	 */
+	public Ref peel(final Ref ref) {
+		return refs.peel(ref);
+	}
+
+	/**
 	 * @return true if HEAD points to a StGit patch.
 	 */
 	public boolean isStGitMode() {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackCo=
nnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePac=
kConnection.java
index e5fc040..e9df30e 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnectio=
n.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnectio=
n.java
@@ -176,7 +176,7 @@ private void readAdvertisedRefsImpl() throws IOExce=
ption {
 					throw duplicateAdvertisement(name + "^{}");
=20
 				avail.put(name, new Ref(Ref.Storage.NETWORK, name, prior
-						.getObjectId(), id));
+						.getObjectId(), id, true));
 			} else {
 				final Ref prior;
 				prior =3D avail.put(name, new Ref(Ref.Storage.NETWORK, name, id));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportA=
mazonS3.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transpor=
tAmazonS3.java
index f9df36d..9f1b516 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3=
=2Ejava
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportAmazonS3=
=2Ejava
@@ -300,7 +300,7 @@ private Ref readRef(final TreeMap<String, Ref> avai=
l, final String rn)
 				if (r =3D=3D null)
 					return null;
 				r =3D new Ref(r.getStorage(), rn, r.getObjectId(), r
-						.getPeeledObjectId());
+						.getPeeledObjectId(), r.isPeeled());
 				avail.put(r.getName(), r);
 				return r;
 			}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportH=
ttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHtt=
p.java
index 1357e58..fe4a437 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.jav=
a
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.jav=
a
@@ -237,7 +237,7 @@ FileStream open(final String path) throws IOExcepti=
on {
 						throw duplicateAdvertisement(name + "^{}");
=20
 					avail.put(name, new Ref(Ref.Storage.NETWORK, name, prior
-							.getObjectId(), id));
+							.getObjectId(), id, true));
 				} else {
 					final Ref prior =3D avail.put(name, new Ref(
 							Ref.Storage.NETWORK, name, id));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportS=
ftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSft=
p.java
index 78f4ad8..544e77c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.jav=
a
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.jav=
a
@@ -428,7 +428,7 @@ private Ref readRef(final TreeMap<String, Ref> avai=
l,
 					r =3D avail.get(p);
 				if (r !=3D null) {
 					r =3D new Ref(loose(r), name, r.getObjectId(), r
-							.getPeeledObjectId());
+							.getPeeledObjectId(), true);
 					avail.put(name, r);
 				}
 				return r;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemote=
ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/W=
alkRemoteObjectDatabase.java
index 54dd581..a4f8961 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectD=
atabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectD=
atabase.java
@@ -438,7 +438,7 @@ private void readPackedRefsImpl(final Map<String, R=
ef> avail,
 					throw new TransportException("Peeled line before ref.");
 				final ObjectId id =3D ObjectId.fromString(line + 1);
 				last =3D new Ref(Ref.Storage.PACKED, last.getName(), last
-						.getObjectId(), id);
+						.getObjectId(), id, true);
 				avail.put(last.getName(), last);
 				continue;
 			}
--=20
1.6.0.3.640.g6331a.dirty

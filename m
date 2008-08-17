From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 09/31] Extract Transport findRemoteRefUpdatesFor() as static method
Date: Sun, 17 Aug 2008 22:43:50 +0200
Message-ID: <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8O-0002uV-9h
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452AbYHQUov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbYHQUou
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:50 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:48257 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYHQUos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:48 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2887049mue.1
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=aUlPFMLZsYuFvUShYLbEOeuwCs+AvUHkiVZHnDXdels=;
        b=NY4ToXkMmJ9das6+kft4c9xmDUF2UKCf9h5Q8av+yWbKC88fh2IQ3D9iOb6jKKJPzw
         2hK+axeJfP3Y6z7pfTn/5AvUbxCit5y0NjGtd0Je/qCbZhvdYjPtIx251LYEzuqHp6bF
         K11PtBDjknWxyws1WZ3Q6NLJWPG3fM9Tb6hq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BWpJm+Ds5cOkc6fyEnzcbCme0lHp8/kEjfOTUeeuvWuc62rOzHbL7XS4YKAH3cs/5S
         3yeybdPp39iutrNU8ssnGXN/vcUBxWHWrubaQIj7GTObVi5BaRIle3REQC95DGR6icCv
         UoBPRoz3aO5dMnJh3n441ANQfgGEkAuRnHq/g=
Received: by 10.103.17.13 with SMTP id u13mr3460890mui.90.1219005887286;
        Sun, 17 Aug 2008 13:44:47 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id e10sm490317muf.14.2008.08.17.13.44.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92638>

This method could be used outside of specific URI scope, so let it be
static. Otherwise, if someone want to generate remote ref updates from
refspecs he/she may have to create some dummy transport just for that.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/Transport.java  |  147 ++++++++++++--------
 1 files changed, 90 insertions(+), 57 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 98853e6..e986e48 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -211,7 +211,92 @@ public abstract class Transport {
 
 		throw new NotSupportedException("URI not supported: " + remote);
 	}
+	
+	/**
+	 * Convert push remote refs update specification from {@link RefSpec} form
+	 * to {@link RemoteRefUpdate}. Conversion expands wildcards by matching
+	 * source part to local refs. expectedOldObjectId in RemoteRefUpdate is
+	 * always set as null. Tracking branch is configured if RefSpec destination
+	 * matches source of any fetch ref spec for this transport remote
+	 * configuration.
+	 * 
+	 * @param db
+	 *            local database.
+	 * @param specs
+	 *            collection of RefSpec to convert.
+	 * @param fetchSpecs
+	 *            fetch specifications used for finding localtracking refs. May
+	 *            be null or empty collection.
+	 * @return collection of set up {@link RemoteRefUpdate}.
+	 * @throws TransportException
+	 *             when problem occurred during conversion or specification set
+	 *             up: most probably, missing objects or refs.
+	 */
+	public static Collection<RemoteRefUpdate> findRemoteRefUpdatesFor(
+			final Repository db, final Collection<RefSpec> specs,
+			Collection<RefSpec> fetchSpecs) throws TransportException {
+		if (fetchSpecs == null)
+			fetchSpecs = Collections.emptyList();
+		final List<RemoteRefUpdate> result = new LinkedList<RemoteRefUpdate>();
+		final Collection<RefSpec> procRefs = expandPushWildcardsFor(db, specs);
+
+		for (final RefSpec spec : procRefs) {
+			try {
+				final String srcRef = spec.getSource();
+				// null destination (no-colon in ref-spec) is a special case
+				final String remoteName = (spec.getDestination() == null ? spec
+						.getSource() : spec.getDestination());
+				final boolean forceUpdate = spec.isForceUpdate();
+				final String localName = findTrackingRefName(remoteName,
+						fetchSpecs);
+
+				final RemoteRefUpdate rru = new RemoteRefUpdate(db, srcRef,
+						remoteName, forceUpdate, localName, null);
+				result.add(rru);
+			} catch (TransportException x) {
+				throw x;
+			} catch (Exception x) {
+				throw new TransportException(
+						"Problem with resolving push ref spec \"" + spec
+								+ "\" locally: " + x.getMessage(), x);
+			}
+		}
+		return result;
+	}
+
+	private static Collection<RefSpec> expandPushWildcardsFor(
+			final Repository db, final Collection<RefSpec> specs) {
+		final Map<String, Ref> localRefs = db.getAllRefs();
+		final Collection<RefSpec> procRefs = new HashSet<RefSpec>();
 
+		for (final RefSpec spec : specs) {
+			if (spec.isWildcard()) {
+				for (final Ref localRef : localRefs.values()) {
+					if (spec.matchSource(localRef))
+						procRefs.add(spec.expandFromSource(localRef));
+				}
+			} else {
+				procRefs.add(spec);
+			}
+		}
+		return procRefs;
+	}
+
+	private static String findTrackingRefName(final String remoteName,
+			final Collection<RefSpec> fetchSpecs) {
+		// try to find matching tracking refs
+		for (final RefSpec fetchSpec : fetchSpecs) {
+			if (fetchSpec.matchSource(remoteName)) {
+				if (fetchSpec.isWildcard())
+					return fetchSpec.expandFromSource(remoteName)
+							.getDestination();
+				else
+					return fetchSpec.getDestination();
+			}
+		}
+		return null;
+	}
+	
 	/**
 	 * Default setting for {@link #fetchThin} option.
 	 */
@@ -573,7 +658,10 @@ public abstract class Transport {
 	 * always set as null. Tracking branch is configured if RefSpec destination
 	 * matches source of any fetch ref spec for this transport remote
 	 * configuration.
-	 *
+	 * <p>
+	 * Conversion is performed for context of this transport (database, fetch
+	 * specifications).
+	 * 
 	 * @param specs
 	 *            collection of RefSpec to convert.
 	 * @return collection of set up {@link RemoteRefUpdate}.
@@ -583,30 +671,7 @@ public abstract class Transport {
 	 */
 	public Collection<RemoteRefUpdate> findRemoteRefUpdatesFor(
 			final Collection<RefSpec> specs) throws TransportException {
-		final List<RemoteRefUpdate> result = new LinkedList<RemoteRefUpdate>();
-		final Collection<RefSpec> procRefs = expandPushWildcardsFor(specs);
-
-		for (final RefSpec spec : procRefs) {
-			try {
-				final String srcRef = spec.getSource();
-				// null destination (no-colon in ref-spec) is a special case
-				final String remoteName = (spec.getDestination() == null ? spec
-						.getSource() : spec.getDestination());
-				final boolean forceUpdate = spec.isForceUpdate();
-				final String localName = findTrackingRefName(remoteName);
-
-				final RemoteRefUpdate rru = new RemoteRefUpdate(local, srcRef,
-						remoteName, forceUpdate, localName, null);
-				result.add(rru);
-			} catch (TransportException x) {
-				throw x;
-			} catch (Exception x) {
-				throw new TransportException(
-						"Problem with resolving push ref spec \"" + spec
-								+ "\" locally: " + x.getMessage(), x);
-			}
-		}
-		return result;
+		return findRemoteRefUpdatesFor(local, specs, fetch);
 	}
 
 	/**
@@ -642,36 +707,4 @@ public abstract class Transport {
 	 * any open file handles used to read the "remote" repository.
 	 */
 	public abstract void close();
-
-	private Collection<RefSpec> expandPushWildcardsFor(
-			final Collection<RefSpec> specs) {
-		final Map<String, Ref> localRefs = local.getAllRefs();
-		final Collection<RefSpec> procRefs = new HashSet<RefSpec>();
-
-		for (final RefSpec spec : specs) {
-			if (spec.isWildcard()) {
-				for (final Ref localRef : localRefs.values()) {
-					if (spec.matchSource(localRef))
-						procRefs.add(spec.expandFromSource(localRef));
-				}
-			} else {
-				procRefs.add(spec);
-			}
-		}
-		return procRefs;
-	}
-
-	private String findTrackingRefName(final String remoteName) {
-		// try to find matching tracking refs
-		for (final RefSpec fetchSpec : fetch) {
-			if (fetchSpec.matchSource(remoteName)) {
-				if (fetchSpec.isWildcard())
-					return fetchSpec.expandFromSource(remoteName)
-							.getDestination();
-				else
-					return fetchSpec.getDestination();
-			}
-		}
-		return null;
-	}
 }
-- 
1.5.6.3

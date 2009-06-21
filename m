From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Add support for remote.name.pushurl
Date: Sat, 20 Jun 2009 18:21:56 -0700
Message-ID: <1245547316-10299-2-git-send-email-spearce@spearce.org>
References: <1245547316-10299-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 03:23:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIBlv-0004JE-QU
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 03:23:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbZFUBV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 21:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbZFUBV7
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 21:21:59 -0400
Received: from george.spearce.org ([209.20.77.23]:39667 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbZFUBVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 21:21:55 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 22D49381FE; Sun, 21 Jun 2009 01:21:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id AFA8D381FD;
	Sun, 21 Jun 2009 01:21:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
In-Reply-To: <1245547316-10299-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121959>

In C Git commit 203462347fce Michael J Gruber added support for a
new URL key within a remote block, permitting a different URL to
be used for push than for fetch.  In the commit message he cites
an example where fetch runs over git://, but push uses ssh://,
as the git:// protocol has lower connection setup overheads.

This change complicates the Transport API as now we must know
in advance when the Transport.open() call is made what type of
operation the caller wants to perform, so we know which config
key to honor when constructing the Transport objects.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Push.java             |    3 +-
 .../org/spearce/jgit/transport/RemoteConfig.java   |   47 ++++++
 .../src/org/spearce/jgit/transport/Transport.java  |  150 ++++++++++++++++++--
 3 files changed, 190 insertions(+), 10 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index 19d31a1..9364e4a 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -102,7 +102,8 @@ protected void run() throws Exception {
 				refSpecs.add(spec.setForceUpdate(true));
 		}
 
-		final List<Transport> transports = Transport.openAll(db, remote);
+		final List<Transport> transports;
+		transports = Transport.openAll(db, remote, Transport.Operation.PUSH);
 		for (final Transport transport : transports) {
 			transport.setPushThin(thin);
 			if (receivePack != null)
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index 519a8a5..f7ed2d7 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -58,6 +58,8 @@
 
 	private static final String KEY_URL = "url";
 
+	private static final String KEY_PUSHURL = "pushurl";
+
 	private static final String KEY_FETCH = "fetch";
 
 	private static final String KEY_PUSH = "push";
@@ -108,6 +110,8 @@
 
 	private List<URIish> uris;
 
+	private List<URIish> pushURIs;
+
 	private List<RefSpec> fetch;
 
 	private List<RefSpec> push;
@@ -147,6 +151,11 @@ public RemoteConfig(final RepositoryConfig rc, final String remoteName)
 		for (final String s : vlst)
 			uris.add(new URIish(s));
 
+		vlst = rc.getStringList(SECTION, name, KEY_PUSHURL);
+		pushURIs = new ArrayList<URIish>(vlst.length);
+		for (final String s : vlst)
+			pushURIs.add(new URIish(s));
+
 		vlst = rc.getStringList(SECTION, name, KEY_FETCH);
 		fetch = new ArrayList<RefSpec>(vlst.length);
 		for (final String s : vlst)
@@ -187,6 +196,11 @@ public void update(final RepositoryConfig rc) {
 		rc.setStringList(SECTION, getName(), KEY_URL, vlst);
 
 		vlst.clear();
+		for (final URIish u : getPushURIs())
+			vlst.add(u.toPrivateString());
+		rc.setStringList(SECTION, getName(), KEY_PUSHURL, vlst);
+
+		vlst.clear();
 		for (final RefSpec u : getFetchRefSpecs())
 			vlst.add(u.toString());
 		rc.setStringList(SECTION, getName(), KEY_FETCH, vlst);
@@ -265,6 +279,39 @@ public boolean removeURI(final URIish toRemove) {
 	}
 
 	/**
+	 * Get all configured push-only URIs under this remote.
+	 * 
+	 * @return the set of URIs known to this remote.
+	 */
+	public List<URIish> getPushURIs() {
+		return Collections.unmodifiableList(pushURIs);
+	}
+
+	/**
+	 * Add a new push-only URI to the end of the list of URIs.
+	 * 
+	 * @param toAdd
+	 *            the new URI to add to this remote.
+	 * @return true if the URI was added; false if it already exists.
+	 */
+	public boolean addPushURI(final URIish toAdd) {
+		if (pushURIs.contains(toAdd))
+			return false;
+		return pushURIs.add(toAdd);
+	}
+
+	/**
+	 * Remove a push-only URI from the list of URIs.
+	 * 
+	 * @param toRemove
+	 *            the URI to remove from this remote.
+	 * @return true if the URI was added; false if it already exists.
+	 */
+	public boolean removePushURI(final URIish toRemove) {
+		return pushURIs.remove(toRemove);
+	}
+
+	/**
 	 * Remembered specifications for fetching from a repository.
 	 * 
 	 * @return set of specs used by default when fetching.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index c36ccdd..ac4807f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -72,8 +72,18 @@
  * Callers must ensure a transport is accessed by only one thread at a time.
  */
 public abstract class Transport {
+	/** Type of operation a Transport is being opened for. */
+	public enum Operation {
+		/** Transport is to fetch objects locally. */
+		FETCH,
+		/** Transport is to push objects remotely. */
+		PUSH;
+	}
+
 	/**
 	 * Open a new transport instance to connect two repositories.
+	 * <p>
+	 * This method assumes {@link Operation#FETCH}.
 	 * 
 	 * @param local
 	 *            existing local repository.
@@ -90,15 +100,41 @@
 	 */
 	public static Transport open(final Repository local, final String remote)
 			throws NotSupportedException, URISyntaxException {
+		return open(local, remote, Operation.FETCH);
+	}
+
+	/**
+	 * Open a new transport instance to connect two repositories.
+	 * 
+	 * @param local
+	 *            existing local repository.
+	 * @param remote
+	 *            location of the remote repository - may be URI or remote
+	 *            configuration name.
+	 * @param op
+	 *            planned use of the returned Transport; the URI may differ
+	 *            based on the type of connection desired.
+	 * @return the new transport instance. Never null. In case of multiple URIs
+	 *         in remote configuration, only the first is chosen.
+	 * @throws URISyntaxException
+	 *             the location is not a remote defined in the configuration
+	 *             file and is not a well-formed URL.
+	 * @throws NotSupportedException
+	 *             the protocol specified is not supported.
+	 */
+	public static Transport open(final Repository local, final String remote,
+			final Operation op) throws NotSupportedException,
+			URISyntaxException {
 		final RemoteConfig cfg = new RemoteConfig(local.getConfig(), remote);
-		final List<URIish> uris = cfg.getURIs();
-		if (uris.size() == 0)
+		if (doesNotExist(cfg))
 			return open(local, new URIish(remote));
-		return open(local, cfg);
+		return open(local, cfg, op);
 	}
 
 	/**
 	 * Open new transport instances to connect two repositories.
+	 * <p>
+	 * This method assumes {@link Operation#FETCH}.
 	 *
 	 * @param local
 	 *            existing local repository.
@@ -116,18 +152,44 @@ public static Transport open(final Repository local, final String remote)
 	public static List<Transport> openAll(final Repository local,
 			final String remote) throws NotSupportedException,
 			URISyntaxException {
+		return openAll(local, remote, Operation.FETCH);
+	}
+
+	/**
+	 * Open new transport instances to connect two repositories.
+	 *
+	 * @param local
+	 *            existing local repository.
+	 * @param remote
+	 *            location of the remote repository - may be URI or remote
+	 *            configuration name.
+	 * @param op
+	 *            planned use of the returned Transport; the URI may differ
+	 *            based on the type of connection desired.
+	 * @return the list of new transport instances for every URI in remote
+	 *         configuration.
+	 * @throws URISyntaxException
+	 *             the location is not a remote defined in the configuration
+	 *             file and is not a well-formed URL.
+	 * @throws NotSupportedException
+	 *             the protocol specified is not supported.
+	 */
+	public static List<Transport> openAll(final Repository local,
+			final String remote, final Operation op)
+			throws NotSupportedException, URISyntaxException {
 		final RemoteConfig cfg = new RemoteConfig(local.getConfig(), remote);
-		final List<URIish> uris = cfg.getURIs();
-		if (uris.size() == 0) {
+		if (doesNotExist(cfg)) {
 			final ArrayList<Transport> transports = new ArrayList<Transport>(1);
 			transports.add(open(local, new URIish(remote)));
 			return transports;
 		}
-		return openAll(local, cfg);
+		return openAll(local, cfg, op);
 	}
 
 	/**
 	 * Open a new transport instance to connect two repositories.
+	 * <p>
+	 * This method assumes {@link Operation#FETCH}.
 	 * 
 	 * @param local
 	 *            existing local repository.
@@ -144,17 +206,45 @@ public static Transport open(final Repository local, final String remote)
 	 */
 	public static Transport open(final Repository local, final RemoteConfig cfg)
 			throws NotSupportedException {
-		if (cfg.getURIs().isEmpty())
+		return open(local, cfg, Operation.FETCH);
+	}
+
+	/**
+	 * Open a new transport instance to connect two repositories.
+	 * 
+	 * @param local
+	 *            existing local repository.
+	 * @param cfg
+	 *            configuration describing how to connect to the remote
+	 *            repository.
+	 * @param op
+	 *            planned use of the returned Transport; the URI may differ
+	 *            based on the type of connection desired.
+	 * @return the new transport instance. Never null. In case of multiple URIs
+	 *         in remote configuration, only the first is chosen.
+	 * @throws NotSupportedException
+	 *             the protocol specified is not supported.
+	 * @throws IllegalArgumentException
+	 *             if provided remote configuration doesn't have any URI
+	 *             associated.
+	 */
+	public static Transport open(final Repository local,
+			final RemoteConfig cfg, final Operation op)
+			throws NotSupportedException {
+		final List<URIish> uris = getURIs(cfg, op);
+		if (uris.isEmpty())
 			throw new IllegalArgumentException(
 					"Remote config \""
 					+ cfg.getName() + "\" has no URIs associated");
-		final Transport tn = open(local, cfg.getURIs().get(0));
+		final Transport tn = open(local, uris.get(0));
 		tn.applyConfig(cfg);
 		return tn;
 	}
 
 	/**
 	 * Open new transport instances to connect two repositories.
+	 * <p>
+	 * This method assumes {@link Operation#FETCH}.
 	 *
 	 * @param local
 	 *            existing local repository.
@@ -168,7 +258,29 @@ public static Transport open(final Repository local, final RemoteConfig cfg)
 	 */
 	public static List<Transport> openAll(final Repository local,
 			final RemoteConfig cfg) throws NotSupportedException {
-		final List<URIish> uris = cfg.getURIs();
+		return openAll(local, cfg, Operation.FETCH);
+	}
+
+	/**
+	 * Open new transport instances to connect two repositories.
+	 *
+	 * @param local
+	 *            existing local repository.
+	 * @param cfg
+	 *            configuration describing how to connect to the remote
+	 *            repository.
+	 * @param op
+	 *            planned use of the returned Transport; the URI may differ
+	 *            based on the type of connection desired.
+	 * @return the list of new transport instances for every URI in remote
+	 *         configuration.
+	 * @throws NotSupportedException
+	 *             the protocol specified is not supported.
+	 */
+	public static List<Transport> openAll(final Repository local,
+			final RemoteConfig cfg, final Operation op)
+			throws NotSupportedException {
+		final List<URIish> uris = getURIs(cfg, op);
 		final List<Transport> transports = new ArrayList<Transport>(uris.size());
 		for (final URIish uri : uris) {
 			final Transport tn = open(local, uri);
@@ -178,6 +290,26 @@ public static Transport open(final Repository local, final RemoteConfig cfg)
 		return transports;
 	}
 
+	private static List<URIish> getURIs(final RemoteConfig cfg,
+			final Operation op) {
+		switch (op) {
+		case FETCH:
+			return cfg.getURIs();
+		case PUSH: {
+			List<URIish> uris = cfg.getPushURIs();
+			if (uris.isEmpty())
+				uris = cfg.getURIs();
+			return uris;
+		}
+		default:
+			throw new IllegalArgumentException(op.toString());
+		}
+	}
+
+	private static boolean doesNotExist(final RemoteConfig cfg) {
+		return cfg.getURIs().isEmpty() && cfg.getPushURIs().isEmpty();
+	}
+
 	/**
 	 * Open a new transport instance to connect two repositories.
 	 * 
-- 
1.6.3.2.416.g04d0

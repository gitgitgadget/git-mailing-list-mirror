From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 07/31] Add openAll() and applyConfig() methods to Transport
Date: Sun, 17 Aug 2008 22:43:48 +0200
Message-ID: <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:45:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8M-0002uV-UF
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYHQUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbYHQUoo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYHQUol (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=onRuaBcVw9gSh2eOzML1GkEzGNdNkeGWzP4MwZZ9SZ0=;
        b=G1SDEMdgU9+9OC732LOQ87bGeWUpm2FAfwv8SDOQuIHob358p8OlF+p2fP4J4jgJax
         gUkEABTTRSvpMJnVoOLUm86r3iozdSLpny+qCTj3E+VFbxFE5NLr4fN959NNuvcgM8YR
         XMETDVQ8kKUf1+IZgO+NkynlJ5kh+VQdaGT5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lunrOJTYH+Lqpu0NBNp2X66MG8APZPFXTv3DoiEI7rsjdcxkwpcT3fn+lROa9t+3z2
         lpKtzgDQ5D/Z4StXys3NHqzrxQXHTYyncYsovBO+rl/cH7q5mLj9AQJpwTYQj2GI9zLp
         RcbCc66P8qxR3YxTmP9m58ta7aKOr3zbCj3us=
Received: by 10.86.1.1 with SMTP id 1mr3967085fga.61.1219005880352;
        Sun, 17 Aug 2008 13:44:40 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id 12sm10364831fgg.0.2008.08.17.13.44.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92637>

openAll() method honours many URIs in remote configuration when opening
transports. Old open() calls remained, they still open only 1 transport
at time.

openAll() is used during push operation - pgm.Push implementation was
fixed to use it.

applyConfig() is used internally here, but could be interesting for
clients and it's safe to call it.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Push.java             |   44 ++++++-----
 .../src/org/spearce/jgit/transport/Transport.java  |   83 ++++++++++++++++++--
 2 files changed, 99 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index 6b35ab8..a952309 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -86,7 +86,7 @@ class Push extends TextBuiltin {
 	@Option(name = "--receive-pack", metaVar = "path")
 	private String receivePack;
 
-	private boolean first = true;
+	private boolean shownURI;
 
 	@Override
 	protected void run() throws Exception {
@@ -97,27 +97,31 @@ class Push extends TextBuiltin {
 				refSpecs.add(spec.setForceUpdate(true));
 		}
 
-		final Transport transport = Transport.open(db, remote);
-		transport.setPushThin(thin);
-		if (receivePack != null)
-			transport.setOptionReceivePack(receivePack);
-		final Collection<RemoteRefUpdate> toPush = transport
-				.findRemoteRefUpdatesFor(refSpecs);
+		final List<Transport> transports = Transport.openAll(db, remote);
+		for (final Transport transport : transports) {
+			transport.setPushThin(thin);
+			if (receivePack != null)
+				transport.setOptionReceivePack(receivePack);
 
-		final PushResult result = transport.push(new TextProgressMonitor(),
-				toPush);
-		transport.close();
+			final Collection<RemoteRefUpdate> toPush = transport
+					.findRemoteRefUpdatesFor(refSpecs);
 
-		printPushResult(result);
+			final PushResult result = transport.push(new TextProgressMonitor(),
+					toPush);
+			printPushResult(transport, result);
+		}
 	}
 
-	private void printPushResult(final PushResult result) {
+	private void printPushResult(final Transport transport,
+			final PushResult result) {
+		shownURI = false;
 		boolean everythingUpToDate = true;
+
 		// at first, print up-to-date ones...
 		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
 			if (rru.getStatus() == Status.UP_TO_DATE) {
 				if (verbose)
-					printRefUpdateResult(result, rru);
+					printRefUpdateResult(transport, result, rru);
 			} else
 				everythingUpToDate = false;
 		}
@@ -125,25 +129,25 @@ class Push extends TextBuiltin {
 		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
 			// ...then successful updates...
 			if (rru.getStatus() == Status.OK)
-				printRefUpdateResult(result, rru);
+				printRefUpdateResult(transport, result, rru);
 		}
 
 		for (final RemoteRefUpdate rru : result.getRemoteUpdates()) {
 			// ...finally, others (problematic)
 			if (rru.getStatus() != Status.OK
 					&& rru.getStatus() != Status.UP_TO_DATE)
-				printRefUpdateResult(result, rru);
+				printRefUpdateResult(transport, result, rru);
 		}
 
 		if (everythingUpToDate)
 			out.println("Everything up-to-date");
 	}
 
-	private void printRefUpdateResult(final PushResult result,
-			final RemoteRefUpdate rru) {
-		if (first) {
-			first = false;
-			out.format("To %s\n", result.getURI());
+	private void printRefUpdateResult(final Transport transport,
+			final PushResult result, final RemoteRefUpdate rru) {
+		if (!shownURI) {
+			shownURI = true;
+			out.format("To %s\n", transport.getURI());
 		}
 
 		final String remoteName = rru.getRemoteName();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 30175e3..73aa771 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -75,8 +75,10 @@ public abstract class Transport {
 	 * @param local
 	 *            existing local repository.
 	 * @param remote
-	 *            location of the remote repository.
-	 * @return the new transport instance. Never null.
+	 *            location of the remote repository - may be URI or remote
+	 *            configuration name.
+	 * @return the new transport instance. Never null. In case of multiple URIs
+	 *         in remote configuration, only the first is chosen.
 	 * @throws URISyntaxException
 	 *             the location is not a remote defined in the configuration
 	 *             file and is not a well-formed URL.
@@ -93,6 +95,35 @@ public abstract class Transport {
 	}
 
 	/**
+	 * Open new transport instances to connect two repositories.
+	 * 
+	 * @param local
+	 *            existing local repository.
+	 * @param remote
+	 *            location of the remote repository - may be URI or remote
+	 *            configuration name.
+	 * @return the list of new transport instances for every URI in remote
+	 *         configuration.
+	 * @throws URISyntaxException
+	 *             the location is not a remote defined in the configuration
+	 *             file and is not a well-formed URL.
+	 * @throws NotSupportedException
+	 *             the protocol specified is not supported.
+	 */
+	public static List<Transport> openAll(final Repository local,
+			final String remote) throws NotSupportedException,
+			URISyntaxException {
+		final RemoteConfig cfg = new RemoteConfig(local.getConfig(), remote);
+		final List<URIish> uris = cfg.getURIs();
+		if (uris.size() == 0) {
+			final ArrayList<Transport> transports = new ArrayList<Transport>(1);
+			transports.add(open(local, new URIish(remote)));
+			return transports;
+		}
+		return openAll(local, cfg);
+	}
+
+	/**
 	 * Open a new transport instance to connect two repositories.
 	 * 
 	 * @param local
@@ -100,7 +131,8 @@ public abstract class Transport {
 	 * @param cfg
 	 *            configuration describing how to connect to the remote
 	 *            repository.
-	 * @return the new transport instance. Never null.
+	 * @return the new transport instance. Never null. In case of multiple URIs
+	 *         in remote configuration, only the first is chosen.
 	 * @throws NotSupportedException
 	 *             the protocol specified is not supported.
 	 * @throws IllegalArgumentException
@@ -114,15 +146,36 @@ public abstract class Transport {
 					"Remote config \""
 					+ cfg.getName() + "\" has no URIs associated");
 		final Transport tn = open(local, cfg.getURIs().get(0));
-		tn.setOptionUploadPack(cfg.getUploadPack());
-		tn.fetch = cfg.getFetchRefSpecs();
-		tn.tagopt = cfg.getTagOpt();
-		tn.setOptionReceivePack(cfg.getReceivePack());
-		tn.push = cfg.getPushRefSpecs();
+		tn.applyConfig(cfg);
 		return tn;
 	}
 
 	/**
+	 * Open new transport instances to connect two repositories.
+	 * 
+	 * @param local
+	 *            existing local repository.
+	 * @param cfg
+	 *            configuration describing how to connect to the remote
+	 *            repository.
+	 * @return the list of new transport instances for every URI in remote
+	 *         configuration.
+	 * @throws NotSupportedException
+	 *             the protocol specified is not supported.
+	 */
+	public static List<Transport> openAll(final Repository local,
+			final RemoteConfig cfg) throws NotSupportedException {
+		final List<URIish> uris = cfg.getURIs();
+		final List<Transport> transports = new ArrayList<Transport>(uris.size());
+		for (final URIish uri : uris) {
+			final Transport tn = open(local, uri);
+			tn.applyConfig(cfg);
+			transports.add(tn);
+		}
+		return transports;
+	}
+
+	/**
 	 * Open a new transport instance to connect two repositories.
 	 * 
 	 * @param local
@@ -357,6 +410,20 @@ public abstract class Transport {
 	public void setPushThin(final boolean pushThin) {
 		this.pushThin = pushThin;
 	}
+	
+	/**
+	 * Apply provided remote configuration on this transport.
+	 * 
+	 * @param cfg
+	 *            configuration to apply on this transport.
+	 */
+	public void applyConfig(final RemoteConfig cfg) {
+		setOptionUploadPack(cfg.getUploadPack());
+		fetch = cfg.getFetchRefSpecs();
+		setTagOpt(cfg.getTagOpt());
+		optionReceivePack = cfg.getReceivePack();
+		push = cfg.getPushRefSpecs();
+	}
 
 	/**
 	 * Fetch objects and refs from the remote repository to the local one.
-- 
1.5.6.3

From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 08/31] Add dryRun option to Transport and console push
Date: Sun, 17 Aug 2008 22:43:49 +0200
Message-ID: <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8N-0002uV-JG
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYHQUor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYHQUor
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:27774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYHQUop (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489195fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=GeRad2tDepgIP2/03+2nOo3N2mtU2rzNy7bc232Gce0=;
        b=kjAuDpMOPb37H7pc4umGMyAWPzMRMKi8TJamMkvnHm9kT9QuYxcp7pWpD/ua2a5WSp
         JpLx5MtoaxEVFwEU6dJ8EDXy9HSfn/v4uNo+flr1AkoSKlxSh3S6ZHhvlSiVg8BhwTFu
         54WTiPUCKWRFBXW+ZR6FsCOafnczSqUoTENlI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=X7eSY8Sdc9IZMHeQmGZPOfT6q7RkKf6WZ17eoYbPXCiD4Lop6F2+FmxDk59ZqlrHkj
         Tc3vjg3sehLPfzC+OWGDozc4rU40dS01xcasd7XiEiV3Ywsd2PlZm/aRB6HZZFSVSEsc
         pNHnh3Q4oqa+ciSIbZAcsuJ60T9Lee7Y+ErhQ=
Received: by 10.103.173.5 with SMTP id a5mr3469787mup.117.1219005883738;
        Sun, 17 Aug 2008 13:44:43 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id i5sm1683261mue.11.2008.08.17.13.44.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92640>

Implementation of C Git --dry-run behavior for push operation.
It allows investigating possible push result, while not performing real
push operation - not updating remote refs.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Push.java             |    4 ++
 .../org/spearce/jgit/transport/PushProcess.java    |   18 +++++++-
 .../src/org/spearce/jgit/transport/Transport.java  |   40 ++++++++++++++++++--
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index a952309..f5b24c6 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -85,6 +85,9 @@ class Push extends TextBuiltin {
 
 	@Option(name = "--receive-pack", metaVar = "path")
 	private String receivePack;
+	
+	@Option(name = "--dry-run")
+	private boolean dryRun = Transport.DEFAULT_DRY_RUN;
 
 	private boolean shownURI;
 
@@ -102,6 +105,7 @@ class Push extends TextBuiltin {
 			transport.setPushThin(thin);
 			if (receivePack != null)
 				transport.setOptionReceivePack(receivePack);
+			transport.setDryRun(dryRun);
 
 			final Collection<RemoteRefUpdate> toPush = transport
 					.findRemoteRefUpdatesFor(refSpecs);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
index 6a2176f..cafec05 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PushProcess.java
@@ -100,7 +100,10 @@ class PushProcess {
 	/**
 	 * Perform push operation between local and remote repository - set remote
 	 * refs appropriately, send needed objects and update local tracking refs.
-	 *
+	 * <p>
+	 * When {@link Transport#isDryRun()} is true, result of this operation is
+	 * just estimation of real operation result, no real action is performed.
+	 * 
 	 * @param monitor
 	 *            progress monitor used for feedback about operation.
 	 * @return result of push operation with complete status description.
@@ -118,12 +121,15 @@ class PushProcess {
 			monitor.endTask();
 
 			final Map<String, RemoteRefUpdate> preprocessed = prepareRemoteUpdates();
-			if (!preprocessed.isEmpty())
+			if (transport.isDryRun())
+				modifyUpdatesForDryRun();
+			else if (!preprocessed.isEmpty())
 				connection.push(monitor, preprocessed);
 		} finally {
 			connection.close();
 		}
-		updateTrackingRefs();
+		if (!transport.isDryRun())
+			updateTrackingRefs();
 		return prepareOperationResult();
 	}
 
@@ -191,6 +197,12 @@ class PushProcess {
 		return result;
 	}
 
+	private void modifyUpdatesForDryRun() {
+		for (final RemoteRefUpdate rru : toPush.values())
+			if (rru.getStatus() == Status.NOT_ATTEMPTED)
+				rru.setStatus(Status.OK);
+	}
+
 	private void updateTrackingRefs() {
 		for (final RemoteRefUpdate rru : toPush.values()) {
 			final Status status = rru.getStatus();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 73aa771..98853e6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -236,6 +236,11 @@ public abstract class Transport {
 	public static final RefSpec REFSPEC_PUSH_ALL = new RefSpec(
 			"refs/heads/*:refs/heads/*");
 
+	/**
+	 * Default setting for {@link #dryRun} option.
+	 */
+	public static final boolean DEFAULT_DRY_RUN = false;
+
 	/** The repository this transport fetches into, or pushes out of. */
 	protected final Repository local;
 
@@ -271,6 +276,9 @@ public abstract class Transport {
 	/** Should push produce thin-pack when sending objects to remote repository. */
 	private boolean pushThin = DEFAULT_PUSH_THIN;
 
+	/** Should push just check for operation result, not really push. */
+	private boolean dryRun = DEFAULT_DRY_RUN;
+
 	/**
 	 * Create a new transport instance.
 	 * 
@@ -426,6 +434,27 @@ public abstract class Transport {
 	}
 
 	/**
+	 * @return true if push operation should just check for possible result and
+	 *         not really update remote refs, false otherwise - when push should
+	 *         act normally.
+	 */
+	public boolean isDryRun() {
+		return dryRun;
+	}
+
+	/**
+	 * Set dry run option for push operation.
+	 * 
+	 * @param dryRun
+	 *            true if push operation should just check for possible result
+	 *            and not really update remote refs, false otherwise - when push
+	 *            should act normally.
+	 */
+	public void setDryRun(final boolean dryRun) {
+		this.dryRun = dryRun;
+	}
+
+	/**
 	 * Fetch objects and refs from the remote repository to the local one.
 	 * <p>
 	 * This is a utility function providing standard fetch behavior. Local
@@ -495,10 +524,13 @@ public abstract class Transport {
 	 * operation result is provided after execution.
 	 * <p>
 	 * For setting up remote ref update specification from ref spec, see helper
-	 * method {@link #findRemoteRefUpdatesFor(Collection)}, predefined refspecs ({@link #REFSPEC_TAGS},
-	 * {@link #REFSPEC_PUSH_ALL}) or consider using directly
-	 * {@link RemoteRefUpdate} for more possibilities.
-	 *
+	 * method {@link #findRemoteRefUpdatesFor(Collection)}, predefined refspecs
+	 * ({@link #REFSPEC_TAGS}, {@link #REFSPEC_PUSH_ALL}) or consider using
+	 * directly {@link RemoteRefUpdate} for more possibilities.
+	 * <p>
+	 * When {@link #isDryRun()} is true, result of this operation is just
+	 * estimation of real operation result, no real action is performed.
+	 * 
 	 * @see RemoteRefUpdate
 	 *
 	 * @param monitor
-- 
1.5.6.3

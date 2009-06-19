From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 6/6] Add --timeout command line options
Date: Fri, 19 Jun 2009 14:27:55 -0700
Message-ID: <1245446875-31102-7-git-send-email-spearce@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org>
 <1245446875-31102-2-git-send-email-spearce@spearce.org>
 <1245446875-31102-3-git-send-email-spearce@spearce.org>
 <1245446875-31102-4-git-send-email-spearce@spearce.org>
 <1245446875-31102-5-git-send-email-spearce@spearce.org>
 <1245446875-31102-6-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHlde-0002a5-RL
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 23:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601AbZFSV2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756496AbZFSV2Q
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 17:28:16 -0400
Received: from george.spearce.org ([209.20.77.23]:42467 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZFSV2B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 17:28:01 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 72925381FD; Fri, 19 Jun 2009 21:28:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id EBFE03821F;
	Fri, 19 Jun 2009 21:27:57 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
In-Reply-To: <1245446875-31102-6-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121916>

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Daemon.java           |    5 +++++
 .../src/org/spearce/jgit/pgm/Fetch.java            |    5 +++++
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    6 ++++++
 .../src/org/spearce/jgit/pgm/Push.java             |    5 +++++
 .../src/org/spearce/jgit/pgm/UploadPack.java       |    6 ++++++
 5 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
index e064fd8..6508910 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
@@ -54,6 +54,9 @@
 	@Option(name = "--listen", metaVar = "HOSTNAME", usage = "hostname (or ip) to listen on")
 	String host;
 
+	@Option(name = "--timeout", metaVar = "SECONDS", usage = "abort connection if no activity")
+	int timeout = -1;
+
 	@Option(name = "--enable", metaVar = "SERVICE", usage = "enable the service in all repositories", multiValued = true)
 	final List<String> enable = new ArrayList<String>();
 
@@ -85,6 +88,8 @@ protected void run() throws Exception {
 				host != null ? new InetSocketAddress(host, port)
 						: new InetSocketAddress(port));
 		d.setExportAll(exportAll);
+		if (0 <= timeout)
+			d.setTimeout(timeout);
 
 		for (final String n : enable)
 			service(d, n).setEnabled(true);
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index 81d6893..d7be9fa 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -48,6 +48,9 @@
 
 @Command(common = true, usage = "Update remote refs from another repository")
 class Fetch extends AbstractFetchCommand {
+	@Option(name = "--timeout", metaVar = "SECONDS", usage = "abort connection if no activity")
+	int timeout = -1;
+
 	@Option(name = "--fsck", usage = "perform fsck style checks on receive")
 	private Boolean fsck;
 
@@ -86,6 +89,8 @@ protected void run() throws Exception {
 		tn.setDryRun(dryRun);
 		if (thin != null)
 			tn.setFetchThin(thin.booleanValue());
+		if (0 <= timeout)
+			tn.setTimeout(timeout);
 		final FetchResult r;
 		try {
 			r = tn.fetch(new TextProgressMonitor(), toget);
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
index bfa38ec..da2de9a 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/LsRemote.java
@@ -38,18 +38,24 @@
 package org.spearce.jgit.pgm;
 
 import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.AnyObjectId;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.transport.FetchConnection;
 import org.spearce.jgit.transport.Transport;
 
 class LsRemote extends TextBuiltin {
+	@Option(name = "--timeout", metaVar = "SECONDS", usage = "abort connection if no activity")
+	int timeout = -1;
+
 	@Argument(index = 0, metaVar = "uri-ish", required = true)
 	private String remote;
 
 	@Override
 	protected void run() throws Exception {
 		final Transport tn = Transport.open(db, remote);
+		if (0 <= timeout)
+			tn.setTimeout(timeout);
 		final FetchConnection c = tn.openFetch();
 		try {
 			for (final Ref r : c.getRefs()) {
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index 19d31a1..018a521 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -55,6 +55,9 @@
 
 @Command(common = true, usage = "Update remote repository from local refs")
 class Push extends TextBuiltin {
+	@Option(name = "--timeout", metaVar = "SECONDS", usage = "abort connection if no activity")
+	int timeout = -1;
+
 	@Argument(index = 0, metaVar = "uri-ish")
 	private String remote = "origin";
 
@@ -104,6 +107,8 @@ protected void run() throws Exception {
 
 		final List<Transport> transports = Transport.openAll(db, remote);
 		for (final Transport transport : transports) {
+			if (0 <= timeout)
+				transport.setTimeout(timeout);
 			transport.setPushThin(thin);
 			if (receivePack != null)
 				transport.setOptionReceivePack(receivePack);
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
index d09d442..1d9af24 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/UploadPack.java
@@ -40,10 +40,14 @@
 import java.io.File;
 
 import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
 import org.spearce.jgit.lib.Repository;
 
 @Command(common = false, usage = "Server side backend for 'jgit fetch'")
 class UploadPack extends TextBuiltin {
+	@Option(name = "--timeout", metaVar = "SECONDS", usage = "abort connection if no activity")
+	int timeout = -1;
+
 	@Argument(index = 0, required = true, metaVar = "DIRECTORY", usage = "Repository to read from")
 	File srcGitdir;
 
@@ -62,6 +66,8 @@ protected void run() throws Exception {
 		if (!db.getObjectsDirectory().isDirectory())
 			throw die("'" + srcGitdir.getPath() + "' not a git repository");
 		rp = new org.spearce.jgit.transport.UploadPack(db);
+		if (0 <= timeout)
+			rp.setTimeout(timeout);
 		rp.upload(System.in, System.out, System.err);
 	}
 }
-- 
1.6.3.2.416.g04d0

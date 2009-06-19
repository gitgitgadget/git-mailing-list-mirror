From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/6] Add remote.name.timeout to configure an IO timeout
Date: Fri, 19 Jun 2009 14:27:51 -0700
Message-ID: <1245446875-31102-3-git-send-email-spearce@spearce.org>
References: <1245446875-31102-1-git-send-email-spearce@spearce.org>
 <1245446875-31102-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHldb-0002a5-ND
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 23:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbZFSV2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 17:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755041AbZFSV2C
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 17:28:02 -0400
Received: from george.spearce.org ([209.20.77.23]:42455 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZFSV14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 17:27:56 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 858F738200; Fri, 19 Jun 2009 21:27:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 60FF2381FE;
	Fri, 19 Jun 2009 21:27:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
In-Reply-To: <1245446875-31102-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121914>

An IO timeout can be useful if the remote peer stops responding,
and the user wants the application to abort rather than block
indefinitely waiting for more input.

This is a JGit specific extension to the standard remote format.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/RemoteConfigTest.java   |   26 ++++++++++++++++
 .../org/spearce/jgit/transport/RemoteConfig.java   |   31 ++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
index 6b72b64..3965bdb 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/RemoteConfigTest.java
@@ -78,6 +78,7 @@ writeConfig("[remote \"spearce\"]\n"
 		assertNotNull(rc.getFetchRefSpecs());
 		assertNotNull(rc.getPushRefSpecs());
 		assertNotNull(rc.getTagOpt());
+		assertEquals(0, rc.getTimeout());
 		assertSame(TagOpt.AUTO_FOLLOW, rc.getTagOpt());
 
 		assertEquals(1, allURIs.size());
@@ -423,4 +424,29 @@ checkFile(new File(db.getDirectory(), "config"), "[core]\n"
 				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
 				+ "\ttagopt = --tags\n");
 	}
+
+	public void testSimpleTimeout() throws Exception {
+		writeConfig("[remote \"spearce\"]\n"
+				+ "url = http://www.spearce.org/egit.git\n"
+				+ "fetch = +refs/heads/*:refs/remotes/spearce/*\n"
+				+ "timeout = 12\n");
+		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "spearce");
+		assertEquals(12, rc.getTimeout());
+	}
+
+	public void testSaveTimeout() throws Exception {
+		final RemoteConfig rc = new RemoteConfig(db.getConfig(), "origin");
+		rc.addURI(new URIish("/some/dir"));
+		rc.addFetchRefSpec(new RefSpec("+refs/heads/*:refs/remotes/"
+				+ rc.getName() + "/*"));
+		rc.setTimeout(60);
+		rc.update(db.getConfig());
+		db.getConfig().save();
+
+		checkFile(new File(db.getDirectory(), "config"), "[core]\n"
+				+ "\trepositoryformatversion = 0\n" + "\tfilemode = true\n"
+				+ "[remote \"origin\"]\n" + "\turl = /some/dir\n"
+				+ "\tfetch = +refs/heads/*:refs/remotes/origin/*\n"
+				+ "\ttimeout = 60\n");
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index 519a8a5..a621dc4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -70,6 +70,8 @@
 
 	private static final String KEY_MIRROR = "mirror";
 
+	private static final String KEY_TIMEOUT = "timeout";
+
 	private static final boolean DEFAULT_MIRROR = false;
 
 	/** Default value for {@link #getUploadPack()} if not specified. */
@@ -120,6 +122,8 @@
 
 	private boolean mirror;
 
+	private int timeout;
+
 	/**
 	 * Parse a remote block from an existing configuration file.
 	 * <p>
@@ -170,6 +174,7 @@ public RemoteConfig(final RepositoryConfig rc, final String remoteName)
 		val = rc.getString(SECTION, name, KEY_TAGOPT);
 		tagopt = TagOpt.fromOption(val);
 		mirror = rc.getBoolean(SECTION, name, KEY_MIRROR, DEFAULT_MIRROR);
+		timeout = rc.getInt(SECTION, name, KEY_TIMEOUT, 0);
 	}
 
 	/**
@@ -200,6 +205,7 @@ public void update(final RepositoryConfig rc) {
 		set(rc, KEY_RECEIVEPACK, getReceivePack(), DEFAULT_RECEIVE_PACK);
 		set(rc, KEY_TAGOPT, getTagOpt().option(), TagOpt.AUTO_FOLLOW.option());
 		set(rc, KEY_MIRROR, mirror, DEFAULT_MIRROR);
+		set(rc, KEY_TIMEOUT, timeout, 0);
 	}
 
 	private void set(final RepositoryConfig rc, final String key,
@@ -218,6 +224,14 @@ private void set(final RepositoryConfig rc, final String key,
 			rc.setBoolean(SECTION, getName(), key, currentValue);
 	}
 
+	private void set(final RepositoryConfig rc, final String key,
+			final int currentValue, final int defaultValue) {
+		if (defaultValue == currentValue)
+			unset(rc, key);
+		else
+			rc.setInt(SECTION, getName(), key, currentValue);
+	}
+
 	private void unset(final RepositoryConfig rc, final String key) {
 		rc.unsetString(SECTION, getName(), key);
 	}
@@ -420,4 +434,21 @@ public boolean isMirror() {
 	public void setMirror(final boolean m) {
 		mirror = m;
 	}
+
+	/** @return timeout (in seconds) before aborting an IO operation. */
+	public int getTimeout() {
+		return timeout;
+	}
+
+	/**
+	 * Set the timeout before willing to abort an IO call.
+	 *
+	 * @param seconds
+	 *            number of seconds to wait (with no data transfer occurring)
+	 *            before aborting an IO read or write operation with this
+	 *            remote.  A timeout of 0 will block indefinitely.
+	 */
+	public void setTimeout(final int seconds) {
+		timeout = seconds;
+	}
 }
-- 
1.6.3.2.416.g04d0

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 4/6] Add the remote.name.mirror flag to RemoteConfig
Date: Thu, 12 Feb 2009 15:54:38 -0800
Message-ID: <1234482880-1316-5-git-send-email-spearce@spearce.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
 <1234482880-1316-2-git-send-email-spearce@spearce.org>
 <1234482880-1316-3-git-send-email-spearce@spearce.org>
 <1234482880-1316-4-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:56:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlPn-0004ei-VQ
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbZBLXyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbZBLXyx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:54:53 -0500
Received: from george.spearce.org ([209.20.77.23]:49159 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117AbZBLXyp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:54:45 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D684438260; Thu, 12 Feb 2009 23:54:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D5A1F3819E;
	Thu, 12 Feb 2009 23:54:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.2.rc0.226.gf08f
In-Reply-To: <1234482880-1316-4-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109687>

This flag is currently only honored by "git push" to delete remote
refs if they are also gone on the source side.  It also causes the
default push spec to be "+refs/*:refs/*" if the user hasn't given
us any other push specs.

This change only implements the config file parsing for the mirror
flag, as there's still a chunk of code needed on the transport to
actually honor it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/RemoteConfig.java   |   40 +++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index 5bbf664..519a8a5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -68,6 +68,10 @@
 
 	private static final String KEY_TAGOPT = "tagopt";
 
+	private static final String KEY_MIRROR = "mirror";
+
+	private static final boolean DEFAULT_MIRROR = false;
+
 	/** Default value for {@link #getUploadPack()} if not specified. */
 	public static final String DEFAULT_UPLOAD_PACK = "git-upload-pack";
 
@@ -114,6 +118,8 @@
 
 	private TagOpt tagopt;
 
+	private boolean mirror;
+
 	/**
 	 * Parse a remote block from an existing configuration file.
 	 * <p>
@@ -163,6 +169,7 @@ public RemoteConfig(final RepositoryConfig rc, final String remoteName)
 
 		val = rc.getString(SECTION, name, KEY_TAGOPT);
 		tagopt = TagOpt.fromOption(val);
+		mirror = rc.getBoolean(SECTION, name, KEY_MIRROR, DEFAULT_MIRROR);
 	}
 
 	/**
@@ -192,16 +199,29 @@ public void update(final RepositoryConfig rc) {
 		set(rc, KEY_UPLOADPACK, getUploadPack(), DEFAULT_UPLOAD_PACK);
 		set(rc, KEY_RECEIVEPACK, getReceivePack(), DEFAULT_RECEIVE_PACK);
 		set(rc, KEY_TAGOPT, getTagOpt().option(), TagOpt.AUTO_FOLLOW.option());
+		set(rc, KEY_MIRROR, mirror, DEFAULT_MIRROR);
 	}
 
 	private void set(final RepositoryConfig rc, final String key,
 			final String currentValue, final String defaultValue) {
 		if (defaultValue.equals(currentValue))
-			rc.unsetString(SECTION, getName(), key);
+			unset(rc, key);
 		else
 			rc.setString(SECTION, getName(), key, currentValue);
 	}
 
+	private void set(final RepositoryConfig rc, final String key,
+			final boolean currentValue, final boolean defaultValue) {
+		if (defaultValue == currentValue)
+			unset(rc, key);
+		else
+			rc.setBoolean(SECTION, getName(), key, currentValue);
+	}
+
+	private void unset(final RepositoryConfig rc, final String key) {
+		rc.unsetString(SECTION, getName(), key);
+	}
+
 	/**
 	 * Get the local name this remote configuration is recognized as.
 	 * 
@@ -382,4 +402,22 @@ public TagOpt getTagOpt() {
 	public void setTagOpt(final TagOpt option) {
 		tagopt = option != null ? option : TagOpt.AUTO_FOLLOW;
 	}
+
+	/**
+	 * @return true if pushing to the remote automatically deletes remote refs
+	 *         which don't exist on the source side.
+	 */
+	public boolean isMirror() {
+		return mirror;
+	}
+
+	/**
+	 * Set the mirror flag to automatically delete remote refs.
+	 *
+	 * @param m
+	 *            true to automatically delete remote refs during push.
+	 */
+	public void setMirror(final boolean m) {
+		mirror = m;
+	}
 }
-- 
1.6.2.rc0.226.gf08f

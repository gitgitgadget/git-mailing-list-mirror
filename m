From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/3] Allow the reflog identity to be set in ReceivePack
Date: Wed,  4 Feb 2009 15:15:41 -0800
Message-ID: <1233789342-28079-2-git-send-email-spearce@spearce.org>
References: <1233789342-28079-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:17:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqzf-0003e7-Gl
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbZBDXPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbZBDXPq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:15:46 -0500
Received: from george.spearce.org ([209.20.77.23]:54322 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360AbZBDXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:15:45 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 4A9D438215; Wed,  4 Feb 2009 23:15:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 1FFDF38210;
	Wed,  4 Feb 2009 23:15:43 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.2.492.g8554a
In-Reply-To: <1233789342-28079-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108458>

Daemons which run ReceivePack can now set the identity used to
record updates in the reflog of any affected refs.  If not set
then it defaults to the repository owner's identity, or that
of the running JVM.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/ReceivePack.java    |   26 ++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index bb6bf26..ba09366 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -57,6 +57,7 @@
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.NullProgressMonitor;
 import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PersonIdent;
 import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.lib.RefComparator;
 import org.spearce.jgit.lib.RefUpdate;
@@ -94,6 +95,9 @@
 	/** Should an incoming transfer permit non-fast-forward requests? */
 	private boolean allowNonFastForwards;
 
+	/** Identity to record action as within the reflog. */
+	private PersonIdent refLogIdent;
+
 	/** Hook to validate the update commands before execution. */
 	private PreReceiveHook preReceive;
 
@@ -221,6 +225,27 @@ public void setAllowNonFastForwards(final boolean canRewind) {
 		allowNonFastForwards = canRewind;
 	}
 
+	/** @return identity of the user making the changes in the reflog. */
+	public PersonIdent getRefLogIdent() {
+		return refLogIdent;
+	}
+
+	/**
+	 * Set the identity of the user appearing in the affected reflogs.
+	 * <p>
+	 * The timestamp portion of the identity is ignored. A new identity with the
+	 * current timestamp will be created automatically when the updates occur
+	 * and the log records are written.
+	 * 
+	 * @param pi
+	 *            identity of the user. If null the identity will be
+	 *            automatically determined based on the repository
+	 *            configuration.
+	 */
+	public void setRefLogIdent(final PersonIdent pi) {
+		refLogIdent = pi;
+	}
+
 	/** @return get the hook invoked before updates occur. */
 	public PreReceiveHook getPreReceiveHook() {
 		return preReceive;
@@ -645,6 +670,7 @@ private void executeCommands() {
 	private void execute(final ReceiveCommand cmd) {
 		try {
 			final RefUpdate ru = db.updateRef(cmd.getRefName());
+			ru.setRefLogIdent(getRefLogIdent());
 			switch (cmd.getType()) {
 			case DELETE:
 				if (!ObjectId.zeroId().equals(cmd.getOldId())) {
-- 
1.6.1.2.492.g8554a

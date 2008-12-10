From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 3/3] Change AnyObjectId.abbreviate() to return AbbreviatedObjectId
Date: Wed, 10 Dec 2008 15:18:27 -0800
Message-ID: <1228951107-5546-4-git-send-email-spearce@spearce.org>
References: <1228951107-5546-1-git-send-email-spearce@spearce.org>
 <1228951107-5546-2-git-send-email-spearce@spearce.org>
 <1228951107-5546-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAYLk-0005dF-Dx
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 00:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbYLJXSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 18:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbYLJXSg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 18:18:36 -0500
Received: from george.spearce.org ([209.20.77.23]:41571 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbYLJXSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 18:18:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 2F44538210; Wed, 10 Dec 2008 23:18:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id D35CF38211;
	Wed, 10 Dec 2008 23:18:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.299.gead4c
In-Reply-To: <1228951107-5546-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102737>

By returning our abstraction type we can reuse the logic inside
AbbreviatedObjectId to format the abbreviated string.  A result
can also be used to test against another ObjectId.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../ui/internal/components/RefContentProposal.java |    2 +-
 .../egit/ui/internal/fetch/FetchResultTable.java   |   12 ++++----
 .../egit/ui/internal/push/PushResultTable.java     |   21 ++++++++-------
 .../src/org/spearce/jgit/pgm/Branch.java           |    2 +-
 .../src/org/spearce/jgit/pgm/Fetch.java            |    8 +++---
 .../src/org/spearce/jgit/pgm/Push.java             |    5 ++-
 .../org/spearce/jgit/lib/AbbreviatedObjectId.java  |    4 +-
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   26 +++++++++++++++++--
 8 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
index 60abaf3..b63c428 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefContentProposal.java
@@ -111,7 +111,7 @@ public String getDescription() {
 		final StringBuilder sb = new StringBuilder();
 		sb.append(refName);
 		sb.append('\n');
-		sb.append(objectId.abbreviate(db));
+		sb.append(objectId.abbreviate(db).name());
 		sb.append(" - ");
 		if (obj instanceof Commit) {
 			final Commit c = ((Commit) obj);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
index 868ca94..f1169d1 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/fetch/FetchResultTable.java
@@ -137,15 +137,15 @@ else if (tru.getLocalName().startsWith(Constants.R_TAGS))
 				}
 
 				if (r == RefUpdate.Result.FORCED) {
-					final String aOld = tru.getOldObjectId().abbreviate(db);
-					final String aNew = tru.getNewObjectId().abbreviate(db);
-					return aOld + "..." + aNew; //$NON-NLS-1$
+					final String o = tru.getOldObjectId().abbreviate(db).name();
+					final String n = tru.getNewObjectId().abbreviate(db).name();
+					return o + "..." + n; //$NON-NLS-1$
 				}
 
 				if (r == RefUpdate.Result.FAST_FORWARD) {
-					final String aOld = tru.getOldObjectId().abbreviate(db);
-					final String aNew = tru.getNewObjectId().abbreviate(db);
-					return aOld + ".." + aNew; //$NON-NLS-1$
+					final String o = tru.getOldObjectId().abbreviate(db).name();
+					final String n = tru.getNewObjectId().abbreviate(db).name();
+					return o + ".." + n; //$NON-NLS-1$
 				}
 
 				if (r == RefUpdate.Result.REJECTED)
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
index c5e476b..6f460dc 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/push/PushResultTable.java
@@ -233,9 +233,9 @@ public String getText(Object element) {
 					return UIText.PushResultTable_statusOkNewBranch;
 				}
 
-				return oldRef.getObjectId().abbreviate(localDb)
+				return oldRef.getObjectId().abbreviate(localDb).name()
 						+ (rru.isFastForward() ? ".." : "...")
-						+ rru.getNewObjectId().abbreviate(localDb);
+						+ rru.getNewObjectId().abbreviate(localDb).name();
 			case UP_TO_DATE:
 				return UIText.PushResultTable_statusUpToDate;
 			case NON_EXISTING:
@@ -289,7 +289,7 @@ public String getToolTipText(Object element) {
 			case OK:
 				if (rru.isDelete())
 					return NLS.bind(UIText.PushResultTable_statusDetailDeleted,
-							oldRef.getObjectId().abbreviate(localDb));
+							oldRef.getObjectId().abbreviate(localDb).name());
 				if (oldRef == null)
 					return null;
 				if (rru.isFastForward())
@@ -305,20 +305,21 @@ public String getToolTipText(Object element) {
 				return UIText.PushResultTable_statusDetailNonFastForward;
 			case REJECTED_REMOTE_CHANGED:
 				final Ref remoteRef = oldRef;
-				final String currentValue;
+				final String curVal;
 				if (remoteRef == null)
-					currentValue = UIText.PushResultTable_refNonExisting;
+					curVal = UIText.PushResultTable_refNonExisting;
 				else
-					currentValue = remoteRef.getObjectId().abbreviate(localDb);
+					curVal = remoteRef.getObjectId().abbreviate(localDb).name();
+
 				final ObjectId expectedOldObjectId = rru
 						.getExpectedOldObjectId();
-				final String expectedValue;
+				final String expVal;
 				if (expectedOldObjectId.equals(ObjectId.zeroId()))
-					expectedValue = UIText.PushResultTable_refNonExisting;
+					expVal = UIText.PushResultTable_refNonExisting;
 				else
-					expectedValue = expectedOldObjectId.abbreviate(localDb);
+					expVal = expectedOldObjectId.abbreviate(localDb).name();
 				return NLS.bind(UIText.PushResultTable_statusDetailChanged,
-						currentValue, expectedValue);
+						curVal, expVal);
 			case REJECTED_OTHER_REASON:
 				return rru.getMessage();
 			default:
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
index db0aab8..11002f0 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Branch.java
@@ -167,7 +167,7 @@ private void printHead(final String ref, final boolean isCurrent,
 			final int spaces = maxNameLength - ref.length() + 1;
 			out.print(String.format("%" + spaces + "s", ""));
 			final ObjectId objectId = refObj.getObjectId();
-			out.print(objectId.abbreviate(db));
+			out.print(objectId.abbreviate(db).name());
 			out.print(' ');
 			out.print(rw.parseCommit(objectId).getShortMessage());
 		}
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index ad7e08f..e9d3260 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -131,14 +131,14 @@ else if (u.getLocalName().startsWith(Constants.R_TAGS))
 		}
 
 		if (r == RefUpdate.Result.FORCED) {
-			final String aOld = u.getOldObjectId().abbreviate(db);
-			final String aNew = u.getNewObjectId().abbreviate(db);
+			final String aOld = u.getOldObjectId().abbreviate(db).name();
+			final String aNew = u.getNewObjectId().abbreviate(db).name();
 			return aOld + "..." + aNew;
 		}
 
 		if (r == RefUpdate.Result.FAST_FORWARD) {
-			final String aOld = u.getOldObjectId().abbreviate(db);
-			final String aNew = u.getNewObjectId().abbreviate(db);
+			final String aOld = u.getOldObjectId().abbreviate(db).name();
+			final String aNew = u.getNewObjectId().abbreviate(db).name();
 			return aOld + ".." + aNew;
 		}
 
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index 53ad080..19d31a1 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -181,8 +181,9 @@ private void printRefUpdateResult(final URIish uri,
 					boolean fastForward = rru.isFastForward();
 					final char flag = fastForward ? ' ' : '+';
 					final String summary = oldRef.getObjectId().abbreviate(db)
+							.name()
 							+ (fastForward ? ".." : "...")
-							+ rru.getNewObjectId().abbreviate(db);
+							+ rru.getNewObjectId().abbreviate(db).name();
 					final String message = fastForward ? null : "forced update";
 					printUpdateLine(flag, summary, srcRef, remoteName, message);
 				}
@@ -205,7 +206,7 @@ printUpdateLine('!', "[rejected]", srcRef, remoteName,
 
 		case REJECTED_REMOTE_CHANGED:
 			final String message = "remote ref object changed - is not expected one "
-					+ rru.getExpectedOldObjectId().abbreviate(db);
+					+ rru.getExpectedOldObjectId().abbreviate(db).name();
 			printUpdateLine('!', "[rejected]", srcRef, remoteName, message);
 			break;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
index 206cc2f..33b62b9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AbbreviatedObjectId.java
@@ -52,7 +52,7 @@
  * This class converts the hex string into a binary form, to make it more
  * efficient for matching against an object.
  */
-public class AbbreviatedObjectId {
+public final class AbbreviatedObjectId {
 	/**
 	 * Convert an AbbreviatedObjectId from hex characters (US-ASCII).
 	 * 
@@ -152,7 +152,7 @@ static int mask(final int nibbles, final int word, final int v) {
 
 	final int w5;
 
-	private AbbreviatedObjectId(final int n, final int new_1, final int new_2,
+	AbbreviatedObjectId(final int n, final int new_1, final int new_2,
 			final int new_3, final int new_4, final int new_5) {
 		nibbles = n;
 		w1 = new_1;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index 8872017..7d7d61b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -432,16 +432,36 @@ public final String name() {
 	/**
 	 * Return unique abbreviation (prefix) of this object SHA-1.
 	 * <p>
+	 * This method is a utility for <code>abbreviate(repo, 8)</code>.
+	 * 
+	 * @param repo
+	 *            repository for checking uniqueness within.
+	 * @return SHA-1 abbreviation.
+	 */
+	public AbbreviatedObjectId abbreviate(final Repository repo) {
+		return abbreviate(repo, 8);
+	}
+
+	/**
+	 * Return unique abbreviation (prefix) of this object SHA-1.
+	 * <p>
 	 * Current implementation is not guaranteeing uniqueness, it just returns
 	 * fixed-length prefix of SHA-1 string.
-	 *
+	 * 
 	 * @param repo
 	 *            repository for checking uniqueness within.
+	 * @param len
+	 *            minimum length of the abbreviated string.
 	 * @return SHA-1 abbreviation.
 	 */
-	public String abbreviate(final Repository repo) {
+	public AbbreviatedObjectId abbreviate(final Repository repo, final int len) {
 		// TODO implement checking for uniqueness
-		return name().substring(0, 7);
+		final int a = AbbreviatedObjectId.mask(len, 1, w1);
+		final int b = AbbreviatedObjectId.mask(len, 2, w2);
+		final int c = AbbreviatedObjectId.mask(len, 3, w3);
+		final int d = AbbreviatedObjectId.mask(len, 4, w4);
+		final int e = AbbreviatedObjectId.mask(len, 5, w5);
+		return new AbbreviatedObjectId(len, a, b, c, d, e);
 	}
 
 	/**
-- 
1.6.1.rc2.299.gead4c

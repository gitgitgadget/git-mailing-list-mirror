From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Skip unnecessary test in ObjectChecker
Date: Mon, 27 Apr 2009 14:30:19 -0700
Message-ID: <20090427213019.GJ23604@spearce.org>
References: <1240756575-24113-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 23:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyYPS-0005u2-Rx
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 23:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbZD0VaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbZD0VaU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 17:30:20 -0400
Received: from george.spearce.org ([209.20.77.23]:34491 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbZD0VaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 17:30:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 985EB38215; Mon, 27 Apr 2009 21:30:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1240756575-24113-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117716>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> The check for duplicate names unnecessarily checks for end of buffer.
> Previous tests took care of that.

NAK.

We call duplicateName once per path in the tree.  Its purpose is
to do a look-ahead into the tree to see if there is another tree
entry whose name is the same name as this one.  Typically we only
have to do 1 entry look ahead, as then we break out at l.269 if
pathCompare returned that the current entry is < the next entry.

A bad tree sorting would cause this test to incorrectly pass,
but would in fact fail later inside checkTree on l.332-336.

I had these bounds checks here in duplicateName because we are
scanning forward in the tree, against tree entries that the
caller checkTree has not yet examined.  If a later tree entry is
in fact malformed, I didn't want duplicateName to throw with an
ArrayIndexOutOfBoundsException, but instead wanted to let it be
handled with a more detailed description inside of checkTree.

Thus, duplicateName returns false when it encounters some sort of
oddity in the tree entry (like unexpected end of buffer) and permits
the caller to move forward, and then the caller will (eventually)
identify the same problem and throw a proper message.

We could change this by wrapping the duplicateName call on l.328
with a try-catch-ArrayIndexOutOfBoundsException, but that felt dirty
to me when I wrote this code.  In practice, we should never run out
of buffer except in the corner case where we are looking at the last
entry in the tree.  Any other time an ArrayIndexOutOfBoundsException
inside of the duplicateName function indicates tree corruption,
but we can't say what *kind* until we let checkTree move forward
to that invalid portion.

So, I counter with this patch, but it makes me feel horrible even
proposing it, as a catch of ArrayIndexOutOfBoundsException could
mask a programming problem inside of duplicateName:

--8<--
Remove duplicate bound tests in ObjectChecker.checkTree

Status: likely a very, very, very bad idea
Not-signed-off-by: me <me@example.com>

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
index 75e3c77..df27cfa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectChecker.java
@@ -242,9 +242,9 @@ private static boolean duplicateName(final byte[] raw,
 		int nextPtr = thisNameEnd + 1 + Constants.OBJECT_ID_LENGTH;
 		for (;;) {
 			int nextMode = 0;
+			if (nextPtr >= sz)
+				return false;
 			for (;;) {
-				if (nextPtr >= sz)
-					return false;
 				final byte c = raw[nextPtr++];
 				if (' ' == c)
 					break;
@@ -254,14 +254,10 @@ private static boolean duplicateName(final byte[] raw,
 
 			final int nextNamePos = nextPtr;
 			for (;;) {
-				if (nextPtr == sz)
-					return false;
 				final byte c = raw[nextPtr++];
 				if (c == 0)
 					break;
 			}
-			if (nextNamePos + 1 == nextPtr)
-				return false;
 
 			final int cmp = pathCompare(raw, thisNamePos, thisNameEnd,
 					FileMode.TREE.getBits(), nextNamePos, nextPtr - 1, nextMode);
@@ -325,8 +321,17 @@ public void checkTree(final byte[] raw) throws CorruptObjectException {
 				if (nameLen == 2 && raw[thisNameB + 1] == '.')
 					throw new CorruptObjectException("invalid name '..'");
 			}
-			if (duplicateName(raw, thisNameB, ptr - 1))
-				throw new CorruptObjectException("duplicate entry names");
+
+			try {
+				if (duplicateName(raw, thisNameB, ptr - 1))
+					throw new CorruptObjectException("duplicate entry names");
+			} catch (ArrayIndexOutOfBoundsException e) {
+				// Fall through.  This tree is somehow corrupt in a later
+				// entry we have not yet processed.  Consider that there
+				// are no duplicates for this name, and allow scanning to
+				// continue so we can later find and report upon that bad
+				// entry that caused us to throw here.
+			}
 
 			if (lastNameB != 0) {
 				final int cmp = pathCompare(raw, lastNameB, lastNameE,

-- 
Shawn.

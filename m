From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Prevent an exception if the user tries to push a
	non-existing ref.
Date: Mon, 9 Mar 2009 08:50:49 -0700
Message-ID: <20090309155049.GE11989@spearce.org>
References: <20090307224831.GS16213@spearce.org> <1236525667-852-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 16:53:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LghmA-0007Pa-OH
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 16:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbZCIPux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 11:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753348AbZCIPuw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 11:50:52 -0400
Received: from george.spearce.org ([209.20.77.23]:51374 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbZCIPuv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 11:50:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 04A6638211; Mon,  9 Mar 2009 15:50:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1236525667-852-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112707>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Instead of a StringIndexOutOfBoundsException we now get an error telling
> us that the ref could not be resolved.

*sigh*

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
> index a0a2575..8a25213 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
> @@ -255,7 +255,7 @@ else if (TransportLocal.canHandle(remote))
>  			} else {
>  				if (!remoteName.startsWith(Constants.R_REFS)) {
>  					// null source is another special case (delete)
> -					if (srcRef != null) {
> +					if (src != null) {
>  						// assume the same type of ref at the destination
>  						String srcPrefix = srcRef.substring(0, srcRef.indexOf('/', Constants.R_REFS.length()));
>  						remoteName = srcPrefix + "/" + remoteName;

After reading that code again, I'm tempted to apply this instead.
Its a much larger patch, but I think the result is a lot easier
to follow.

--8<--
Fix DWIMery for push to handle non-existant source refs

Instead of a StringIndexOutOfBoundsException we now get an error
telling us that the ref could not be resolved.

Found-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/transport/Transport.java  |   45 ++++++++++---------
 1 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index a0a2575..1068f50 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -244,29 +244,32 @@ else if (TransportLocal.canHandle(remote))
 		final Collection<RefSpec> procRefs = expandPushWildcardsFor(db, specs);
 
 		for (final RefSpec spec : procRefs) {
-			String srcRef = spec.getSource();
-			final Ref src = db.getRef(srcRef);
-			if (src != null)
-				srcRef = src.getName();
-			String remoteName = spec.getDestination();
-			// null destination (no-colon in ref-spec) is a special case
-			if (remoteName == null) {
-				remoteName = srcRef;
-			} else {
-				if (!remoteName.startsWith(Constants.R_REFS)) {
-					// null source is another special case (delete)
-					if (srcRef != null) {
-						// assume the same type of ref at the destination
-						String srcPrefix = srcRef.substring(0, srcRef.indexOf('/', Constants.R_REFS.length()));
-						remoteName = srcPrefix + "/" + remoteName;
-					}
-				}
+			String srcSpec = spec.getSource();
+			final Ref srcRef = db.getRef(srcSpec);
+			if (srcRef != null)
+				srcSpec = srcRef.getName();
+
+			String destSpec = spec.getDestination();
+			if (destSpec == null) {
+				// No destination (no-colon in ref-spec), DWIMery assumes src
+				//
+				destSpec = srcSpec;
 			}
-			final boolean forceUpdate = spec.isForceUpdate();
-			final String localName = findTrackingRefName(remoteName, fetchSpecs);
 
-			final RemoteRefUpdate rru = new RemoteRefUpdate(db, srcRef,
-					remoteName, forceUpdate, localName, null);
+			if (srcRef != null && !destSpec.startsWith(Constants.R_REFS)) {
+				// Assume the same kind of ref at the destination, e.g.
+				// "refs/heads/foo:master", DWIMery assumes master is also
+				// under "refs/heads/".
+				//
+				final String n = srcRef.getName();
+				final int kindEnd = n.indexOf('/', Constants.R_REFS.length());
+				destSpec = n.substring(0, kindEnd + 1) + destSpec;
+			}
+
+			final boolean forceUpdate = spec.isForceUpdate();
+			final String localName = findTrackingRefName(destSpec, fetchSpecs);
+			final RemoteRefUpdate rru = new RemoteRefUpdate(db, srcSpec,
+					destSpec, forceUpdate, localName, null);
 			result.add(rru);
 		}
 		return result;
-- 
1.6.2.185.g8b635


-- 
Shawn.

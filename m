From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/3] Give NoRemoteRepositoryException better
	message in BasePackConnection
Date: Wed, 27 Aug 2008 19:35:01 -0700
Message-ID: <20080828023501.GC8624@spearce.org>
References: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXMm-0007YQ-LR
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407AbYH1CfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbYH1CfE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:35:04 -0400
Received: from george.spearce.org ([209.20.77.23]:44070 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYH1CfD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:35:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7C55238375; Thu, 28 Aug 2008 02:35:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219887370-17265-1-git-send-email-marek.zawirski@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94025>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> 
> See http://code.google.com/p/egit/issues/detail?id=16
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
> index 14fffc3..de0c7b6 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
> @@ -129,8 +129,15 @@ private void readAdvertisedRefsImpl() throws IOException {
>  			try {
>  				line = pckIn.readString();
>  			} catch (EOFException eof) {
> -				if (avail.isEmpty())
> -					throw new NoRemoteRepositoryException(uri, "not found.");
> +				if (avail.isEmpty()) {
> +					String service = "unknown";
> +					if (this instanceof PushConnection)
> +						service = "push";
> +					else if (this instanceof FetchConnection)
> +						service = "fetch";
> +					throw new NoRemoteRepositoryException(uri, service
> +							+ " service not found.");
> +				}

Hmm.  I wonder if we could detect this better.  With the patch
below I can get nice errors:

  $ ./jgit.sh push git://repo.or.cz/egit.git refs/heads/master
  fatal: git://repo.or.cz/egit.git: push not permitted

  $ ./jgit.sh push git://repo.or.cz/fake.git refs/heads/master
  fatal: git://repo.or.cz/fake.git: not found.

--8<--
Disambiguate "push not supported" from "repository not found"

If we are pushing to a remote repository the reason why we
get no refs may be because push is not permitted, or it is
a bad URI and points to a non-existant repository.

To get a good error message for the user we need to open a
fetch connection to see if fetch also fails.  If it failed
we know the URI is invalid; if fetch succeeds we know that
the repository is there but the user is just not allowed to
push to it over this transport.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |   10 +++++++-
 .../jgit/transport/BasePackPushConnection.java     |   25 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 14fffc3..e35f850 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -72,6 +72,9 @@
 	/** Remote repository location. */
 	protected final URIish uri;
 
+	/** A transport connected to {@link #uri}. */
+	protected final PackTransport transport;
+
 	/** Buffered input stream reading from the remote. */
 	protected InputStream in;
 
@@ -93,6 +96,7 @@
 	BasePackConnection(final PackTransport packTransport) {
 		local = packTransport.local;
 		uri = packTransport.uri;
+		transport = packTransport;
 	}
 
 	protected void init(final InputStream myIn, final OutputStream myOut) {
@@ -130,7 +134,7 @@ private void readAdvertisedRefsImpl() throws IOException {
 				line = pckIn.readString();
 			} catch (EOFException eof) {
 				if (avail.isEmpty())
-					throw new NoRemoteRepositoryException(uri, "not found.");
+					throw noRepository();
 				throw eof;
 			}
 
@@ -178,6 +182,10 @@ if (prior != null)
 		available(avail);
 	}
 
+	protected TransportException noRepository() {
+		return new NoRemoteRepositoryException(uri, "not found.");
+	}
+
 	protected boolean isCapableOf(final String option) {
 		return remoteCapablities.contains(option);
 	}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index a2d5b6f..a6ab9c4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -43,6 +43,8 @@
 import java.util.Collection;
 import java.util.Map;
 
+import org.spearce.jgit.errors.NoRemoteRepositoryException;
+import org.spearce.jgit.errors.NotSupportedException;
 import org.spearce.jgit.errors.PackProtocolException;
 import org.spearce.jgit.errors.TransportException;
 import org.spearce.jgit.lib.ObjectId;
@@ -98,6 +100,29 @@ public void push(final ProgressMonitor monitor,
 		doPush(monitor, refUpdates);
 	}
 
+	@Override
+	protected TransportException noRepository() {
+		// Sadly we cannot tell the "invalid URI" case from "push not allowed".
+		// Opening a fetch connection can help us tell the difference, as any
+		// useful repository is going to support fetch if it also would allow
+		// push. So if fetch throws NoRemoteRepositoryException we know the
+		// URI is wrong. Otherwise we can correctly state push isn't allowed
+		// as the fetch connection opened successfully.
+		//
+		try {
+			transport.openFetch().close();
+		} catch (NotSupportedException e) {
+			// Fall through.
+		} catch (NoRemoteRepositoryException e) {
+			// Fetch concluded the repository doesn't exist.
+			//
+			return e;
+		} catch (TransportException e) {
+			// Fall through.
+		}
+		return new TransportException(uri, "push not permitted");
+	}
+
 	protected void doPush(final ProgressMonitor monitor,
 			final Map<String, RemoteRefUpdate> refUpdates)
 			throws TransportException {
-- 
1.6.0.272.g9ab4


-- 
Shawn.

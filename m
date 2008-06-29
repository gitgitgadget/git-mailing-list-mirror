From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/21] Support push over the sftp:// dumb transport
Date: Sun, 29 Jun 2008 03:59:23 -0400
Message-ID: <1214726371-93520-14-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
 <1214726371-93520-3-git-send-email-spearce@spearce.org>
 <1214726371-93520-4-git-send-email-spearce@spearce.org>
 <1214726371-93520-5-git-send-email-spearce@spearce.org>
 <1214726371-93520-6-git-send-email-spearce@spearce.org>
 <1214726371-93520-7-git-send-email-spearce@spearce.org>
 <1214726371-93520-8-git-send-email-spearce@spearce.org>
 <1214726371-93520-9-git-send-email-spearce@spearce.org>
 <1214726371-93520-10-git-send-email-spearce@spearce.org>
 <1214726371-93520-11-git-send-email-spearce@spearce.org>
 <1214726371-93520-12-git-send-email-spearce@spearce.org>
 <1214726371-93520-13-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:02:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrrp-0000I1-2y
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYF2IBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbYF2IA6
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36812 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYF2IAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:00:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCrpX-0004OP-EV; Sun, 29 Jun 2008 04:00:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id D55AD20FBAE; Sun, 29 Jun 2008 04:00:15 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 8A62F20FBD6;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-13-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86776>

jgit now allows users to push changes over the sftp:// protocol,
taking advantage of the SFTP client available as part of JSch to
(more or less) safely update the remote repository.

Since locking is not available over SFTP this is not suitable for
use with concurrent pushes, but is safe with concurrent fetches
during a single push.  This is sufficient support to safely update
a Git repository published over HTTP where the only means of making
changes is through SSH/SFTP and the remote side does not make Git
available through the shell, or does not offer direct shell access.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/TransportHttp.java  |    2 -
 .../org/spearce/jgit/transport/TransportSftp.java  |  109 +++++++-
 .../spearce/jgit/transport/WalkPushConnection.java |  296 ++++++++++++++++++++
 .../jgit/transport/WalkRemoteObjectDatabase.java   |  243 ++++++++++++++++
 4 files changed, 647 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index 231dbfe..4655950 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -112,8 +112,6 @@ class TransportHttp extends WalkTransport {
 	}
 
 	class HttpObjectDB extends WalkRemoteObjectDatabase {
-		private static final String INFO_REFS = "../info/refs";
-
 		private final URL objectsUrl;
 
 		HttpObjectDB(final URL b) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
index c2f34f7..e5db6cc 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportSftp.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.transport;
 import java.io.BufferedReader;
 import java.io.FileNotFoundException;
 import java.io.IOException;
+import java.io.OutputStream;
 import java.net.ConnectException;
 import java.net.UnknownHostException;
 import java.util.ArrayList;
@@ -78,6 +79,9 @@ import com.jcraft.jsch.SftpException;
  * listing files through SFTP we can avoid needing to have current
  * <code>objects/info/packs</code> or <code>info/refs</code> files on the
  * remote repository and access the data directly, much as Git itself would.
+ * <p>
+ * Concurrent pushing over this transport is not supported. Multiple concurrent
+ * push operations may cause confusion in the repository state.
  * 
  * @see WalkFetchConnection
  */
@@ -101,6 +105,14 @@ class TransportSftp extends WalkTransport {
 		return r;
 	}
 
+	@Override
+	public PushConnection openPush() throws TransportException {
+		final SftpObjectDB c = new SftpObjectDB(uri.getPath());
+		final WalkPushConnection r = new WalkPushConnection(this, c);
+		r.available(c.readAdvertisedRefs());
+		return r;
+	}
+
 	Session openSession() throws TransportException {
 		final String user = uri.getUser();
 		final String pass = uri.getPass();
@@ -246,10 +258,105 @@ class TransportSftp extends WalkTransport {
 			}
 		}
 
+		@Override
+		void deleteFile(final String path) throws IOException {
+			try {
+				ftp.rm(path);
+			} catch (SftpException je) {
+				if (je.id == ChannelSftp.SSH_FX_NO_SUCH_FILE)
+					return;
+				throw new TransportException("Can't delete " + objectsPath
+						+ "/" + path + ": " + je.getMessage(), je);
+			}
+
+			// Prune any now empty directories.
+			//
+			String dir = path;
+			int s = dir.lastIndexOf('/');
+			while (s > 0) {
+				try {
+					dir = dir.substring(0, s);
+					ftp.rmdir(dir);
+					s = dir.lastIndexOf('/');
+				} catch (SftpException je) {
+					// If we cannot delete it, leave it alone. It may have
+					// entries still in it, or maybe we lack write access on
+					// the parent. Either way it isn't a fatal error.
+					//
+					break;
+				}
+			}
+		}
+
+		@Override
+		OutputStream writeFile(final String path) throws IOException {
+			try {
+				return ftp.put(path);
+			} catch (SftpException je) {
+				if (je.id == ChannelSftp.SSH_FX_NO_SUCH_FILE) {
+					mkdir_p(path);
+					try {
+						return ftp.put(path);
+					} catch (SftpException je2) {
+						je = je2;
+					}
+				}
+
+				throw new TransportException("Can't write " + objectsPath + "/"
+						+ path + ": " + je.getMessage(), je);
+			}
+		}
+
+		@Override
+		void writeFile(final String path, final byte[] data) throws IOException {
+			final String lock = path + ".lock";
+			try {
+				super.writeFile(lock, data);
+				try {
+					ftp.rename(lock, path);
+				} catch (SftpException je) {
+					throw new TransportException("Can't write " + objectsPath
+							+ "/" + path + ": " + je.getMessage(), je);
+				}
+			} catch (IOException err) {
+				try {
+					ftp.rm(lock);
+				} catch (SftpException e) {
+					// Ignore deletion failure, we are already
+					// failing anyway.
+				}
+				throw err;
+			}
+		}
+
+		private void mkdir_p(String path) throws IOException {
+			final int s = path.lastIndexOf('/');
+			if (s <= 0)
+				return;
+
+			path = path.substring(0, s);
+			try {
+				ftp.mkdir(path);
+			} catch (SftpException je) {
+				if (je.id == ChannelSftp.SSH_FX_NO_SUCH_FILE) {
+					mkdir_p(path);
+					try {
+						ftp.mkdir(path);
+						return;
+					} catch (SftpException je2) {
+						je = je2;
+					}
+				}
+
+				throw new TransportException("Can't mkdir " + objectsPath + "/"
+						+ path + ": " + je.getMessage(), je);
+			}
+		}
+
 		Map<String, Ref> readAdvertisedRefs() throws TransportException {
 			final TreeMap<String, Ref> avail = new TreeMap<String, Ref>();
 			try {
-				final BufferedReader br = openReader("../packed-refs");
+				final BufferedReader br = openReader(PACKED_REFS);
 				try {
 					readPackedRefs(avail, br);
 				} finally {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
new file mode 100644
index 0000000..ab16f65
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkPushConnection.java
@@ -0,0 +1,296 @@
+/*
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.transport;
+
+import java.io.IOException;
+import java.io.OutputStream;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.LinkedHashMap;
+import java.util.List;
+import java.util.Map;
+import java.util.TreeMap;
+
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackWriter;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.Ref.Storage;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
+/**
+ * Generic push support for dumb transport protocols.
+ * <p>
+ * Since there are no Git-specific smarts on the remote side of the connection
+ * the client side must handle everything on its own. The generic push support
+ * requires being able to delete, create and overwrite files on the remote side,
+ * as well as create any missing directories (if necessary). Typically this can
+ * be handled through an FTP style protocol.
+ * <p>
+ * Objects not on the remote side are uploaded as pack files, using one pack
+ * file per invocation. This simplifies the implementation as only two data
+ * files need to be written to the remote repository.
+ * <p>
+ * Push support supplied by this class is not multiuser safe. Concurrent pushes
+ * to the same repository may yield an inconsistent reference database which may
+ * confuse fetch clients.
+ * <p>
+ * A single push is concurrently safe with multiple fetch requests, due to the
+ * careful order of operations used to update the repository. Clients fetching
+ * may receive transient failures due to short reads on certain files if the
+ * protocol does not support atomic file replacement.
+ * 
+ * @see WalkRemoteObjectDatabase
+ */
+class WalkPushConnection extends BaseConnection implements PushConnection {
+	/** The repository this transport pushes out of. */
+	private final Repository local;
+
+	/** Location of the remote repository we are writing to. */
+	private final URIish uri;
+
+	/** Database connection to the remote repository. */
+	private final WalkRemoteObjectDatabase dest;
+
+	/**
+	 * Packs already known to reside in the remote repository.
+	 * <p>
+	 * This is a LinkedHashMap to maintain the original order.
+	 */
+	private LinkedHashMap<String, String> packNames;
+
+	/** Complete listing of refs the remote will have after our push. */
+	private Map<String, Ref> newRefs;
+
+	/**
+	 * Updates which require altering the packed-refs file to complete.
+	 * <p>
+	 * If this collection is non-empty then any refs listed in {@link #newRefs}
+	 * with a storage class of {@link Storage#PACKED} will be written.
+	 */
+	private Collection<RemoteRefUpdate> packedRefUpdates;
+
+	WalkPushConnection(final WalkTransport walkTransport,
+			final WalkRemoteObjectDatabase w) {
+		local = walkTransport.local;
+		uri = walkTransport.getURI();
+		dest = w;
+	}
+
+	public void push(final ProgressMonitor monitor,
+			final Map<String, RemoteRefUpdate> refUpdates)
+			throws TransportException {
+		markStartedOperation();
+		packNames = null;
+		newRefs = new TreeMap<String, Ref>(getRefsMap());
+		packedRefUpdates = new ArrayList<RemoteRefUpdate>(refUpdates.size());
+
+		// Filter the commands and issue all deletes first. This way we
+		// can correctly handle a directory being cleared out and a new
+		// ref using the directory name being created.
+		//
+		final List<RemoteRefUpdate> updates = new ArrayList<RemoteRefUpdate>();
+		for (final RemoteRefUpdate u : refUpdates.values()) {
+			if (AnyObjectId.equals(ObjectId.zeroId(), u.getNewObjectId()))
+				deleteCommand(u);
+			else
+				updates.add(u);
+		}
+
+		// If we have any updates we need to upload the objects first, to
+		// prevent creating refs pointing at non-existant data. Then we
+		// can update the refs, and the info-refs file for dumb transports.
+		//
+		if (!updates.isEmpty())
+			sendpack(updates, monitor);
+		for (final RemoteRefUpdate u : updates)
+			updateCommand(u);
+
+		if (!packedRefUpdates.isEmpty()) {
+			try {
+				dest.writePackedRefs(newRefs.values());
+				for (final RemoteRefUpdate u : packedRefUpdates)
+					u.setStatus(Status.OK);
+			} catch (IOException err) {
+				for (final RemoteRefUpdate u : packedRefUpdates) {
+					u.setStatus(Status.REJECTED_OTHER_REASON);
+					u.setMessage(err.getMessage());
+				}
+				throw new TransportException(uri, "failed updating refs", err);
+			}
+		}
+
+		try {
+			dest.writeInfoRefs(newRefs.values());
+		} catch (IOException err) {
+			throw new TransportException(uri, "failed updating refs", err);
+		}
+	}
+
+	@Override
+	public void close() {
+		dest.close();
+	}
+
+	private void sendpack(final List<RemoteRefUpdate> updates,
+			final ProgressMonitor monitor) throws TransportException {
+		String pathPack = null;
+		String pathIdx = null;
+
+		try {
+			final PackWriter pw = new PackWriter(local, monitor);
+			final List<ObjectId> need = new ArrayList<ObjectId>();
+			final List<ObjectId> have = new ArrayList<ObjectId>();
+			for (final RemoteRefUpdate r : updates)
+				need.add(r.getNewObjectId());
+			for (final Ref r : getRefs()) {
+				have.add(r.getObjectId());
+				if (r.getPeeledObjectId() != null)
+					have.add(r.getPeeledObjectId());
+			}
+			pw.preparePack(need, have, false, true);
+
+			// We don't have to continue further if the pack will
+			// be an empty pack, as the remote has all objects it
+			// needs to complete this change.
+			//
+			if (pw.getObjectsNumber() == 0)
+				return;
+
+			packNames = new LinkedHashMap<String, String>();
+			for (final String n : dest.getPackNames())
+				packNames.put(n, n);
+
+			final String base = "pack-" + pw.computeName();
+			final String packName = base + ".pack";
+			pathPack = "pack/" + packName;
+			pathIdx = "pack/" + base + ".idx";
+
+			if (packNames.remove(packName) != null) {
+				// The remote already contains this pack. We should
+				// remove the index before overwriting to prevent bad
+				// offsets from appearing to clients.
+				//
+				dest.writeInfoPacks(packNames.keySet());
+				dest.deleteFile(pathIdx);
+			}
+
+			// Write the pack file, then the index, as readers look the
+			// other direction (index, then pack file).
+			//
+			OutputStream os = dest.writeFile(pathPack);
+			try {
+				pw.writePack(os);
+			} finally {
+				os.close();
+			}
+
+			os = dest.writeFile(pathIdx);
+			try {
+				pw.writeIndex(os);
+			} finally {
+				os.close();
+			}
+
+			// Record the pack at the start of the pack info list. This
+			// way clients are likely to consult the newest pack first,
+			// and discover the most recent objects there.
+			//
+			final ArrayList<String> infoPacks = new ArrayList<String>();
+			infoPacks.add(packName);
+			infoPacks.addAll(packNames.keySet());
+			dest.writeInfoPacks(infoPacks);
+
+		} catch (IOException err) {
+			safeDelete(pathIdx);
+			safeDelete(pathPack);
+
+			throw new TransportException(uri, "cannot store objects", err);
+		}
+	}
+
+	private void safeDelete(final String path) {
+		if (path != null) {
+			try {
+				dest.deleteFile(path);
+			} catch (IOException cleanupFailure) {
+				// Ignore the deletion failure. We probably are
+				// already failing and were just trying to pick
+				// up after ourselves.
+			}
+		}
+	}
+
+	private void deleteCommand(final RemoteRefUpdate u) {
+		final Ref r = newRefs.remove(u.getRemoteName());
+		if (r == null) {
+			// Already gone.
+			//
+			u.setStatus(Status.OK);
+			return;
+		}
+
+		if (r.getStorage().isPacked())
+			packedRefUpdates.add(u);
+
+		if (r.getStorage().isLoose()) {
+			try {
+				dest.deleteRef(u.getRemoteName());
+				u.setStatus(Status.OK);
+			} catch (IOException e) {
+				u.setStatus(Status.REJECTED_OTHER_REASON);
+				u.setMessage(e.getMessage());
+			}
+		}
+	}
+
+	private void updateCommand(final RemoteRefUpdate u) {
+		try {
+			dest.writeRef(u.getRemoteName(), u.getNewObjectId());
+			newRefs.put(u.getRemoteName(), new Ref(Storage.LOOSE, u
+					.getRemoteName(), u.getNewObjectId()));
+			u.setStatus(Status.OK);
+		} catch (IOException e) {
+			u.setStatus(Status.REJECTED_OTHER_REASON);
+			u.setMessage(e.getMessage());
+		}
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
index 2196fc9..57d525f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/WalkRemoteObjectDatabase.java
@@ -43,10 +43,14 @@ import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.InputStreamReader;
+import java.io.OutputStream;
+import java.io.StringWriter;
 import java.util.ArrayList;
 import java.util.Collection;
 
 import org.spearce.jgit.lib.Constants;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.Ref;
 import org.spearce.jgit.util.NB;
 
 /**
@@ -68,6 +72,10 @@ abstract class WalkRemoteObjectDatabase {
 
 	static final String INFO_HTTP_ALTERNATES = "info/http-alternates";
 
+	static final String INFO_REFS = "../info/refs";
+
+	static final String PACKED_REFS = "../packed-refs";
+
 	/**
 	 * Obtain the list of available packs (if any).
 	 * <p>
@@ -163,6 +171,241 @@ abstract class WalkRemoteObjectDatabase {
 	abstract void close();
 
 	/**
+	 * Delete a file from the object database.
+	 * <p>
+	 * Path may start with <code>../</code> to request deletion of a file that
+	 * resides in the repository itself.
+	 * <p>
+	 * When possible empty directories must be removed, up to but not including
+	 * the current object database directory itself.
+	 * <p>
+	 * This method does not support deletion of directories.
+	 * 
+	 * @param path
+	 *            name of the item to be removed, relative to the current object
+	 *            database.
+	 * @throws IOException
+	 *             deletion is not supported, or deletion failed.
+	 */
+	void deleteFile(final String path) throws IOException {
+		throw new IOException("Deleting '" + path + "' not supported.");
+	}
+
+	/**
+	 * Open a remote file for writing.
+	 * <p>
+	 * Path may start with <code>../</code> to request writing of a file that
+	 * resides in the repository itself.
+	 * <p>
+	 * The requested path may or may not exist. If the path already exists as a
+	 * file the file should be truncated and completely replaced.
+	 * <p>
+	 * This method creates any missing parent directories, if necessary.
+	 * 
+	 * @param path
+	 *            name of the file to write, relative to the current object
+	 *            database.
+	 * @return stream to write into this file. Caller must close the stream to
+	 *         complete the write request. The stream is not buffered and each
+	 *         write may cause a network request/response so callers should
+	 *         buffer to smooth out small writes.
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	OutputStream writeFile(final String path) throws IOException {
+		throw new IOException("Writing of '" + path + "' not supported.");
+	}
+
+	/**
+	 * Atomically write a remote file.
+	 * <p>
+	 * This method attempts to perform as atomic of an update as it can,
+	 * reducing (or eliminating) the time that clients might be able to see
+	 * partial file content. This method is not suitable for very large
+	 * transfers as the complete content must be passed as an argument.
+	 * <p>
+	 * Path may start with <code>../</code> to request writing of a file that
+	 * resides in the repository itself.
+	 * <p>
+	 * The requested path may or may not exist. If the path already exists as a
+	 * file the file should be truncated and completely replaced.
+	 * <p>
+	 * This method creates any missing parent directories, if necessary.
+	 * 
+	 * @param path
+	 *            name of the file to write, relative to the current object
+	 *            database.
+	 * @param data
+	 *            complete new content of the file.
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	void writeFile(final String path, final byte[] data) throws IOException {
+		final OutputStream os = writeFile(path);
+		try {
+			os.write(data);
+		} finally {
+			os.close();
+		}
+	}
+
+	/**
+	 * Delete a loose ref from the remote repository.
+	 * 
+	 * @param name
+	 *            name of the ref within the ref space, for example
+	 *            <code>refs/heads/pu</code>.
+	 * @throws IOException
+	 *             deletion is not supported, or deletion failed.
+	 */
+	void deleteRef(final String name) throws IOException {
+		deleteFile("../" + name);
+	}
+
+	/**
+	 * Overwrite (or create) a loose ref in the remote repository.
+	 * <p>
+	 * This method creates any missing parent directories, if necessary.
+	 * 
+	 * @param name
+	 *            name of the ref within the ref space, for example
+	 *            <code>refs/heads/pu</code>.
+	 * @param value
+	 *            new value to store in this ref. Must not be null.
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	void writeRef(final String name, final ObjectId value) throws IOException {
+		final ByteArrayOutputStream b;
+
+		b = new ByteArrayOutputStream(Constants.OBJECT_ID_LENGTH * 2 + 1);
+		value.copyTo(b);
+		b.write('\n');
+
+		writeFile("../" + name, b.toByteArray());
+	}
+
+	/**
+	 * Rebuild the {@link #INFO_PACKS} for dumb transport clients.
+	 * <p>
+	 * This method rebuilds the contents of the {@link #INFO_PACKS} file to
+	 * match the passed list of pack names.
+	 * 
+	 * @param packNames
+	 *            names of available pack files, in the order they should appear
+	 *            in the file. Valid pack name strings are of the form
+	 *            <code>pack-035760ab452d6eebd123add421f253ce7682355a.pack</code>.
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	void writeInfoPacks(final Collection<String> packNames) throws IOException {
+		final StringBuilder w = new StringBuilder();
+		for (final String n : packNames) {
+			w.append("P ");
+			w.append(n);
+			w.append('\n');
+		}
+		writeFile(INFO_PACKS, Constants.encodeASCII(w.toString()));
+	}
+
+	/**
+	 * Rebuild the {@link #INFO_REFS} for dumb transport clients.
+	 * <p>
+	 * This method rebuilds the contents of the {@link #INFO_REFS} file to match
+	 * the passed list of references.
+	 * 
+	 * @param refs
+	 *            the complete set of references the remote side now has. This
+	 *            should have been computed by applying updates to the
+	 *            advertised refs already discovered.
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	void writeInfoRefs(final Collection<Ref> refs) throws IOException {
+		final StringWriter w = new StringWriter();
+		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
+		for (final Ref r : refs) {
+			if (Constants.HEAD.equals(r.getName())) {
+				// Historically HEAD has never been published through
+				// the INFO_REFS file. This is a mistake, but its the
+				// way things are.
+				//
+				continue;
+			}
+
+			r.getObjectId().copyTo(tmp, w);
+			w.write('\t');
+			w.write(r.getName());
+			w.write('\n');
+
+			if (r.getPeeledObjectId() != null) {
+				r.getPeeledObjectId().copyTo(tmp, w);
+				w.write('\t');
+				w.write(r.getName());
+				w.write("^{}\n");
+			}
+		}
+		writeFile(INFO_REFS, Constants.encodeASCII(w.toString()));
+	}
+
+	/**
+	 * Rebuild the {@link #PACKED_REFS} file.
+	 * <p>
+	 * This method rebuilds the contents of the {@link #PACKED_REFS} file to
+	 * match the passed list of references, including only those refs that have
+	 * a storage type of {@link Ref.Storage#PACKED}.
+	 * 
+	 * @param refs
+	 *            the complete set of references the remote side now has. This
+	 *            should have been computed by applying updates to the
+	 *            advertised refs already discovered.
+	 * @throws IOException
+	 *             writing is not supported, or attempting to write the file
+	 *             failed, possibly due to permissions or remote disk full, etc.
+	 */
+	void writePackedRefs(final Collection<Ref> refs) throws IOException {
+		boolean peeled = false;
+
+		for (final Ref r : refs) {
+			if (r.getStorage() != Ref.Storage.PACKED)
+				continue;
+			if (r.getPeeledObjectId() != null)
+				peeled = true;
+		}
+
+		final StringWriter w = new StringWriter();
+		if (peeled) {
+			w.write("# pack-refs with:");
+			if (peeled)
+				w.write(" peeled");
+			w.write('\n');
+		}
+
+		final char[] tmp = new char[Constants.OBJECT_ID_LENGTH * 2];
+		for (final Ref r : refs) {
+			if (r.getStorage() != Ref.Storage.PACKED)
+				continue;
+
+			r.getObjectId().copyTo(tmp, w);
+			w.write(' ');
+			w.write(r.getName());
+			w.write('\n');
+
+			if (r.getPeeledObjectId() != null) {
+				w.write('^');
+				r.getPeeledObjectId().copyTo(tmp, w);
+				w.write('\n');
+			}
+		}
+		writeFile(PACKED_REFS, Constants.encodeASCII(w.toString()));
+	}
+
+	/**
 	 * Open a buffered reader around a file.
 	 * <p>
 	 * This is shorthand for calling {@link #open(String)} and then wrapping it
-- 
1.5.6.74.g8a5e

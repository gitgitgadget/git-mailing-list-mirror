From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 13/13] Add basic git daemon support to publish receive-pack
Date: Mon, 22 Dec 2008 16:27:23 -0800
Message-ID: <1229992043-1053-14-git-send-email-spearce@spearce.org>
References: <1229992043-1053-1-git-send-email-spearce@spearce.org>
 <1229992043-1053-2-git-send-email-spearce@spearce.org>
 <1229992043-1053-3-git-send-email-spearce@spearce.org>
 <1229992043-1053-4-git-send-email-spearce@spearce.org>
 <1229992043-1053-5-git-send-email-spearce@spearce.org>
 <1229992043-1053-6-git-send-email-spearce@spearce.org>
 <1229992043-1053-7-git-send-email-spearce@spearce.org>
 <1229992043-1053-8-git-send-email-spearce@spearce.org>
 <1229992043-1053-9-git-send-email-spearce@spearce.org>
 <1229992043-1053-10-git-send-email-spearce@spearce.org>
 <1229992043-1053-11-git-send-email-spearce@spearce.org>
 <1229992043-1053-12-git-send-email-spearce@spearce.org>
 <1229992043-1053-13-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEvA1-0005lu-8A
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753044AbYLWA15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYLWA14
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:56 -0500
Received: from george.spearce.org ([209.20.77.23]:54497 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbYLWA1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:34 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id CE99938211; Tue, 23 Dec 2008 00:27:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 99C0C38197;
	Tue, 23 Dec 2008 00:27:28 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
In-Reply-To: <1229992043-1053-13-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103792>

The git:// daemon service receives anonymous TCP connections and runs
commands as they are received.

Currently we only support the server portion of send-pack/receive-pack,
so that is the only service registered in our Daemon class.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Daemon.java           |  125 ++++++++
 .../src/org/spearce/jgit/transport/Daemon.java     |  309 ++++++++++++++++++++
 .../org/spearce/jgit/transport/DaemonClient.java   |  106 +++++++
 .../org/spearce/jgit/transport/DaemonService.java  |  120 ++++++++
 .../spearce/jgit/transport/TransportGitAnon.java   |    3 +-
 6 files changed, 662 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java

diff --git a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
index e2e7938..5fb0953 100644
--- a/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
+++ b/org.spearce.jgit.pgm/src/META-INF/services/org.spearce.jgit.pgm.TextBuiltin
@@ -1,4 +1,5 @@
 org.spearce.jgit.pgm.Branch
+org.spearce.jgit.pgm.Daemon
 org.spearce.jgit.pgm.DiffTree
 org.spearce.jgit.pgm.Fetch
 org.spearce.jgit.pgm.Glog
diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
new file mode 100644
index 0000000..aafc82e
--- /dev/null
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
@@ -0,0 +1,125 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+package org.spearce.jgit.pgm;
+
+import java.io.File;
+import java.net.InetSocketAddress;
+import java.util.ArrayList;
+import java.util.List;
+
+import org.kohsuke.args4j.Argument;
+import org.kohsuke.args4j.Option;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.transport.DaemonService;
+
+@Command(common = true, usage = "Export repositories over git://")
+class Daemon extends TextBuiltin {
+	@Option(name = "--port", metaVar = "PORT", usage = "port number to listen on")
+	int port = org.spearce.jgit.transport.Daemon.DEFAULT_PORT;
+
+	@Option(name = "--listen", metaVar = "HOSTNAME", usage = "hostname (or ip) to listen on")
+	String host;
+
+	@Option(name = "--enable", metaVar = "SERVICE", usage = "enable the service in all repositories", multiValued = true)
+	final List<String> enable = new ArrayList<String>();
+
+	@Option(name = "--disable", metaVar = "SERVICE", usage = "disable the service in all repositories", multiValued = true)
+	final List<String> disable = new ArrayList<String>();
+
+	@Option(name = "--allow-override", metaVar = "SERVICE", usage = "configure the service in daemon.servicename", multiValued = true)
+	final List<String> canOverride = new ArrayList<String>();
+
+	@Option(name = "--forbid-override", metaVar = "SERVICE", usage = "configure the service in daemon.servicename", multiValued = true)
+	final List<String> forbidOverride = new ArrayList<String>();
+
+	@Argument(metaVar = "DIRECTORY", usage = "directories to export")
+	final List<File> directory = new ArrayList<File>();
+
+	@Override
+	protected void run() throws Exception {
+		final org.spearce.jgit.transport.Daemon d;
+
+		d = new org.spearce.jgit.transport.Daemon(
+				host != null ? new InetSocketAddress(host, port)
+						: new InetSocketAddress(port));
+
+		for (final String n : enable)
+			service(d, n).setEnabled(true);
+		for (final String n : disable)
+			service(d, n).setEnabled(false);
+
+		for (final String n : canOverride)
+			service(d, n).setOverridable(true);
+		for (final String n : forbidOverride)
+			service(d, n).setOverridable(false);
+
+		if (directory.isEmpty()) {
+			export(d, db);
+		} else {
+			for (final File f : directory) {
+				out.println("Exporting " + f.getAbsolutePath());
+				d.exportDirectory(f);
+			}
+		}
+		d.start();
+		out.println("Listening on " + d.getAddress());
+	}
+
+	private DaemonService service(final org.spearce.jgit.transport.Daemon d,
+			final String n) {
+		final DaemonService svc = d.getService(n);
+		if (svc == null)
+			throw die("Service '" + n + "' not supported");
+		return svc;
+	}
+
+	private void export(final org.spearce.jgit.transport.Daemon daemon,
+			final Repository repo) {
+		File d = repo.getDirectory();
+		String name = d.getName();
+		while (name.equals(".git") || name.equals(".")) {
+			d = d.getParentFile();
+			name = d.getName();
+		}
+		if (!name.endsWith(".git"))
+			name += ".git";
+
+		out.println("Exporting current repository as \"" + name + "\"");
+		daemon.exportRepository(name, repo);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
new file mode 100644
index 0000000..c225740
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
@@ -0,0 +1,309 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+import java.io.BufferedInputStream;
+import java.io.BufferedOutputStream;
+import java.io.File;
+import java.io.IOException;
+import java.io.InterruptedIOException;
+import java.net.InetSocketAddress;
+import java.net.ServerSocket;
+import java.net.Socket;
+import java.net.SocketAddress;
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.HashMap;
+import java.util.Map;
+import java.util.regex.Pattern;
+
+import org.spearce.jgit.lib.Repository;
+
+/** Basic daemon for the anonymous <code>git://</code> transport protocol. */
+public class Daemon {
+	/** 9418: IANA assigned port number for Git. */
+	public static final int DEFAULT_PORT = 9418;
+
+	private static final int BACKLOG = 5;
+
+	private static final Pattern SAFE_REPOSITORY_NAME = Pattern
+			.compile("^[A-Za-z][A-Za-z0-9/_ -]+(\\.git)?$");
+
+	private InetSocketAddress myAddress;
+
+	private final DaemonService[] services;
+
+	private final ThreadGroup processors;
+
+	private Map<String, Repository> exports;
+
+	private Collection<File> exportBase;
+
+	private boolean run;
+
+	private Thread acceptThread;
+
+	/** Configure a daemon to listen on any available network port. */
+	public Daemon() {
+		this(null);
+	}
+
+	/**
+	 * Configure a new daemon for the specified network address.
+	 * 
+	 * @param addr
+	 *            address to listen for connections on. If null, any available
+	 *            port will be chosen on all network interfaces.
+	 */
+	public Daemon(final InetSocketAddress addr) {
+		myAddress = addr;
+		exports = new HashMap<String, Repository>();
+		exportBase = new ArrayList<File>();
+		processors = new ThreadGroup("Git-Daemon");
+
+		services = new DaemonService[] { new DaemonService("receive-pack",
+				"receivepack") {
+			@Override
+			protected void execute(final DaemonClient dc, final Repository db)
+					throws IOException {
+				final ReceivePack rp = new ReceivePack(db);
+				rp.receive(dc.getInputStream(), dc.getOutputStream(), null);
+			}
+		} };
+	}
+
+	/** @return the address connections are received on. */
+	public synchronized InetSocketAddress getAddress() {
+		return myAddress;
+	}
+
+	/**
+	 * Lookup a supported service so it can be reconfigured.
+	 * 
+	 * @param name
+	 *            name of the service; e.g. "receive-pack"/"git-receive-pack" or
+	 *            "upload-pack"/"git-upload-pack".
+	 * @return the service; null if this daemon implementation doesn't support
+	 *         the requested service type.
+	 */
+	public synchronized DaemonService getService(String name) {
+		if (!name.startsWith("git-"))
+			name = "git-" + name;
+		for (final DaemonService s : services) {
+			if (s.getCommandName().equals(name))
+				return s;
+		}
+		return null;
+	}
+
+	/**
+	 * Add a single repository to the set that is exported by this daemon.
+	 * <p>
+	 * The existence (or lack-thereof) of <code>git-daemon-export-ok</code> is
+	 * ignored by this method. The repository is always published.
+	 * 
+	 * @param name
+	 *            name the repository will be published under.
+	 * @param db
+	 *            the repository instance.
+	 */
+	public void exportRepository(final String name, final Repository db) {
+		synchronized (exports) {
+			exports.put(name, db);
+		}
+	}
+
+	/**
+	 * Recursively export all Git repositories within a directory.
+	 * 
+	 * @param dir
+	 *            the directory to export. This directory must not itself be a
+	 *            git repository, but any directory below it which has a file
+	 *            named <code>git-daemon-export-ok</code> will be published.
+	 */
+	public void exportDirectory(final File dir) {
+		synchronized (exportBase) {
+			exportBase.add(dir);
+		}
+	}
+
+	/**
+	 * Start this daemon on a background thread.
+	 * 
+	 * @throws IOException
+	 *             the server socket could not be opened.
+	 * @throws IllegalStateException
+	 *             the daemon is already running.
+	 */
+	public synchronized void start() throws IOException {
+		if (acceptThread != null)
+			throw new IllegalStateException("Daemon already running");
+
+		final ServerSocket listenSock = new ServerSocket(
+				myAddress != null ? myAddress.getPort() : 0, BACKLOG,
+				myAddress != null ? myAddress.getAddress() : null);
+		myAddress = (InetSocketAddress) listenSock.getLocalSocketAddress();
+
+		run = true;
+		acceptThread = new Thread(processors, "Git-Daemon-Accept") {
+			public void run() {
+				while (isRunning()) {
+					try {
+						startClient(listenSock.accept());
+					} catch (InterruptedIOException e) {
+						// Test again to see if we should keep accepting.
+					} catch (IOException e) {
+						break;
+					}
+				}
+
+				try {
+					listenSock.close();
+				} catch (IOException err) {
+					//
+				} finally {
+					synchronized (Daemon.this) {
+						acceptThread = null;
+					}
+				}
+			}
+		};
+		acceptThread.start();
+	}
+
+	/** @return true if this daemon is receiving connections. */
+	public synchronized boolean isRunning() {
+		return run;
+	}
+
+	/** Stop this daemon. */
+	public synchronized void stop() {
+		if (acceptThread != null) {
+			run = false;
+			acceptThread.interrupt();
+		}
+	}
+
+	private void startClient(final Socket s) {
+		final DaemonClient dc = new DaemonClient(this);
+
+		final SocketAddress peer = s.getRemoteSocketAddress();
+		if (peer instanceof InetSocketAddress)
+			dc.setRemoteAddress(((InetSocketAddress) peer).getAddress());
+
+		new Thread(processors, "Git-Daemon-Client " + peer.toString()) {
+			public void run() {
+				try {
+					dc.execute(new BufferedInputStream(s.getInputStream()),
+							new BufferedOutputStream(s.getOutputStream()));
+				} catch (IOException e) {
+					// Ignore unexpected IO exceptions from clients
+					e.printStackTrace();
+				} finally {
+					try {
+						s.getInputStream().close();
+					} catch (IOException e) {
+						// Ignore close exceptions
+					}
+					try {
+						s.getOutputStream().close();
+					} catch (IOException e) {
+						// Ignore close exceptions
+					}
+				}
+			}
+		}.start();
+	}
+
+	synchronized DaemonService matchService(final String cmd) {
+		for (final DaemonService d : services) {
+			if (d.handles(cmd))
+				return d;
+		}
+		return null;
+	}
+
+	Repository openRepository(String name) {
+		if (!name.startsWith("/"))
+			return null;
+		name = name.substring(1);
+
+		Repository db;
+		synchronized (exports) {
+			db = exports.get(name);
+			if (db != null)
+				return db;
+
+			db = exports.get(name + ".git");
+			if (db != null)
+				return db;
+		}
+
+		if (SAFE_REPOSITORY_NAME.matcher(name).matches()) {
+			final File[] search;
+			synchronized (exportBase) {
+				search = exportBase.toArray(new File[exportBase.size()]);
+			}
+			for (final File f : search) {
+				db = openRepository(new File(f, name));
+				if (db != null)
+					return db;
+
+				db = openRepository(new File(f, name + ".git"));
+				if (db != null)
+					return db;
+
+				db = openRepository(new File(f, name + "/.git"));
+				if (db != null)
+					return db;
+			}
+		}
+		return null;
+	}
+
+	private Repository openRepository(final File d) {
+		if (d.isDirectory() && new File(d, "git-daemon-export-ok").exists()) {
+			try {
+				return new Repository(d);
+			} catch (IOException err) {
+				// Ignore
+			}
+		}
+		return null;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
new file mode 100644
index 0000000..636cf22
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.net.InetAddress;
+
+/** Active network client of {@link Daemon}. */
+public class DaemonClient {
+	private final Daemon daemon;
+
+	private InetAddress peer;
+
+	private InputStream rawIn;
+
+	private OutputStream rawOut;
+
+	DaemonClient(final Daemon d) {
+		daemon = d;
+	}
+
+	void setRemoteAddress(final InetAddress ia) {
+		peer = ia;
+	}
+
+	/** @return the daemon which spawned this client. */
+	public Daemon getDaemon() {
+		return daemon;
+	}
+
+	/** @return Internet address of the remote client. */
+	public InetAddress getRemoteAddress() {
+		return peer;
+	}
+
+	/** @return input stream to read from the connected client. */
+	public InputStream getInputStream() {
+		return rawIn;
+	}
+
+	/** @return output stream to send data to the connected client. */
+	public OutputStream getOutputStream() {
+		return rawOut;
+	}
+
+	void execute(final InputStream in, final OutputStream out)
+			throws IOException {
+		rawIn = in;
+		rawOut = out;
+
+		String cmd = new PacketLineIn(rawIn).readStringNoLF();
+		if (cmd == null || cmd.length() == 0)
+			return;
+
+		final int nul = cmd.indexOf('\0');
+		if (nul >= 0) {
+			// Newer clients hide a "host" header behind this byte.
+			// Currently we don't use it for anything, so we ignore
+			// this portion of the command.
+			//
+			cmd = cmd.substring(0, nul);
+		}
+
+		final DaemonService srv = getDaemon().matchService(cmd);
+		if (srv == null)
+			return;
+		srv.execute(this, cmd);
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
new file mode 100644
index 0000000..775a506
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
@@ -0,0 +1,120 @@
+/*
+ * Copyright (C) 2008, Google Inc.
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
+
+import org.spearce.jgit.lib.Repository;
+
+/** A service exposed by {@link Daemon} over anonymous <code>git://</code>. */
+public abstract class DaemonService {
+	private final String command;
+
+	private final String config;
+
+	private boolean enabled;
+
+	private boolean overridable;
+
+	protected DaemonService(final String cmdName, final String cfgName) {
+		command = cmdName.startsWith("git-") ? cmdName : "git-" + cmdName;
+		config = cfgName;
+		overridable = true;
+	}
+
+	/** @return is this service enabled for invocation? */
+	public boolean isEnabled() {
+		return enabled;
+	}
+
+	/**
+	 * @param on
+	 *            true to allow this service to be used; false to deny it.
+	 */
+	public void setEnabled(final boolean on) {
+		enabled = on;
+	}
+
+	/** @return can this service be configured in the repository config file? */
+	public boolean isOverridable() {
+		return overridable;
+	}
+
+	/**
+	 * @param on
+	 *            true to permit repositories to override this service's enabled
+	 *            state with the <code>daemon.servicename</code> config setting.
+	 */
+	public void setOverridable(final boolean on) {
+		overridable = on;
+	}
+
+	/** @return name of the command requested by clients. */
+	public String getCommandName() {
+		return command;
+	}
+
+	/**
+	 * Determine if this service can handle the requested command.
+	 * 
+	 * @param commandLine
+	 *            input line from the client.
+	 * @return true if this command can accept the given command line.
+	 */
+	public boolean handles(final String commandLine) {
+		return command.length() + 1 < commandLine.length()
+				&& commandLine.charAt(command.length()) == ' '
+				&& commandLine.startsWith(command);
+	}
+
+	void execute(final DaemonClient client, final String commandLine)
+			throws IOException {
+		final String name = commandLine.substring(command.length() + 1);
+		final Repository db = client.getDaemon().openRepository(name);
+		if (db == null)
+			return;
+		boolean on = isEnabled();
+		if (isOverridable())
+			on = db.getConfig().getBoolean("daemon", config, on);
+		if (on)
+			execute(client, db);
+	}
+
+	protected abstract void execute(DaemonClient client, Repository db)
+			throws IOException;
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
index a80c335..a11f293 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportGitAnon.java
@@ -56,8 +56,7 @@
  * source projects, as there are no authentication or authorization overheads.
  */
 class TransportGitAnon extends PackTransport {
-	/** IANA assigned port number for Git. */
-	static final int GIT_PORT = 9418;
+	static final int GIT_PORT = Daemon.DEFAULT_PORT;
 
 	static boolean canHandle(final URIish uri) {
 		return "git".equals(uri.getScheme());
-- 
1.6.1.rc4.301.g5497a

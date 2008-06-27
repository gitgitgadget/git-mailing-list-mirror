From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 11/23] Add BasePackPushConnection implementing git-send-pack protocol
Date: Sat, 28 Jun 2008 00:06:35 +0200
Message-ID: <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7i-0000rw-BD
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbYF0WHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492AbYF0WHt
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36995 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347AbYF0WHo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182348nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1/UzXSjFRnV+90YKI+PyHIbOMjhC3BVgNIQZoOCa+cI=;
        b=VFmtqHDrc+jw6wwp5vETwWwIX2C90c7vrLUgX6Nd3f8IT97RlKNl7JCT5JnNAv07tR
         NDkZq3YK0UhPbS+ztvZV9DWkDrXlwz828h919Dl0IrpKh5h8duH+ifTEOHTkuTWZsV/6
         8zfdn0PX/5bQeTjiF3+AgJDBMKX7kUDiUn0p4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nFXtz9nAk3gDqjcBGMxFcMJZv+2F55AHiVST8LDsAnA/Jbgb6nKriL6tb2pMx7iHp3
         qeYtDWpRnYjLRKRkiK61FaxbC7cSwfcwFVDI5QdFC2/UlBxU9QOrLLvQWm6hxCC9RuLW
         UJqGAlZpLU8QGXvYWi76ZtFjU/SnO+O6CvoAg=
Received: by 10.210.66.13 with SMTP id o13mr1570739eba.193.1214604463875;
        Fri, 27 Jun 2008 15:07:43 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id z33sm2455281ikz.0.2008.06.27.15.07.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86650>

Implementation realies extensively on RemoteRefUpdate as input.

It supports report-status capability, and honors delete-refs one.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../jgit/transport/BasePackPushConnection.java     |  226 ++++++++++++++++++++
 1 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
new file mode 100644
index 0000000..159e331
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -0,0 +1,226 @@
+/*
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
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
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Map;
+
+import org.spearce.jgit.errors.PackProtocolException;
+import org.spearce.jgit.errors.TransportException;
+import org.spearce.jgit.lib.ObjectId;
+import org.spearce.jgit.lib.PackWriter;
+import org.spearce.jgit.lib.ProgressMonitor;
+import org.spearce.jgit.lib.Ref;
+import org.spearce.jgit.transport.RemoteRefUpdate.Status;
+
+/**
+ * Push implementation using the native Git pack transfer service.
+ * <p>
+ * This is the canonical implementation for transferring objects to the remote
+ * repository from the local repository by talking to the 'git-receive-pack'
+ * service. Objects are packed on the local side into a pack file and then sent
+ * to the remote repository.
+ * <p>
+ * This connection requires only a bi-directional pipe or socket, and thus is
+ * easily wrapped up into a local process pipe, anonymous TCP socket, or a
+ * command executed through an SSH tunnel.
+ * <p>
+ * This implementation honors {@link Transport#isPushThin()} option.
+ * <p>
+ * Concrete implementations should just call
+ * {@link #init(java.io.InputStream, java.io.OutputStream)} and
+ * {@link #readAdvertisedRefs()} methods in constructor or before any use. They
+ * should also handle resources releasing in {@link #close()} method if needed.
+ */
+class BasePackPushConnection extends BasePackConnection implements
+		PushConnection {
+	static final String CAPABILITY_REPORT_STATUS = "report-status";
+
+	static final String CAPABILITY_DELETE_REFS = "delete-refs";
+
+	private final boolean thinPack;
+
+	private boolean capableDeleteRefs;
+
+	private boolean capableReport;
+
+	private boolean sentCommand;
+
+	private boolean writePack;
+
+	BasePackPushConnection(final PackTransport transport) {
+		super(transport);
+		thinPack = transport.isPushThin();
+	}
+
+	public void push(final ProgressMonitor monitor,
+			final Map<String, RemoteRefUpdate> refUpdates)
+			throws TransportException {
+		markStartedOperation();
+		doPush(monitor, refUpdates);
+	}
+
+	protected void doPush(final ProgressMonitor monitor,
+			final Map<String, RemoteRefUpdate> refUpdates)
+			throws TransportException {
+		try {
+			writeCommands(refUpdates.values(), monitor);
+			if (writePack)
+				writePack(refUpdates, monitor);
+			if (sentCommand && capableReport)
+				readStatusReport(refUpdates);
+		} catch (TransportException e) {
+			throw e;
+		} catch (Exception e) {
+			throw new TransportException(uri + ": " + e.getMessage(), e);
+		} finally {
+			close();
+		}
+	}
+
+	private void writeCommands(final Collection<RemoteRefUpdate> refUpdates,
+			final ProgressMonitor monitor) throws IOException {
+		final String capabilties = enableCapabilties();
+		for (final RemoteRefUpdate rru : refUpdates) {
+			if (!capableDeleteRefs && rru.isDelete()) {
+				rru.setStatus(Status.REJECTED_NODELETE);
+				continue;
+			}
+
+			final StringBuilder sb = new StringBuilder();
+			final Ref advertisedRef = getRef(rru.getRemoteName());
+			final ObjectId oldId = (advertisedRef == null ? ObjectId.zeroId()
+					: advertisedRef.getObjectId());
+			sb.append(oldId);
+			sb.append(' ');
+			sb.append(rru.getNewObjectId());
+			sb.append(' ');
+			sb.append(rru.getRemoteName());
+			if (!sentCommand) {
+				sentCommand = true;
+				sb.append(capabilties);
+			}
+
+			pckOut.writeString(sb.toString());
+			rru.setStatus(sentCommand ? Status.AWAITING_REPORT : Status.OK);
+			if (!rru.isDelete())
+				writePack = true;
+		}
+
+		if (monitor.isCancelled())
+			throw new TransportException(uri + ": push cancelled");
+		pckOut.end();
+	}
+
+	private String enableCapabilties() {
+		final StringBuilder line = new StringBuilder();
+		capableReport = wantCapability(line, CAPABILITY_REPORT_STATUS);
+		capableDeleteRefs = wantCapability(line, CAPABILITY_DELETE_REFS);
+		if (line.length() > 0)
+			line.insert(0, '\0');
+		return line.toString();
+	}
+
+	private void writePack(final Map<String, RemoteRefUpdate> refUpdates,
+			final ProgressMonitor monitor) throws IOException {
+		final PackWriter writer = new PackWriter(local, out, monitor);
+		final ArrayList<ObjectId> remoteObjects = new ArrayList<ObjectId>(
+				getRefs().size());
+		final ArrayList<ObjectId> newObjects = new ArrayList<ObjectId>(
+				refUpdates.size());
+
+		for (final Ref r : getRefs())
+			remoteObjects.add(r.getObjectId());
+		for (final RemoteRefUpdate r : refUpdates.values())
+			newObjects.add(r.getNewObjectId());
+
+		writer.writePack(newObjects, remoteObjects, thinPack, true);
+	}
+
+	private void readStatusReport(final Map<String, RemoteRefUpdate> refUpdates)
+			throws IOException {
+		final String unpackLine = pckIn.readString();
+		if (!unpackLine.startsWith("unpack "))
+			throw new PackProtocolException(uri + ": unexpected report line: "
+					+ unpackLine);
+		final String unpackStatus = unpackLine.substring("unpack ".length());
+		if (!unpackStatus.equals("ok"))
+			throw new TransportException(uri
+					+ ": error occurred during unpacking on the remote end: "
+					+ unpackStatus);
+
+		String refLine;
+		while ((refLine = pckIn.readString()).length() > 0) {
+			boolean ok = false;
+			int refNameEnd = -1;
+			if (refLine.startsWith("ok ")) {
+				ok = true;
+				refNameEnd = refLine.length();
+			} else if (refLine.startsWith("ng ")) {
+				ok = false;
+				refNameEnd = refLine.indexOf(" ", 3);
+			}
+			if (refNameEnd == -1)
+				throw new PackProtocolException(uri
+						+ ": unexpected report line: " + refLine);
+			final String refName = refLine.substring(3, refNameEnd);
+			final String message = (ok ? null : refLine
+					.substring(refNameEnd + 1));
+
+			final RemoteRefUpdate rru = refUpdates.get(refName);
+			if (rru == null)
+				throw new PackProtocolException(uri
+						+ ": unexpected ref report: " + refName);
+			if (ok) {
+				rru.setStatus(Status.OK);
+			} else {
+				rru.setStatus(Status.REJECTED_OTHER_REASON);
+				rru.setMessage(message);
+			}
+		}
+		for (final RemoteRefUpdate rru : refUpdates.values()) {
+			if (rru.getStatus() == Status.AWAITING_REPORT)
+				throw new PackProtocolException(uri
+						+ ": expected report for ref " + rru.getRemoteName()
+						+ " not received");
+		}
+	}
+}
-- 
1.5.5.3

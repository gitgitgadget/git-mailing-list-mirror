From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/7] Disambiguate pkt-line "0000" from "0004"
Date: Thu,  4 Jun 2009 14:43:58 -0700
Message-ID: <1244151843-26954-3-git-send-email-spearce@spearce.org>
References: <1244151843-26954-1-git-send-email-spearce@spearce.org>
 <1244151843-26954-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:45:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKkG-0001OL-Sh
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752997AbZFDVoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 17:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZFDVoJ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:44:09 -0400
Received: from george.spearce.org ([209.20.77.23]:35365 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbZFDVoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 17:44:04 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 1823538239; Thu,  4 Jun 2009 21:44:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 258D9381CE;
	Thu,  4 Jun 2009 21:44:04 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.1.333.g3ebba7
In-Reply-To: <1244151843-26954-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120716>

The pkt-line length includes its own 4 bytes.  So "0000" is the
magic flush/end marker used as part of the protocols based upon
pkt-line, while "0004" indicates a packet of 0 bytes, but not a
flush/end marker.

Currently there is no need for this distinction in the code, as
the protocol never sends an empty packet, but it reduces the risk
that in the future a "0004" packet is misread as a "0000" flush.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/transport/BasePackConnection.java |    5 ++---
 .../jgit/transport/BasePackPushConnection.java     |    2 +-
 .../org/spearce/jgit/transport/DaemonClient.java   |    5 +----
 .../org/spearce/jgit/transport/PacketLineIn.java   |   18 +++++++++---------
 .../org/spearce/jgit/transport/ReceivePack.java    |    6 +++---
 .../src/org/spearce/jgit/transport/UploadPack.java |    4 ++--
 6 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index c6440c7..0382d2b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -140,6 +140,8 @@ private void readAdvertisedRefsImpl() throws IOException {
 					throw noRepository();
 				throw eof;
 			}
+			if (line == PacketLineIn.END)
+				break;
 
 			if (avail.isEmpty()) {
 				final int nul = line.indexOf('\0');
@@ -152,9 +154,6 @@ private void readAdvertisedRefsImpl() throws IOException {
 				}
 			}
 
-			if (line.length() == 0)
-				break;
-
 			String name = line.substring(41, line.length());
 			if (avail.isEmpty() && name.equals("capabilities^{}")) {
 				// special line from git-receive-pack to show
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 1117109..712d3c0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -225,7 +225,7 @@ private void readStatusReport(final Map<String, RemoteRefUpdate> refUpdates)
 							+ unpackStatus);
 
 		String refLine;
-		while ((refLine = pckIn.readString()).length() > 0) {
+		while ((refLine = pckIn.readString()) != PacketLineIn.END) {
 			boolean ok = false;
 			int refNameEnd = -1;
 			if (refLine.startsWith("ok ")) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
index 636cf22..e80d86b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
@@ -85,10 +85,7 @@ void execute(final InputStream in, final OutputStream out)
 		rawIn = in;
 		rawOut = out;
 
-		String cmd = new PacketLineIn(rawIn).readStringNoLF();
-		if (cmd == null || cmd.length() == 0)
-			return;
-
+		String cmd = new PacketLineIn(rawIn).readStringRaw();
 		final int nul = cmd.indexOf('\0');
 		if (nul >= 0) {
 			// Newer clients hide a "host" header behind this byte.
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
index ef218be..92c7009 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/PacketLineIn.java
@@ -50,6 +50,7 @@
 import org.spearce.jgit.util.RawParseUtils;
 
 class PacketLineIn {
+	static final String END = new String("") /* must not string pool */;
 	private static final byte fromhex[];
 
 	static {
@@ -101,20 +102,23 @@ AckNackResult readACK(final MutableObjectId returnedId) throws IOException {
 	String readString() throws IOException {
 		int len = readLength();
 		if (len == 0)
-			return "";
+			return END;
 
-		len -= 5; // length header (4 bytes) and trailing LF.
+		len -= 4; // length header (4 bytes)
+		if (len == 0)
+			return "";
 
 		final byte[] raw = new byte[len];
 		NB.readFully(in, raw, 0, len);
-		readLF();
+		if (raw[len - 1] == '\n')
+			len--;
 		return RawParseUtils.decode(Constants.CHARSET, raw, 0, len);
 	}
 
-	String readStringNoLF() throws IOException {
+	String readStringRaw() throws IOException {
 		int len = readLength();
 		if (len == 0)
-			return "";
+			return END;
 
 		len -= 4; // length header (4 bytes)
 
@@ -123,10 +127,6 @@ String readStringNoLF() throws IOException {
 		return RawParseUtils.decode(Constants.CHARSET, raw, 0, len);
 	}
 
-	private void readLF() throws IOException {
-		if (in.read() != '\n')
-			throw new IOException("Protocol error: expected LF");
-	}
 
 	int readLength() throws IOException {
 		NB.readFully(in, lenbuffer, 0, 4);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
index eaa1016..abaf876 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java
@@ -506,12 +506,14 @@ private void recvCommands() throws IOException {
 		for (;;) {
 			String line;
 			try {
-				line = pckIn.readStringNoLF();
+				line = pckIn.readStringRaw();
 			} catch (EOFException eof) {
 				if (commands.isEmpty())
 					return;
 				throw eof;
 			}
+			if (line == PacketLineIn.END)
+				break;
 
 			if (commands.isEmpty()) {
 				final int nul = line.indexOf('\0');
@@ -522,8 +524,6 @@ private void recvCommands() throws IOException {
 				}
 			}
 
-			if (line.length() == 0)
-				break;
 			if (line.length() < 83) {
 				final String m = "error: invalid protocol: wanted 'old new ref'";
 				sendError(m);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
index 45d57b3..53fbce0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/UploadPack.java
@@ -293,7 +293,7 @@ private void recvWants() throws IOException {
 				throw eof;
 			}
 
-			if (line.length() == 0)
+			if (line == PacketLineIn.END)
 				break;
 			if (!line.startsWith("want ") || line.length() < 45)
 				throw new PackProtocolException("expected want; got " + line);
@@ -348,7 +348,7 @@ private void negotiate() throws IOException {
 				throw eof;
 			}
 
-			if (line.length() == 0) {
+			if (line == PacketLineIn.END) {
 				if (commonBase.isEmpty() || multiAck)
 					pckOut.writeString("NAK\n");
 				pckOut.flush();
-- 
1.6.3.1.333.g3ebba7

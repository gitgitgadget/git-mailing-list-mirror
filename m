From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/13] Add receive-pack server side support
Date: Mon, 22 Dec 2008 16:27:10 -0800
Message-ID: <1229992043-1053-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 01:28:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEv8g-0005Qg-Ve
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 01:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbYLWA11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 19:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbYLWA10
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 19:27:26 -0500
Received: from george.spearce.org ([209.20.77.23]:54461 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYLWA1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 19:27:25 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9DEC038211; Tue, 23 Dec 2008 00:27:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id CDCF738197;
	Tue, 23 Dec 2008 00:27:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc4.301.g5497a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103782>

This is a simple implementation of the receive-pack part of the
send-pack/receive-pack protocol used by push.  Most of the logic
the server implements can be customized by implementing your
own PreReceiveHook implementation.

I'm actually going to use this within Gerrit 2 so users can push
into the special ref name "refs/changes/new" and have an anonymous
topic branch be created instead.

A basic "jgit daemon" for the git:// protocol is also included.
This daemon still has some major limitations over "git daemon":

 - Only "receive-pack" is supported.  We do not have a Java
   version of "upload-pack" so we do not support it here.

 - Virtual hosting is not supported; the "host=" header (if sent
   by the client) is discarded.

 - User escapes ("git://host/~user/foo.git") are not honored.

 - No receive timeouts.  Evil clients can connect and do nothing,
   pinning the server thread indefinitely.  This can cause the
   server to consume resources until it crashes.

 - No connection limits.  Evil clients can DOS the server by just
   opening a ton of connections.

 - "jgit daemon" must be started within a git repository, even if
   it won't publish that repository over the network.  This is due
   to a limitation in the way TextBuiltin initializes itself.

Providing "jgit receive-pack" should be trivial if the last item
is fixed, permitting jgit commands to be executed from outside of
a Git repository.

JSch does not have an SSH server implementation, so we cannot easily
provide an SSH daemon for our new push support.  Apache MINA SSHD has
a nice daemon under development, and I plan on using it in Gerrit 2.
Perhaps someone will eventually contribute an extension library
for JGit which provides the binding glue necessary for MINA SSHD
to invoke JGit.

JGit's ReceivePack class does not invoke the standard hooks honored
by "git receive-pack", because doing so would require executing
an external process.  There's enough data available in memory that
someone could easily contribute a PreReceiveHook and PostRecieveHook
implementation that honored these.

The early part of the series has some code cleanups to ensure we
are thread-safe, and to reduce the thrasing on the InflaterCache.


Shawn O. Pearce (13):
  Fix invalid "double checked locking" in InflaterCache
  Cleanup stupid release of the cached Inflater in IndexPack
  Cache an Inflater inside a WindowCursor and reuse it as much as
    possible
  Make RefDatabase thread-safe
  Make PackFile thread-safe
  Make Repository thread-safe
  Don't open a PackFile multiple times on scanForPacks
  Expose RepositoryConfig.getBoolean so applications can use it
  Add AnyObjectId.copyTo(StringBuilder)
  Add compare-and-swap semantics to RefUpdate
  Allow null new ObjectId during RefUpdate.delete
  Implement the git-receive-pack process in Java
  Add basic git daemon support to publish receive-pack

 .../services/org.spearce.jgit.pgm.TextBuiltin      |    1 +
 .../src/org/spearce/jgit/pgm/Daemon.java           |  125 +++
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |   17 +-
 .../jgit/lib/DeltaRefPackedObjectLoader.java       |    2 +-
 .../src/org/spearce/jgit/lib/InflaterCache.java    |   31 +-
 .../src/org/spearce/jgit/lib/PackFile.java         |   14 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   29 +-
 .../src/org/spearce/jgit/lib/RefUpdate.java        |   32 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   90 ++-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |    4 +-
 .../src/org/spearce/jgit/lib/WindowCursor.java     |   33 +-
 .../src/org/spearce/jgit/lib/WindowedFile.java     |   17 +-
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    4 +-
 .../src/org/spearce/jgit/transport/Daemon.java     |  309 ++++++++
 .../org/spearce/jgit/transport/DaemonClient.java   |  106 +++
 .../org/spearce/jgit/transport/DaemonService.java  |  120 +++
 .../src/org/spearce/jgit/transport/IndexPack.java  |   17 +-
 .../org/spearce/jgit/transport/PacketLineIn.java   |   12 +
 .../spearce/jgit/transport/PostReceiveHook.java    |   77 ++
 .../org/spearce/jgit/transport/PreReceiveHook.java |   94 +++
 .../org/spearce/jgit/transport/ReceiveCommand.java |  223 ++++++
 .../org/spearce/jgit/transport/ReceivePack.java    |  793 ++++++++++++++++++++
 .../spearce/jgit/transport/TransportGitAnon.java   |    3 +-
 23 files changed, 2060 insertions(+), 93 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Daemon.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/Daemon.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/DaemonClient.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/DaemonService.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PostReceiveHook.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/PreReceiveHook.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/ReceiveCommand.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/ReceivePack.java

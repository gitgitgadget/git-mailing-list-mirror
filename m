From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/6] Add timeouts to network IO
Date: Fri, 19 Jun 2009 14:27:49 -0700
Message-ID: <1245446875-31102-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:28:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHlcz-0002NZ-13
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 23:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbZFSV1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 17:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbZFSV1y
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 17:27:54 -0400
Received: from george.spearce.org ([209.20.77.23]:42449 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZFSV1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 17:27:53 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 703A638200; Fri, 19 Jun 2009 21:27:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 812943819E;
	Fri, 19 Jun 2009 21:27:55 +0000 (UTC)
X-Mailer: git-send-email 1.6.3.2.416.g04d0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121911>

If there's a bug in the remote peer software, or even just random
network hardware/cable failures between us and the remote peer, we
might block indefinitely waiting for more incoming data, or waiting
for TCP ACKs necessary to release space in our transmit buffer.

This series adds a timeout to everything, allowing the caller to
define some maximum waiting period before we abort and declare the
remote peer to be unresponsive.  The default timeout of 0 will use
the traditional "block indefinitely" behavior we have always had.


Shawn O. Pearce (6):
  Create input and output streams that have timeouts
  Add remote.name.timeout to configure an IO timeout
  Add timeouts to smart transport protocol clients
  Add timeouts to smart transport protocol servers
  Add timeouts to anonymous git:// daemon
  Add --timeout command line options

 .../src/org/spearce/jgit/pgm/Daemon.java           |    5 +
 .../src/org/spearce/jgit/pgm/Fetch.java            |    5 +
 .../src/org/spearce/jgit/pgm/LsRemote.java         |    6 +
 .../src/org/spearce/jgit/pgm/Push.java             |    5 +
 .../src/org/spearce/jgit/pgm/UploadPack.java       |    6 +
 .../spearce/jgit/transport/RemoteConfigTest.java   |   26 ++
 .../jgit/util/io/TimeoutInputStreamTest.java       |  187 +++++++++++++
 .../jgit/util/io/TimeoutOutputStreamTest.java      |  286 ++++++++++++++++++++
 .../spearce/jgit/transport/BasePackConnection.java |   36 +++-
 .../jgit/transport/BasePackPushConnection.java     |   29 ++-
 .../src/org/spearce/jgit/transport/Daemon.java     |   26 ++-
 .../org/spearce/jgit/transport/DaemonClient.java   |   12 +-
 .../org/spearce/jgit/transport/ReceivePack.java    |   57 ++++
 .../org/spearce/jgit/transport/RemoteConfig.java   |   31 +++
 .../org/spearce/jgit/transport/SshTransport.java   |    3 +-
 .../src/org/spearce/jgit/transport/Transport.java  |   21 ++
 .../spearce/jgit/transport/TransportGitAnon.java   |   13 +-
 .../spearce/jgit/transport/TransportGitSsh.java    |  103 +++++++-
 .../org/spearce/jgit/transport/TransportLocal.java |    9 +-
 .../org/spearce/jgit/transport/TransportSftp.java  |    3 +-
 .../src/org/spearce/jgit/transport/UploadPack.java |   59 ++++-
 .../org/spearce/jgit/util/io/InterruptTimer.java   |  216 +++++++++++++++
 .../spearce/jgit/util/io/TimeoutInputStream.java   |  133 +++++++++
 .../spearce/jgit/util/io/TimeoutOutputStream.java  |  146 ++++++++++
 24 files changed, 1400 insertions(+), 23 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutInputStreamTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/util/io/TimeoutOutputStreamTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/InterruptTimer.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutInputStream.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/util/io/TimeoutOutputStream.java

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/11] Repository instance caching
Date: Sat, 11 Jul 2009 13:19:15 -0700
Message-ID: <1247343566-19025-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 11 22:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPj2w-0003MO-AI
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 22:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbZGKUTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbZGKUT2
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 16:19:28 -0400
Received: from george.spearce.org ([209.20.77.23]:39687 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZGKUT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 16:19:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 90150381FE; Sat, 11 Jul 2009 20:19:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 08B1238194;
	Sat, 11 Jul 2009 20:19:26 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc0.117.g28cb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123117>

This series lays the groundwork for caching Repository instances
within the JRE, such as a server daemon might want when it is
accessing multiple repositories, like a git:// daemon needs to do.

We also modify the way alternates are handled, checking to see if
an alternate is actually an objects directory for a Repository,
and if so, using the Repository instance from the cache in the
alternate chain.  This permits better reuse of pack files windows
when repositories are using alternates.  Based on this support we can
also now implement the ".have" logic in the ReceivePack server code.

I plan to follow onto this series with work to support submodules in
a server setting, e.g. processing the .gitmodules directly from the
object database and being able to examine the submodule Repository.

Shawn O. Pearce (11):
  Change Daemon to use concurrent collections for exported repositories
  Make Daemon's exportAll check not require synchronization
  Don't retry ".git" suffix in daemon if already tried
  Refactor ref advertisement code from server implementations
  Don't advertise HEAD from ReceivePack
  Add a use reference counter to Repository
  Introduce RepositoryCache to cache handles of Repository objects
  Change Daemon to use RepositoryCache
  Expose the Repository's ObjectDatabase object
  Use cached Repository instances when resolving alternates
  Send .have lines in ReceivePack for alternate repositories

 .../org/spearce/jgit/lib/RepositoryCacheTest.java  |  126 +++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   16 +-
 .../jgit/errors/RepositoryNotFoundException.java   |   65 ++++
 .../jgit/lib/AlternateRepositoryDatabase.java      |  127 +++++++
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |   16 +-
 .../src/org/spearce/jgit/lib/ObjectDirectory.java  |   18 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   18 +-
 .../src/org/spearce/jgit/lib/RepositoryCache.java  |  386 ++++++++++++++++++++
 .../src/org/spearce/jgit/transport/Daemon.java     |   76 ++---
 .../org/spearce/jgit/transport/DaemonService.java  |   14 +-
 .../org/spearce/jgit/transport/ReceivePack.java    |   67 +---
 .../org/spearce/jgit/transport/RefAdvertiser.java  |  189 ++++++++++
 .../src/org/spearce/jgit/transport/UploadPack.java |   93 +-----
 13 files changed, 1019 insertions(+), 192 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryCacheTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/RepositoryNotFoundException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryCache.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/RefAdvertiser.java

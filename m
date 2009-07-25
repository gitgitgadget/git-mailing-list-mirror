From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/19] More Config class cleanup work
Date: Sat, 25 Jul 2009 11:52:43 -0700
Message-ID: <1248547982-4003-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 20:53:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUmN5-0002D8-Jw
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 20:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZGYSxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 14:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZGYSxE
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 14:53:04 -0400
Received: from george.spearce.org ([209.20.77.23]:35539 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbZGYSxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 14:53:03 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 5E079381FF; Sat, 25 Jul 2009 18:53:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id B9A1A38196;
	Sat, 25 Jul 2009 18:53:02 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc2.216.g769fa
CC: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124035>

Yet another series to cleanup the Config class and its
implementations to be slightly more useful.

The later part of the series makes Config thread safe and introduces
caching of application-specific model instances as part of the
Config, making it more efficient for code to query for multiple
values at once.

This new caching feature is especially useful for ReceivePack on
the server side, where the values aren't expected to change between
connections, but connections come in at a steady enough rate that
reparsing the configuration each time is just a waste of time.

Later I plan to extend the caching by using it RemoteConfig and
also for a new SubmoduleConfig.


The entire series applies on top of my 1 patch from yesterday that
fixes the Turkish locale problems in Config.


Shawn O. Pearce (19):
  Cleanup nonstandard references to encoding strings to bytes
  Delete incorrect Javadoc from Config's getRawString method
  Make Config.escapeValue a private method
  Allow a RemoteConfig to use the more generic Config class
  Use type specific sets when creating a new RepositoryConfig
  Move SystemReader out of RepositoryConfig
  Correct user config to be of type FileBasedConfig
  Extract the test specific SystemReader out of RepositoryTestCase
  Refactor Config hierarchy to make IO more explicit
  Test for the config file when creating a new repository
  Remove the map lookup for values in Config
  Return base values first from Config.getStringList()
  Make Config thread safe by using copy-on-write semantics
  Support cached application models in a Config
  Cache Config subsection names when requested by application code
  Refactor author/committer lookup to use cached data
  Move repository config creation fully into Repository class
  Use Config SectionParser cache to store daemon enable states
  Use Config cache for fetch and receive configuration parsing

 .../org/spearce/jgit/lib/ConcurrentRepackTest.java |    2 +-
 .../tst/org/spearce/jgit/lib/MockSystemReader.java |   78 ++
 .../org/spearce/jgit/lib/RepositoryConfigTest.java |  193 +++---
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   51 +--
 .../tst/org/spearce/jgit/lib/T0003_Basic.java      |   16 +-
 .../org/spearce/jgit/revwalk/RevWalkTestCase.java  |    3 +-
 .../spearce/jgit/transport/RemoteConfigTest.java   |  166 ++---
 .../jgit/errors/ConfigInvalidException.java        |   53 ++
 .../src/org/spearce/jgit/lib/BlobBasedConfig.java  |  110 ++--
 .../src/org/spearce/jgit/lib/Config.java           |  743 +++++++++++---------
 .../src/org/spearce/jgit/lib/CoreConfig.java       |   16 +-
 .../src/org/spearce/jgit/lib/FileBasedConfig.java  |   83 ++-
 .../src/org/spearce/jgit/lib/ObjectWriter.java     |    2 +-
 .../src/org/spearce/jgit/lib/Repository.java       |   38 +-
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |  144 +----
 .../src/org/spearce/jgit/lib/TransferConfig.java   |   11 +-
 .../src/org/spearce/jgit/lib/UserConfig.java       |  149 ++++
 .../jgit/revwalk/filter/PatternMatchRevFilter.java |   10 +-
 .../jgit/transport/BasePackFetchConnection.java    |   21 +-
 .../org/spearce/jgit/transport/DaemonService.java  |   30 +-
 .../org/spearce/jgit/transport/ReceivePack.java    |   45 +-
 .../org/spearce/jgit/transport/RemoteConfig.java   |   15 +-
 .../org/spearce/jgit/util/RawSubStringPattern.java |   10 +-
 .../src/org/spearce/jgit/util/SystemReader.java    |   65 ++-
 24 files changed, 1172 insertions(+), 882 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/MockSystemReader.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/ConfigInvalidException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/UserConfig.java

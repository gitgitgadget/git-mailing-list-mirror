From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 00/28] Convert command line parsing to args4j
Date: Thu, 17 Jul 2008 21:43:53 -0400
Message-ID: <1216345461-59382-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:45:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJf2G-0005th-7k
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490AbYGRBoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757392AbYGRBoY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:44:24 -0400
Received: from george.spearce.org ([209.20.77.23]:46930 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821AbYGRBoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:44:23 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id DB6E738262; Fri, 18 Jul 2008 01:44:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id E0D8638262;
	Fri, 18 Jul 2008 01:44:21 +0000 (UTC)
X-Mailer: git-send-email 1.5.6.3.569.ga9185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88949>

Instead of using a custom argument parsing loop for each builtin
subcommand we use a standard parsing library.  The library can
also generate help text, such as:

$ jgit -h
jgit --git-dir GIT_DIR --help (-h) --show-stack-trace command [ARG ...]

 --git-dir GIT_DIR  : set the git repository to operate on
 --help (-h)        : display this help text
 --show-stack-trace : display the Java stack trace on exceptions

$ jgit merge-base -h
jgit merge-base commit-ish commit-ish ... [--all] [--help (-h)]

 --all       : display all possible merge bases
 --help (-h) : display this help text

--8<--

Shawn O. Pearce (28):
  Fix deadlock caused by push over SSH
  Use die utility method in glog
  Add args4j library for command line switch processing
  Move org.spearce.jgit.pgm to its own Java project
  Make TextBuiltin public so other packages can implement and use it
  Initialize TextBuiltins with the repository before execution
  Define our own extended CmdLineParser for extra parsing support
  Add parseTree method to RevWalk to obtain a RevTree from AnyObjectId
  Add option handler for AbstractTreeIterator values
  Add option handler for ObjectId values
  Add option handler for PathTreeFilter values
  Add option handler for RefSpec values
  Add option handler for RevCommit values
  Add option handler for RevTree values
  Register most of our OptionHandler implementations for automatic use
  Convert jgit's Main to use args4j for basic parsing services
  Support automatic command line parsing for TextBuiltin subclasses
  Convert diff-tree program to args4j
  Convert fetch program to args4j
  Convert index-pack program to args4j
  Convert ls-remote program to args4j
  Convert ls-tree program to args4j
  Convert merge-base program to args4j
  Convert push program to args4j
  Convert show-ref program to args4j
  Convert tag program to args4j
  Convert rev-list, log, glog programs to args4j
  Remove support for legacy style TextBuiltins

 jgit.sh                                            |    2 +
 make_jgit.sh                                       |   88 +++++-
 org.spearce.jgit.pgm/.classpath                    |    8 +
 org.spearce.jgit.pgm/.gitignore                    |    1 +
 org.spearce.jgit.pgm/.project                      |   17 +
 .../.settings/org.eclipse.core.runtime.prefs       |    3 +
 .../.settings/org.eclipse.jdt.core.prefs           |  320 ++++++++++++++++++++
 .../.settings/org.eclipse.jdt.ui.prefs             |    9 +
 org.spearce.jgit.pgm/lib/args4j-2.0.9.jar          |  Bin 0 -> 40654 bytes
 org.spearce.jgit.pgm/lib/args4j-2.0.9.zip          |  Bin 0 -> 31516 bytes
 org.spearce.jgit.pgm/lib/args4j.LICENSE.txt        |   32 ++
 .../src/org/spearce/jgit/pgm/Die.java              |   17 +-
 .../src/org/spearce/jgit/pgm/DiffTree.java         |   57 ++--
 .../src/org/spearce/jgit/pgm/Fetch.java            |   27 +--
 .../src/org/spearce/jgit/pgm/Glog.java             |    2 +-
 .../src/org/spearce/jgit/pgm/IndexPack.java        |   35 +--
 .../src/org/spearce/jgit/pgm/Log.java              |    0
 .../src/org/spearce/jgit/pgm/LsRemote.java         |   23 +-
 .../src/org/spearce/jgit/pgm/LsTree.java           |   42 +--
 .../src/org/spearce/jgit/pgm/Main.java             |  115 +++----
 .../src/org/spearce/jgit/pgm/MergeBase.java        |   37 ++-
 .../src/org/spearce/jgit/pgm/Push.java             |   99 +++----
 .../src/org/spearce/jgit/pgm/RevList.java          |    0
 .../org/spearce/jgit/pgm/RevWalkTextBuiltin.java   |  146 +++++----
 .../src/org/spearce/jgit/pgm/ShowRef.java          |    2 +-
 .../src/org/spearce/jgit/pgm/Tag.java              |   79 ++---
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |  202 ++++++++++++
 .../org/spearce/jgit/pgm/build/JarLinkUtil.java    |  204 +++++++++++++
 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |  121 ++++++++
 .../org/spearce/jgit/pgm/opt/CmdLineParser.java    |  171 +++++++++++
 .../org/spearce/jgit/pgm/opt/ObjectIdHandler.java  |   94 ++++++
 .../jgit/pgm/opt/PathTreeFilterHandler.java        |  102 +++++++
 .../org/spearce/jgit/pgm/opt/RefSpecHandler.java   |   63 ++--
 .../org/spearce/jgit/pgm/opt/RevCommitHandler.java |  141 +++++++++
 .../org/spearce/jgit/pgm/opt/RevTreeHandler.java   |  109 +++++++
 .../spearce/jgit/pgm/opt/SubcommandHandler.java    |  149 +++++++++
 .../src/org/spearce/jgit/pgm/TextBuiltin.java      |   96 ------
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   35 +++
 .../org/spearce/jgit/transport/FetchProcess.java   |    2 +-
 .../spearce/jgit/transport/OperationResult.java    |   16 +-
 .../org/spearce/jgit/transport/PushProcess.java    |    2 +-
 41 files changed, 2149 insertions(+), 519 deletions(-)
 create mode 100644 org.spearce.jgit.pgm/.classpath
 create mode 100644 org.spearce.jgit.pgm/.gitignore
 create mode 100644 org.spearce.jgit.pgm/.project
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.core.runtime.prefs
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.jdt.core.prefs
 create mode 100644 org.spearce.jgit.pgm/.settings/org.eclipse.jdt.ui.prefs
 create mode 100644 org.spearce.jgit.pgm/lib/args4j-2.0.9.jar
 create mode 100644 org.spearce.jgit.pgm/lib/args4j-2.0.9.zip
 create mode 100644 org.spearce.jgit.pgm/lib/args4j.LICENSE.txt
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Die.java (76%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/DiffTree.java (73%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Fetch.java (89%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Glog.java (98%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/IndexPack.java (76%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Log.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/LsRemote.java (85%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/LsTree.java (76%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Main.java (64%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/MergeBase.java (73%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Push.java (78%)
 copy {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/RevList.java (100%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/RevWalkTextBuiltin.java (62%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/ShowRef.java (97%)
 rename {org.spearce.jgit => org.spearce.jgit.pgm}/src/org/spearce/jgit/pgm/Tag.java (66%)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/TextBuiltin.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/build/JarLinkUtil.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/AbstractTreeIteratorHandler.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/CmdLineParser.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/ObjectIdHandler.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/PathTreeFilterHandler.java
 rename org.spearce.jgit/src/org/spearce/jgit/pgm/RevList.java => org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RefSpecHandler.java (61%)
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevCommitHandler.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/RevTreeHandler.java
 create mode 100644 org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/opt/SubcommandHandler.java
 delete mode 100644 org.spearce.jgit/src/org/spearce/jgit/pgm/TextBuiltin.java

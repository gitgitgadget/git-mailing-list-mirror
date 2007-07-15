From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/6] Introduce commit notes
Date: Mon, 16 Jul 2007 00:19:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707152326080.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jul 16 01:19:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IADNL-0000WY-3U
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 01:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712AbXGOXTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 19:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXGOXTe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 19:19:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:54427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753668AbXGOXTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 19:19:33 -0400
Received: (qmail invoked by alias); 15 Jul 2007 23:19:31 -0000
Received: from R04e1.r.pppool.de (EHLO noname) [89.54.4.225]
  by mail.gmx.net (mp036) with SMTP; 16 Jul 2007 01:19:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Kf/0mfp9KZ9gp6EfLtB+hj2bb2IC5WIao/jiVn+
	jBVmaifyFb69pT
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52598>

Hi,

This patch series replaces the series I sent out a while ago, which added 
"commit annotations".  Since "commit notes" was liked much better, here 
they are.

It picks up the same idea, having a pseudo-branch whose revisions contain 
a .git/objects/??/* like file structure, and whose blobs are the commit 
notes.

By default, that pseudo-branch is "refs/notes/commits", but it is 
overridable by the config variable core.notesRef, which in turn can be 
overridden by the environment variable GIT_NOTES_REF.  If the given ref 
does not exist yet, it is interpreted as empty.

The biggest obstacle was a thinko about the scalability.  Tree objects 
take free form name entries, and therefore a binary search by name is not 
possible.

Patch 6/6 is only a WIP patch, but it shows the road ahead.  It adds code 
to generate .git/notes-index from refs/notes/commits (or any other ref you 
specify as notes ref), which is reused until refs/notes/commits^{tree} 
changes.  Patch 6/6 is only meant to assess which data structure yields 
best performance, and how big the costs are.

However, as long as there are no public, fetchable commit notes, I think 
the first 5 patches are safe for application and testing.

Ciao,
Dscho

Johannes Schindelin (6):
      Rename git_one_line() to git_line_length() and export it
      Introduce commit notes
      Add git-notes
      Add a test script for "git notes"
      Document git-notes
      notes: add notes-index for a substantial speedup.

 .gitignore                       |    1 +
 Documentation/cmd-list.perl      |    1 +
 Documentation/config.txt         |   15 ++
 Documentation/git-notes.txt      |   45 ++++
 Makefile                         |    5 +-
 cache.h                          |    1 +
 commit.c                         |   15 +-
 commit.h                         |    1 +
 config.c                         |    5 +
 environment.c                    |    1 +
 git-notes.sh                     |   61 ++++++
 notes.c                          |  416 ++++++++++++++++++++++++++++++++++++++
 notes.h                          |    9 +
 t/t3301-notes.sh                 |   63 ++++++
 t/t3302-notes-index-expensive.sh |  118 +++++++++++
 15 files changed, 750 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-notes.txt
 create mode 100755 git-notes.sh
 create mode 100644 notes.c
 create mode 100644 notes.h
 create mode 100755 t/t3301-notes.sh
 create mode 100755 t/t3302-notes-index-expensive.sh

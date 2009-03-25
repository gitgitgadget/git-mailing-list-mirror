From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 0/5] Foreign VCS as remote config
Date: Tue, 24 Mar 2009 23:04:03 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242239030.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:05:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJRA-00061j-FG
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361AbZCYDEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752967AbZCYDEH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:04:07 -0400
Received: from iabervon.org ([66.92.72.58]:43750 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972AbZCYDEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:04:06 -0400
Received: (qmail 11062 invoked by uid 1000); 25 Mar 2009 03:04:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:04:03 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114545>

This series, like my previous series, makes it possible to set up a git 
config like:

[remote "origin"]
        vcs = p4
        port = localhost:1666
        ignoreCodeline = //depot/projects/oof-1.0
        codeline = //depot/projects/foo-1.0
        fetch = refs/p4/depot/projects/*:refs/remotes/origin/*

And then "git fetch origin" will actually incrementally import a p4 
project.

The main difference from the previous series, aside from a nicer version 
of the p4 importer that can use the free-as-in-beer C++ API, is the fact 
that the only diff for a builtin command is to builtin-clone, which just 
needs to make a copy of a const struct before passing it to a function 
that can now change it.

Parts 1 and 2 are potentially useful for other other protocols 
transporting git data, and could be applied now. Part 3 creates the option 
and makes it not work at all. Part 4 is the same old API, and transport.c 
code to use it. Part 5 is my p4 example.

There's still the oddity that foreign systems that don't use a URL will 
lead to struct remotes that don't look valid to some git code that expects 
the URL field to be filled.

Daniel Barkalow (5):
  Allow late reporting of fetched hashes
  Document details of transport function APIs
  Add option for using a foreign VCS
  Draft of API for git-vcs-*, transport.c code to use it.
  p4 example of git-vcs API for fetch direction

 Documentation/config.txt     |    4 +
 Documentation/git-vcs-p4.txt |   33 ++
 Documentation/git-vcs.txt    |   93 ++++
 Makefile                     |   25 +
 builtin-clone.c              |    6 +-
 p4-notes                     |   33 ++
 remote.c                     |    2 +
 remote.h                     |    2 +
 transport.c                  |  129 ++++-
 transport.h                  |   42 ++-
 vcs-p4/p4client-api.cc       |  169 ++++++
 vcs-p4/p4client.c            |  137 +++++
 vcs-p4/p4client.h            |   38 ++
 vcs-p4/vcs-p4.c              | 1229 ++++++++++++++++++++++++++++++++++++++++++
 vcs-p4/vcs-p4.h              |  128 +++++
 15 files changed, 2057 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/git-vcs-p4.txt
 create mode 100644 Documentation/git-vcs.txt
 create mode 100644 p4-notes
 create mode 100644 vcs-p4/p4client-api.cc
 create mode 100644 vcs-p4/p4client.c
 create mode 100644 vcs-p4/p4client.h
 create mode 100644 vcs-p4/vcs-p4.c
 create mode 100644 vcs-p4/vcs-p4.h

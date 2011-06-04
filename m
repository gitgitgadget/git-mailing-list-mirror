From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv6 0/4] Support ref namespaces
Date: Fri,  3 Jun 2011 17:11:39 -0700
Message-ID: <1307146303-4524-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 02:12:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSeTT-0004Xo-FI
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 02:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755871Ab1FDAMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 20:12:09 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:56471 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754023Ab1FDAMH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 20:12:07 -0400
Received: by pxi2 with SMTP id 2so1517546pxi.10
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 17:12:06 -0700 (PDT)
Received: by 10.68.25.1 with SMTP id y1mr987197pbf.169.1307146326837;
        Fri, 03 Jun 2011 17:12:06 -0700 (PDT)
Received: from oh.minilop.net (host-242-103.pubnet.pdx.edu [131.252.242.103])
        by mx.google.com with ESMTPS id i7sm1815580pbj.58.2011.06.03.17.12.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 17:12:05 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QSeTE-0001Bj-Qa; Fri, 03 Jun 2011 17:12:04 -0700
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175046>

This series adds support for dividing the refs of a single repository
into multiple namespaces, each of which can have its own branches, tags,
and HEAD. Git can expose each namespace as an independent repository to
pull from and push to, while sharing the object store, and exposing all
the refs to operations such as git-gc.

Storing multiple repositories as namespaces of a single repository
avoids storing duplicate copies of the same objects, such as when
storing multiple branches of the same source.  The alternates mechanism
provides similar support for avoiding duplicates, but alternates do not
prevent duplication between new objects added to the repositories
without ongoing maintenance, while namespaces do.

The first patch is a bugfix; it's important regardless, but we need it
to correctly implement for_each_namespaced_ref later. The next two
patches implement and then use infrastructure for tracking the current
namespace and iterating over the refs in that namespace. The last patch
adds general documentation for namespaces, and specific references from
the documentation on receive-pack, upload-pack, http-backend, and git.

v6 improves the commit message in patch 2/4, and the documentation in 4/4,
regarding why namespaces treat '/' specially.

Jamey Sharp and Josh Triplett (4):
  Fix prefix handling in ref iteration functions
  Add infrastructure for ref namespaces
  Support ref namespaces for remote repositories via upload-pack and
    receive-pack
  Add documentation for ref namespaces

 Documentation/Makefile                 |    2 +-
 Documentation/git-http-backend.txt     |    8 +++
 Documentation/git-receive-pack.txt     |    2 +-
 Documentation/git-upload-pack.txt      |    4 ++
 Documentation/git.txt                  |   13 +++++-
 Documentation/gitnamespaces.txt        |   75 ++++++++++++++++++++++++++++++++
 builtin/receive-pack.c                 |   34 ++++++++++++---
 cache.h                                |    3 +
 contrib/completion/git-completion.bash |    3 +-
 environment.c                          |   41 +++++++++++++++++
 git.c                                  |   18 +++++++-
 refs.c                                 |   27 +++++++++++-
 refs.h                                 |    3 +
 upload-pack.c                          |   15 +++---
 14 files changed, 227 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/gitnamespaces.txt

-- 
1.7.5.3

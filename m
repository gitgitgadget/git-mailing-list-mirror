From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv5 0/4] Support ref namespaces
Date: Fri,  3 Jun 2011 14:29:49 -0700
Message-ID: <1307136593-16306-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSbxP-0007Ol-HY
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 23:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363Ab1FCVa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 17:30:58 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64395 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315Ab1FCVa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 17:30:56 -0400
Received: by pzk9 with SMTP id 9so965763pzk.19
        for <git@vger.kernel.org>; Fri, 03 Jun 2011 14:30:55 -0700 (PDT)
Received: by 10.68.69.17 with SMTP id a17mr949295pbu.239.1307136655627;
        Fri, 03 Jun 2011 14:30:55 -0700 (PDT)
Received: from oh.minilop.net (host-246-52.pubnet.pdx.edu [131.252.246.52])
        by mx.google.com with ESMTPS id y2sm1736172pbg.8.2011.06.03.14.30.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Jun 2011 14:30:54 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QSbxE-0004IU-NQ; Fri, 03 Jun 2011 14:30:52 -0700
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175025>

From: Josh Triplett <josh@joshtriplett.org>

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

v5 of this series incorporates some additional feedback from Junio:
patch 1/4 now fixes the existing ref iteration functions to filter out
refs that don't start with "refs/", rather than preserving the existing
behavior of iterating over all refs and ignoring the prefix.  Patch 3/4
now refactors the logic for handling "capabilities^{}" to make it less
of a special case, and moves the call to strip_namespace into a wrapper
function used only when *not* passing "capabilities^{}".

We've also taken Jakub Narebski's suggestion of including a cover
letter. :-)

Jamey Sharp and Josh Triplett (4):
  Fix prefix handling in ref iteration functions
  Add infrastructure for ref namespaces
  Support ref namespaces for remote repositories via upload-pack and
    receive-pack
  Add documentation for ref namespaces

 Documentation/Makefile                 |    2 +-
 Documentation/git-http-backend.txt     |    8 ++++
 Documentation/git-receive-pack.txt     |    2 +-
 Documentation/git-upload-pack.txt      |    4 ++
 Documentation/git.txt                  |   13 +++++-
 Documentation/gitnamespaces.txt        |   71 ++++++++++++++++++++++++++++++++
 builtin/receive-pack.c                 |   34 ++++++++++++---
 cache.h                                |    3 +
 contrib/completion/git-completion.bash |    3 +-
 environment.c                          |   41 ++++++++++++++++++
 git.c                                  |   18 +++++++-
 refs.c                                 |   27 ++++++++++++-
 refs.h                                 |    3 +
 upload-pack.c                          |   15 ++++---
 14 files changed, 223 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/gitnamespaces.txt

-- 
1.7.5.3

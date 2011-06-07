From: Jamey Sharp <jamey@minilop.net>
Subject: [PATCHv8 0/4] Support ref namespaces
Date: Tue,  7 Jun 2011 16:04:46 -0700
Message-ID: <1307487890-3915-1-git-send-email-jamey@minilop.net>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:06:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5M0-0006pT-B5
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674Ab1FGXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:06:15 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:35987 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab1FGXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:05:48 -0400
Received: by pxi2 with SMTP id 2so4013694pxi.10
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 16:05:48 -0700 (PDT)
Received: by 10.68.67.211 with SMTP id p19mr517218pbt.286.1307487948346;
        Tue, 07 Jun 2011 16:05:48 -0700 (PDT)
Received: from oh.minilop.net (host-247-89.pubnet.pdx.edu [131.252.247.89])
        by mx.google.com with ESMTPS id k4sm457379pbl.11.2011.06.07.16.05.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 16:05:47 -0700 (PDT)
Received: from jamey by oh.minilop.net with local (Exim 4.76)
	(envelope-from <jamey@oh.minilop.net>)
	id 1QU5LG-00011u-1x; Tue, 07 Jun 2011 16:05:46 -0700
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175285>

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

The first patch improves the prefix handling in the ref iteration
functions, making it possible for us to implement
for_each_namespaced_ref later. The next two patches implement and then
use infrastructure for tracking the current namespace and iterating over
the refs in that namespace. The last patch adds general documentation
for namespaces, and specific references from the documentation on
receive-pack, upload-pack, http-backend, and git.

v8: Fix error message in parsing of the --namespace option; noticed by
Bert Wesarg.

v7 (unintentionally sent without a version number): Back out the change
to actually use "refs/" as a filter, which caused t5501 to fail.  Patch
1/4 now preserves the existing behavior, to avoid breaking assumptions
like this; that seems preferable to tracking down all the places that
would break due to this new ref filtering.  Adding that filtering and
fixing all the resulting breakage seems like an entirely separate
change.

Josh Triplett and Jamey Sharp (4):
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
 refs.c                                 |   33 ++++++++++++--
 refs.h                                 |    3 +
 upload-pack.c                          |   15 +++---
 14 files changed, 230 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/gitnamespaces.txt

-- 
1.7.5.3

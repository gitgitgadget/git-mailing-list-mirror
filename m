From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv10 0/4] ref namespaces
Date: Fri, 8 Jul 2011 16:12:31 -0700
Message-ID: <cover.1310166525.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 09 01:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfKED-0001WH-GW
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jul 2011 01:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879Ab1GHXMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 19:12:47 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39357 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab1GHXMq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 19:12:46 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 7D8D2172067;
	Sat,  9 Jul 2011 01:12:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id CbZSeKif6MDm; Sat,  9 Jul 2011 01:12:43 +0200 (CEST)
X-Originating-IP: 131.252.247.48
Received: from leaf (host-247-48.pubnet.pdx.edu [131.252.247.48])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7B4AF172070;
	Sat,  9 Jul 2011 01:12:33 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176808>

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

v10: In receive-pack, add a comment to show_ref_cb documenting the use
of .have refs for refs outside the current namespace.  Add the same
comment to the commit message of patch 3.

Josh Triplett (4):
  Fix prefix handling in ref iteration functions
  ref namespaces: infrastructure
  ref namespaces: Support remote repositories via upload-pack and
    receive-pack
  ref namespaces: documentation

 Documentation/Makefile                 |    2 +-
 Documentation/git-http-backend.txt     |    8 +++
 Documentation/git-receive-pack.txt     |    2 +-
 Documentation/git-upload-pack.txt      |    4 ++
 Documentation/git.txt                  |   13 +++++-
 Documentation/gitnamespaces.txt        |   75 ++++++++++++++++++++++++++++++++
 builtin/receive-pack.c                 |   40 ++++++++++++++---
 cache.h                                |    3 +
 contrib/completion/git-completion.bash |    3 +-
 environment.c                          |   41 +++++++++++++++++
 git.c                                  |   18 +++++++-
 refs.c                                 |   33 ++++++++++++--
 refs.h                                 |    3 +
 upload-pack.c                          |   15 +++---
 14 files changed, 236 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/gitnamespaces.txt

-- 
1.7.5.4

From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCHv3 0/4] Be more careful when prunning
Date: Sat,  8 Oct 2011 00:51:05 +0200
Message-ID: <1318027869-4037-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 00:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCJGM-00034q-DF
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 00:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759230Ab1JGWvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 18:51:11 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53013 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754755Ab1JGWvK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 18:51:10 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc5717.pool.mediaWays.net [77.188.87.23])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 6CCAB46103;
	Sat,  8 Oct 2011 00:50:44 +0200 (CEST)
Received: (nullmailer pid 4076 invoked by uid 1000);
	Fri, 07 Oct 2011 22:51:09 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183122>

Hello,

The first patch is not that big a deal, but it's better if we're
freeing the refspecs, we might as well free all of them.

The second patch introduces expected failures for the features that
this series fixes.

The third patch changes prune_resf and get_stale_heads so the caller
has to decide which refspecs are the appropriate ones to use. For
example, running

    git fetch --prune origin refs/heads/master:refs/heads/master

doesn't remove the other branches anymore. For a more interesting (and
believable) example, let's take

    git fetch --prune origin refs/heads/b/*:refs/heads/b/*

because you want to prune the refs inside the b/ namespace
only. Currently git will delete all the refs that aren't under that
namespace. With the second patch applied, git won't remove any refs
outside the b/ namespace.

What is probably the most usual case is covered by the forth patch,
which pretends that a "refs/tags/*:refs/tags/*" refspec was given on
the command-line. That fixes the

    git fetch --prune --tags origin

case. The non-tag refs are kept now.

Cheers,
   cmn

Carlos Mart=C3=ADn Nieto (4):
  fetch: free all the additional refspecs
  t5510: add tests for fetch --prune
  fetch: honor the user-provided refspecs when pruning refs
  fetch: treat --tags like refs/tags/*:refs/tags/* when pruning

 builtin/fetch.c  |   33 +++++++++++++++++++++++----
 builtin/remote.c |    3 +-
 remote.c         |   66 ++++++++++++++++++++++++++++++++++++++++++++++=
-------
 remote.h         |    2 +-
 t/t5510-fetch.sh |   50 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 138 insertions(+), 16 deletions(-)

--=20
1.7.5.2.354.g349bf

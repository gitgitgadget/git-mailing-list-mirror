From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCHv4 0/5] Be more careful when prunning
Date: Sat, 15 Oct 2011 07:04:21 +0200
Message-ID: <1318655066-29001-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 07:04:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REwQM-0001QL-9F
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606Ab1JOFE2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 01:04:28 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:48770 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502Ab1JOFE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:04:27 -0400
Received: from centaur.lab.cmartin.tk (brln-4dbc6671.pool.mediaWays.net [77.188.102.113])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A063746100;
	Sat, 15 Oct 2011 07:03:57 +0200 (CEST)
Received: (nullmailer pid 29042 invoked by uid 1000);
	Sat, 15 Oct 2011 05:04:26 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183634>

Hello,

This version covers Junio's concerns about code and functionality
duplication with the third patch. The order of arguments for
get_stale_heads is not changed anymore in the fourth patch.

The first patch is not that big a deal, but it's better if we're
freeing the refspecs, we might as well free all of them.

The second patch introduces expected failures for the features that
this series fixes.

The third patch is new and moves the logic out of remote_find_tracking
into a query_refspecs function. remote_find_tracking and
apply_refspecs are both changed to be wrappers around this
function. This way, the logic is in one function instead of three
different ones.

The fourth patch changes prune_refs and get_stale_heads so the caller
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

What is probably the most usual case is covered by the fifth patch,
which pretends that a "refs/tags/*:refs/tags/*" refspec was given on
the command-line. That fixes the

    git fetch --prune --tags origin

case. The non-tag refs are kept now.

Cheers,
   cmn

Carlos Mart=C3=ADn Nieto (5):
  fetch: free all the additional refspecs
  t5510: add tests for fetch --prune
  remote: separate out the remote_find_tracking logic into
    query_refspecs
  fetch: honor the user-provided refspecs when pruning refs
  fetch: treat --tags like refs/tags/*:refs/tags/* when pruning

 builtin/fetch.c  |   33 ++++++++++++++---
 builtin/remote.c |    3 +-
 remote.c         |  106 +++++++++++++++++++++++++++++-----------------=
-------
 remote.h         |    2 +-
 t/t5510-fetch.sh |   50 +++++++++++++++++++++++++
 5 files changed, 139 insertions(+), 55 deletions(-)

--=20
1.7.5.2.354.g349bf

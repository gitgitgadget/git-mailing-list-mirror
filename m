From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH 0/3] Be more careful when prunning
Date: Thu,  6 Oct 2011 22:19:42 +0200
Message-ID: <1317932385-28604-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 22:19:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBuQ3-000377-TJ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 22:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757016Ab1JFUTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 16:19:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:52064 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756820Ab1JFUTq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 16:19:46 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e4ec.pool.mediaWays.net [77.185.228.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 9050B46100;
	Thu,  6 Oct 2011 22:19:20 +0200 (CEST)
Received: (nullmailer pid 28641 invoked by uid 1000);
	Thu, 06 Oct 2011 20:19:45 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183025>

Hello,

The first patch is not that big a deal, but it's better if we're
freeing the refspecs, we might as well free all of them.

The second patch teaches get_stale_heads to use the user-provided
refspecs instead of the ones in the config. For example, running

    git fetch --prune origin refs/heads/master:refs/heads/master

doesn't remove the other branches anymore. For a more interesting (and
believable) example, let's take

    git fetch --prune origin refs/heads/b/*:refs/heads/b/*

because you want to prune the refs inside the b/ namespace
only. Currently git will delete all the refs that aren't under that
namespace. With the second patch applied, git won't remove any refs
outside the b/ namespace.

What is probably the most usual case is covered by the third patch,
which pretends that a "refs/tags/*:refs/tags/*" refspec was given on
the command-line.

Cheers,
   cmn

Carlos Mart=C3=ADn Nieto (3):
      fetch: free all the additional refspecs
      fetch: honor the user-provided refspecs when pruning refs
      fetch: treat --tags like refs/tags/*:refs/tags/* when pruning

 builtin/fetch.c  |   19 ++++++++++---
 builtin/remote.c |    2 +-
 remote.c         |   74 ++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 remote.h         |    3 +-
 4 files changed, 84 insertions(+), 14 deletions(-)

--=20
1.7.5.2.354.g349bf

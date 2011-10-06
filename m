From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCHv2 0/3] Be more careful when prunning
Date: Thu,  6 Oct 2011 23:21:44 +0200
Message-ID: <1317936107-1230-1-git-send-email-cmn@elego.de>
References: <20111006205103.GA1271@erythro.kitwarein.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	mathstuf@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 23:21:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBvOA-0000sC-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 23:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759318Ab1JFVVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 17:21:50 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:53054 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759174Ab1JFVVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 17:21:50 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e4ec.pool.mediaWays.net [77.185.228.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A6B4B46100;
	Thu,  6 Oct 2011 23:21:23 +0200 (CEST)
Received: (nullmailer pid 1271 invoked by uid 1000);
	Thu, 06 Oct 2011 21:21:47 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <20111006205103.GA1271@erythro.kitwarein.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183034>

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

Version 1 assumed that a refspec would have its dst filled
automatically. This is not the case and was fixed in the second patch.

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

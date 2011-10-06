From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [WIP PATCH 0/2] Be more careful when prunning
Date: Thu,  6 Oct 2011 18:56:25 +0200
Message-ID: <1317920187-17389-1-git-send-email-cmn@elego.de>
References: <20111004103624.GA11863@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 18:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBrFJ-0001u3-SW
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 18:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935709Ab1JFQ43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 12:56:29 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:54966 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758654Ab1JFQ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 12:56:28 -0400
Received: from centaur.lab.cmartin.tk (brln-4db9e4ec.pool.mediaWays.net [77.185.228.236])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 9F23446100
	for <git@vger.kernel.org>; Thu,  6 Oct 2011 18:56:02 +0200 (CEST)
Received: (nullmailer pid 17426 invoked by uid 1000);
	Thu, 06 Oct 2011 16:56:27 -0000
X-Mailer: git-send-email 1.7.5.2.354.g349bf
In-Reply-To: <20111004103624.GA11863@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182979>

[I turns out that my system was slightly misconfigured, so vger didn't
want to accept my mail, this a re-send to the list only]

Hello,

I consider this WIP because I haven't addressed the issue when --tags
is given. It's likely the most common issue (and what sparked this),
but the second patch sets it up so it becomes easier.

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

Now comes the interesting part: when --tags is given, there is no
refspec set up, fetch just sets up a global variable. What I'm
thinking (and going to implement after dinner, unless people cry out
against it) is this: just before calling prune_refs, add a refspec to
the user-provided list with the refspec refs/tags/*:refs/tags/*
similar to what fetch_one does if you gave it "tag v1.5.6". This would
cause us to ignore the configured refspec and keep the branches. The
lack of '+' is most certainly on purpose. Is there anything
fundamentally wrong with that idea?

Cheers,
   cmn

Carlos Mart=C3=ADn Nieto (2):
  fetch: free all the additional refspecs
  fetch: honor the user-provided refspecs when pruning refs

 builtin/fetch.c  |    8 +++---
 builtin/remote.c |    2 +-
 remote.c         |   74 ++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 remote.h         |    3 +-
 4 files changed, 74 insertions(+), 13 deletions(-)

--=20
1.7.5.2.354.g349bf

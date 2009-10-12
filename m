From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Filesystem has no item: Working copy path [...] does not exist
	in repository at /usr/bin/git-svn line 3856
Date: Mon, 12 Oct 2009 11:20:18 -0700
Message-ID: <20091012182018.GA14143@dcvr.yhbt.net>
References: <9accb4400910120848n6a1e4036l5e45ce3882deb5aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPaW-0004KI-RP
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbZJLSU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbZJLSU4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:20:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33956 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754767AbZJLSUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:20:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 7AA2C1F78E;
	Mon, 12 Oct 2009 18:20:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9accb4400910120848n6a1e4036l5e45ce3882deb5aa@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130043>

Daniele Segato <daniele.bilug@gmail.com> wrote:
> Hi,
> i'm trying to clone a public SVN repo (user = guest, password is
> empty/blank/not neeeded)
> 
> this was my steps:
> 
> $ git --version
> git version 1.5.6.5

Hi Daniele,

First I thought this was a problem fixed in
83c2fcff214fe89649fcd88e095d9961a36b53dd (git v1.6.2 or later),
but then I tried running it just to make sure.

> $ mkdir plugins
> $ cd plugins
> $ git svn init http://svn.liferay.com/repos/public/plugins -T trunk -b
> branches # doesn't have tags
> $ git svn fetch
> [...]
> # it takes hours.....
> [...]
> r25355 = ee13a19e656e6f96b1ebb562b10ee7fa688921df (svn/trunk)
> Filesystem has no item: Working copy path 'plugins/branches/trunk'
> does not exist in repository at /usr/bin/git-svn line 3856
> 
> 
> after that revision it give me that error... and then stops.
> if I issue again the git svn fetch it keep telling me the error and I
> can't complete the cloning.

This is a namespace conflict, the "trunk" ref is conflicting with a
(what seems to be a miscreated) branch named "trunk".  I anticipated
this problem originally but figured it was rare/uncommon enough that I
didn't want to burden users by prefixing all branches with something:

  ------------------------------------------------------------------------
  r25364 | michael.hashimoto | 2009-01-21 14:06:53 -0800 (Wed, 21 Jan 2009) | 1 line
  Changed paths:
     A /plugins/branches/trunk

  Created directory 'plugins/branches/trunk'.
  ------------------------------------------------------------------------
  r25365 | michael.hashimoto | 2009-01-21 14:07:15 -0800 (Wed, 21 Jan 2009) | 1 line
  Changed paths:
     D /plugins/branches/trunk

  Removed plugins/branches/trunk

Since it looks pretty obvious that "trunk" was miscreated here from the
revision history, you can skip these two revisions in your import by
recontinuing the clone with "git svn fetch -r25365:HEAD"

If you encounter this problem further in a non-workaroundable way,
you can prefix the local branches refs:

Replace:
  [svn-remote "svn"]
    branches = plugins/branches/*:refs/remotes/svn/*

With:

  [svn-remote "svn"]
    branches = plugins/branches/*:refs/remotes/svn/branches/*

I didn't do this by default since I figured very few people would create
a branch named "trunk" (and those who did, did it accidentally as it
seems to be the case here).

Hope that helps.

-- 
Eric Wong

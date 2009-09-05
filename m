From: Eric Wong <normalperson@yhbt.net>
Subject: Re: how to skip branches on git svn clone/fetch when there are
	errors
Date: Fri, 4 Sep 2009 23:16:57 -0700
Message-ID: <20090905061657.GC22272@dcvr.yhbt.net>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 08:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjoa9-0007gw-Op
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 08:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbZIEGQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 02:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbZIEGQz
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 02:16:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51148 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZIEGQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 02:16:55 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 1CBA01F5D0;
	Sat,  5 Sep 2009 06:16:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127779>

Daniele Segato <daniele.bilug@gmail.com> wrote:
> Hi,
> 
> I'm trying to clone a big repository.
> 
> I follow this steps:
> 
> git init
> git svn init svn://svn.mydomain.com/path/to/repo -T HEAD -b BRANCHES -t TAGS
> 
> vim .git/config # edited the svn-remote config as follow (add /root to
> branches and tag) to match the repo structure
> [svn-remote "svn"]
>        url = svn://svn.mydomain.com
>        fetch = path/to/repo/HEAD/root:refs/remotes/svn/trunk
>        branches = path/to/repo/BRANCHES/*/root:refs/remotes/svn/*
>        tags = path/to/repo/TAGS/*/root:refs/remotes/svn/tags/*
> 
> git svn fetch
> 
> When I reach revision ~7500 (I don't remember the exact number) I get an error:
> 
> $ git svn fetch
> Use of uninitialized value in concatenation (.) or string at
> /usr/lib/perl5/SVN/Core.pm line 584.
> Authorization failed:  at /usr/bin/git-svn line 1415
> 
> 
> After some debugging I found out the reason is something strange on
> the SVN server: there is a folder in the SVN that give an error when
> trying to access:
> 
> $ svn info svn://svn.mydomain.com/path/to/repo/BRANCHES/V2.1-A
> svn: Authorization failed
> 
> The same error with svn list.
> 
> I don't know what's wrong with that branch but I just want to skip it...

Ouch :(

> I tried modifying the .git/config svn-remote configuration adding this:
> 
> ignore-paths = path\\/to\\/repo\\/BRANCHES\\/V2\\.1-A

> and re-launching git svn fetch.

ignore-paths is only for paths that get converted into part of
the git tree

> I had no luck.
> 
> Ho do I skip a path on the svn repository?

It's unfortunate, but there's not yet an exclude/ignore directive
when globbing.  You'll have to change your $GIT_CONFIG to only
have a list of branches you want, something like this:

[svn-remote "svn"]
	url = svn://svn.mydomain.com
	fetch = path/to/repo/HEAD/root:refs/remotes/svn/trunk

	; have one "fetch" line for every branch except the one you want
	fetch = path/to/repo/BRANCHES/a/root:refs/remotes/svn/a
	fetch = path/to/repo/BRANCHES/b/root:refs/remotes/svn/b
	fetch = path/to/repo/BRANCHES/c/root:refs/remotes/svn/c

	; you can do the same for tags if you have the same problem
	tags = path/to/repo/TAGS/*/root:refs/remotes/svn/tags/*

But you shouldn't have to worry about having "fetch" entries for
stale/old branches/tags you've already imported.

-- 
Eric Wong

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Subprojects tasks
Date: Mon, 18 Dec 2006 00:23:45 +0100
Message-ID: <200612180023.45815.Josef.Weidendorfer@gmx.de>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <200612171401.10585.jnareb@gmail.com> <20061217134848.GH12411@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 23:24:31 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <20061217134848.GH12411@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34711>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw5Ml-0002JE-BA for gcvg-git@gmane.org; Mon, 18 Dec
 2006 00:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753213AbWLQXYV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 18:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbWLQXYU
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 18:24:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:40413 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1753213AbWLQXYU
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 18:24:20 -0500
Received: (qmail invoked by alias); 17 Dec 2006 23:24:18 -0000
Received: from p549680A1.dip0.t-ipconnect.de (EHLO noname) [84.150.128.161]
 by mail.gmx.net (mp019) with SMTP; 18 Dec 2006 00:24:18 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Sunday 17 December 2006 14:48, Martin Waitz wrote:
> The version tracked by the supermodule is completely independent from
> any branches you define in your submodule.
> It is of course possible to use different versions of your submodule in
> different branches of your supermodule.  But the supermodule does not
> know the name of these branches.

I see that you always use "refs/heads/master" in the submodule.
What happens if you do development in the submodule, create a new commit
there, and want to switch supermodule branch afterwards?
Wouldn't you lose your new work, as "refs/heads/master" has to be reset
to another commit when you switch the supermodule branch?

IMHO it would be nice to have refs in the submodule matching all the
branches/tags of the supermodule.
Meaning: "this is the commit which is used by branch/tag XYZ in the
supermodule". This can be valuable information, and a "gitk --all" in
the submodule would show you all the uses of your subproject in the
scope of the given superproject.
We could occupy the local refs namespace of the
submodule with the same refs as there are in the supermodule. But that
is no problem as the original branches of the subproject would be
in "refs/remotes/".

When switching branches in the supermodule, it simply would switch
to the same name in submodules. The submodule refs would not need
to match the submodule object in the tree of the supermodule; instead,
it would represent the development done in the submodule while on a
given branch in the supermodule. Thus, this would allow to do bug fix commits
for a submodule at all places where the supermodule has a branch, without
the need to switch supermodule branches.
However, "git commit" in branch X in the supermodule should give a warning
when submodules are not all at the same branch X, as the commit would use
branch X for committing.

> > Second, if you want to do some independent work on the module not related
> > to work on submodule you should really clone (clone -l -s) submodule
> > and work in separate checkout;
> 
> Yes.
> But I really like the possibility to switch one module to a branch which
> is not tracked by the parent, because it perhaps contains some debugging
> code which is needed to debug some other submodule.  You can't move it
> out because you need the common build infrastructure but you don't want
> to branch the entire toplevel project because you don't want your
> debugging changes to ever become visible at that level.

In general, I agree with not following submodule's HEAD for supermodule
commits. As you cannot store any submodule branch names, this really
would be confusing, as after switching to another supermodule branch
and back again, the submodule branch name would reset to a given name
("master" in your current implementation).

But why wouldn't you create a temporary branch "debug_submodule1" in the
supermodule for your use case? Branches are cheap with git, even in supermodules.
Supermodule branches also are pure local, you never have to publish
it somewhere, and can delete it afterwards.


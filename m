From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 11:08:35 +0200
Message-ID: <200510041108.36202.Josef.Weidendorfer@gmx.de>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <200510031455.30187.Josef.Weidendorfer@gmx.de> <7v1x31hlj4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 11:10:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMin9-0008Km-6r
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 11:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVJDJIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 05:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbVJDJIp
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 05:08:45 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:63925 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750790AbVJDJIp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 05:08:45 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 52BB62339;
	Tue,  4 Oct 2005 11:08:41 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8.2
In-Reply-To: <7v1x31hlj4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9671>

On Tuesday 04 October 2005 07:57, Junio C Hamano wrote:
> I do not understand this comment.

I talk about configuration per remote repository vs. configuration per
local head, and a consistent user interface regarding these.

Cogito is using configuration per head: If there is a remote fetch mapping,
this is stored in branches/<headname>. There is no new shortcut to
remember, because every file in branches corresponds to a local head.

On the other hand, a remotes/<remote> file is configuration per remote 
repository, and it introduces a new shortname <remote> for a repository, 
which by itself has nothing to do with a head name.

You look for a file in branches/ if there is nothing in remotes/.
I think this is quite confusing for newbies, and blurs the understanding
of remotes/ files, as a file name in branches/ (which is a existing head),
and the file name in remotes/ (which is an arbitrary choosen shortcut for a 
remote repository) are quite different things.

If GIT makes use of per-remote-repository only (as it is now), I
suggest getting rid of parsing branches/. Cogito can do its
per-head configuration in addition/layered on top of GITs 
per-remote-repository configuration, e.g. by refering to a repository
shortcut name in its files in branches/.


> I do not think you are just 
> talking about the syntax:
>
>         $ git-push <remote> <refspec1> <refspec2>...
>     vs
>         $ git-push' <refspec1> <refspec2>... <remote>

No. It is about specifying local head names only, without remote.
Please forget for the moment the current command lines, and
and suppose it is about

	$ git-fetch <localhead>

Given per-head configuration for <localhead>, the <remote> would
be already available (in branches/<localhead>); it does not
need to be specified at all. And a

	$ git-fetch <localhead1> <localhead2> ...

would potentially fetch from different remote repositories.
The nice thing here is that without a head, you can use the
current HEAD as default.

I do not advocate to change this in GIT at all; but what about
git-fetch-head/git-pull-head/git-push-head ?

> It appears that cg-push uses the same branches information for
> pushing into remote, which is what I missed when I did
> git-parse-remote --- we do not use this information to decide
> the default ref to push into, and not to break expectations of
> Cogito users we may need to fix this.

This even would be the wrong behavior: cg-clone creates local <origin>
head, branches off <master>, and checks out <master>. So when running
cg-push afterwards, you are in fact on the <master> branch, and there
is no remote specified for <master>. Cogito
currently is hardcoded to push to the remote head specified in <origin>
when on <master>.

I suggested Pasky to get rid of this hardcoding, support a "Push:"
line in branches/ files, and create a branches/master in cg-clone.
Similar, a configuration to specify the relation of origin and master
is missing.

Then, to be correct, you would have to use the remote head
in the "Push:" line of the current HEAD.

> Is this what you are 
> discussing here?

No. We can not do this, as Cogito currently only stores half of its
behavior in configuration files.

> > In the current state, it would be better to get rid of branches/
> > parsing in GIT at all: By keeping it in, we force Cogito to keep the
> > current format.
>
> Hmph.  The intent was to keep people's existing Cogito derived
> configuration working.

If you really want to still parse branches/ files, perhaps it would be
better to create a remotes/ file the first time after parsing it, and
give out a warning that a new repository shortcut was created, to be
used with git-pull etc.

I still think it is wrong to use one head name of a repository as the
default for the repository's name.

Josef

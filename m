From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 17:09:49 +0200
Message-ID: <4E96FF3D.90600@drmicha.warpmail.net>
References: <loom.20111013T094053-111@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 17:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REMv1-0000PU-AM
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 17:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121Ab1JMPJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 11:09:54 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38613 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932116Ab1JMPJx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 11:09:53 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AF22121B6F;
	Thu, 13 Oct 2011 11:09:52 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 13 Oct 2011 11:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=oUTTGjuvs/YU02S5hzYhTj
	y8acs=; b=NeRTd/ge5wsLkGiMOoZtuttuljDXgEU6PGWgvGgLp9SfGbgktvJeHl
	BkbSs/6FXwJfpYt3WhwDFE1kOEe6f1fdE8olKXJPCYnRLHfOnpAZY7/SfD0wE1QM
	6G4Oy7PcDXSsJJnG75mONII6mF7DtebTwm2KYN74wKVwIlQA5GewI=
X-Sasl-enc: EeKZo6EkakVuyS/MDOdmxw+vA969G6gJBlodfTSZmXbx 1318518592
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2B0FE4044FD;
	Thu, 13 Oct 2011 11:09:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <loom.20111013T094053-111@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183490>

arQon venit, vidit, dixit 13.10.2011 10:40:
> Which, as you'd expect, results in both the on-disk copies and other branches
> becoming corrupted.
> 
> Tested on git versions 1.7.6 and 1.7.7 (msysgit)
> 
> http://benno.id.au/blog/2011/10/01/git-recursive-merge-broken describes
> something that sounds similar, but that's supposedly fixed on 1.7.7,
> whereas this happens on that as well.
> 
> master is a tracking branch, "ttfcon" is the branch I was using to develop
> a change. Got to a good point on the branch, merged it in:
> 
> $ git co master
> $ git merge ttfcon
> Updating b9f0c75..6280b7a
> Fast-forward
>  .gitignore                |    2 ++
>  code/renderer/tr_font.cpp |   27 ++++++++-------------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
> 
> $ git st
> # On branch master
> # Your branch is ahead of 'origin/master' by 3 commits.
> 
> back to the branch to mess around with a couple of things to be sure this
> is what i want to push
> $ git co ttfcon
> do stuff
> 
> $ git st
> # On branch ttfcon
> # Changes not staged for commit:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #       modified:   code/freetype-2.3.11/builds/win32/visualc/freetype.vcproj
> #       modified:   code/renderer/tr_font.cpp
> 
> so far so good...
> 
> $ git ci -m "blah" code/freetype-2.3.11/builds/win32/visualc/freetype.vcproj
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> note that tr_font is locally modified and still *not committed* at this point.

and neither staged for commit, exactly.

> $ git co master
> M       code/renderer/tr_font.cpp
> Switched to branch 'master'
> Your branch is ahead of 'origin/master' by 3 commits.
> 
> boom. instead of rejecting the branch change, git switches branches anyway,
> and doesn't do anything about the uncommitted changes in the file itself -

Exactly. git leaves them as they are, without changing what you have in
your work tree.

(This is possible because the switch ttfcon to master involves no
changes which conflict with the chnage that you have in your work tree).

> meaning they're now effectively "in" master because they're still on disk,
> so now the master is poisoned.

Not at all. They are on "disk" (work tree). Full stop. Not staged, not
committed, not at all "in master".

> 
> "git st" does show the change:
> 
> # On branch master
> # Changes not staged for commit:
> #       modified:   code/renderer/tr_font.cpp
> 
> but it's a change I never MADE on this branch (ie master), only on the
> other branch.

You never made it on the other branch either. You made it in the work
tree. And "git status" clearly says so: modified, not staged.

> "git diff" is just as confused as I am:
> 
> $ git diff ttfcon
> --- a/code/renderer/tr_font.cpp
> +++ b/code/renderer/tr_font.cpp
> +		// git branch bug

"git diff" shows you the change you have in your work tree, i.e. the
difference between index (which coincides with master since nothing is
staged) and work tree. The fact that there is a difference is equivalent
to saying "there are unstaged changes".

> So it's picking up the difference between the two branches, but as far as

No. The difference between the branches is the change to freetype.vcproj
because you committed that to ttfcon, not master.

> the *actual file* goes, master now has a line in it that shouldn't be there.

It's in the work tree, not master....

> I'm just trying out git as a possible replacement for SVN, so maybe I'm
> mistaken about what "should" happen, but AIUI git switching branches with
> uncommitted changes is a bug (and given that it poisoned a branch that I
> wasn't on, it certainly looks like one). A couple of days ago it DID complain
> when I tried to switch with uncommitted files still present, so it was working
> properly then. I have no idea what's made it happy to ignore them now:
> nothing's changed that I know of.

When switching branches, git tries to preserves the changes that you
have in your work tree. If it is possible (because there is no overlap,
as written above), it hapilly does just that. If not it barks.

I think you have to wrap your head around the Git model after unwinding
it from the svn model, which is normal ;)

Cheers,
Michael

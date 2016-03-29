From: Jeff King <peff@peff.net>
Subject: Re: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 16:26:27 -0400
Message-ID: <20160329202626.GC9527@sigill.intra.peff.net>
References: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
 <CAPZ477PD7SkRg7T_Y_n27Hjw5TeW6Sh0-vtoP6-4xUDraC7OiA@mail.gmail.com>
 <20160329123306.GD1578@serenity.lan>
 <xmqqshz9z5hu.fsf@gitster.mtv.corp.google.com>
 <20160329194156.GA9527@sigill.intra.peff.net>
 <xmqq60w5xdl2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, Elliott Cable <me@ell.io>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:26:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0Du-0004KS-R9
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbcC2U0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:26:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:40163 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757979AbcC2U0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:26:30 -0400
Received: (qmail 7618 invoked by uid 102); 29 Mar 2016 20:26:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 16:26:29 -0400
Received: (qmail 26211 invoked by uid 107); 29 Mar 2016 20:26:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Mar 2016 16:26:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2016 16:26:27 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60w5xdl2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290188>

On Tue, Mar 29, 2016 at 12:56:41PM -0700, Junio C Hamano wrote:

> >> So it is a misconfiguration if you only set GIT_WORK_TREE without
> >> setting GIT_DIR.
> >
> > Hmm. I have frequently done this when my cwd is a git repository (e.g.,
> > a bare one), and it works as you'd expect (find the git-dir in the
> > current path, then the working tree via $GIT_WORK_TREE).
> 
> Hmm, does what is done by "git add HEAD" in such a situation match
> what you'd expect?
> 
>         git init work
>         cd work; date >HEAD; git commit -m initial
>         git push ../bare master:master
> 	date >>HEAD
>         export GIT_WORK_TREE=$(pwd)
> 	cd ..
> 	git --bare init bare
> 	cd bare
> 	git add HEAD

I had to tweak your commands a little, but I assume the part you are
interested in is the end, when git-add finds HEAD in $GIT_WORK_TREE and
not the bare repository.

And yes, that is exactly what I'd expect, and why it is useful (if you
wanted to add arbitrary cruft from the bare repo, you'd set
$GIT_WORK_TREE to point there).

> I'd have to say that this invites unnecessary confusion, even though
> I agree that "go to the GIT_WORK_TREE and take pathspecs relative to
> that directory" is the only sensible thing for us to be doing.
> 
> But that is not an issue about "set only work-tree" (it is about
> "run from outside the work-tree").

Yeah, there are two things going on:

  1. Without $GIT_DIR but with $GIT_WORK_TREE, we find $GIT_DIR via the
     usual discovery path.

  2. When outside $GIT_WORK_TREE, any work-tree operations work as if
     they were started from $GIT_WORK_TREE.

And relying on (1) almost always relies on (2), unless your work-tree
happens to be inside the discovery path for your $GIT_DIR. So you could
do:

  git init repo
  mkdir repo/subdir
  echo content >file
  GIT_WORK_TREE=$(pwd) git add .

which adds "file" at the top-level. And we used only rule (1), not rule
(2). I don't know whether people actually do that or not (I guess it
could be useful for tricky subtree things).

-Peff

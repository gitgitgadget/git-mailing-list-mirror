From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Fri, 4 Sep 2009 10:32:42 +0200
Message-ID: <20090904083242.GT6144@neumann>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 10:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjUEA-0006wK-JS
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 10:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbZIDIcv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 04:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbZIDIcu
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 04:32:50 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:57379 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbZIDIct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 04:32:49 -0400
Received: from [127.0.1.1] (p5B131428.dip0.t-ipconnect.de [91.19.20.40])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MKt72-1MjUDr3r12-000D5W; Fri, 04 Sep 2009 10:32:45 +0200
Content-Disposition: inline
In-Reply-To: <20090902081917.GA5447@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX19jW9rjH/5WDJVQFXk2Urq/XvehXx4rtcGFJWU
 8jBgwdcKlAxQHWy8K4oHXkggBYnOdWhAaxfbsi7pSoJLB7N3f6
 VHkwC28kUCSIWZbmCrQlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127695>


[Oops, I 've just noticed that my reply to Jeff didn't made it to the
git list, because I hit 'reply' instead of 'reply to all'...]



Hi Jeff,


thanks for your quick reply.

On Wed, Sep 02, 2009 at 04:19:17AM -0400, Jeff King wrote:
> On Wed, Sep 02, 2009 at 10:03:05AM +0200, SZEDER G=E1bor wrote:
>
> > As the subject says, 'git add -u' does not work from an untracked
> > subdir, because it doesn't add modified files to the index.  The
> > following script reproduces the issue:
> >
> > mkdir repo
> > cd repo
> > git init
> > echo 1 >foo
> > git add foo
> > git commit -m first
> > echo 2 >foo
> > mkdir untracked_subdir
> > cd untracked_subdir
> > git add -u
> > git diff
> >
> > It worked in the initial 'git add -u' implementation (dfdac5d,
> > git-add
> > -u: match the index with working tree, 2007-04-20), but 2ed2c222
> > (git-add -u paths... now works from subdirectory, 2007-08-16)
> > broke it
> > later, and is broken ever since.
>
> It is not just untracked subdirs. Try:
>
>   mkdir repo && cd repo && git init
>   echo 1 >foo
>   mkdir subdir
>   echo 1 >subdir/bar
>   git add . && git commit -m first
>   echo 2 >foo
>   echo 2 >subdir/bar
>   cd subdir
>   git add -u
>   git diff ;# still shows foo/1 in index
>   git diff --cached ;# shows subdir/bar was updated
>
> While I have sometimes found the behavior a bit annoying[1], I
> always
> assumed that was the intended behavior.
>
> And indeed, in modern builtin-add.c, we find this:
>
>         if ((addremove || take_worktree_changes) && !argc) {
>                 static const char *here[2] =3D { ".", NULL };
>                 argc =3D 1;
>                 argv =3D here;
>         }
>
> which seems pretty explicit.

Since then I looked at the man page (I should have done that right
away ;), and it says under the description of -u that "If no paths are
specified, all tracked files in the current directory and its
subdirectories are updated."  So this is indeed the intended
behaviour, but I was just not aware of it.  Oh well, sorry for the
noise.

> [1] I would prefer "git add -u ." to add only the current directory,
> and
> "git add -u" to touch everything. But then, I am one of the people
> who
> turn off status.relativepaths, so I think I may be in the minority
> in
> always wanting to think of the project as a whole.

I don't really know which would I prefer.

I was updating some Javadoc documentation in Eclipse, and checking the
generated docs in terminal, deep down in an untracked subdir, and
performed some 'add -u ; commit --amend' from there (and was rather
surprised after the fifth amend to see all the changes still in the
worktree).  Doing perform the desired add -u from there I should have
run 'git add -u ../../../../../..', what doesn't seem very convenient.
But since this was the first time I've done that since 2007-08-16, I
guess it's not a very common use case.


G=E1bor

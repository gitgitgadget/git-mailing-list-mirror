From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Diftool problems
Date: Wed, 29 Apr 2009 22:48:05 +0200
Message-ID: <200904292248.06107.markus.heidelberg@web.de>
References: <7c0fdf4f0904290915i56f58981i70e7093e9bf87d8b@mail.gmail.com> <200904292142.59471.markus.heidelberg@web.de> <7c0fdf4f0904291255i4076df8cubb26fdb2d51826d4@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcin Zalewski <marcin.zalewski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 22:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzGiE-0004t0-Sh
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 22:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757735AbZD2Ush (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 16:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbZD2Ush
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 16:48:37 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39589 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbZD2Usg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 16:48:36 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 4DA15100EDA14;
	Wed, 29 Apr 2009 22:48:08 +0200 (CEST)
Received: from [89.59.108.55] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LzGhK-0003MG-00; Wed, 29 Apr 2009 22:48:06 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7c0fdf4f0904291255i4076df8cubb26fdb2d51826d4@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/c+zhYnzZPqFwkIV8FHedZKumH7CdLfsAC6m0u
	hpJ6Rh2XSBLWFf41HJioNMZwSKX4A64Efdvahr3UswYmImqYOO
	ixk1cgXGg+7/GBx9t5jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117945>

Marcin Zalewski, 29.04.2009:
> > The real fix would be to adjust the ediff snippet for difftool support.
> 
> The emas snippet was meant to work with mergetool and it does (I
> think). Changing the emacs code could indeed help with difftool but it
> would break mergetool.

I'm sure the emacs snippet can be adjusted to work with both. If it is
called with 2 files, then it's for difftool, else for mergetool.

> > As you said yourself, git-difftool is not meant for merging files, so
> > there is no reason to open more than 2 files at all.
> 
> I agree, but the current implementation of difftool uses mergetool
> library.

The file is called git-mergetool--lib, but more exactly it should be
called git-mergetool-difftool--lib, but who wants this? Difftool was
originally based on mergetool, but the recent refactoring introduced the
lib, which is shared by both, without belonging to one of them more than
to the other.

> That may be the reason why difftool is trying to come up with
> the third file.

Difftool isn't forcing a third file on you.

> Here is the snippet of code from mergetool library
> that executes emerge in case of non-merge-mode:
> 
> "$merge_tool_path" -f emerge-files-command \
> 				"$LOCAL" "$REMOTE" "$(basename "$MERGED")"

As said, this command shouldn't open the 3rd MERGED file, this should be
fixed. This part of the lib is not responsible for difftool.

> > The built-in difftools 'emerge' and 'ecmerge' still seem to open LOCAL,
> > REMOTE and MERGED. This should be fixed, so that they don't open MERGED
> > any more, but I don't have emacs installed, so I shouldn't try it
> > myself.
> 
> Again, I agree. This could be one of the possible solutions,

No, that doesn't solve your problem with ediff.
Or do you set merge.tool=emerge and ediff is called due to the snippet
in your ~/.emacs? If yes, then I got it now... Sure, I just read the
post from Ted Tso again, use-ediff-instead.el, aha.

I guess it would be cleaner to do this in ~/.gitconfig:

[diff]
	tool = ediff
[difftool "ediff"]
	cmd = emacs --options "$LOCAL" "$REMOTE"

Which is annoying, of course.

But now that I got it (see above) I think you should leave
merge.tool=emerge, since the snippet somehow seems to rely on it.

> but it
> would require that mergetool library is changed

What's wrong with that?
If this solves the 'ediff' problem and also makes 'emerge' to work right
as difftool, then everyone would benefit from.

> or rewriting pieces of
> mergetool in difftool. Correct me if I am wrong.
> 
> > Oh, and LOCAL shouldn't be copied to a temporary file in the first
> > place, because people don't use git-difftool in read-only mode only.
> 
> I think that merge result could be a temporary file, like in
> mergetool. In a situation where I use git to track an SVN repository,
> difftool can be actually used to merge my uncommitted changes with a
> commit from someone else after doing svn rebase.

Above you want your ediff mergetool snippet to work with difftool. And
here you want to use difftool as a mergetool. I'm confused :)

BTW, difftool doesn't work with files in unmerged state.

Markus

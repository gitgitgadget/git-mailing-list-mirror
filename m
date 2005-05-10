From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Mon, 9 May 2005 20:07:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505091913250.30848-100000@iabervon.org>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Tue May 10 02:01:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIB6-00014R-LN
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVEJAIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVEJAIG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:08:06 -0400
Received: from iabervon.org ([66.92.72.58]:37639 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261438AbVEJAH7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:07:59 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DVIHg-0005z6-00; Mon, 9 May 2005 20:07:36 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Juliusz Chroboczek wrote:

> Hi,
> 
> Here are a few notes about Git that should probably be taken into
> account by people working on Git itself or on Git wrappers.  The notes
> apply to Linus' Git-0.6, which is the code I'm using in Darcs-git;
> some of them might no longer be applicable to Darcs.
> 
> 
> 1. Darcs-git uses the fact that Git updates are atomic when reading
> from a Git repository.  Darcs-git almost writes to Git repositories
> atomically, with one exception: it performs a non-atomic
> read/update/write cycle on .git/HEAD.
> 
> For that reason, I'm taking a high-level lock on .git repositories
> whenever I write them.  The lockfile is ``.git/lock''.  I haven't
> thought about whether Darcs can be easily coerced into accessing Git
> repos atomically; have people writing Git wrappers found the need for
> a global lock?

I think most things are using the O_CREAT | O_EXCL write to a file and
then rename or link/unlink to the desired location. I have some code to do
this with refs/*/* as well, and I think people have generally settled on
symlinking HEAD to something in refs/heads/. So it shouldn't be necessary
to lock the whole repository, unless you're doing some operation like
swapping two heads.

> 2. The files git.h and git.c in Darcs-git are a simple ``libgit'' that
> contains just enough functionality for Darcs-git; they use the
> functionality of sha1_file.c and read_cache.c from Git-0.6.
> 
> I've found a few problems with the interfaces in these files:
> 
>  - the global variables sha1_file_directory, active_cache, active_nr
>    and active_alloc are not marked ``extern'' in cache.h.  This breaks
>    linkers that don't grok common symbols, such as the one in GHCi
>    (silly GHCi).

Should be trivial to fix.

>  - the function write_sha1_file takes the metadata and the data in a
>    contiguous buffer, which is a problem when the data has been
>    allocated by a higher layer.  I'm currently working around the
>    problem by memcpy-ing everything into a temp buffer, but that's
>    obviously not a good thing.  I don't care whether write_sha1_file
>    is changed to use a writev-like interface, or to take the metadata
>    explicitly (as in char *type, unsigned long length).

I've got some patches to make new functions of the write_sha1_file sort
easier to write cleanly (for making git-*-pull clean); it wouldn't be too
hard to have an open/write/close set.

>  - there is no (usable) function to write a tree; there's the code in
>    write_tree.c, but it's not generally useful.  See the function
>    ``git_write_tree_done'' in git.c for the type of interface I'm
>    thinking of.

I'm working on making this cleaner. Are you wanting to write a tree from
something other than a cache?

I can post my patches, but Linus is on vacation, so they couldn't go into
the mainline until Friday or so anyway.

	-Daniel
*This .sig left intentionally blank*


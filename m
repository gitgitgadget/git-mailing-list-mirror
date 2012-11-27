From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Mon, 26 Nov 2012 22:20:20 -0800
Message-ID: <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 07:20:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdEX7-0006SN-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 07:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861Ab2K0GUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 01:20:22 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54634 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab2K0GUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 01:20:21 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so6508472vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 22:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f5NcUjz0h1SN3Jf8L4MV2L62irZRTI3O+m3CxdLgM44=;
        b=vbGYItykmXNmVE4Zx5tPSwvn30sG7XZQTG13UrWQxaDQxQfYsuO4yGVhybwyR5786H
         hxFXJqe15uNzQIgAFYVxSjXkU2zLL2unHOJszINLl0dcIEDaLLippwFRf0dp9EiYhDck
         iCqJPCKAqItWc87kICHeYP+1d4whw01G1LQmXHBcdm2bXiVLudYck0VxA8nanEN86JbM
         zQOjN3+2krxDrv7j/M1WyCazMFnJ6+ECv8tWRNayKI9wxeqAf/da2+bCQfDXw6sF8fxN
         Nhhmc9Y/KdCIX7kJdidHaA6kPN3yihY72hxroZn7+9iQa33LBxXeDokmgSuXDmlVANUO
         0QpA==
Received: by 10.220.226.67 with SMTP id iv3mr22546753vcb.57.1353997220766;
 Mon, 26 Nov 2012 22:20:20 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Mon, 26 Nov 2012 22:20:20 -0800 (PST)
In-Reply-To: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210534>

On Mon, Nov 26, 2012 at 12:23 PM, Matt McClure
<matthewlmcclure@gmail.com> wrote:
> I'm finding the behavior of `git difftool -d` surprising. It seems that it
> only uses symlinks to the working copy for files that are modified in the
> working copy since the most recent commit. I would have expected it to use
> symlinks for all files whose version under comparison is the working copy
> version, regardless of whether the working copy differs from the HEAD.
>
> I'm using
>
>     $ git --version
>     git version 1.8.0
>
> on a Mac from Homebrew.

cc:ing Tim since he probably remembers this feature.

This is a side-effect of how it's currently implemented,
and the general-purpose nature of the "diff" command.

diff can also be used for diffing arbitrary commits.
The simplest way to implement that is to create two temporary
directories containing "a/" and "b/" and then launch the tool
against them.  That's what difftool does; it creates a temporary
index and uses `git checkout-index` to populate these two dirs.

The worktree handling is a bolt-on that symlinks
(or copies (on windows or with --no-symlinks)) modified
worktree files into one of these temporary directories.

When symlinks are used (the default) we avoid needing to
copy these files back into the worktree; we can blindly
remove the temporary directories without checking whether
the tool edited any files.

When copies are used we check their content for changes
before deciding to copy them back into the worktree.

Files that are not modified are not considered part of the
set of files to check when copying back, or when symlinking,
mostly because that's just how it's implemented right now.

It seems that there is an edge case here that we are not
accounting for: unmodified worktree paths, when checked out
into the temporary directory, can be edited by the tool when
comparing against older commits.  These edits will be lost.

If we had a way to know that either a/ or b/ can be replaced
with the worktree itself then we could make it even simpler.

Right now we don't because difftool barely parses the
command-line at all; most of it is parsed by git-diff.
Originally, difftool was a read-only tool so it was able to
avoid needing to know too much about what diff is really doing.

We would need to a way to re-use git's diff command-line parsing
logic to answer: "is the worktree involved in this diff invocation?"

When we can do that then we avoid needing to have a temporary
directory altogether for any dir-diffs that involve the worktree.

Does anyone know of a good way to answer that question?

The input is the command-line provided to diff/difftool.
The output is one of ('a', 'b', 'x'), where 'a' means the left
side of the diff is the worktree, 'b' means the right side,
and 'x' means neither (e.g. the command-line contains two refs).

Assuming we can do this, it would also make dir-diff faster
since we can avoid needing to checkout the entire tree for
that side of the diff.
-- 
David

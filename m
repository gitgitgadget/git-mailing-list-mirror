From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] setup_git_directory: Setup cwd properly if worktree is found
Date: Tue, 27 Nov 2007 21:12:27 +0700
Message-ID: <fcaeb9bf0711270612p52ce20eaue39eac1d529c3fd3@mail.gmail.com>
References: <20071112112408.GA5420@laptop>
	 <Pine.LNX.4.64.0711121139010.4362@racer.site>
	 <fcaeb9bf0711120413w180c07e1qbf1b186753593d7@mail.gmail.com>
	 <Pine.LNX.4.64.0711121224430.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1BG-0004py-V1
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbXK0OMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbXK0OMg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:12:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:1720 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbXK0OMf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:12:35 -0500
Received: by nf-out-0910.google.com with SMTP id g13so961911nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=58sWmEjnCiLqdavwTK1UoRDIg80FkxzTb48ZnEAsHsI=;
        b=k/gHfq3VkaWal5ir1O4gWsGjcdw1x7s6U7oJPr2fnhqNIut1Vd4R/NdMkLjy6XIis4SfMVWmIENZdTvrX+JQEDdeBuT9eWZfIpTBnjtROwNSLkcU0N1wqctXYU45N/duelsvBPZ1advUkr8bjbZhWDp8RUAgU+JDCIKTG+VLmG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HnRBU9l8cQgBKNJT5JEwdQsKQ1fBWo0RnegjRHqJP6LD6xvMEPmF1rQmVFrDYe2szx/lpVZVzzwiUKrrKfiqHbjAmG2FIu8Btl5mHX2SzCX6QeqJGAebyGOZEpLBI2EyhSAsW/kVn9/LdhfMgzjN5VsxZQrCoHjJGPjUOsL5ry4=
Received: by 10.86.76.16 with SMTP id y16mr3861881fga.1196172747697;
        Tue, 27 Nov 2007 06:12:27 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Tue, 27 Nov 2007 06:12:27 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711121224430.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66213>

On Nov 12, 2007 7:31 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 12 Nov 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On Nov 12, 2007 6:57 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > But what about setup_git_directory_gently()?  If the working tree is
> > > overridden by the config, this function is still bogus, right?
> >
> > Hmm.. thinking a little bit more. I guess you're right because
> > GIT_WORK_TREE takes precedence over core.worktree. Maybe some more bits
> > for check_repository_format_version(). Tough decision because, from the
> > value of inside_work_tree, we don't know if we can safely skip
> > overriding inside_work_tree.
>
> I was thinking about adding check_repository_format_version() and a check
> for inside_work_tree < 0 with obvious handling in two places, probably as
> a function:  first, when we have a gitdirenv but no work_tree_env, and
> second, at the end of _gently() when we found a git dir but only if
> work_tree_env was not set.
>
> > > As far as I see, setup_git_directory_gently() only works correctly
> > > when core.worktree is _not_ set, unless GIT_WORK_TREE is set (which is
> > > supposed to override the config setting).  Note: I treat GIT_WORK_TREE
> > > the same as --work-tree, since at that time they are identical.
> > >
> > > Maybe the config stuff has to move into _gently()?
> >
> > Well, it could be a bit more complicated because you need to know
> > GIT_DIR first before reading config. I'd rather not move as _gently()
> > is complicated already.
>
> AFAICT it is not a question of complexity, but of correctness.  Wouldn't
> you agree that the prefix _gently() returns is wrong if we don't fix it?
>
> Besides, it might be needed anyway if we are serious about the version
> check.  This check, however, would have to be done _whenever_ we found a
> git directory, not only when work_tree_env is NULL.

Question time. setup_git_directory_gently() can be happy even if there
is no repository. Now if we move version check into setup_..._gently
and it finds git program is too old to handle the repository, what
would we do? die() like in check_repository_format() or tell the
caller there is no repository?
-- 
Duy

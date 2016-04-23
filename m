From: Jeff King <peff@peff.net>
Subject: Re: possible bug of git stash deleting uncommitted files in corner
 case
Date: Fri, 22 Apr 2016 23:53:12 -0400
Message-ID: <20160423035312.GB15994@sigill.intra.peff.net>
References: <CAND5yRvCK9YuVOJ91CHbnbWAVYcPrpihGkoKs28f7PJgzRwW6Q@mail.gmail.com>
 <CAND5yRvU1-AgvQW106fHbNN-GRQ615HjTDjR6AY9gkpoquBgDw@mail.gmail.com>
 <1304154573.4013923.1461328186541.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <xmqqmvolpmsw.fsf@gitster.mtv.corp.google.com>
 <754076461.4029096.1461351865455.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniele Segato <daniele.segato@gmail.com>, git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Apr 23 05:53:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atodE-0006Cg-8w
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 05:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbcDWDxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 23:53:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:54715 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751219AbcDWDxP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 23:53:15 -0400
Received: (qmail 17314 invoked by uid 102); 23 Apr 2016 03:53:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 23:53:15 -0400
Received: (qmail 14505 invoked by uid 107); 23 Apr 2016 03:53:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 23:53:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 23:53:12 -0400
Content-Disposition: inline
In-Reply-To: <754076461.4029096.1461351865455.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292298>

On Fri, Apr 22, 2016 at 09:04:25PM +0200, Remi Galan Alfonso wrote:

> For this bug it doesn't seem to be specifically linked to git stash,
> since 'git status' doesn't display correct informations in the first
> place (it doesn't show foo/bar as an untracked file).
> 
> I tried something quickly, based on Daniele's case:
>     git init
>     echo 'X' >foo
>     git add foo
>     git commit -m "Added foo"
>     rm foo
>     mkdir foo
>     echo 'B' >foo/bar
> 
>     git status # foo/bar not shown in Untracked files
> 
>     git add foo/bar
> 
> git status then shows as expected:
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> # 
> # 	deleted:    foo
> # 	new file:   foo/bar

Before you "git add foo/bar", try "git status -uall", which asks git to
descend into directories when looking for untracked files. It _does_
show foo/bar as untracked.

So I think what is happening is that in the case without "-uall", we see
"foo" as an untracked file, but then check that with the index to say
"ah, it is not untracked, there is an entry in the index".  But of
course the earlier mention in "not staged for commit" will not say
anything about the new directory "foo", because we only diff actual
files there.

Likewise, if you ask "ls-files -o", it mentions "foo/bar".

So I think the bug is in the way dir.c handles
DIR_SHOW_OTHER_DIRECTORIES, or possibly in the way that
wt_status_collect_untracked handles its results.

It may be that the latter needs to special-case its
cache_name_is_other() check, and make sure we mention an "other" file we
found that is a directory, even if it has an index entry.

> However git stash fails this time:
> # error: foo: is a directory - add individual files instead
> # fatal: Unable to process path foo
> # Cannot save the current worktree state

I suspect the actual stash bug is separate from the bug above. It just
looks like update-index is not smart enough to realize that a file being
replaced with a directory is effectively an index deletion of that
entry. That's just a guess, though.

-Peff

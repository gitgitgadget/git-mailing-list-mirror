From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT - breaking backward compatibility
Date: Mon, 19 Sep 2005 23:19:36 -0700
Message-ID: <7vu0gg8dmv.fsf@assigned-by-dhcp.cox.net>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
	<432F8C33.5080603@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 08:21:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHbUA-0004ng-3M
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 08:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932674AbVITGUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 02:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbVITGUG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 02:20:06 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1960 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932674AbVITGUE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 02:20:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920061938.EPZM23945.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Sep 2005 02:19:38 -0400
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <432F8C33.5080603@didntduck.org> (Brian Gerst's message of "Tue,
	20 Sep 2005 00:12:35 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8980>

Brian Gerst <bgerst@didntduck.org> writes:

> Junio C Hamano wrote:

[Long quotation snipped]

Brian, you did not have to quote the whole thing if you wanted
to respond to only one bullet point in my footnotes.

> Essentially what I want to do is:
>
> git-ls-files --others | xargs git-update-index --add --
> git-ls-files --deleted | xargs git-update-index --remove --
> git-ls-files --modified | xargs git-update-index --
>
> This will completely resync the index and cache to the working tree 
> state after applying a patch.  git-update-index --refresh only updates 
> the stat info in the index.  It does _not_ write a new cache object if 
> the file contents have actually changed.

First of all, what I meant to say with 'update-index --refresh'
was not the refreshing part itself, but the fact that says
'needs update' -- meaning it knows those paths have been truly
modified.

Forgetting 'use git-apply' comment from Linus for now,... if you
are going to do the above in separate steps, then the last one
is already available (but not as an option to 'git-ls-files'):

    git-diff-files -r --name-only -z | xargs -0 git-update-index --

> If your objection is to calling the files modifed, then call it dirty or 
> something else.

I was not talking about the name, but the semantics.

* The user may be interested in cache-dirty files, but I suspect
  that is a very limited audience.  I do not offhand think of a
  good reason to want to know which files are cache-dirty
  without wanting to know if they are really modified, except
  when debugging git itself.  If you really want to know that,
  you can always say `git-diff-files`, or if you want to be
  pickier, `git-diff-files --diff-filter=M --name-only`.

* Showing a list of *truly* 'modified' files, disregarding the
  false hits from cache-dirty but otherwise unmodified files,
  would be another useful thing.  But that is something
  `git-update-cache --refresh` already gives you.

* As a front-end, `git status` shows you list of modifications
  between HEAD and cache, and between cache and working tree.
  The latter is done with `git-diff-files` after running
  `git-update-cache --refresh`.  This probably gives the most
  useful information to the end user.

Having said all that, `git-ls-files`, especially with `-t` flag,
is a handy way to know the status of all files in the working
tree with a single command.  What it does not currently give us
that would be nicer to have as an addition is not cache-dirty
status, but *true* 'modified' flag.  Although this is something
available from `git-update-cache --refresh` as I said earlier,
it would still be nice to be able to get it out of a single
command invocation, together with files in other status.

So that is what I have on the proposed updates branch tonight.
Does it more-or-less do what you wanted?

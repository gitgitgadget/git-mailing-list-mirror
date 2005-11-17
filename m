From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Stgit - gitmergeonefile.py: handle removal vs. changes
Date: Thu, 17 Nov 2005 22:10:11 +0000
Message-ID: <b0943d9e0511171410y357fb0bfv@mail.gmail.com>
References: <20051113194225.20447.57910.stgit@zion.home.lan>
	 <b0943d9e0511150154y2d2af24ck@mail.gmail.com>
	 <200511161544.13825.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 23:12:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcrxU-0004D3-1N
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 23:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVKQWKQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 17:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVKQWKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 17:10:16 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:43448 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932287AbVKQWKO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 17:10:14 -0500
Received: by xproxy.gmail.com with SMTP id i30so38259wxd
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 14:10:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZdhQflJTpprDGkpKlUFk5UoBQOINlxDagbrkQOL7JgnziMAMIVOe1esCRzXy0p2LDNBWVIuxXXUz0jGsAgcgbhvMwvQykVLXfod1h+4L9BO22vjDxApw1l/+O7ChEYdZA+Wt+QL1DUh8opADNRVrHjT3NCaZbHJj9YPA82PJLzk=
Received: by 10.70.54.15 with SMTP id c15mr5553059wxa;
        Thu, 17 Nov 2005 14:10:11 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Thu, 17 Nov 2005 14:10:11 -0800 (PST)
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200511161544.13825.blaisorblade@yahoo.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12162>

On 16/11/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Tuesday 15 November 2005 10:54, Catalin Marinas wrote:
> Actually, with .git/commits we are reimplementing handling of "unmerged"
> entries... it could be better to use the "unmerged entry" stgit idea. So "stg
> resolved" should modify the entries by itself.

But would a git-diff-tree still show the changes between the current
files and the index if there are unmerged entries? I haven't tried it.

> > My initial idea was to make
> > gitmergeonefile not to leave any unmerged entries in the index. As you
> > could see, there are cases where it failed.
>
> Yep... it seems you took examples from git-merge-one-file, but that's lacking
> (but it's low-level so it's appropriate for it - it must leave unmerged
> entries when there are conflicts).

When I started writing StGIT, my main thoughts were driven towards the
patch merging/commuting via the diff3 algorithm. I found it simpler to
copy the algorithm from git-merge-one-file since that wasn't my main
interest in StGIT. I also looked at how Cogito did it.

> > I can see the following scenarios for a file:
>
> In both cases, we're going to have a conflict, so we leave file.
> {older,remote,local} as appropriate and already done.
>
> > 1. deleted in the base and modified by the patch. It should leave the
> > file in the tree together with file.older.
>
> Why not leaving file.remote? We already do that in general, so we have a
> duplicate, but it's easier to understand.

I agree with this.

> > Another option would be to
> > remove the file and leave both file.older and file.remote in the tree
> > (here .remote means the version in the patch)
>
> I remember that at times, but .remote is very confusing... I see that's the
> mishandling is induced by various sources, maybe including "merge" itself,
> but that program (and possibly others) supports changing the labels, and this
> should probably be done (using "original", "patched" and "upstream"
> probably).

I know that diff3/merge support labels. I don't exactly remember my
reasons but I think that I chose those namings because StGIT was
supporting another type of merge where "patched" etc. did not apply.

I agree that we should change them. I would rather use "ancestor",
"patch" and "base" but I don't have a strong opinion.

> > 2. changed in the base but deleted by the patch. It should remove the
> > file from the tree but leave file.older and file.local. The other
> > option is to leave the file in the tree but, as above, I prefer the
> > first one.
>
> The policy about when to remove the file and when to leave it is very
> personal... the user must anyway solve the conflict in some smart way...
> about the defaults, anything would do, but if we really care we could leave
> the user the choice.

At the moment, the conflicts usually leave the index in the state
before pushing the patch. I think it should also leave the file and
just mark it as conflict in .git/conflicts.

--
Catalin

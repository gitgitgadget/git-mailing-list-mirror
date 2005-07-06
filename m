From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merging and parents
Date: Tue, 5 Jul 2005 20:26:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507052011440.3570@g5.osdl.org>
References: <pan.2005.07.05.16.19.28.957617@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 06 05:31:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq0d5-0006f2-1k
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 05:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVGFDab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 23:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVGFD3A
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 23:29:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261543AbVGFD1q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 23:27:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j663QEjA018519
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 5 Jul 2005 20:26:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j663QDE1009626;
	Tue, 5 Jul 2005 20:26:13 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.07.05.16.19.28.957617@smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 5 Jul 2005, Matthias Urlichs wrote:
>
> I just had this ugly merge situation:
> 
>  M
>  |\
>  | \
>  A  B
>  |\/|
>  |/\|
>  C  D
>  | /
>  |/
>  E
> 
> Suppose both the EC and the ED branch add files (not with conflicting
> filenames!) which then get modified somewhere between C/D and M.
> 
> No matter which node gets picked as the parent, some files will end
> up as "created on different branches" because the chosen parent doesn't
> have them, even though, strictly speaking, it ain't so.

So walk me through it. Why is this ugly?

It's kind of interesting in that it has a merge-base that isn't unique any 
more: both C and D are "equally valid" merge bases, but do it really 
generate any real problems?

Let's say that you pick C as the merge base, which means that both A and B 
suddenly have the same new files show up (that came from D). Now, to make 
it interesting, let's say that D/B also modified that file, so that you 
have the merge at M see two different files just "show up".

The trivial merger will fail this case, for sure. So I agree that it's a 
problem for the _current_ stupid merger, but it's not a fundamentally hard 
thing to do per se. Go backwards in history, look for where it was 
created, and use that as the merge-base for that particular file. 

So yes, the current merge is very very stupid. It's worked impressively 
well for the kernel, though, so stupid tends to often be "good enough". 
And since it _has_ been good enough, I personally haven't been motivated 
to try to improve the merge logic.

Basically, the first-level trivial merge that "git-read-tree -m" does is 
really meant to just cut down the list of files to a manageable level, so 
that you can do the "real work" on a per-file level without being bogged 
down by having 17,000+ files to work with.

So if you want to document that the current automatic merge is stupid,
hey, go wild. It _is_ stupid. It's surprisingly effective, but that may be
because of kernel development patterns and may not be true in other
projects.

And if somebody wants to write a better merger than the current
git-merge-one-file-script, I can only encourage you. I think git has the
potential to have made the "normal case" so cheap that the algorithms in
git-merge-one-file-script could be quite advanced, without it slowing down
things noticeably. So to some degree I think git should _allow_ for doing
very complicated merges, exactly because it efficiently pinpoints the
effort to the place where it is needed. So a lot of merges that are 
interesting in theory but aren't _practical_ as a main merge, might 
actually be practical with git.

		Linus

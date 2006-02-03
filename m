From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git bisect and the merge from hell
Date: Fri, 3 Feb 2006 12:58:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602031246030.4630@g5.osdl.org>
References: <200602031947.k13JlaDr003720@agluck-lia64.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 21:59:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F581P-0000fS-SM
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945957AbWBCU7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945961AbWBCU7I
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:59:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945957AbWBCU7H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 15:59:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k13KwFDZ008165
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Feb 2006 12:58:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k13KwEsn028108;
	Fri, 3 Feb 2006 12:58:15 -0800
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <200602031947.k13JlaDr003720@agluck-lia64.sc.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15555>



On Fri, 3 Feb 2006, Luck, Tony wrote:
>
> Sometime between -rc1 and -rc2 the ia64 kernel picked up a bug
> that prevents booting a UP kernel on my workstation (I recycled
> the serial cable to hook up a new machine, so I don't have the
> OOPS).
> 
> So I thought I'd use git bisect to narrow it down.  A few iterations
> in it picked the merge from hell, and two iterations after that it
> appears to have wandered into the weeds and picked something from
> before -rc1.
>
>  $ git describe 3c5c363826e435cf4d54d917202567e5b57cae5f
>  v2.6.15-g3c5c3638
> 
> Is this normal?

That commit _is_ in between v2.6.16-rc1 and -r2:

  [torvalds@g5 linux]$ git-rev-list v2.6.16-rc1..v2.6.16-rc2 | grep 3c5c363826e435
  3c5c363826e435cf4d54d917202567e5b57cae5f

but it came through a merge, so the history isn't linear. That commit does 
not actually ever reach 2.6.16-rc1 in its history.

Use "git bisect visualize" to see what "git bisect" is doing. It's doing 
everything right so far..

> A couple of iterations down (with git bisect saying that we were into
> the home stretch with only 5 commits to go) I ran into build problems,
> so I haven't yet got to the bottom of the problem).

Ok. That's a different issue. 

When you hit a problem where "git bisect" will pick a place that doesn't 
compile (usually for some stupid reason that you're not at all 
interested in chasing down), what you should do is

	git bisect visualize

to see what commits are interesting.

Then, pick one of the interesting ones "at random" (it helps if it's not 
close to any of the known-uninteresting points), and do

	git reset --hard <picked-sha1>

and try that instead (and compile that, and just continue with your 
bisection: mark it good or bad depending on whether it works).

Basically, what you're doing is to override the choice of place to test 
that "git bisect" chose automatically for you. It still works, but 
obviously the point is probably not as "half-way" any more, so it makes 
the narrowing down of the bad commit slightly less efficient.

> Here's the BISECT_LOG:

Ok, you've done great progress. You only have 11 revisions left to test 
(the last message would have been "5 revisions left to test after this", 
but that means that _after_ you've verified the picked point, you'd have 
had just five versions left.

"git bisect visualize" really makes it very obvious what to try next, I 
think. Which exact commit you try next probably depends on what the 
compile error was. I'd try

	git reset --hard 3d5271f9883cba7b54762bc4fe027d4172f06db7

(which is after the "pull release into acpica branch" commit).

		Linus

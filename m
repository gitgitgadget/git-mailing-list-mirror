From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Wed, 8 Feb 2006 17:05:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081643570.2458@g5.osdl.org>
References: <87slqtcr2f.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 02:05:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F70Fl-0004QN-6O
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 02:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422727AbWBIBF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 20:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbWBIBF3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 20:05:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422727AbWBIBF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 20:05:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1915KDZ026855
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 17:05:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1915EAm022103;
	Wed, 8 Feb 2006 17:05:17 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87slqtcr2f.wl%cworth@cworth.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15777>



On Wed, 8 Feb 2006, Carl Worth wrote:
> 
> I would be using this before every "got commit" to get a preview, and
> it seems like a painfully long name for such a common operation. Even
> its shortcut form:
> 
> 	git diff --cached HEAD
> 
> is among the longest of the "git diff" shortcuts.

[ snip snip ]

Yeah, I agree. The "git diff" semantics are incomplete, and the choices 
may not be (aka "almost certainly aren't") the best. The recent "git show" 
actually came from a very common use (well, for me, at least) for 
"git-diff-tree" that the "git diff" command simply didn't support.

I don't think it's really worth changing the low-level command naming: 
nopefully few enough people use them that it doesn't matter, but that's 
also what scripts out there are likely to have, so the pain factor when 
something breaks is high enough.

But making "git diff" itself more often "Do The Right Thing(tm)" would 
probably be a good idea.

In particular, I think the real culprit is the plain "git diff" with no 
arguments at all. Right now it ends up showing just a piece of the 
picture, and the piece it shows is incomplete enough to be irritating.

So I would prefer a slightly different fix from yours: instead of changing 
the core commands (which hopefully people mainly use in scripts where 
stability is more important than "intuitive and easy defaults"), how about 
_just_ changing the meaning of "git diff"?

Right now a plain "git diff" only shows the differences in the current 
tree against the index. I think that was just the wrong choice. I think 
almost everybody would actually prefer the default to be to show the 
difference against HEAD.

The largest reason for why "git diff" defaults to diffing against the 
index (and not head) is _literally_ that it's faster. Yes, I'm ashamed, 
but "git diff HEAD" takes 0.35 seconds for me, and "git diff" takes 0.07
seconds, and largely based entirely on that (and not "what would users 
want"), I made the bad choice to default to git-diff-files for the "no 
arguments" case.

I hang my head in shame. I just like the _instantness_ of "nothing 
changed". That's a bad reason for choice of interfaces, though.

One option is to realize that "git status" is actually a much better thing 
to use (because it shows _both_ the "HEAD to index" _and_ "index to 
current tree" format).

Teaching "git status" to take a "-p" flag (for "patch" - or -v for 
"verbose") might actually be a good thing. Then, instead of "git diff", 
you'd use "git status -p" and it would show you what the differences are 
in the index, and what they are in the tree, so you'd _really_ know what 
"git commit" in all its glory would do.

		Linus

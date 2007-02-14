From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 13:13:09 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141250300.20368@woody.linux-foundation.org>
References: <17875.25882.784307.731860@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRRD-0005oH-5p
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbXBNVNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbXBNVNM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:13:12 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46005 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932602AbXBNVNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:13:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1ELDAhB015959
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 13:13:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1ELD9gC009240;
	Wed, 14 Feb 2007 13:13:09 -0800
In-Reply-To: <17875.25882.784307.731860@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.41 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39747>



On Wed, 14 Feb 2007, Bill Lear wrote:
>
> I have not yet figured this one out: I have not tagged anything, but
> know that I checked in something lame sometime between now and two days
> ago.  How do I get my working repo to be that as it was, say, yesterday?
> 
> Do I do:
> 
> % git log --since="2 days ago"
> 
> parse, the output for the commit I want, and then do
> 
> % git reset <SHA>

No, use that only if you want to throw away everything you did after 
that particular point.

If you just want to go and look at it more closely, with git-1.5 you do

	git checkout <SHA>

which will just detatch your HEAD from any current branch, and just move 
you there. But with an older git that doesn't like the detached state, 
you'd could instead do

	git checkout -b nonlame-branch <SHA>

which actually creates a new branch with the <SHA> as the beginning point, 
and switches to it. That will work with any version (including 1.5, of 
course).

You can then decide to re-do the branch without the lame commit. One 
particularly simple thing to do (if it's just one lame commit, and you 
don't want to *remove* it, but just fix it up a bit) is to literally check 
out the tip of tree juat AT the lame commit, and then you can use

	git commit --amend

to actually change it.

So depending on what your situation is, this sequence actually works:

	#
	# Create and check out a "fixes" branch that has the 
	# known-broken commit as its head commit
	#
	git checkout -b fixes <BROKEN-COMMIT>

	.. edit edit edit to fix the broken commit ..

	#
	# Then, just _replace_ the broken commit with the fixed state
	# by doing a "git commit --amend"
	#
	git commit -a --amend

	#
	# ok, now the "fixed-branch" is in good shape, but we
	# want to re-surrect our original 'master' branch WITH the 
	# fix, and based on the fixed branch, so we rebase the
	# master branch# _onto_ the fixed state in "fixes", with
	# the broken commit (that we do _not_ want to include) as
	# the base.
	#
	git rebase --onto fixes <BROKEN-COMMIT> master

Somebody else should verify that "git rebase" thing. I still find the 
syntax for that thing rather illogical for these kinds of things.  
Possibly because I never do it myself.

		Linus

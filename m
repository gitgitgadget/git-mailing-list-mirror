From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How can I easily verify my diffs are in parent branch?
Date: Wed, 4 Apr 2007 08:12:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
References: <1175686583.19898.68.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 17:12:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ79v-0006YN-On
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 17:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992918AbXDDPMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 11:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992920AbXDDPMZ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 11:12:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43814 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992918AbXDDPMY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 11:12:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l34FCLPD019818
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 Apr 2007 08:12:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l34FCKxM023156;
	Wed, 4 Apr 2007 08:12:20 -0700
In-Reply-To: <1175686583.19898.68.camel@okra.transitives.com>
X-Spam-Status: No, hits=-0.452 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43744>



On Wed, 4 Apr 2007, Alex Bennee wrote:
> 
> This is not the case of looking through the logs for my commit as I'm
> exporting my changes from my tree into the company system through CVS.
> This means all the usual commit tracking benefits are lost.

Yeah, sad.

> So I have a master branch which tracks this master baseline from CVS and
> each release I import a big change set which includes all the fixes that
> went into that baseline.

So all your small diffs get smushed in as part of one *big* change? Or do 
they still exist in the baseline CVS tree as individual commits?

If they still exist in the CVS tree as individual commits, you're slightly 
better off: you can use "git patch-id" to generate a hash of all the 
patches, and compare just the hashes. That allows you to efficiently find 
patches that have been applied *identically* in both trees.

NOTE! "git-patch-id" generates a hash of a patch by ignoring 
 - line numbers
 - whitespace
 - commit comments
so "identical" means just that the patch has to have the exact same 
context and +/- patterns, but it will still be considered identical if 
it's been moved around (perhaps because some other patch added/removed 
code before it) or if the whitespace has been tweaked.

You can then compare the hashes upstream with all the commits *you* cared 
about, and see if they are all there. But as noted, this only works if 
upstream is expected to actually honor patch-boundaries. If you just get a 
single big changeset that contains *all* the changes, doign this obviously 
won't work.

NOTE2! I don't think anybody actually *uses* git-patch-id, and what you 
should do is to use "git cherry" that does this all internally, but it is 
worth understanding *what* git-cherry does.

So to compare all patch-ID's, you can do

	git cherry cvs-upstream my-branch

adn it should look at all the commits that are in *your* branch but not 
upstream, and report their ID's preceded by a "-" if they are upstream, 
and a "+" if they are not.

You can then look at the "+" commits more closely, to see whether maybe 
they actually did get merged, but got changed/fixed in the process, or 
whether they really are missing.

> Is there an invocation of git-diff or another tool that can tell me all
> my diffs are present in the big uber-commit of my master branch baseline
> release?

If git cherry doesn't work for you, you're kind of screwed and have to do 
it manually. Of course, even "manually" can be done with a lot of help 
from git.

For example, one thing you can do, if the number of commits you have is 
fairly small, is to just be on your "my-branch" and then do

	git rebase [--merge] cvs-upstream

which will rebase your "my-branch" onto the CVS upstream thing. It will 
automatically discard any patches that get merged away (which effectively 
means that they were already there). The end result will be that your 
branch will now either be identical to "cvs-upstream" (if everything was 
already there) or will contain the commits that weren't there on top of 
the new cvs-upstream tip.

NOTE NOTE NOTE! The "git rebase" thing sounds perfect, but the fact is, 
quite often you'll end up having to help it do its work. It really 
defaults to just trying to apply the patches (ie without "--merge" it's 
literally just a fancy

	git-format-patch | git am

pipeline).

So "git rebase" may well be the right thing for you, but quite frankly, 
it's more likely to work well for simple cases (with no real conflicts 
with anybody elses work in the same areas) than for anything complicated.

For complicated stuff, you'll be on your own. "git diff pathname" etc..

		Linus

From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: new file leaked onto release branch
Date: Wed, 14 Dec 2005 12:10:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512141150210.3292@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 21:16:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmcyF-000733-SB
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 21:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVLNULI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 15:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVLNULH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 15:11:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964924AbVLNULG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 15:11:06 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBEKApDZ003678
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Dec 2005 12:10:52 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBEKAlRP002778;
	Wed, 14 Dec 2005 12:10:49 -0800
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30056B83F2@hdsmsx401.amr.corp.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13639>



On Wed, 14 Dec 2005, Brown, Len wrote:
>
> >So Len, since you seem to use "git merge" in your scripts, I 
> >suspect you have an old version of git lying around. Can you try doing just
> 
> Should I be using something different than git merge?

No, "git merge" should be fine. It's what "git pull" ends up doing 
internally, which is why I suspected an old git version: "git merge" 
should be well-tested, since it's very much what I end up using every day 
when I pull stuff.

> >	git merge-base -a 0a47c906342e2447003e207d23917dfa5c912071 d2149b542382bfc206cb28485108f6470c979566
> >
> >to see what the result is for you?
> 
> $ git merge-base -a 0a47c906342e2447003e207d23917dfa5c912071 d2149b542382bfc206cb28485108f6470c979566
> d2149b542382bfc206cb28485108f6470c979566

Ok, that's correct.

git-merge does:

	common=$(git-merge-base --all $head "$@")

and then it _should_ have triggered this case:

	case "$#,$common,$no_commit" in
	..
	1,"$1",*)
		# If head can reach all the merge then we are up to date.
		# but first the most common case of merging one remote
		echo "Already up-to-date."
		dropsave
		exit 0
		;;
	..

and thus never have created any merge messages.

That's what I get when I try this:

	git checkout -b test-merge 0a47c906342e2447003e207d23917dfa5c912071
	git merge "Testing merging" HEAD d2149b542382bfc206cb28485108f6470c979566

results in a very immediate

	"Already up-to-date."

message. Does it do that for you too?

I tested not only with current git, but also the gits that were valid on 
Nov 29 and Nov 30. All of them did this.

> Doesn't appear to be the case, as I don't have a /usr/bin/git
> IIR, months ago I tried to install the rpm and
> it failed due to some incompatibility like not groking
> a SuSE destination.  I got Dave's git tarball according
> to Jeff's howto: http://linux.yyz.us/git-howto.html
> and have been building and installing from a git repo since.
> (I found git-current tarball dated 7/21/05, so maybe it was then)
> I did, however a few months ago copy my i386 home directory over to the
> x86_64 box I use now, re-build and re-install.  Dunno
> if there may have been a hickup in that process...
> I found a backup copy of my i386 bin directory from 2005-08-25 --
> binaries still in i386 format.  But I don't think I ran that b/c
> it isn't on any PATH.  Git lives in ~/bin which is 1st in my PATH.

Hmm. It really looks like it should have been impossible to generate that 
commit with current git, which is why I'm still a bit suspicious. 

> I think the lesson I'm taking away from this is that
> as I continue to stumble forward using git I should
> immediately report anything that doesn't look quite right
> while I can still guarantee that all the clues are still
> at the scene of the crime.

I think this list has been pretty responsive to reports of strange 
behaviour, so yes. 

			Linus

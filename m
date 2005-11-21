From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: auto-packing on kernel.org? please?
Date: Mon, 21 Nov 2005 12:01:51 -0700
Organization: Hewlett Packard
Message-ID: <20051121190151.GA2568@hpsvcnb.fc.hp.com>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 20:03:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeGvS-0004sq-RX
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVKUTB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVKUTB6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:01:58 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:32733 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932453AbVKUTB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 14:01:57 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel8.hp.com (Postfix) with ESMTP id 154783B5C;
	Mon, 21 Nov 2005 14:01:55 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 55E3738274; Mon, 21 Nov 2005 19:01:51 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 3B1592B0C; Mon, 21 Nov 2005 12:01:51 -0700 (MST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12467>

I have a question about automatic repacking.

I am thinking of turning something like Linus' repacking heuristic loose
on my repositories.  I just want to make sure it is as safe as possible.

At the core of the incremental and full repack strategies are these
statements.

Incremental...
> 		git repack &&
> 			git prune-packed

Full...
> 		git repack -a -d &&
> 			git prune-packed

Are there some built in safety checks in 'git repack' and/or 'git
prune-packed' to guard against corruption?  In the long run, I would
feel more comfortable with somelike like this:

git repack
git verify-pack <new pack>
git prune-packed

Would something like this even work with 'git repack -a -d'?  Is there a
way to do something like the following for a full repack to achieve the
ultimate in paranoia?

git repack -a
git verify-pack <new pack file>
git trash-redundant-packs <new pack file>
git prune-packed

Carl

On Thu, Oct 13, 2005 at 11:44:30AM -0700, Linus Torvalds wrote:
> 
> I know we tried this once earlier, and it caused problems, but that was 
> when pack-files were new, and not everybody could handle them. These days, 
> if you can't handle pack-files, kernel.org is already pretty useless, 
> because all the major packages use them anyway, because people have 
> packed their repositories by hand.
> 
> So I'm suggesting we try to do an automatic repack every once in a while. 
> 
> In my suggestion, there would be two levels of repacking: "incremental" 
> and "full", and both of them would count the number of files before they 
> run, so that you'd only do it when it seems worthwhile.
> 
> This is a _really_ simple heuristic:
> 
>  - incremental repacking run every day:
> 
> 	#
> 	# Check if we have more than a couple of hundred
> 	# unpacked objects - approximated by whether we
> 	# have any "00" directory with more than one 
> 	#
> 	# This means that we don't repack projects that
> 	# that don't have a lot of work going on.
> 	#
> 	# Note: with really new versions of git, the "00"
> 	# directory may not exist if it has been pruned
> 	# away, so handle that gracefully.
> 	#
> 	export GIT_DIR=${1:-.}
> 	objs=$(find "$GIT_DIR/objects/00" -type f 2> /dev/null | wc -l)
> 	if [ "$obj" -gt 0 ]; then
> 		git repack &&
> 			git prune-packed
> 	fi
> 
>  - "full repack" every week if the number of packs has grown to be bigger 
>    than say 10 (ie even a very active projects will never have a full 
>    repack more than every other week)
> 
> 	#
> 	# Check if we have lots of packs, where "lots" is defined as 10.
> 	#
> 	# Note: with something that was generated with an old version
> 	# of git, the "pack" directory may not exist, so handle that
> 	# gracefully.
> 	#
> 	export GIT_DIR=${1:-.}
> 	packs=$(find "$GIT_DIR/objects/pack" -name '*.idx' 2> /dev/null | wc -l)
> 	if [ "$packs" -gt 10 ]; then
> 		git repack -a -d &&
> 			git prune-packed
> 	fi
> 
>  - do a full repack of everything once to start with.
> 
> 	export GIT_DIR=${1:-.}
> 	git repack -a -d &&
> 		git prune-packed
> 
> the above three trivial scripts just take a single argument, which becomes 
> the GIT_DIR (and if no argument exists, it would default to ".")
> 
> Is there any reason not to do this? Right now mirroring is slow, and 
> webgit is also getting to be very slow sometimes. I bet we'd be _much_ 
> better off with this kind of setup.
> 
> NOTE! The above is the "stupid" approach, which totally ignores alternate 
> directories, and isn't able to take advantage of the fact that many 
> projects could share objects. But it's simple, and it's efficient (eg it 
> won't spend time on things like the large historic archives which don't 
> change, but that would be expensive to repack if you didn't check for the 
> need).
> 
> So we could try to come up with a better approach eventually, which would 
> automatically notice alternate directories and not repack stuff that 
> exists there, but I'm pretty sure that the above would already help a 
> _lot_, and while pack-files have been been around forever, the 
> "alternates" support is still pretty new, so the above is also the "safer" 
> thing to do.
> 
> We'd only do the automatic thing on stuff under /pub/scm, of course: not 
> stuff in peoples home directories etc..
> 
> Peter?
> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

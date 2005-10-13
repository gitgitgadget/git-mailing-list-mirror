From: Linus Torvalds <torvalds@osdl.org>
Subject: auto-packing on kernel.org? please?
Date: Thu, 13 Oct 2005 11:44:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ84E-0001eY-B0
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 20:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbVJMSod (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 14:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbVJMSod
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 14:44:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751598AbVJMSod (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2005 14:44:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9DIiV4s014958
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 11:44:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9DIiUKa028080;
	Thu, 13 Oct 2005 11:44:31 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10087>


I know we tried this once earlier, and it caused problems, but that was 
when pack-files were new, and not everybody could handle them. These days, 
if you can't handle pack-files, kernel.org is already pretty useless, 
because all the major packages use them anyway, because people have 
packed their repositories by hand.

So I'm suggesting we try to do an automatic repack every once in a while. 

In my suggestion, there would be two levels of repacking: "incremental" 
and "full", and both of them would count the number of files before they 
run, so that you'd only do it when it seems worthwhile.

This is a _really_ simple heuristic:

 - incremental repacking run every day:

	#
	# Check if we have more than a couple of hundred
	# unpacked objects - approximated by whether we
	# have any "00" directory with more than one 
	#
	# This means that we don't repack projects that
	# that don't have a lot of work going on.
	#
	# Note: with really new versions of git, the "00"
	# directory may not exist if it has been pruned
	# away, so handle that gracefully.
	#
	export GIT_DIR=${1:-.}
	objs=$(find "$GIT_DIR/objects/00" -type f 2> /dev/null | wc -l)
	if [ "$obj" -gt 0 ]; then
		git repack &&
			git prune-packed
	fi

 - "full repack" every week if the number of packs has grown to be bigger 
   than say 10 (ie even a very active projects will never have a full 
   repack more than every other week)

	#
	# Check if we have lots of packs, where "lots" is defined as 10.
	#
	# Note: with something that was generated with an old version
	# of git, the "pack" directory may not exist, so handle that
	# gracefully.
	#
	export GIT_DIR=${1:-.}
	packs=$(find "$GIT_DIR/objects/pack" -name '*.idx' 2> /dev/null | wc -l)
	if [ "$packs" -gt 10 ]; then
		git repack -a -d &&
			git prune-packed
	fi

 - do a full repack of everything once to start with.

	export GIT_DIR=${1:-.}
	git repack -a -d &&
		git prune-packed

the above three trivial scripts just take a single argument, which becomes 
the GIT_DIR (and if no argument exists, it would default to ".")

Is there any reason not to do this? Right now mirroring is slow, and 
webgit is also getting to be very slow sometimes. I bet we'd be _much_ 
better off with this kind of setup.

NOTE! The above is the "stupid" approach, which totally ignores alternate 
directories, and isn't able to take advantage of the fact that many 
projects could share objects. But it's simple, and it's efficient (eg it 
won't spend time on things like the large historic archives which don't 
change, but that would be expensive to repack if you didn't check for the 
need).

So we could try to come up with a better approach eventually, which would 
automatically notice alternate directories and not repack stuff that 
exists there, but I'm pretty sure that the above would already help a 
_lot_, and while pack-files have been been around forever, the 
"alternates" support is still pretty new, so the above is also the "safer" 
thing to do.

We'd only do the automatic thing on stuff under /pub/scm, of course: not 
stuff in peoples home directories etc..

Peter?

			Linus

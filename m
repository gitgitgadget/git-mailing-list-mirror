From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: auto-packing on kernel.org? please?
Date: Mon, 21 Nov 2005 11:24:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org>
 <20051121190151.GA2568@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 20:32:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeHN7-0006My-AC
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 20:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbVKUTae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 14:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKUTae
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 14:30:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47339 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932190AbVKUTad (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2005 14:30:33 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jALJOCnO003655
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 21 Nov 2005 11:24:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jALJOBbs027717;
	Mon, 21 Nov 2005 11:24:11 -0800
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051121190151.GA2568@hpsvcnb.fc.hp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12471>



On Mon, 21 Nov 2005, Carl Baldwin wrote:
>
> I have a question about automatic repacking.
> 
> I am thinking of turning something like Linus' repacking heuristic loose
> on my repositories.  I just want to make sure it is as safe as possible.
> 
> At the core of the incremental and full repack strategies are these
> statements.
> 
> Incremental...
> > 		git repack &&
> > 			git prune-packed
> 
> Full...
> > 		git repack -a -d &&
> > 			git prune-packed

NOTE! Since that email, "git repack" has gotten a "local" option (-l), 
which is very useful if the repositories have pointers to alternates.

So do

	git repack -l

instead, to get much better packs (and "-a -d" for the full case, of 
course).

Other that than, the old email suggestion should still be fine.

> Are there some built in safety checks in 'git repack' and/or 'git
> prune-packed' to guard against corruption?  In the long run, I would
> feel more comfortable with somelike like this:
> 
> git repack
> git verify-pack <new pack>
> git prune-packed

You can certainly do that if you are nervous. It might even be a good 
idea: just for fun, I just did

	git clone -l git git-clone
	cd git-clone

	# pick an object at random
	rm .git/objects/f7/c3d39fe3db6da3a307da385a7a1cb563ed15f7

	git repack -a -d

and it said:

	error: Could not read f7c3d39fe3db6da3a307da385a7a1cb563ed15f7
	fatal: bad tree object f7c3d39fe3db6da3a307da385a7a1cb563ed15f7

but then it created the pack _anyway_, and said:

	Packing 27 objects
	Pack pack-13bfca704078175c1c1c59964553b14f7b952651 created.

and happily removed all the old ones.

So right now, repacking a broken archive can actually break it even more.

NOTE! Your "git verify-pack" wouldn't even catch this: the _pack_ is fine, 
it's just incomplete.

Of course, this only happens if the repository was broken to begin with, 
so arguably it's not that bad. But it does show that git-repack should be 
more careful and return an error more aggressively.

Can anybody tell me how to do that sanely? Right now we do

	..
	name=$(git-rev-list --objects $rev_list $(git-rev-parse $rev_parse) |
	        git-pack-objects --non-empty $pack_objects .tmp-pack) ||
	        exit 1
	..

and the thing is, the "git-pack-objects" thing is happy, it's the 
"git-rev-list" that fails. So because the last command in the pipeline 
returns ok, we think it all is ok..

(This is one of the reasons I much prefer working in C over working in 
shell: it may be twenty times more lines, but when you have a problem, the 
fix is always obvious..)

Anyway, with that fixed, a "git repack" in many ways would be a mini-fsck, 
so it should be very safe in general. Modulo any other bugs like the 
above.

		Linus

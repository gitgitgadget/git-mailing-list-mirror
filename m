From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Mon, 25 Jul 2005 20:07:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507251922310.6074@g5.osdl.org>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de>
 <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org> <20050725234257.GC5680@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>,
	David Mansfield <cvsps@dm.cobite.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 05:12:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxFr1-0005xq-6c
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 05:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVGZDLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 23:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVGZDLd
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 23:11:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261545AbVGZDLc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 23:11:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6Q37VjA005951
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Jul 2005 20:07:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6Q37TaN027741;
	Mon, 25 Jul 2005 20:07:30 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050725234257.GC5680@kiste.smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


On Tue, 26 Jul 2005, Matthias Urlichs wrote:
>
> That's a problem with the bkcvs tree. Remember tht Bitkeeper does
> exactly the same thing -- the 1.0 version of *any* file is empty, and
> content appears only in version 1.1.

Not really. That may be how the SCCS _deltas_ end up being done
internally, but it's definitely not how BK changesets work. 

For example, in BK SCCS files (if I understood it correctly, I've not
actually looked very closely) a "rename" ends up being two deltas - the
"diff" delta and the "rename" delta. That does _not_ really mean that BK
considers it two different things, it's purely a SCCS file layout thing, 
and it just shows through to bkcvs.

Similarly, apparently in SCCS the "create" event is one revision, and the
"initial data" is another one, and again, that shows up in bkcvs even
though that's not really how BK works conceptually at all.

So then the cvs archives end up showing some of these things as multiple
separate patches, but that just means that cvsps doesn't understand that
they all get collapsed into one changeset in the bk model.  The fact that
some changes may end up showing as multiple deltas is just a result of BK
mostly re-using an old fileformat that just doesn't know anything at all
about changesets what-so-ever.

cvsps should really have collapsed those things into _one_ changeset. I 
had thought that it would do so automatically based on the date (the date 
should always be exactly the same), but it turns out that since the log 
messages might be different, cvsps will split _one_ ChangeSet into 
multiple patches, which is _wrong_.

In fact, I guess the log messages _will_ be different, because the bkcvs 
thing will always put in the BK key in the "real" message.

I _thought_ that this was exactly what the "--bkcvs" flag was going to
notice, but it seems to not be the case. Or maybe "cvsimport" just doesn't 
pass that flag through.. In fact, I just checked, and "cvsps --bkcvs" 
_does_ do the right thing, and collapses all of these things to one 
"PatchSet".

But I think I see why "git cvsimport" does the wrong thing: since that one 
commit has _all_ the deltas associated with the commit, it looks like 
this:

	PatchSet 2
	Date: 2002/02/05 17:40:40
	Author: torvalds
	Branch: HEAD
	Tag: v2_4_0
	Log:
	Import changeset
	
	BKrev: 3c601918i-Rse1XOIZxu4fPHUrTmmA
	
	Members:
	        COPYING:1.1->1.2
	        COPYING:INITIAL->1.1
	        CREDITS:1.1->1.2
	        CREDITS:INITIAL->1.1
	        ChangeSet:1.2->1.3
	        MAINTAINERS:1.1->1.2
		....

and notice how "COPYING" (and all other new files) has two deltas
associated with it, the "INITIAL->1.1" and the "1.1->1.2" one.

And they are in the wrong order, so "cvsimport" ends up committing the 
last one, which is the _empty_ one.

Notice? We'll end up committing "COPYING 1.1" (the empty initial create)
even though we _should_ have committed "COPYING 1.2" (the actual thing
that BK committed).

> Well, the bkcvs export preserved that ... "feature".

No, the bkcvs thing exports an atomic BK commit as several deltas (with
the same date) not because it's a "feature" of BK, but partly because you
can't express what BK does in CVS, and partly because of what appears to
be purely internal BK implementation details (ie a feature of the SCCS
file).

BK did it right, and we just imported it wrong.

David - is there some way where cvsps could always order these things by 
revision? I now realize that this is probably also what causes cvsps to 
complain about things like:

	..
	PatchSet 2 has collisions
	..

which means that cvsps actually _saw_ this, but just output the result in 
the wrong order as far as "git cvsimport" was concerned.

The preferred solution would be to always just suppress the older revision
when you see multiple ones - it is by definition not interesting (you
cannot actually ever access it even in the original BK tree).

> (Side question - why aren't you doing a direct bk2git import?)

Because I don't have any BK trees left, and because I'm not going to touch
Andrews code. We'd have had a portable BK export format (in fact, I wrote
one as a proof-of-concept thing when we were tryign to convince Tridge
that he really doesn't want to muck inside BK internals), but then shit 
happens..

So I'll use the CVS thing. 

> >                                         I realize you'd want to do that to 
> > avoid connecting millions of times, but maybe it's better to use something 
> > like cvsnup to download the whole thing, and then always use a local CVS 
> > archive?
> 
> ... I don't have a sensible RCS library for perl (the code that I could
> find is just a command line front-end). Fork+exec of some cvs checkout
> command per file is slower than just running a persistent CVS server.

Fair enough, I suspect that without a builtin RCS library it really ends 
up being faster than the whole exec thing. 

I thought there was a RCS library (I know I got some hits for "rcslib"  
for some scripting language and was cursing the fact that it wasn't for
C), but I never really looked closer. I'm not surprised if the "library"
ends up just doing a "system()" thing.

> I've tried other ideas, but they run into problems because some
> idiots^Wpeople occasionally tag only parts of a CVS tree

Yeah, CVS really allows some very very annoying things that only work in a 
file-at-a-time model.

		Linus

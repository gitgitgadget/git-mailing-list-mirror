From: Brad Roberts <braddr@puremagic.com>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Tue, 10 May 2005 05:55:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0505100546010.2136-100000@bellevue.puremagic.com>
References: <Pine.LNX.4.44.0505091549210.2136-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	Git Mailing List <git@vger.kernel.org>,
	<darcs-devel@abridgegame.org>
X-From: git-owner@vger.kernel.org Tue May 10 14:49:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVUAX-0000HX-KO
	for gcvg-git@gmane.org; Tue, 10 May 2005 14:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVEJM4V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 08:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbVEJM4V
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 08:56:21 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:24485 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261629AbVEJM4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 08:56:09 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-1) with ESMTP id j4ACtucs007709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 10 May 2005 05:55:56 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j4ACtt8c007705;
	Tue, 10 May 2005 05:55:55 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0505091549210.2136-100000@bellevue.puremagic.com>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 9 May 2005, Brad Roberts wrote:

> Date: Mon, 9 May 2005 15:50:33 -0700 (PDT)
> From: Brad Roberts <braddr@puremagic.com>
> To: Petr Baudis <pasky@ucw.cz>
> Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
>      Git Mailing List <git@vger.kernel.org>, darcs-devel@abridgegame.org
> Subject: Re: Darcs-git: a few notes for Git hackers
>
> > >  - there's no way to have multiple simultaneous caches, short of
> > >    hacking at the values of Git's global variables by hand.
> >
> > See the Brad Robert's patches of Apr 21. I've decided not to apply them
> > since it appears a lot has changed since then and it would be some pain;
> > but they may be a worthy starting point for a more up-to-date patch.
> >
> > --
> > 				Petr "Pasky" Baudis
>
> Since there's interest, I'll pull tip of your tree and re-do them.  I
> haven't bothered todate since no one seemed interested.  Do you want them
> piece meal like I did last time or just one big diff?
>
> Later,
> Brad

I wasn't able to finish redoing these against linus tip, but I got most of
it done (patches 1-14 of the original 19):

  http://gameboy2.puremagic.com:8090/
  rsync://gameboy2.puremagic.com/git/

The second, third, and forth to last changes need a careful review,
they're direct applications of the original patches which were lightly
tested during the first round and nothing other than compile tested in
this round.

I suspect the remaining parts of the original patch series will go in
fairly smoothly.  If no one gets to them before tonight I'll finish
it up after work.

Later,
Brad


The commit comments:

Signed-off-by: Brad Roberts <braddr@puremagic.com>

!-------------------------------------------------------------flip-

- remove the no-longer-true comment about the cache being in native byte order
- move the cache_header struct into read-cache.c since it's in internal detail
  of the cache, not a publicly accessed element

!-------------------------------------------------------------flip-

Drop the active_cache and active_nr parameters to write_cache

!-------------------------------------------------------------flip-

- Introduce set_cache_entry(ce, pos)
- Migrate update-cache.c, the only place that does a active_cache[pos] = ce to use it
- Migrate all the same style code in read-cache.c to use it also, except for
  read_cache itself which is setting up the initial active_cache entries

TODO: rewrite the code that deal with pointers into the active_cache array such as
read-tree.c's merging code.

!-------------------------------------------------------------flip-

Introduce get_cache_entry(int pos) and use it for all trivial calls like:
  ce = active_cache[pos]

TODO: rework the non-trivial active_cache manipulations

!-------------------------------------------------------------flip-

remove active_cache_changed from cache.h

!-------------------------------------------------------------flip-

Introduce get_num_cache_entries() and migrate all the trivial callers to it

!-------------------------------------------------------------flip-

Remove active_alloc from cache.h

!-------------------------------------------------------------flip-

Restructure the diff algorythm to use indexes rather than pointer math.
The resulting code is probably a little less efficient but abstracts
the data structure.

!-------------------------------------------------------------flip-

Restructure the write tree algorythm to use indexes rather than moving
the base pointer and reducing the num entries and start using the
cache abstraction apis.

!-------------------------------------------------------------flip-

Move from pointer math to indexes and use the abstractions

!-------------------------------------------------------------flip-

- convert the last caller from touching active_cache directly
- drop active_cache and active_nr from cache.h

!-------------------------------------------------------------flip-




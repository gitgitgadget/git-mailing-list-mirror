From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Thu, 29 Jun 2006 20:40:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606291945200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> 
 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> 
 <20060627223249.GA8177@steel.home>  <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
  <20060629002547.GA27507@steel.home>  <7vzmfwy97w.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0606290143g5a3a0f5atbda3f4250411e92e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 20:41:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw1Rb-0002Xe-OY
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWF2Skt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWF2Skt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:40:49 -0400
Received: from mail.gmx.net ([213.165.64.21]:14553 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751258AbWF2Sks (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 14:40:48 -0400
Received: (qmail invoked by alias); 29 Jun 2006 18:40:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 29 Jun 2006 20:40:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606290143g5a3a0f5atbda3f4250411e92e@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22887>

Hi,

On Thu, 29 Jun 2006, Alex Riesen wrote:

> [cc list restored, I'm lost in the maze of git update-index, all cache
> changing functions looking almost the same]
> 
> On 6/29/06, Junio C Hamano <junkio@cox.net> wrote:
> > > this broke t6022-merge-rename.sh (the second test). It produces an
> > > index with this:
> > >
> > > .../t/trash$ git-diff-index white
> > > :100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a
> > 0000000000000000000000000000000000000000 M      B
> > > :100644 100644 ba41fb96393979b22691106b06bf5231eab57b85
> > 0000000000000000000000000000000000000000 M      N
> > >
> > > whereas git-merge-recursive (and the previous version, without pipe):
> > >
> > > .../t/trash$ git-diff-index white
> > > :100644 100644 2d603156dc5bdf6295c789cac08e3c9942a0b82a
> > 0000000000000000000000000000000000000000 M      B
> > >
> > > I can see that "git update-index --add" is somehow different from a
> > > pipe to "git update-index --index-info", but not very clear. Does this
> > > "zero-sha1" mean that the file "N" is not in the index?
> > 
> > When diff-index and diff-files compare a tree entry or an index
> > entry with a file in the working tree, they do not compute the
> > blob hash value for the file in the working tree.  0{40} is used
> > on the RHS in such a case.  When the working tree file matches
> > the corresponding index entry, then we know RHS matches what is
> > in the index, so both sides have the blob hash value.
> 
> Ok. Am I correct in the assumption, that if the file in working tree has
> the same SHA1 as LHS, than the next "git-update-index --refresh" will
> remove the entry from git-diff-index output?
> This is what actually happens, if I do "git-update-index --refresh", so I
> suspect that I have an SHA1 update gone missing somewhere.

I think the problem is more like this (in ce_match_stat_basic()):

        if (ce->ce_mtime.sec != htonl(st->st_mtime))
                changed |= MTIME_CHANGED;
        if (ce->ce_ctime.sec != htonl(st->st_ctime))
                changed |= CTIME_CHANGED;

If you update with --index-info, the mtime and ctime is not updated 
from the file in the working directory.

All the more a reason to go forward with direct calls to read_cache() and 
write_cache(). At the moment, my plan is

- trivially split the read_cache() code into read_cache()/read_cache_from(),
- introduce flush_cache(),
- trivially rewrite add_file_to_cache(), and add_cache_info() from
  builtin-update-index.c, move that to read-tree.c, too, and
- throw out the pipe to git-update-index from merge-recursive.c 
  altogether.

This should be less intrusive than it sounds: with the introduction of 
read_cache_from() it should be trivial to handle the problem of different 
index files.

We have to put a lock_file on the index file at the start, and write the 
index file at the end.

Ciao,
Dscho

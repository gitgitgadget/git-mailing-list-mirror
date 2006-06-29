From: fork0@t-online.de (Alex Riesen)
Subject: Re: CFT: merge-recursive in C (updated)
Date: Fri, 30 Jun 2006 01:28:36 +0200
Message-ID: <20060629232836.GB7216@steel.home>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com> <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060627223249.GA8177@steel.home> <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com> <20060629002547.GA27507@steel.home> <7vzmfwy97w.fsf@assigned-by-dhcp.cox.net> <81b0412b0606290143g5a3a0f5atbda3f4250411e92e@mail.gmail.com> <Pine.LNX.4.63.0606291945200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jun 30 01:29:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw5wY-0001wA-JH
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 01:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095AbWF2X26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 19:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbWF2X26
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 19:28:58 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:7119 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S933098AbWF2X25 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 19:28:57 -0400
Received: from fwd26.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1Fw5wH-0005EQ-00; Fri, 30 Jun 2006 01:28:49 +0200
Received: from tigra.home (Ee0FZ4ZvreayHGmRJu8pUx+Q0QCRk0BE9zPlViKwFzu3heU-4Zs6Eh@[84.160.88.232]) by fwd26.sul.t-online.de
	with esmtp id 1Fw5w5-0px8ts0; Fri, 30 Jun 2006 01:28:37 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 636A6277B5;
	Fri, 30 Jun 2006 01:28:36 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Fw5w4-0004yL-9I; Fri, 30 Jun 2006 01:28:36 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606291945200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6i
X-ID: Ee0FZ4ZvreayHGmRJu8pUx+Q0QCRk0BE9zPlViKwFzu3heU-4Zs6Eh
X-TOI-MSGID: 991e5aef-b38f-4438-b92e-2fdab2558e04
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22927>

Johannes Schindelin, Thu, Jun 29, 2006 20:40:46 +0200:
> > > 
> > > When diff-index and diff-files compare a tree entry or an index
> > > entry with a file in the working tree, they do not compute the
> > > blob hash value for the file in the working tree.  0{40} is used
> > > on the RHS in such a case.  When the working tree file matches
> > > the corresponding index entry, then we know RHS matches what is
> > > in the index, so both sides have the blob hash value.
> > 
> > Ok. Am I correct in the assumption, that if the file in working tree has
> > the same SHA1 as LHS, than the next "git-update-index --refresh" will
> > remove the entry from git-diff-index output?
> > This is what actually happens, if I do "git-update-index --refresh", so I
> > suspect that I have an SHA1 update gone missing somewhere.
> 
> I think the problem is more like this (in ce_match_stat_basic()):
> 
>         if (ce->ce_mtime.sec != htonl(st->st_mtime))
>                 changed |= MTIME_CHANGED;
>         if (ce->ce_ctime.sec != htonl(st->st_ctime))
>                 changed |= CTIME_CHANGED;
> 
> If you update with --index-info, the mtime and ctime is not updated 
> from the file in the working directory.

Oh, I see. I was under impression git-diff-index does not use mtime/ctime.
Thought it was just mode+sha between treeish and index.
    $ man git-diff-index
       git-diff-index <tree-ish>
              compares the <tree-ish> and the files on the filesystem.
       git-diff-index --cached <tree-ish>
              compares the <tree-ish> and the index.
So it does compare treeish ad index, but only if explicitly told so.
Pity, there seem to be no way to update the times in --index-info
protocol yet. Maybe it'll be even never needed, after cache functions
gone libraries.

> All the more a reason to go forward with direct calls to read_cache() and 
> write_cache(). At the moment, my plan is
> 
> - trivially split the read_cache() code into read_cache()/read_cache_from(),
> - introduce flush_cache(),
> - trivially rewrite add_file_to_cache(), and add_cache_info() from
>   builtin-update-index.c, move that to read-tree.c, too, and
> - throw out the pipe to git-update-index from merge-recursive.c 
>   altogether.
> 
> This should be less intrusive than it sounds: with the introduction of 
> read_cache_from() it should be trivial to handle the problem of different 
> index files.
> 
> We have to put a lock_file on the index file at the start, and write the 
> index file at the end.
> 

Yes, very nice plan, all by itself :)

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Fri, 7 Sep 2007 00:07:31 -0400
Message-ID: <20070907040731.GT18160@spearce.org>
References: <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709061651550.28586@racer.site> <7vk5r3adlx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org> <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 06:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITV8P-0003qO-Kv
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 06:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbXIGEHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 00:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbXIGEHw
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 00:07:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56844 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbXIGEHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 00:07:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1ITV7p-00079V-9M; Fri, 07 Sep 2007 00:07:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6891420FBAE; Fri,  7 Sep 2007 00:07:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57970>

Nicolas Pitre <nico@cam.org> wrote:
> I would have concatenated all packs provided on the command line into a 
> single one, simply by reading data from existing packs and writing it 
> back without any processing at all.  The offset for OBJ_OFS_DELTA is 
> relative so a simple concatenation will just work.
> 
> Then the index for that pack can be created just as easily by reading 
> existing pack index files and storing the data into an array of struct 
> pack_idx_entry, adding the appropriate offset to object offsets, then 
> call write_idx_file().
> 
> All data is read once and written once making it no more costly than a 
> simple file copy.  On the flip side it wouldn't get rid of duplicated 
> objects (I don't know if that matters i.e. if something might break with 
> the same object twice in a pack).

Yea, that's a really quick repack.  :-)  Plus its actually something
that can be easily halted in the middle and resumed later.  Just need
to save the list of packfiles you are concatenating so you can pick
up later when you get more time.

There shouldn't be a problem with having duplicates in the packfile.
You can do one of two things:

  a) Omit the duplicates from the .idx when you merge the .idx tables
     together to produce the new one.  Just take the object with the
	 earliest offset.

  b) Leave the duplicates in the final .idx.  In this case the
     binary search may pick any of them, but it wouldn't matter
     which it finds.

About the only process that might care about duplicates would be
index-pack.  I don't think it makes sense to run index-pack on a
packfile you already have a .idx for.  I don't think it would have
a problem with the duplicate SHA-1s either, but it wouldn't be hard
to make it do something reasonable when it finds them.
 
> > To consolidate all packs that are smaller than a megabytes into
> > one, you would use it in its current form like this:
> > 
> >     $ old=$(find .git/objects/pack -type f -name '*.pack' -size 1M)
> >     $ new=$(echo "$old" | git merge-pack | git pack-objects pack)
> >     $ for p in $old; do rm -f $p ${p%.pack}.idx; done
> >     $ for s in pack idx; do mv pack-$new.$s .git/objects/pack/; done
> 
> You might want to move the new pack before removing the old ones though.

Not might, *must*.  If you delete the old ones before the new
ones are ready then readers can run into problems trying to access
the objects.  We've spent some effort trying to make these sorts
of operations safe.  No sense in destroying that by getting the
order wrong here.  :)

-- 
Shawn.

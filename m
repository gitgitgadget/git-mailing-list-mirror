From: Nicolas Pitre <nico@cam.org>
Subject: Re: Subject: [PATCH] git-merge-pack
Date: Thu, 06 Sep 2007 20:51:58 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709061942320.21186@xanadu.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
 <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709061651550.28586@racer.site>
 <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
 <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 02:52:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITS4u-0000ad-84
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 02:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbXIGAwC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 20:52:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbXIGAwB
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 20:52:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:8455 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964865AbXIGAwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 20:52:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNZ00DG03QM25I0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Sep 2007 20:51:59 -0400 (EDT)
In-reply-to: <7v1wdb9ymf.fsf_-_@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57958>

On Thu, 6 Sep 2007, Junio C Hamano wrote:

> This is a beginning of "git-merge-pack" that combines smaller
> packs into one.  Currently it does not actually create a new
> pack, but pretends that it is a (dumb) "git-rev-list --objects"
> that lists the objects in the affected packs.  You have to pipe
> its output to "git-pack-objects".
> 
> The command reads names of pack-*.pack files from the standard
> input, outputs the objects' names in the order they are stored
> in the original packs (i.e. the offset order).  This sorting is
> done in order to emulate the traversal order the original
> "git-rev-list --objects" that was used to create the existing
> pack listed the objects.
> 
> While this approach would give the resulting packfile very
> similar locality of access as the original, it does not give the
> "name" component you would see in "git-rev-list --objects"
> output.  This information is used as the clustering cue while
> computing delta, and the lack of it means you can get horrible
> delta selection.  You do _not_ want to run the downstream
> "git-pack-objects" without the optimization/heuristics to reuse
> delta.  IOW, do not run it with --no-reuse-delta.

I wonder if this is the best way to go.  In the context of a really fast 
repack happening automatically after (or during) user interactive 
operations, the above seems a bit heavyweight and slow to me.

I would have concatenated all packs provided on the command line into a 
single one, simply by reading data from existing packs and writing it 
back without any processing at all.  The offset for OBJ_OFS_DELTA is 
relative so a simple concatenation will just work.

Then the index for that pack can be created just as easily by reading 
existing pack index files and storing the data into an array of struct 
pack_idx_entry, adding the appropriate offset to object offsets, then 
call write_idx_file().

All data is read once and written once making it no more costly than a 
simple file copy.  On the flip side it wouldn't get rid of duplicated 
objects (I don't know if that matters i.e. if something might break with 
the same object twice in a pack).

> To consolidate all packs that are smaller than a megabytes into
> one, you would use it in its current form like this:
> 
>     $ old=$(find .git/objects/pack -type f -name '*.pack' -size 1M)
>     $ new=$(echo "$old" | git merge-pack | git pack-objects pack)
>     $ for p in $old; do rm -f $p ${p%.pack}.idx; done
>     $ for s in pack idx; do mv pack-$new.$s .git/objects/pack/; done

You might want to move the new pack before removing the old ones though.

> An obvious next steps that can be done in parallel by interested
> parties would be:
> 
>  (1) come up with a way to give "name" aka "clustering cue" (I
>      think this is very hard);

It is, and IMHO not worth it.  If you do it separately from the usual 
pack-objects process you'll perform extra IO and decompression when 
walking tree objects just to reconstruct those paths, becoming really 
slow by the context definition I provided above.

If you really want to do it then the best way might simply to reverse 
your find result above, in order to use pack-objects as if the larger 
packs, i.e. the ones that you don't want to merge, simply had an 
associated .keep file.

In fact, since we want to _also_ perform a repack of loose objects in 
the context of automatic repacking, I wonder why we wouldn't use that 
--unpacked= argument to also repack smallish packs at the same time in 
only one pack-objects pass.  Or maybe I'm missing something?


Nicolas

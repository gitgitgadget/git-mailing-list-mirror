From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Thu, 6 Sep 2007 19:15:58 +0100 (BST)
Message-ID: <alpine.LFD.0.999.0709061906010.5626@evo.linux-foundation.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0709061651550.28586@racer.site>
 <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLv5-0003sw-0H
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 20:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803AbXIFSRa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 14:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754643AbXIFSRa
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 14:17:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54308 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752302AbXIFSR3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 14:17:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l86IG1J5007598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 11:16:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l86IFxt9002020;
	Thu, 6 Sep 2007 11:15:59 -0700
In-Reply-To: <7vk5r3adlx.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.742 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.31__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57922>



On Thu, 6 Sep 2007, Junio C Hamano wrote:
> 
> I thought the whole point of "gc --auto" was to have something
> that does not lose/prune any objects, even the ones that do not
> seem to be referenced from anywhere.  That is why invocations of
> "git gc --auto" do not say --prune as you saw the second patch,
> and the repack command "gc --auto" runs is "repack -d -l"
> instead of "repack -a -d -l", which means that it does run
> git-prune-packed after repacking but not git-prune.

I think "repack -d -l" should be ok from a safety perspective, but I'd 
also like to say that always running it incrementally is going to largely 
suck after a time.

IOW, if you get lots of small incrmental packs, after a while you really 
*do* need to do "git gc" to get the real pack generated.

In the case I saw, James really had hundreds of pack-files. That makes all 
our object lookups suck. Yes, not having loose objects at all is a big 
deal too, and yes, we try to start from the last pack-file we found (for 
the locality that we hope is there), but it's still pretty bad from a 
cache usage standpoint, and when we create a new object, we'll first 
search (in vain) in all the hundreds of pack-files.

So would "git gc --auto" have helped James? I'm sure it would have. But he 
already had lots of pack-files from doing "git fetch/pull", and while 
doing the "git gc --auto" will likely *delay* the point where you need to 
do a full repack, it doesn't make it go away.

We still need to tell people to do a full git gc at some point, or do it 
for them. And the longer you delay doing it, the more expensive it's going 
to get to do and/or the worse the final packing is going to be (especially 
if it ends up reusing non-optimal packing decisions from the smaller 
packs).

So I think the --auto stuff is still worth it, but it's really just 
pushing the pain somewhat further out.

(In the kernel community, if you fetch my tree daily, you really *are* 
going to have hundreds and hundreds of packfiles just from doing that).

So I'd really like us to also remind people to do a *real* and full "git 
gc", not just the incremental ones.

		Linus

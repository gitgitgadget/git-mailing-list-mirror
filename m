From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Creating objects manually and repack
Date: Sat, 5 Aug 2006 01:21:36 -0400
Message-ID: <20060805052135.GA18679@spearce.org>
References: <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org> <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org> <9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com> <9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com> <Pine.LNX.4.64.0608040818270.5167@g5.osdl.org> <9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com> <Pine.LNX.4.64.0608040945070.5167@g5.osdl.org> <9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com> <46a038f90608042115m71adc8ffo77de7940efa847a8@mail.gmail.com> <9e4733910608042212p6bf56224ye0ecf3f06b2840cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 07:21:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Ebf-0005fb-DO
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWHEFVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWHEFVq
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:21:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:19659 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932522AbWHEFVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:21:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9EbS-0005fy-7R; Sat, 05 Aug 2006 01:21:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 325F920FB77; Sat,  5 Aug 2006 01:21:36 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910608042212p6bf56224ye0ecf3f06b2840cf@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24883>

Jon Smirl <jonsmirl@gmail.com> wrote:
> On 8/5/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >On 8/5/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >> > and you're basically all done. The above would turn each *,v file into 
> >a
> >> > *-<sha>.pack/*-<sha>.idx file pair, so you'd have exactly as many
> >> > pack-files as you have *,v files.
> >>
> >> I'll end up with 110,000 pack files.
> >
> >Then just do it every 100 files, and you'll only have 1,100 pack
> >files, and it'll be fine.
> 
> This is something that has to be tuned. If you wait too long
> everything spills out of RAM and you go totally IO bound for days. If
> you do it too often you end up with too many packs and it takes a day
> to repack them.
> 
> If I had a way to pipe the all of the objects into repack one at a
> time without repack doing multiple passes none of this tuning would be
> necessary. In this model the standalone objects never get created in
> the first place. The fastest IO is IO that has been eliminated.

I'm almost done with what I'm calling `git-fast-import`.  It takes
a stream of blobs on STDIN and writes the pack to a file, printing
SHA1s in hex format to STDOUT.  The basic format for STDIN is a 4
byte length (native format) followed by that many bytes of blob data.
It prints the SHA1 for that blob to STDOUT, then waits for another
length.

It naively deltas each object against the prior object, thus it
would be best to feed it one ,v file at a time working from the most
recent revision back to the oldest revision.  This works well for
an RCS file as that's the natural order to process the file in.  :-)

When done you close STDIN and it'll rip through and update the pack
object count and the trailing checksum.  This should let you pack
the entire repository in delta format using only two passes over the
data: one to write out the pack file and one to compute its checksum.


I'll post the code in a couple of hours.

-- 
Shawn.

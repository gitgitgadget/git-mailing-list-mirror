From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] [RFC] Generational repacking
Date: Thu, 07 Jun 2007 14:28:20 +1200
Message-ID: <46676D44.7070703@vilain.net>
References: <11811281053874-git-send-email-sam.vilain@catalyst.net.nz> <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 04:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw7jh-0002h8-Ip
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 04:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965411AbXFGC21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 22:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965412AbXFGC21
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 22:28:27 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48377 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965411AbXFGC20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 22:28:26 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 8A50B1574B8; Thu,  7 Jun 2007 14:28:24 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id EA9B413A4EA;
	Thu,  7 Jun 2007 14:28:20 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <56b7f5510706061704r34692c49v994ff368bbc12d05@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49343>

Dana How wrote:
> This patch complicates git-repack.sh quite a bit and
> I'm unclear on what _problem_ you're addressing.

The problem is simple, and it is partially in the eye of the beholder.

That is;

  1. without repacking, you get a lot of loose objects.
     - unnecessary disk space usage
     - bad performance on many OSes

  2. repack takes too long to run very regularly; it's an occasional
     command.

  3. the perception that git repositories are not maintenance free.

What I'm aiming for is something which is light enough that it might
even win back the performance loss you got from 1), and to solve the
perception problem of 3).

Much as users who don't like automatic database maintenance turn it off
and run it at the best time, advanced git users will want to disable
this feature in ~/.gitrc and run repack themselves when it suits them,
or via cron or whatever.  Or it's disabled by default and users that
whine get told to turn it on, it really doesn't matter.  I can already
do it with a commit hook, so I'm quite happy.

> The recent LRU preferred pack patch
> reduces much of the value in keeping a repository tidy
> ("tidy" == "few pack files").

Great, that is a good thing.

Pack files are an almost indistinguishable concept from database
partitions.  In terms of that, scaling problems with lots of partitions
can be managed, certainly.

For instance with database partitioning you would expect your query
planner (in this case, read_packed_sha1()) to be able to select the
right partition (pack) to go to first to avoid excessive index lookups.
 That a strategy for picking the best pack quickly N% of the time exists
for git is an excellent measure to reduce the impact of a large number
of pack files.  I think you would probably find measurable wins by
ensuring that the gross number of packs is kept limited.

Consider that I'm thinking of running this generational repack somewhere
such as a commit hook, if it found >100 loose objects, so that the first
generation repack is very quick and doesn't annoy me - and the second
generation will similarly be fairly quick as many deltas will already be
computed.  The exact behaviour will probably require tuning to get a
good balance between good delta computation and minimal interruption to
commit flow.  Someone on IRC floated the idea of making the first
generation do no delta computation to make it lightning fast.

Note that if you had 3 pack generations, only the first two levels will
ever be repacked - you'll end up with an unlimited number of third
generation packs, which will also end up in LRP* order.

> Already git-gc calls git-repack -a -d.  How do you plan to change this?
> I wonder if you should be making git-gc more intelligent instead.
> 
> Also,  you introduce a new pack properties file (.gen) which seems
> awkward to me.

This implementation is a simple demonstration of the logic which was
designed to communicate the idea and stimulate discussion.  I think the
logic could probably go elsewhere too, and yes the new file is a bit of
a hack.

It might be better to base the "generation" assessment of the file on
the actual size of the pack, for instance - ie, Instead of the number of
loose objects, the size of the loose objects, call 1st generation = <1MB
pack, 2nd generation = <5MB, etc.  When the combined size of 1st
generation packs gets above 5MB then that generation is full and a new
2nd generation pack is made.  Then no state file is required.

> Perhaps something like this would be useful on a huge repository
> under active use.  But delta re-use makes full repacking quite quick for
> a reasonably-sized repository already,  and I don't see this being very useful
> for a repository which is large due to large objects.

I agree with your point of view, however I think if the feature is out
there but disabled by default then this can be found through experience.
 As you can see all of the elements to implement it are already there -
and as you mention, combining packs is already quick.

Sam.

* Last Recently Packed ;)

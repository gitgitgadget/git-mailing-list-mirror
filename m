From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Mon, 11 Aug 2008 08:01:50 -0700
Message-ID: <20080811150150.GC26363@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ken Pratt <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 17:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSYv8-0003oV-MO
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 17:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYHKPBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 11:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYHKPBv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 11:01:51 -0400
Received: from george.spearce.org ([209.20.77.23]:40631 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbYHKPBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 11:01:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8C79538375; Mon, 11 Aug 2008 15:01:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91941>

Ken Pratt <ken@kenpratt.net> wrote:
> I just went as low as:
> 
> [core]
>         packedGitWindowSize = 1m
>         packedGitLimit = 4m
> [pack]
>         threads = 1
>         windowMemory = 4m
>         deltaCacheSize = 128k
> 
> And it didn't make a dent in memory usage. Server is still swapping
> within ~10 seconds of starting object compression.
> 
> I'm starting to think repacking is just not feasible on a 64-bit
> server with 256MB of RAM (which is a very popular configuration in the
> VPS market).

What is the largest object in that repository? Do you have a
rough guess?  You said earlier:

> The remote repository is bare, and is 180MB in size (says du), with
> 1824 objects.

That implies there is at least one really large object in that
repository.  The average of 101KB per object is not going to be
a correct figure here as most commits and trees are _very_ tiny.
It must be a large object.  Those big objects are going to consume
a lot of memory if they get inflated in memory.

You may very well be right that this particular repository of
yours is simply not packable on a 64 bit system with only 256M.
Packing takes a good chunk of memory as we maintain data about
every single object, plus we need working space to unpack several
objects at once so we can perform diffs to find deltas.

I'm not sure there are any more tunables you can try to tweak to
reduce the memory usage further.  The configuration above is pushed
down about as low as it will go.  For the most part the code is
pretty good about not exploding memory usage.

You said earlier this was Git 1.5.6.4.  I recently fixed a bug in
the code that reads data from packs to prevent it from blowing out
memory usage, but that bug fix was included in 1.5.6.4.


On the up side, packing should only be consuming huge memory like
this when it needs to move loose objects into a pack file.  I think
Martin Langhoff suggested packing this on your laptop then using
rsync over SSH to copy the pack file and .idx file to the server, so
the server didn't have to spend time figuring out the deltas itself.

Even though the clone command will fire off git-pack-objects the
pack-objects command will have a lot less work to do if the data
it needs is already stored in existing pack files.

-- 
Shawn.

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 22:42:12 -0700
Message-ID: <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
	<7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
	<20061028034206.GA14044@spearce.org>
	<Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 05:42:24 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 27 Oct 2006 21:18:07 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30365>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdgxW-0007Ko-2a for gcvg-git@gmane.org; Sat, 28 Oct
 2006 07:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751848AbWJ1FmO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 01:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWJ1FmO
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 01:42:14 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11935 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1751848AbWJ1FmN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 01:42:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028054213.MFUF18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sat, 28
 Oct 2006 01:42:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fhhu1V00Y1kojtg0000000 Sat, 28 Oct 2006
 01:41:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 27 Oct 2006, Shawn Pearce wrote:
>> 
>> So a reader-writer lock is preferred over
>> a non-locking solution such as I posted in
>> http://article.gmane.org/gmane.comp.version-control.git/30288 ?
>> 
>> Not to mention that such a solution would also fix the -d issue
>> Linus points out above.
>
> Be very careful.
>
> There's a good reason why git doesn't use locking, and tends to use the 
> "create file exclusively and move over the old version after having tested 
> that the old version is still relevant" approach.
>
> Two _major_ issues:
>...
>
> I would MUCH rather we just rename the index/pack file to something that 
> git can _use_, but that "git repack -a -d" won't remove....

Two points.

The "locking" I mentioned was between receive-pack and repack -a
-d; upload-pack (what millions people are using to read from the
repository you are pushing into) is not affected.  So in that
sense, we can afford to use lock without much contention.

I just thought of a cute hack that does not involve renaming
packs at all (so no need to match new-pack-X.pack with
pack-X.idx), and Shawn's sequence actually would work, which is:

The receive-pack side:

  a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
  b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
  c. Write pack and index, in "inactive" state.
  d. Move pack to $GIT_DIR/objects/pack/...
  e. Move idx to $GIT_DIR/objects/pack...
  f. Update refs.
  g. Mark new pack and idx as "active".

The "repack -a -d" side:

  1. List all active packs and store in memory.
  2. Repack only loose objects and objects contained in active packs.
  3. Move new pack and idx into $GIT_DIR/objects/pack/...
  4. Mark new pack and idx as "active".
  5. Delete active packs found by step #1.

Pack-idx pair is marked "active" by "chmod u+s" the .pack file.
During the normal operation, all .pack/.idx pair in objects/pack/
directories are usable regardless of the setuid bit; we would
never make .pack files executable so u+s would not otherwise
hurt us either.  "active" probably is better read as "eligible
for repacking".



X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 14:53:59 -0700
Message-ID: <7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 21:54:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610271310450.3849@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 27 Oct 2006 13:22:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30349>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdZeR-0007NG-U1 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 23:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750709AbWJ0VyE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 17:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWJ0VyE
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 17:54:04 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10147 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1750705AbWJ0VyB
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 17:54:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027215400.HWBD22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 17:54:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fZti1V00F1kojtg0000000 Fri, 27 Oct 2006
 17:53:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> We really should _never_ create a pack in-place with the final name.

The "fattening" index-pack Nico did does not have this problem
as far as I can see.  Under --stdin, it creates a temporary pack
file "$GIT_OBJECT_DIRECTORY/pack_XXXXXX"; after the received
pack is fattened by adding missing delta-base objects and fixing
up the pack header, final() moves the {pack,idx} pair to the
final location.

The race is about this sequence:

	- git-receive-pack is spawned from remove git-send-pack;
          it lets "index-pack --stdin --fatten" to keep the pack.

	- index-pack does its magic and moves the pack and idx
          to their final location;

	- "repack -a -d" is started by somebody else; it first
          remembers all the existing packs; it does the usual
          repacking-into-one.

	- git-receive-pack that invoked the index-pack waits for
          index-pack to finish, and then updates the refs;

	- "repack -a -d" is done repacking; removes the packs
          that existed when it checked earlier.

Two instances of receive-pack running simultaneously is safe (in
the sense that it does not corrupt the repository; one instance
can fail after noticing the other updated the ref it wanted to
update) and there is no reason to exclude each other.  But
"repack -a -d" and receive-pack are not.

Can we perhaps have reader-writer lock on the filesystem to
pretect the repository?  "prune" can also be made into a writer
for that lock and "fetch-pack --keep" would be a reader for the
lock.  That reader-writer lock would solve the issue rather
nicely.

> That said, I think some of the "git repack -d" logic is also unnecessarily 
> fragile.

Noted; will fix.

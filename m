X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 21:09:34 -0700
Message-ID: <7vd58daxoh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
	<7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
	<20061028034206.GA14044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 04:09:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061028034206.GA14044@spearce.org> (Shawn Pearce's message of
	"Fri, 27 Oct 2006 23:42:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30361>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdfVr-0008CZ-3A for gcvg-git@gmane.org; Sat, 28 Oct
 2006 06:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751431AbWJ1EJg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 00:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWJ1EJg
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 00:09:36 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:4244 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1751431AbWJ1EJf
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 00:09:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028040935.QRFR6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Sat, 28
 Oct 2006 00:09:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fg9G1V00l1kojtg0000000 Sat, 28 Oct 2006
 00:09:17 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> So a reader-writer lock is preferred over
> a non-locking solution such as I posted in
> http://article.gmane.org/gmane.comp.version-control.git/30288 ?

If you mean these two in your message to be "solution":

   So the receive-pack process becomes:

     a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
     b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
     c. Write pack and index.
     d. Move pack to $GIT_DIR/objects/pack/...
     e. Move index to $GIT_DIR/objects/pack...
     f. Update refs.
     g. Arrange for new pack and index to be considered active.

   And the repack -a -d process becomes:

     1. List all active packs and store in memory.
     2. Repack only loose objects and objects contained in active packs.
     3. Move new pack and idx into $GIT_DIR/objects/pack/...
     4. Arrange for new pack and idx to be considered active.
     5. Delete active packs found by step #1.

I am not so sure how it solves anything at all.

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

Now, I am not sure what your plan to "arrange for new pack and
idx to be considered active" is.  Care to explain?

There is a tricky constraints imposed on us by (arguably broken)
commit walkers in that it relies on the (arguably broken)
sha1_file.c:sha1_pack_name() interface, so naming historical
ones $GIT_OBJECT_DIR/pack/hist-X{40}.pack would not work; we
would need to fix commit walkers for that first.




X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 04:13:43 -0400
Message-ID: <20061027081343.GE29057@spearce.org>
References: <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <4541850B.8060608@tromer.org> <20061027044233.GA29057@spearce.org> <81b0412b0610270042w29279b90t7c94d8590d701519@mail.gmail.com> <20061027075229.GD29057@spearce.org> <81b0412b0610270108t7b93d04y2c99be20b7f41387@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 08:14:22 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <81b0412b0610270108t7b93d04y2c99be20b7f41387@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30305>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMqi-0000Ie-AP for gcvg-git@gmane.org; Fri, 27 Oct
 2006 10:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946230AbWJ0INx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 04:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946239AbWJ0INx
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 04:13:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50106 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1946230AbWJ0INw
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 04:13:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdMqm-0002C8-PG; Fri, 27 Oct 2006 04:14:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6749220E45B; Fri, 27 Oct 2006 04:13:44 -0400 (EDT)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <raa.lkml@gmail.com> wrote:
> >>>So the receive-pack process becomes:
> >>>
> >>> a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
> >>>b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
> >>
> >>Why not $GIT_DIR/objects/tmp/pack... and ignore it everywhere?
> >
> >Because there is a race condition.
> 
> Oh, right. Incidentally, is there a lockfile for packs?

No, we have never needed them before.  And I think we'd like to
avoid adding them now.

We do have the rule that a pack can only be accessed if its .idx
file exists; therefore we generate a pack and its index, then place
the pack into the object directory, then the index.  That way the
pack is there before the index but another process won't attempt
to read the pack until the index exists.  It also means we should
never put an index into the pack directory before its associated
pack.  :-)

If we are pruneing packs or loose objects after the repack we delete
only after the pack and index are in place.  Running processes
rescan the existing packs once if they look for an object and
cannot find it in the loose objects directory or in the packs it
already knows about; this lets most running processes automatically
recover should a parallel repack delete the loose objects it needs
(as they were just packed).

-- 

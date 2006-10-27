X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 03:52:29 -0400
Message-ID: <20061027075229.GD29057@spearce.org>
References: <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <4541850B.8060608@tromer.org> <20061027044233.GA29057@spearce.org> <81b0412b0610270042w29279b90t7c94d8590d701519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 07:53:35 +0000 (UTC)
Cc: Eran Tromer <git2eran@tromer.org>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <81b0412b0610270042w29279b90t7c94d8590d701519@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30301>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdMWk-0004R3-Cu for gcvg-git@gmane.org; Fri, 27 Oct
 2006 09:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946232AbWJ0Hwk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 03:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946233AbWJ0Hwk
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 03:52:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:7352 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1946232AbWJ0Hwj
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 03:52:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdMWD-0001AP-QF; Fri, 27 Oct 2006 03:52:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 62E2020E45B; Fri, 27 Oct 2006 03:52:29 -0400 (EDT)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <raa.lkml@gmail.com> wrote:
> >So the receive-pack process becomes:
> >
> > a. Create temporary pack file in $GIT_DIR/objects/pack_XXXXX.
> >b. Create temporary index file in $GIT_DIR/objects/index_XXXXX.
> 
> Why not $GIT_DIR/objects/tmp/pack... and ignore it everywhere?

Because there is a race condition.

The contents of the new pack must be accessable as a normal pack
before we update and unlock the refs that are being changed.  This
means it must be a normal pack in $GIT_DIR/objects/pack.

Currently all packs under $GIT_DIR/objects/pack are deleted during
`repack -a -d`.  Those packs may have been added to that directory
after the repack started resulting in them getting deleted when
the repack completes, but with none of their contained objects in
the newly created pack.  Thus the repository is suddenly missing
everything that was just pushed (or fetched).

-- 

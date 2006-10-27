X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 23:00:54 -0400
Message-ID: <20061027030054.GB28407@spearce.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 03:01:20 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45417205.6020805@tromer.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30283>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdHy1-0001mJ-FM for gcvg-git@gmane.org; Fri, 27 Oct
 2006 05:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161441AbWJ0DBF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 23:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161475AbWJ0DBF
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 23:01:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48280 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161441AbWJ0DBC
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 23:01:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GdHxc-0008HN-VT; Thu, 26 Oct 2006 23:00:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0135E20E45B; Thu, 26 Oct 2006 23:00:54 -0400 (EDT)
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

Eran Tromer <git2eran@tromer.org> wrote:
> > Unfortunately I don't have a solution.  I tried to come up with
> > one but didn't.  :-)
> 
> Here's one way to do it.
> Change git-repack to follow references under $GIT_DIR/tmp/refs/ too.
> To receive or fetch a pack:
> 1. Add references to the new heads in
>    `mktemp $GIT_DIR/tmp/refs/XXXXXX`.
> 2. Put the new .pack under $GIT_DIR/objects/pack/.
> 3. Put the new .idx under $GIT_DIR/objects/pack/.
> 4. Update the relevant heads under $GIT_DIR/refs/.
> 5. Delete the references from step 1.
> 
> This is repack-safe and never corrupts the repo. The worst-case failure
> mode is if you die before cleaning the refs from $GIT_DIR/tmp/refs. That
> may mean some packed objects will never be removed by "repack -a -d"
> even if they lose all references from $GIT_DIR/refs, so do "tmpwatch -m
> 240 $GIT_DIR/tmp/refs" to take care of that.

That was actually my (and also Sean's) solution.  Except I would
put the temporary refs as "$GIT_DIR/refs/ref_XXXXXX" as this is
less code to change and its consistent with how temporary loose
objects are created.

Unfortunately it does not completely work.

What happens when the incoming pack (steps #2 and #3) takes 15
minutes to upload (slow ADSL modem, lots of objects) and the
background repack process sees those temporary refs and starts
trying to include those objects?  It can't walk the DAG that those
refs point at because the objects aren't in the current repository.

From what I know of that code the pack-objects process will fail to
find the object pointed at by the ref, rescan the packs directory,
find no new packs, look for the object again, and abort over the
"corruption".

OK so the repository won't get corrupted but the repack would be
forced to abort.


Another issue I just thought about tonight is we may need a
count-packs utility that like count-objects lists the number
of active packs and their total size.  If we start hanging onto
every pack we receive over the wire the pack directory is going to
grow pretty fast and we'll need a way to tell us when its time to
`repack -a -d`.

-- 

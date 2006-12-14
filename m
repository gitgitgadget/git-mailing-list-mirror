X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 07:00:28 -0500
Message-ID: <20061214120028.GK1747@spearce.org>
References: <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com> <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de> <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 12:00:48 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34325>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GupGO-0000xU-K0 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 13:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932674AbWLNMAe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 07:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWLNMAe
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 07:00:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37254 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932674AbWLNMAd (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 07:00:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GupGE-0000zM-AH; Thu, 14 Dec 2006 07:00:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7102B20FB65; Thu, 14 Dec 2006 07:00:28 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> What it the relation between git-merge-recursive and "git-read-tree
> -m" (if any)? I currently still use "git-read-tree -m" for some merges
> because of the speed gain due to the --agressive option (really
> noticeable when picking a patch from an older branch). Probably
> git-merge-recursive cannot implement this since it needs to track
> deletion/additions for rename detection.

There is a difference; always has been, probably will be for a
long time.

read-tree -m performs some trivial merges in the index.  Its manual
page explains it in gory detail, but its the really trivial, basic
three way merge rules: Given two trees X and Y and some so-called
base B:

 * If X == Y == B for that file, take any of the three.
 * If X == Y, but not B, take X or Y.
 * If X changes a file, but Y == B for that file, take X.
 * If Y changes a file, but X == B for that file, take Y.

I believe that the --agressive option has added some additional
rules about trivial file deletes.  However notice the all important
rule is not handled by read-tree -m:

 * If X changes a file, Y also changes file, merge them to create Z.

This is where read-tree -m punts and hands things off to
merge-recursive, which needs to invoke diff3 (or now the internal
xdl_merge).  read-tree -m also currently does not handle file
additions, mode changes, or renames/copies.  All of which are a
lot more expensive to compute and are slightly less common.

So Git gets decent performance by going through the rather cheap
read-tree -m, then falling back into the slower merge-recursive
when read-tree -m punted.  Given that I see about 50% of my merges
succeed with just read-tree -m and the other half punt over to
merge-recursive it just about balances out over several merges.

> Are there any other things to be aware if I completely replace the
> "git-read-tree + diff3" with git-merge-recursive?

From what I understand git-merge-recursive will do everything that
git-read-tree -m will do, except its going to be slower doing the
really common, stupid cases that git-read-tree -m can handle on
its own.

-- 

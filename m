X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Teach git-index-pack how to keep a pack file.
Date: Sun, 29 Oct 2006 11:14:24 -0800
Message-ID: <7vr6wr0wa7.fsf@assigned-by-dhcp.cox.net>
References: <20061029094159.GE3847@spearce.org> <ei210e$dfs$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 19:14:49 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ei210e$dfs$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	29 Oct 2006 11:49:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30440>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeG73-0004Tb-AE for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:14:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965325AbWJ2TO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJ2TOZ
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:14:25 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42422 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S932353AbWJ2TOZ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:14:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029191424.OWCC22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 14:14:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gKEU1V00R1kojtg0000000 Sun, 29 Oct 2006
 14:14:29 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Wouldn't it be better to use 'git-index-pack', perhaps with source URL if
> possible, as the default 'why'?

I think it is sensible that Shawn did keep="reason" because
git-index-pack usually cannot decide.  .keep would be around for
at least three reasons:

 - you as the repository owner want to keep the pack from
   repacked because that is the big "initial clone" pack;

 - somebody fetched with --keep and index-pack created .keep
   flag, but somehow the fetch-pack after updating the refs
   failed to remove the flag (or has not finished);

 - somebody pushed into the repository with --keep but somehow
   the receive-pack after updating the refs failed to remove the
   flag (or has not finished);

For a shared repository settings, the person who cares about .keep
is the person who logged onto the machine with the repository and
ran "clone" (or "init-db && fetch-pack") to prepare the initial
state, and fetching would be done by smaller group of people
than pushing into it.  So these three kinds need to be easily
distinguishable by the repository owner.  The first kind would
not be usually removed; the second one the owner is likely to
know if that fetch is still running, and if it is known that
fetch is not running then .keep should probably be removed.  The
third kind is harder to tell if it is safe to remove .keep
because usually more people can push into it than fetch into it.

It might be a good idea to leave process ID of the caller of the
index-pack as part of --keep="reason" string, along with the
timestamp to help the user decide if the .keep is leftover or
still in progress (the timestamp can be seen from ls -l *.keep
so it is not strictly needed).





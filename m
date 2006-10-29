X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Sat, 28 Oct 2006 21:29:34 -0700
Message-ID: <7vejsr68y9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610271310450.3849@g5.osdl.org>
	<7v3b99e87c.fsf@assigned-by-dhcp.cox.net>
	<20061028034206.GA14044@spearce.org>
	<Pine.LNX.4.64.0610272109500.3849@g5.osdl.org>
	<7vwt6l9etn.fsf@assigned-by-dhcp.cox.net>
	<20061028072146.GB14607@spearce.org>
	<20061028084001.GC14607@spearce.org>
	<7vfyd88d6s.fsf@assigned-by-dhcp.cox.net>
	<20061029035025.GC3435@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 04:29:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061029035025.GC3435@spearce.org> (Shawn Pearce's message of
	"Sat, 28 Oct 2006 23:50:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30412>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge2Ip-000652-Rs for gcvg-git@gmane.org; Sun, 29 Oct
 2006 05:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964998AbWJ2E3h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 00:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWJ2E3h
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 00:29:37 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46332 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S964998AbWJ2E3g
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 00:29:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029042935.TODV12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 00:29:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id g4Vf1V00C1kojtg0000000 Sun, 29 Oct 2006
 00:29:40 -0400
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> The issue is --unpacked= uses the path of the pack name, which
> includes $GIT_OBJECT_DIRECTORY, whatever that may be.  This makes it
> impossible for the shell script to hand through a proper --unpacked=
> line for the active packs without including $GIT_OBJECT_DIRECTORY
> as part of the option.

Yeah, I realize that; you need to know how to build shell script
that is properly shell quoted to be eval'ed, which is not hard
but is not usually done and is cumbersome.

I would suspect it is probably easier to just say --unpacked
(without packname) means "unpacked objects, and objects in packs
that do not have corresponding .keep".  However, that would be a
change in semantics for --unpacked (without packname), which is
not nice.

So how about pack-X{40}.volatile that marks an eligible one for
repacking?

Then we can make "pack-objects --unpacked" to pretend the ones
with corresponding .volatile as if the objects in them are
loose, without breaking backward compatibility.

> However on the git.git repository if I ran `git repack -a -d`
> with every single object in a kept pack and no loose objects I
> kept repacking the same 102 objects into a new active pack,
> even though there were no loose objects to repack and no
> active packs.  Uh, yea.

Will take a look myself if you are otherwise busy.

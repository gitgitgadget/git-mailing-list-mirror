X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] send-pack --keep: do not explode into loose objects on the receiving end.
Date: Sun, 29 Oct 2006 01:05:37 -0700
Message-ID: <7vslh74kdq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<7vwt6j4l77.fsf@assigned-by-dhcp.cox.net>
	<20061029075638.GB3847@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 08:05:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061029075638.GB3847@spearce.org> (Shawn Pearce's message of
	"Sun, 29 Oct 2006 02:56:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30419>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge5fy-0000Jc-QP for gcvg-git@gmane.org; Sun, 29 Oct
 2006 09:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965140AbWJ2IFj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 03:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWJ2IFj
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 03:05:39 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59864 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S965140AbWJ2IFi
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 03:05:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029080538.EHDY12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 03:05:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id g85i1V00B1kojtg0000000 Sun, 29 Oct 2006
 03:05:42 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> I was thinking of just reading the pack header in receive-pack,
> checking the object count, and if its over a configured threshold
> call index-pack rather than unpack-objects.  Unfortunately I just
> realized that if we read the pack header to make that decision then
> its gone and the child process won't have it.  :-(

If you want to do that, that is certainly possible.

You can read the first block in the parent (without discarding),
make the decision and then fork()+exec() either unpack-objects
or index-pack and feed it from the parent.  The parent first
feeds the initial block it read to make that decision, and then
becomes a cat that reads from send-pack and writes to the child
process that is either unpack-objects or index-pack.

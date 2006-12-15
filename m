X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fetch slow as molasses due to tag downloading
Date: Fri, 15 Dec 2006 13:55:13 -0800
Message-ID: <7vtzzwn7su.fsf@assigned-by-dhcp.cox.net>
References: <elrr8j$a02$1@sea.gmane.org>
	<Pine.LNX.4.63.0612141701440.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:56:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34561>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL2P-0006er-G4 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965191AbWLOVzX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWLOVzW
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38542 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965195AbWLOVzP (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215514.IBZC18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vS1V0061kojtg0000000; Fri, 15 Dec 2006
 16:55:26 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> IMHO this should be solved as a filter: "git-show-ref --stdin 
> --show-invalid". Thus, git does not have to traverse _every_ ref for 
> _every_ incoming tag.

That sounds like a too specialized hack to me.  We should first
speed up the general "--verify $ref" case; as you corrected me
earlier it still has a useless loop.

If it is still too slow (which I suspect it could be the case,
with fork+exec overhead), we should _also_ pursue the filter
approach, but even then I think "filter out the valid ones" is a
specialized hack, if you mean "show only the invalid one's
names" by --show-invalid.

It would make sense to do

        $ git show-ref --show-invalid v1.0.0 v2.6.18
        f665776185ad074b236c00751d666da7d1977dbe refs/tags/v1.0.0
        - refs/tags/v2.6.18

(and its equivalent to take refs from --stdin) though.


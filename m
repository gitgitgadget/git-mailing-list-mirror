X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] allow deepening of a shallow repository
Date: Fri, 17 Nov 2006 03:35:58 -0800
Message-ID: <7vu00ymhk1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611141150010.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7qaqw12.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611171050440.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 11:36:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611171050440.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 17 Nov 2006 10:52:54 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31691>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl215-0003ag-VI for gcvg-git@gmane.org; Fri, 17 Nov
 2006 12:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933533AbWKQLgB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 06:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932877AbWKQLgA
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 06:36:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:61848 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S933533AbWKQLf7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 06:35:59 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117113559.PVUF18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 06:35:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nnc51V00U1kojtg0000000; Fri, 17 Nov 2006
 06:36:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Although I am reasonably sure we can eventually make it work, it
>> is very subtle and fragile -- somebody touching this code can
>> easily break it.
>
> I fully agree. Even the OA did not understand the code fully ;-)
>
> How about adding "int force_reparse" to the signature of 
> unregister_shallow()? (Just like we added "int cleanup" to 
> get_merge_bases() to avoid pilot errors.)

I do not think that's where its fragility lies.  It is that any
random place can later call parse_object() on the commit, after
you elaborately pre-parsed it with shallow so that it appears to
have fewer parents, with the expectation that nobody ever would
clear the parsed bit and cause it to be reparsed again.  With
that assumption, find_common() manipulated the shallow entry
after setting that scheme up.  A mechanism to prevent the commit
from getting re-parsed would have made it more robust.

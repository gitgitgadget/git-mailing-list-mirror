X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] allow deepening of a shallow repository
Date: Fri, 17 Nov 2006 01:09:45 -0800
Message-ID: <7vy7qaqw12.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610302009390.26682@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7qeze0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611141150010.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 09:10:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611141150010.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 14 Nov 2006 12:03:39 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31678>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkzjX-0002L9-0i for gcvg-git@gmane.org; Fri, 17 Nov
 2006 10:10:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755574AbWKQJJr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 04:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbWKQJJr
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 04:09:47 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:24775 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1755573AbWKQJJq
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 04:09:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117090945.EOGC20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 04:09:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nl9s1V0041kojtg0000000; Fri, 17 Nov 2006
 04:09:52 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes. Somehow, an important part of unregister_shallow() went missing (yet 
> another proof that my poor-man's-StGit does not always work). I think that 
> the "object->parsed = 0;" should go into unregister_shallow() like this:

That does not fly so well.  Your fetch-pack.c does this in
find_common() and dropping the parsed flag inside unregister
causes it to be parsed again later with its true parents, which
defeats what the commented part of the code wanted to do.

	if (!lookup_object(sha1))
		die("object not found: %s", line);
	/* make sure that it is parsed as shallow */
	parse_object(sha1);
	if (unregister_shallow(sha1))
		die("no shallow found: %s", line);
	continue;

Although I am reasonably sure we can eventually make it work, it
is very subtle and fragile -- somebody touching this code can
easily break it.
.

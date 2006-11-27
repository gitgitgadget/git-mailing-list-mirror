X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Idea for rebase strategy
Date: Mon, 27 Nov 2006 00:33:54 -0800
Message-ID: <7vfyc5l24t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0611270108160.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 08:34:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611270108160.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 27 Nov 2006 01:15:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32390>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gobw7-0006CF-KW for gcvg-git@gmane.org; Mon, 27 Nov
 2006 09:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757386AbWK0Id5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 03:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757393AbWK0Id5
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 03:33:57 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:34467 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1757386AbWK0Id4
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 03:33:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127083355.PWSD5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Mon, 27
 Nov 2006 03:33:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rka41V0011kojtg0000000; Mon, 27 Nov 2006
 03:34:04 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> an idea hit me today: maybe we can make rebase work nicely with merges 
> after all. We could record the original branch point and the new branch 
> point for rebases.

One case that that would be simple enough, appear often enough
in real life, and would be useful in practice is this:

       A---B---C---D---E topic
      /       /
  ---X---o---Y---Z master

After forking 'topic' at 'X' and built two commits A and B, the
master has a related change in the area 'topic' works on, and a
merge to adjust is made at C.  Then it builds two other commits
D and E.  We should be able to rebase it on top of the master.

If we have a reliable ref-log for 'topic' that should be trivial
to do.  It will be just the matter of replaying the log on top
of master.  The ref-log says we committed two after we forked,
so we replay them:

       A---B---C---D---E topic
      /       /
  ---X---o---Y---Z master
                  \
                   A'--B'

Then the log says we merged 'Y'.  We faithfully replay that,
which wuold result in "fast-forward -- nothing special is
needed" situation.  The remaining log entries would say we have
two further commits, so replaying them would result in:

       A---B---C---D---E topic
      /       /
  ---X---o---Y---Z master
                  \
                   A'--B'--C'--D' topic'


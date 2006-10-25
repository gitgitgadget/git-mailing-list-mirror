X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] gitweb: Filter out commit ID from @difftree in git_commit and git_commitdiff
Date: Tue, 24 Oct 2006 21:36:26 -0700
Message-ID: <7v1woxf1v9.fsf@assigned-by-dhcp.cox.net>
References: <200610241349.54685.jnareb@gmail.com>
	<200610241354.49396.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 04:36:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610241354.49396.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 24 Oct 2006 13:54:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30029>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcaVD-0000Ri-9s for gcvg-git@gmane.org; Wed, 25 Oct
 2006 06:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422953AbWJYEg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 00:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422956AbWJYEg2
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 00:36:28 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:46576 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1422953AbWJYEg1
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 00:36:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061025043626.KOOL28934.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Wed, 25
 Oct 2006 00:36:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id eUc91V01m1kojtg0000000 Wed, 25 Oct 2006
 00:36:10 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Filter out commit ID output that git-diff-tree adds when called with
> only one <tree-ish> (not only for --stdin) in git_commit and
> git_commitdiff.

I initially wondered why this, or other existing such sripping,
is necessary in the first place.

The collected result is given to git_difftree_body() and it
feeds parse_difftree_raw_line() with it.  Interestingly enough,
it _is_ prepared to handle the line with the commit object
name.

However, the very initial part of git_difftree_body assumes that
the array it gets does not have the commit object name (i.e. it
counts the array members and says "N files changed").

So I think your change is probably a good one, but I suspect you
probably are better off to make parse_difftree_raw_line() to
barf when it gets the commit object name to make sure that all
callers strip it at the same time; better yet, perhaps you can
have a single function that invokes git-diff-tree -r (with
different parameters) and returns the result that is already
only the difftree body lines?

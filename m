X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 12:41:38 -0800
Message-ID: <7v8xha2osd.fsf@assigned-by-dhcp.cox.net>
References: <200612141340.43925.andyparkins@gmail.com>
	<200612141518.05770.andyparkins@gmail.com>
	<458171B7.1020702@xs4all.nl>
	<200612141620.17782.andyparkins@gmail.com>
	<Pine.LNX.4.63.0612141732410.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 20:41:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34395>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuxOi-0004EA-6X for gcvg-git@gmane.org; Thu, 14 Dec
 2006 21:41:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932907AbWLNUll (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 15:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932902AbWLNUlk
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 15:41:40 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51834 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932904AbWLNUlj (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 15:41:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214204139.PHCT15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 15:41:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ykhq1V00M1kojtg0000000; Thu, 14 Dec 2006
 15:41:50 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> git-show-ref traverses every single _local_ tag when called. This is to 
> overcome the problem that tags can be packed now, so a simple file 
> existence check is not sufficient.

Is "traverses every single _local_ tag" a fact?  It might go
through every single _local_ (possibly stale) packed tag in
memory but it should not traverse $GIT_DIR/refs/tags.

If I recall correctly, show-ref (1) first checks the filesystem
"$GIT_DIR/$named_ref" and says Ok if found and valid; otherwise
(2) checks packed refs (reads $GIT_DIR/packed-refs if not
already).  So that would be at most one open (which may fail in
(1)) and one open+read (in (2)).  Unless we are talking about
fork+exec overhead, that "traverse" should be reasonably fast.

Where is the bottleneck?

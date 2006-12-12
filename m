X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Adding a new file as if it had existed
Date: Tue, 12 Dec 2006 10:31:16 -0800
Message-ID: <7vzm9tuft7.fsf@assigned-by-dhcp.cox.net>
References: <7ac1e90c0612120205k38b2fc14jbfd8ea682406efb2@mail.gmail.com>
	<7vhcw1whfx.fsf@assigned-by-dhcp.cox.net>
	<7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 18:31:43 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>,
	Andreas Ericsson <ae@op5.se>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7ac1e90c0612120332o20d6778bsa16a788fdc04a3a1@mail.gmail.com>
	(Bahadir Balban's message of "Tue, 12 Dec 2006 11:32:28 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34120>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuCPa-00019u-R0 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751433AbWLLSbY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWLLSbY
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:31:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56395 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751433AbWLLSbX (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 13:31:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212183117.JRNV4226.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Tue, 12
 Dec 2006 13:31:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xuWf1V0041kojtg0000000; Tue, 12 Dec 2006
 13:30:39 -0500
To: "Bahadir Balban" <bahadir.balban@gmail.com>
Sender: git-owner@vger.kernel.org

"Bahadir Balban" <bahadir.balban@gmail.com> writes:

> ... I said "performance reasons" assuming all the
> file hashes need checked for every commit -a to see if they're
> changed, but I just tried on a PIII and it seems not so slow.

Ok.

Other people have already cleared the fear for 'commit' case, so
I hope you are happier.

There is one thing we could further optimize, though.

Switching branches with 100k blobs in a commit even when there
are a handful paths different between the branches would still
need to populate the index by reading two trees and collapsing
them into a single stage.  In theory, we should be able to do a
lot better if two-tree case of read-tree took advanrage of
cache-tree information.  If ce_match_stat() says Ok for all
paths in a subdirectory and the cached tree object name for that
subdirectory in the index match what we are reading from the new
tree, we should be able to skip reading that subdirectory (and
its subdirectories) from the new tree object at all.

Anybody interested to give it a try?


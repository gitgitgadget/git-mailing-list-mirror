From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] filter-branch: subdirectory filter needs
 --full-history
Date: Fri, 8 Jun 2007 19:40:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706081822500.4205@woody.linux-foundation.org>
References: <200706082328.50923.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Jun 09 04:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwqt8-0005V0-Sw
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 04:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968324AbXFIClH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 22:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968269AbXFIClG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 22:41:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53027 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968256AbXFIClF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 22:41:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l592er27008540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2007 19:40:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l592elZP028465;
	Fri, 8 Jun 2007 19:40:47 -0700
In-Reply-To: <200706082328.50923.johannes.sixt@telecom.at>
X-Spam-Status: No, hits=-3.222 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49552>



On Fri, 8 Jun 2007, Johannes Sixt wrote:
>
> When two branches are merged that modify a subdirectory (possibly in
> different intermediate steps) such that both end up identical, then
> rev-list chooses only one branch. But when we filter history, we want to
> keep both branches. Therefore, we must use --full-history.

--full-history needs to be fixed up for this, I think.

It leaves *too* many merges around, in particular, it leaves merges where 
both parents end up (after simplification) being related to each other.

As an example, do this:

	mkdir hello
	cd hello/
	git init

	echo "Initial state" > file-A
	echo "Another initial state" > file-B
	git add file-A file-B
	git commit -m "Initial commit"

	echo "Add a line" >> file-A
	echo "Add another line" >> file-B
	git commit -a -m "On master branch"

	git checkout -b another HEAD^
	echo "Add a line" >> file-A
	git commit -a -m "On another branch"

	git checkout master
	git merge another

and then do

	gitk --full-history file-B

and notice what happens.. There was no actual developmet on branch 
"another", so all the commits went away, but it left the merge (because 
that's how --full-history works), which has now become pointless.

So you should do a "merge cleanup" phase after running --full-history.

			Linus

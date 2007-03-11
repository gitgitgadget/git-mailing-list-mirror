From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git-diff -p :/anything" always segfaults
Date: Sun, 11 Mar 2007 13:25:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703111322180.9690@woody.linux-foundation.org>
References: <87d53fsjiz.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUbv-0005Gn-2l
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbXCKUZk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbXCKUZk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:25:40 -0400
Received: from smtp.osdl.org ([65.172.181.24]:57452 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbXCKUZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:25:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2BKPYo4010776
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Mar 2007 13:25:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2BKPXZ7018956;
	Sun, 11 Mar 2007 12:25:33 -0800
In-Reply-To: <87d53fsjiz.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41974>



On Sun, 11 Mar 2007, Jim Meyering wrote:
>
> I like the idea of the new ':/<oneline prefix>' notation, and gave it
> a try, but all I could get was a segfault.  It was dereferencing a NULL
> commit list.  Fix below.  With it, this example now works:

The fix is correct, but not complete.

> -	while ((commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {
> +	while (list && (commit = pop_most_recent_commit(&list, ONELINE_SEEN))) {

The old code was broken, but the new one isn't much better.

"pop_most_recent_commit()" simply doesn't work that way. It *never* 
returns NULL. So having it as part of a while-loop was buggy to begin 
with, and you fixed the test, but the thing is, it should just look like

	while (list) {
		struct commit *commit;

		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
		..

and the "pop_most_recent_commit()" simply shouldn't be part of the 
conditional at all.

Alternatively, we could just change the semantics, and have it return NULL 
when the list is empty. That would probably be fine too, but then the old 
code was correct.

Hmm?

		Linus
